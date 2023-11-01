package kr.ed.haebeop.controller;

import com.github.scribejava.core.model.OAuth2AccessToken;
import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.repository.AuthRepositoryImpl;
import kr.ed.haebeop.repository.MemberRepository;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.service.board.BoardService;
import kr.ed.haebeop.util.Utils;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@Slf4j
@RequestMapping("/member/*")
public class MemberController {
    @Autowired
    private MemberService memberService; // 서비스 생성

    @Autowired
    private InstService instService; // 강사 로그인을 위해 사용

    @Autowired
    private BoardService boardService;

    @Autowired
    private InstructorService instructorService;

    @Autowired
    HttpSession session; // 세션 생성

    @Autowired
    JavaMailSender mailSender;

    @Autowired
    private NaverLoginBo naverLoginBo;

    @Autowired
    private Utils utils;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private AuthRepositoryImpl authRepository;

    @Autowired
    private MyclassService myclassService;
    @Resource(name="uploadPath")
    String uploadPath;
    OAuth2AccessToken oauthToken;

    org.json.simple.JSONObject jsonObj;
    private String apiResult = null;

    // spring security 이용
    private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

    @Autowired
    private ReviewService reviewService;

    //로그인 폼 로딩
    @RequestMapping("login.do")
    public String memberLoginForm(Model model) throws Exception {
        String naverAuthUrl = naverLoginBo.getAuthorizationUrl(session);
        model.addAttribute("urlNaver", naverAuthUrl);
        return "/member/loginForm";
    }

    // 로그인 시도
    @PostMapping("signin.do")
    public String signIn(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        boolean check = memberService.loginCheck(id, pw);
        if (check) { // 로그인 성공
            Member mem = new Member();
            mem = memberService.getMember(id);

            List<Instructor> instructorList = instructorService.getInstructorList();
            boolean isInst = false;
            int instNo=0;

            // 반복문을 사용하여 Instructor 객체와 id를 비교
            for (Instructor instructor : instructorList) {
                if (instructor.getId() != null && instructor.getId().equals(id)) {
                    isInst = true;
                    instNo = instructor.getNo();
                    break;
                }
            }
            System.out.println(isInst+" / "+instNo);
            if (isInst) {
                // 찾았을 때
                session.setAttribute("isInst", isInst);
                session.setAttribute("instNo", instNo);
            } else {
                // 찾지 못했을 때
                session.setAttribute("isInst", isInst);
            }


            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 성공');</script>");
            out.flush();
            session.setAttribute("sid", id);
            return "/index";
        } else { // 로그인 실패
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 실패');</script>");
            out.flush();
            return "/member/loginForm";
        }
    }

    //랜덤 문자열 생성, 랜덤비밀번호 생성
    public String crtPW() { //랜덤 문자열 생성, 소셜 닉네임 생성
        return utils.createRandomStr();
    }
    
    // 강사 로그인
    @RequestMapping("instLogin.do")
    public String instLoginForm(Model model) throws Exception {
        return "/member/loginForm2";
    }
    @PostMapping("instSignin.do")
    public String instSignIn(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        boolean check = instService.loginCheck(id, pw);
        if (check) { // 로그인 성공
            Instructor mem = new Instructor();
            mem = instService.getInstructor(id);
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 성공');</script>");
            out.flush();
            session.setAttribute("sid", id);
            return "/index";
        } else { // 로그인 실패
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 실패');</script>");
            out.flush();
            return "/member/loginForm2";
        }
    }

    //네이버 로그인
    @RequestMapping("social/naver")
    public String naverLogin(HttpSession session, Model model, String code, String state, RedirectAttributes rattr) {
        try {
            oauthToken = naverLoginBo.getAccessToken(session, code, state);


            log.info("state 호출해봄 from callback " + state);
            // 1. 로그인 사용자 정보를 읽어온다.
            apiResult = naverLoginBo.getUserProfile(oauthToken); // String형식의 json데이터

//            System.out.println("혹시 이거???" + apiResult);
//            log.info("oauthToken이 이거임!!!!!!!!!" + oauthToken);
            /**
             * apiResult json 구조 {"resultcode":"00","message":"success",
             * "response":{"id":"VWXu82fUob3nzhSp9Cqdfw7OSlpWJtKYOL66c7zbpio","nickname":"\uad6c\uc608\uc9c4",
             *              "profile_image":"https:\/\/ssl.pstatic.net\/static\/pwe\/address\/img_profile.png",
             *              "age":"30-39","gender":"F",
             *              "email":"spospotv@naver.com",
             *              "mobile":"010-9959-7512",
             *              "mobile_e164":"+821099597512",
             *              "name":"\uad6c\uc608\uc9c4",
             *              "birthday":"08-10",
             *              "birthyear":"1992"}}
             **/

            jsonObj = getParsedApiResult(apiResult);
            org.json.simple.JSONObject response_obj = (org.json.simple.JSONObject) jsonObj.get("response");

            String email = (String) response_obj.get("email"); //네이버 이메일 가져오기
            String name = (String) response_obj.get("name"); // 네이버 이름 가져오기
            String naverid = (String) response_obj.get("id"); // 네이버 아이디 가져오기 -> 너무 길다
            String tel = (String) response_obj.get("mobile"); // 네이버 휴대폰 번호 가져오기


            // 네이버 이메일이 DB에 있는 이메일안에 있는 지 확인
            Member member = memberService.getMemberEmail(email);
            if (member == null) { //신규

                //출력확인
                System.out.println(email+" " + name+" " +naverid+" " +tel);
                
                //네이버 정보 view로 보내기
                model.addAttribute("socialEmail", email);
                model.addAttribute("socialName", name);
                model.addAttribute("socialId", naverid);
                model.addAttribute("socialTel", tel);
                

                return "/member/socialJoin";

            } else {
                if (member.getState_cd() == 3) {
                    rattr.addFlashAttribute("msg", "UNABLE");
                    return "redirect:/member/login.do";
                }
                /*memberService.updateLoginTm(member.getIdx(), member.getEmail()); *///ok
            }


            if (makeAuth(member)) {
                session.setAttribute("loginService", "naver"); // 최종 로그인 서비스타입 명시. 같은 이메일, 다른 서비스 로그인 구
                crtSession(session, member);
                return "redirect:/";
            } else throw new Exception("auth failed");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println("로그인 에러");
            rattr.addFlashAttribute("msg", "LOGIN_ERR"); //로그인 에러
            return "redirect:/member/login.do";
        }
    }

    // 소셜 회원가입 처리
    @PostMapping(value = "naverJoin.do" )
    public String socialInsert(HttpSession session, HttpServletRequest request, Model model, Member member,String code, String state, RedirectAttributes rattr) throws Exception {

        String email = request.getParameter("socialEmail");
        String name = request.getParameter("socialName");
        String tel = request.getParameter("socialTel");


        try {

            //아이디 -> 이메일 @전까지 자르기
            // @의 인덱스를 찾는다.
            int idx = email.indexOf("@");
            // @ 앞부분 추출
            String id = email.substring(0,idx);


            final int NAVER = 3;
            member = member.builder()
                    .id(id)
                    .pw(crtPW()) //랜덤 비밀번호 생성
                    .name(name)
                    .email(email)
                    .tel(tel)
                    .login_tp_cd(NAVER) // 네이버 로그인 코드 : 3
                    .build();

            //회원정보 insert하고 해당 아이디 값 리턴 받기
            String socialId = memberService.regSocialUser(member);
            member = memberService.getMember(socialId);
            System.out.println("회원정보 : " + member);

            model.addAttribute("member", member);
            model.addAttribute("msg", "회원가입이 완료되었습니다.");
            model.addAttribute("url", "/");
            

            return "/include/redirect";

        }catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println("로그인 에러");
            rattr.addFlashAttribute("msg", "LOGIN_ERR"); //로그인 에러
            return "redirect:/member/login.do";
        }
    }

    //TODO:: 네이버 로그아웃


    // 인증 생성
    public boolean makeAuth(Member member) throws Exception {
        //회원 이메일로 조회한 정보를 dto에 담는다
        UserDetail dto = memberRepository.getUserDetailsDto(member.getEmail());

        if (dto == null) return false;
        dto.setAuthority((ArrayList<String>) authRepository.getAuthList(member.getState_cd()));
        if (dto.getAuthorities() == null) return false; //인증 실패시 null

        Authentication authentication =
                new UsernamePasswordAuthenticationToken(member, null, dto.getAuthorities()); //userDetailsDto.getAuthorities()식으로 권한을 추가해야 함

        SecurityContext securityContext = SecurityContextHolder.getContext();
        securityContext.setAuthentication(authentication);
        return true;
    }


    //세션 저장
    public void crtSession(HttpSession session, Member member) {
        session.setAttribute("sid", member.getId());
        session.setAttribute("email", member.getEmail());
        //session.setAttribute("nickName", member.getNick_nm());

    }

    public org.json.simple.JSONObject getParsedApiResult(String apiResult) throws Exception {
        JSONParser jsonParser = new JSONParser();
        return (org.json.simple.JSONObject) jsonParser.parse(apiResult);
    }

    // 로그아웃
    @GetMapping("logout.do")
    public String logout(HttpServletResponse response,Model model) throws Exception {
        session.invalidate();

        //ScriptAlertUtils.alert(response,"로그아웃 되었습니다");

        model.addAttribute("msg", "로그아웃 되었습니다");
        model.addAttribute("url", "/");

        return "/include/redirect";
    }

    /*회원목록*/
    @RequestMapping(value = "list.do", method = RequestMethod.GET)
    public String memberList(Model model) throws Exception {
        List<Member> memberList = memberService.memberList();
        model.addAttribute("memberList", memberList);
        model.addAttribute("title", "회원 목록");
        return "/member/memberList";
    }

    // 관리자 회원 상세
    @GetMapping("detail.do")    // board/detail.do?bno=1
    public String getBoardDetail(HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        Member member = memberService.getMember(id);
        model.addAttribute("member", member);
        return "/member/memberDetail";
    }


    //회원 가입 - 학부모 , 선생 선택
    @GetMapping("term.do")
    public String getAgree(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        return "/member/term";
    }

    //회원 가입 - 회원가입폼 페이지 로딩
    @GetMapping("join.do")
    public String getJoin(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        model.addAttribute("job", "1");
        return "/member/join";
    }

    //회원 가입 - Ajax로 아이디 중복 체크
    @RequestMapping(value = "idCheck.do", method = RequestMethod.POST)
    public void idCheck(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        Member mem = memberService.getMember(id);
        boolean result = false;
        if (mem != null) {
            result = false;
        } else {
            result = true;
        }

        JSONObject json = new JSONObject();
        json.put("result", result);
        PrintWriter out = response.getWriter();
        out.println(json.toString());
    }


    //회원 가입 - 회원 가입 처리
    @RequestMapping(value = "insert.do", method = RequestMethod.POST)
    public String memberWrite(HttpServletResponse response, Member member, Model model) throws Exception {
        String ppw = member.getPw();
        String pw = pwEncoder.encode(ppw);
        member.setPw(pw);
        memberService.memberInsert(member);
        model.addAttribute("msg", "완료되었습니다.");
        model.addAttribute("url", "/");
        return "/include/redirect";

    }

    // 마이페이지 메인
    @GetMapping("mypage.do")
    public String mypage(HttpServletRequest request, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        Member member = memberService.getMember(id);
        model.addAttribute("member", member);

        List<BoardlistVO> boardlist = memberService.getWriteList1(id);
        int cntBoard = boardlist.size();
        model.addAttribute("cntBoard",cntBoard);

        return "/member/myPage/myPageindex";
    }


    /*회원 정보 수정 폼 이동*/
    @GetMapping("update.do")
    public String editForm(HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        Member member = memberService.getMember(id);
        model.addAttribute("member", member);
        System.out.println(member.toString());
        return "/member/myPage/memberUpdate";
    }
    
    // 회원 정보 수정
    @PostMapping("update.do")
    public String memberEdit(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {


        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String tel = request.getParameter("tel");
        String addr1 = request.getParameter("addr1");
        String addr2 = request.getParameter("addr2");
        String postcode = request.getParameter("postcode");
        String birth = request.getParameter("birth");
        int job = Integer.parseInt(request.getParameter("job"));

        Member member = new Member();
        member.setId(id);
        member.setPw(pw);
        member.setName(name);
        member.setEmail(email);
        member.setTel(tel);
        member.setAddr1(addr1);
        member.setAddr2(addr2);
        member.setPostcode(postcode);
        member.setBirth(birth);


        if (job==2) {

            MultipartHttpServletRequest files = (MultipartHttpServletRequest) request;
            MultipartFile img = files.getFile("img");

            String devFolder = uploadPath;    //개발자용 컴퓨터에 업로드 디렉토리 지정
            String uploadFolder = request.getRealPath("/resources/upload");
            File folder = new File(uploadFolder);
            File devfol = new File(devFolder);

            if (!folder.exists()) folder.mkdirs();
            if (!devfol.exists()) devfol.mkdirs();

            //파라미터 분리
            Enumeration<String> enum1 = files.getParameterNames();
            Map map = new HashMap();
            while (enum1.hasMoreElements()) {
                String name2 = enum1.nextElement();
                String value = files.getParameter(name2);
                map.put(name2, value);
            }


            Instructor inst2 = instructorService.getInstructorById(id);
            inst2.setCate(request.getParameter("cate"));
            inst2.setIntro(request.getParameter("intro"));
            inst2.setName(request.getParameter("name"));
            inst2.setEmail(request.getParameter("email"));
            inst2.setTel(request.getParameter("tel"));
            inst2.setId(request.getParameter("id"));
            System.out.println("inst2 : " + inst2.toString());
// 개발 서버 파일 저장 경로
//        String uploadDir = "D:/team_pro4/team14/src/main/webapp/resources/upload/"; // 회사
//            String uploadDir = "/Users/juncheol/Desktop/team_pro4/team14/src/main/webapp/resources/upload/"; // 백준철
            // String uploadDir = "E:/git/spring_study/pro04/src/main/webapp/resources/upload/"; // 집
            // 실제 서버 파일 저장 경로
            String uploadSev = request.getRealPath("/resources/upload/");

            if (!img.isEmpty()) {
                String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
                String OriginalFilename = img.getOriginalFilename();
                String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
                String RandomFileName = randomUUID + Extension;
                inst2.setImg(RandomFileName);

                try {
                    img.transferTo(new File(uploadSev + RandomFileName));
//                    img.transferTo(new File(uploadDir + RandomFileName));

                } catch (IOException e) {
                    e.printStackTrace(); // 오류 처리
                }
            }

            instService.updateInstructor(inst2);
        }


        memberService.memberUpdate(member);
        model.addAttribute("member", member);

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('회원님의 정보가 수정되었습니다.');</script>");
        out.flush();

        List<Member> memberList = memberService.memberList();
        model.addAttribute("memberList", memberList);
        model.addAttribute("title", "회원 목록");
        String sid = (String) session.getAttribute("sid");
        if (sid.equals("admin")) {
            return "/admin/memberList";
        } else {
            return "/member/myPage/memberUpdate";
        }
    }

/*    @RequestMapping(value = "update.do", method = RequestMethod.POST)
    public String memberUpdate(Member member,Model model) throws Exception{
        String pwd ="";
        if(member.getPw().length() <= 16){
            pwd = pwEncoder.encode(member.getPw());
            member.setPw(pwd);
        }
        memberService.memberUpdate(member);
        return "redirect:list.do";
    }*/


    // 회원 탈퇴 전 비밀번호 입력 로딩
    @GetMapping("delete.do")
    public String pwCheckForm(HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        Member member = memberService.getMember(id);
        model.addAttribute("member", member);
        //memberService.memberDelete(id);
        return "/member/myPage/memberDelete";
    }


    //회원 탈퇴 - Ajax로 비밀번호 일치 체크
    @RequestMapping(value = "pwCheck.do", method = RequestMethod.POST)
    public void pwCheck(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpServletResponse response, Model model) throws Exception {

        Member mem = memberService.getMember(id);
        boolean result = false;

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        if (encoder.matches(pw, mem.getPw())) {//넘겨받은 비밀번호와 user객체에 암호화된 비밀번호와 비교
            result = true;
        } else {
            result = false;
        }

        JSONObject json = new JSONObject();
        json.put("result", result);
        PrintWriter out = response.getWriter();
        out.println(json.toString());
    }


    //회원 탈퇴 전 숙지사항 폼뷰
    @RequestMapping("withdrawForm.do")
    public String withdrawForm(HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        Member member = memberService.getMember(id);
        model.addAttribute("member", member);
        //memberService.memberDelete(id);
        return "/member/myPage/withdraw";
    }

    //회원 탈퇴 처리
    @GetMapping("withdraw.do")
    public String memberdelete(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String id = request.getParameter("id");
        memberService.memberDelete(id);
        session.invalidate();

        model.addAttribute("msg", "회원 탈퇴가 처리되었습니다");
        model.addAttribute("url", "/");
        return "/include/redirect";
    }

    // 내가 쓴 댓글 (나의 학습방)
    @GetMapping("memberWrittenComent.do")
    public String writtenComentList(HttpSession session, Model model) throws Exception{
        String id = (String) session.getAttribute("sid");

        Member member = memberService.getMember(id);
        model.addAttribute("member", member);

        //최근 수강 중인 강의 수
        int count = myclassService.takingCount(id);
        model.addAttribute("count",count);

        /*자유게시판*/
        List<CommentlistVO> board_comlist = memberService.getWriteComment1(id);
        if (board_comlist != null) {
            model.addAttribute("board_comlist", board_comlist);
        }

        /*강의평*/
        List<Review> revList = reviewService.getReviewListId(id);
        if(revList != null) {
            model.addAttribute("revList", revList);
            System.out.println(revList.toString());
        }

        return  "/member/memberWrittenComent";
    }

    /*내가 쓴 글 (나의 학습방) */
    @RequestMapping("memberWrittenBoard.do")
    public String writtenBoardList(HttpSession session, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        System.out.println("id:  " + id);

        Member member = memberService.getMember(id);
        model.addAttribute("member", member);

        //최근 수강 중인 강의 수
        int count = myclassService.takingCount(id);
        model.addAttribute("count",count);

        /*자유게시판*/
        List<BoardlistVO> boardlist = memberService.getWriteList1(id);
        if (boardlist != null) {
            model.addAttribute("boardlist", boardlist);
            System.out.println(boardlist.toString());
        }
        return "/member/memberWrittenBoard";

    }

    /*내가 쓴 글*/
    @RequestMapping(value = "/writtenList.do")
    public String writtenList(HttpSession session, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        System.out.println("id:  " + id);

        Member member = memberService.getMember(id);
        model.addAttribute("member", member);

        /*자유게시판*/
        List<BoardlistVO> boardlist = memberService.getWriteList1(id);
        if (boardlist != null) {
            model.addAttribute("boardlist", boardlist);
            System.out.println(boardlist.toString());
        }

//        /*선생님 게시판*/
//        List<BoardlistVO> boardtealist = memberService.getWriteList2(id);
//        if (boardtealist != null) {
//            model.addAttribute("boardtealist", boardtealist);
//        }
//
//        /*학부모 게시판*/
//        List<BoardlistVO> boardparlist = memberService.getWriteList3(id);
//        if (boardparlist != null) {
//            model.addAttribute("boardparlist", boardparlist);
//        }

        /* 자료실 */
//        List<BoardlistVO> boardfreelist = memberService.getWriteList4(id);
//        if (boardfreelist != null) {
//            model.addAttribute("boardfreelist", boardfreelist);
//        }


        /* 자유게시판 댓글 */
        List<CommentlistVO> board_comlist = memberService.getWriteComment1(id);
        if (board_comlist != null) {
            model.addAttribute("board_comlist", board_comlist);
        }

        /*  List<CommentlistVO> c_listfd = memberService.getWriteComment2(id);
        if(c_listfd != null ) {
            model.addAttribute("c_listfd", c_listfd);
        }

        List<CommentlistVO> c_listfa = memberService.getWriteComment3(id);
        if(c_listfa != null ) {
            model.addAttribute("c_listfa", c_listfa);
        }

        List<CommentlistVO> c_listah = memberService.getWriteComment4(id);
        if(c_listah != null ) {
            model.addAttribute("c_listah", c_listah);
        }
        List<BoardlistVO> b_listco = memberService.getWriteList5(id);
        if(b_listco != null ) {
            model.addAttribute("b_listco", b_listco);
        }
        List<CommentlistVO> c_listco = memberService.getWriteComment5(id);
        if(c_listco != null ) {
            model.addAttribute("c_listco", c_listco);
        }
        List<BoardlistVO> b_listp = memberService.getWriteList6(id);
        if(b_listp != null ) {
            model.addAttribute("b_listp", b_listp);
        }
        List<CommentlistVO> c_listp = memberService.getWriteComment6(id);
        if(c_listp != null ) {
            model.addAttribute("c_listp", c_listp);
        }
        List<BoardlistVO> b_listm = memberService.getWriteList7(id);
        if(b_listm != null ) {
            model.addAttribute("b_listm", b_listm);
        }
        List<CommentlistVO> c_listm = memberService.getWriteComment7(id);
        if(c_listm != null ) {
            model.addAttribute("c_listm", c_listm);
        }*/

        return "/member/myPage/memberWritten2";

    }
    
    // 비밀번호 찾기 폼 이동
    @RequestMapping(value = "/pw_find.do", method = RequestMethod.GET)
    public String pw_find() {
        return "/member/pw_find";
    }

    //메일 보내기
    @RequestMapping(value = "/pw_auth.do")
    public ModelAndView pw_auth(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String email = (String) request.getParameter("email");
        String name = (String) request.getParameter("name");

        Member mem = memberService.selectMember(email);
        System.out.println(mem);

        try{
            Random r = new Random();
            int num = r.nextInt(999999); // 랜덤난수설정

            if (mem.getName().equals(name)) {
                session.setAttribute("email", mem.getEmail());

                String setfrom = "spospotv@naver.com"; // naver
                String tomail = email; //받는사람
                String title = "[티스푼] 비밀번호변경 인증 이메일 입니다";
                String content = System.getProperty("line.separator") + "안녕하세요 회원님" + System.getProperty("line.separator")
                        + "비밀번호찾기(변경) 인증번호는 " + num + " 입니다." + System.getProperty("line.separator"); //

                try {
                    MimeMessage message = mailSender.createMimeMessage();
                    MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

                    messageHelper.setFrom(setfrom);
                    messageHelper.setTo(tomail);
                    messageHelper.setSubject(title);
                    messageHelper.setText(content);

                    mailSender.send(message);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

                ModelAndView mv = new ModelAndView();
                mv.setViewName("/member/pw_auth");
                mv.addObject("num", num);
                return mv;
            } else {
                ModelAndView mv = new ModelAndView();
                mv.setViewName("/member/pw_find");
                return mv;
            }
        } catch (Exception e) {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/member/pw_find");
            return mv;
        }
    }

    //이메일 인증번호 확인
    @RequestMapping(value = "/pw_set.do", method = RequestMethod.POST)
    public String pw_set(@RequestParam(value = "email_injeung") String email_injeung,
                         @RequestParam(value = "num") String num, Model model, HttpServletResponse response) throws Exception {

        if (email_injeung.equals(num)) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('인증번호가 일치합니다.');</script>");
            out.flush();
            return "/member/pw_new";

        } else {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('인증번호가 다릅니다. 다시 입력해주세요.');</script>");
            out.flush();
            return "/member/pw_auth";

        }

    }

    //비밀번호 재설정
    @RequestMapping(value = "/pw_new.do", method = RequestMethod.POST)
    public String pw_new(Member member, HttpSession session, HttpServletResponse response, Model model) throws Exception {
        System.out.println("session email : " + session.getAttribute("email"));
        System.out.println("pw : " + member.getPw());

        String ppw = member.getPw();
        String pw = pwEncoder.encode(ppw);
        member.setPw(pw);

        int result = memberService.pwUpdate(member);

        if (result == 1) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 재설정 되었습니다.');</script>");
            out.flush();

            return "/member/loginForm";

        } else {
            System.out.println("pw_update" + result);
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 다릅니다. 다시 입력해주세요.');</script>");
            out.flush();


            return "/member/pw_new";
        }
    }



    @GetMapping("/signUpConfirm.me")
    public ModelAndView signUpConfirm(@RequestParam HashMap<String, Integer> map, ModelAndView mav) throws Exception {
        //email, authKey 가 일치할경우 authStatus 업데이트
        System.out.println("connection  email :" + map.get("email"));
        System.out.println("connection  authkey :" + map.get("authkey"));
        memberService.updateAuthStatus(map);
        System.out.println("connection  email2 :" + map.get("email"));
        mav.addObject("display", "/member/loginForm");
        mav.setViewName("/member/loginForm");
        return mav;
    }

    //신고한 게시글 목록
    @GetMapping("myReportList.do")
    public String myReportList(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        List<Board> boardList = memberService.myReportList(id);
        model.addAttribute("boardList", boardList);
        System.out.println(boardList.toString());
        return "/member/myPage/myReportList";
    }

    @GetMapping("myReportCancel.do")
    public String myReportCancel(HttpServletRequest request, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        int bno = Integer.parseInt(request.getParameter("bno"));
        String category = request.getParameter("category");

        Report report = new Report();
        report.setReporter(id);
        report.setBoard_bno(bno);

        if (category.equals("board")) {
            memberService.boardReportCancel(report);
            return "redirect:myReportList.do";
        } else if (category.equals("boardTea")) {
            memberService.teaReportCancel(bno);
            return "redirect:myReportList.do";
        } else if (category.equals("boardPar")) {
            memberService.parReportCancel(bno);
            return "redirect:myReportList.do";
        } else {
            return "redirect:myReportList.do";
        }

    }

    //추천한 게시글 목록
    @GetMapping("myLikeList.do")
    public String myLikeList(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        List<Board> boardList = boardService.boardLikeList(id);
        model.addAttribute("likeList", boardList);
        System.out.println(boardList.toString());
        return "/member/myPage/myLikeList";
    }

    @GetMapping("myLikeRemove.do")
    public String myLikeRemove(HttpServletRequest request, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        int bno = Integer.parseInt(request.getParameter("bno"));
//        String category = request.getParameter("category");

        Like like=new Like();
        like.setUserId(id);
        like.setBoardNo(bno);

        boardService.removeLike(like);

//        if (category.equals("board")) {
//            memberService.boardLikeRemove(bno);
//            return "redirect:myLikeList.do";
//        } else if (category.equals("boardTea")) {
//            memberService.teaLikeRemove(bno);
//            return "redirect:myLikeList.do";
//        } else if (category.equals("boardPar")) {
//            memberService.parLikeRemove(bno);
//            return "redirect:myLikeList.do";
//        } else {
//            return "redirect:myLikeList.do";
//        }
        return "redirect:myLikeList.do";
    }

}