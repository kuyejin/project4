
package kr.ed.haebeop.controller;

import kr.ed.haebeop.controller.file.FileController;
import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.service.board.BoardServiceImpl;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

    private static final Logger log = LoggerFactory.getLogger(FileController.class);
    @Resource(name="uploadPath")
    String uploadPath;

    @Autowired
    private MemberService memberService; // 서비스 생성
    @Autowired
    private BoardServiceImpl boardService; //자유게시판
    @Autowired
    private NoticeService noticeService; //공지사항
    @Autowired
    private InstService instService; // 강사 관련 기능
    @Autowired
    private ReviewService reviewService; // 리뷰 관련 기능
    @Autowired
    private InstructorService instructorService;
    @Autowired
    HttpSession session; // 세션 생성

    // spring security 이용
    private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();


    @GetMapping("adminMain.do")
    public String adminMain(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        List<Board> boardList = boardService.recentReportList();    // 최근 신고 내역 알림창
        model.addAttribute("boardList", boardList); // 최근 신고 내역 알림창

        return "/admin/adminMain";
    }

    //회원 목록
    @RequestMapping(value = "memberList.do", method = RequestMethod.GET)
    public String memberList(Model model) throws Exception {
        List<Member> memberList = memberService.memberList();
        model.addAttribute("memberList", memberList);
        model.addAttribute("title", "회원 목록");
        return "/admin/memberList";
    }

    //강사 목록
    @RequestMapping(value = "instList.do", method = RequestMethod.GET)
    public String instList(Model model) throws Exception {
        List<Instructor> memberList = instService.getInstructorList();
        model.addAttribute("memberList", memberList);
        model.addAttribute("title", "회원 목록");
        return "/admin/instList";
    }

    // 관리자 회원 상세
    @GetMapping("memberDetail.do")
    public String getMemberDetail(HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        Member member = memberService.getMember(id);
        model.addAttribute("member", member);

        Instructor instructor = instructorService.getInstructorById(id);
        model.addAttribute("instructor",instructor);

        return "/admin/memberDetail";
    }

    // 회원 탈퇴, 강퇴
    @GetMapping("delete.do")
    public String memberDelete(HttpServletRequest request) throws Exception {
        String id = request.getParameter("id");
        memberService.memberDelete(id);
        return "redirect:/admin/memberList.do";
    }

    //게시판 관리
    //게시판 글 목록
    @GetMapping("boardList.do")
    public String getBoardList(HttpServletRequest request,Model model) throws Exception {
        String category = (String) request.getParameter("category");
        if(category.equals("free")){
            List<Board> boardList = boardService.boardList();
            model.addAttribute("categoryKor", "자유");
            model.addAttribute("category", category); //한글 사용시 에러 나므로 영문값도 전달
            model.addAttribute("boardList", boardList);
            model.addAttribute("boardCate", "board");
            return "/admin/boardList";
        } else {
            return "/admin/adminMain";
        }
    }
    //게시글 삭제
    @GetMapping("boardDelete.do")
    public String freeDelete(HttpServletRequest request, Model model) throws Exception {
        int bno = Integer.parseInt(request.getParameter("bno"));
        String category = (String) request.getParameter("category");
        if(category.equals("free")){
            boardService.boardDelete(bno);
            boardService.commentDeleteAll(bno);
            return "redirect:boardList.do?category=free";
        } else {
            return "/admin/adminMain";
        }
    }

    //댓글 리스트
    @GetMapping("commentList.do")	// board/detail.do?bno=1
    public String getFreeCommentList(HttpServletRequest request, Model model) throws Exception {
        String category = (String) request.getParameter("category");
        if(category.equals("free")){
            List<Board> boardList = boardService.allCommentList();
            model.addAttribute("categoryKor", "자유");
            model.addAttribute("category", category); //한글 사용시 에러 나므로 영문값도 전달
            model.addAttribute("boardList", boardList);
            model.addAttribute("boardCate", "board");
            return "/admin/commentList";
        } else {
            return "/admin/adminMain";
        }
    }

    //게시판 댓글 삭제
    @GetMapping("CommentDelete.do")
    public String freeCommentDelete(HttpServletRequest request, Model model) throws Exception {
        int bno = Integer.parseInt(request.getParameter("bno"));
        String category = (String) request.getParameter("category");
        if(category.equals("free")){
            boardService.boardDelete(bno);
            boardService.commentDeleteAll(bno);
            return "redirect:commentList.do?category=free";
        } else {
            return "/admin/adminMain";
        }
    }

    @GetMapping("boardReportList.do")
    public String getBoardReportList(HttpServletRequest request,Model model) throws Exception {
        String category = (String) request.getParameter("category");
        if(category.equals("free")){
            List<Board> boardList = boardService.boardReportList();
            model.addAttribute("categoryKor", "자유");
            model.addAttribute("category", category); //한글 사용시 에러 나므로 영문값도 전달
            model.addAttribute("boardCate", "board");
            model.addAttribute("boardList", boardList);
            return "/admin/boardReportList";
        } else {
            return "/admin/adminMain";
        }

    }
    @GetMapping("boardReportDelete.do")
    public String boardReportDelete(HttpServletRequest request, Model model) throws Exception {
        int bno = Integer.parseInt(request.getParameter("bno"));
        String category = (String) request.getParameter("category");
        if (category.equals("free")) {
            boardService.boardDelete(bno);
            boardService.commentDeleteAll(bno);
            return "redirect:boardReportList.do?category=free";
        } else {
            return "/admin/adminMain";
        }
    }

    // 강사 등록폼 이동
    @GetMapping("instInsert.do")
    public String instInsertForm(HttpServletRequest req, Model model) throws Exception {
        return "/admin/instInsert";
    }

    // 강사 아이디 중복 확인
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

    // 강사 등록, member 포함
    @PostMapping("instInsert.do")
    public String instInsert(HttpServletRequest req, MultipartHttpServletRequest files, Model model) throws Exception {

        MultipartFile img = files.getFile("img");

        String devFolder = uploadPath;    //개발자용 컴퓨터에 업로드 디렉토리 지정
        String uploadFolder = req.getRealPath("/resources/upload/");
        File folder = new File(uploadFolder);
        File devfol = new File(devFolder);

        if(!folder.exists()) folder.mkdirs();
        if(!devfol.exists()) devfol.mkdirs();

        //파라미터 분리
        Enumeration<String> enum1 = files.getParameterNames();
        Map map = new HashMap();
        while (enum1.hasMoreElements()) {
            String name = enum1.nextElement();
            String value = files.getParameter(name);
            map.put(name, value);
        }

        // member 테이블에 강사 정보 등록
        Member member = new Member();
        Instructor inst = new Instructor();
        member.setId(files.getParameter("id"));
        String ppw = files.getParameter("pw");
        String pw = pwEncoder.encode(ppw);
        member.setPw(pw);
        member.setName(files.getParameter("name"));
        member.setEmail(files.getParameter("email"));
        member.setTel(files.getParameter("tel"));
        member.setAddr1(files.getParameter("addr1"));
        member.setAddr2(files.getParameter("addr2"));
        member.setPostcode(files.getParameter("postcode"));
        member.setRegdate(files.getParameter("regdate"));
        member.setPt(0);
        member.setBirth(files.getParameter("birth"));
        member.setJob(2);
        memberService.memberInsert(member);

        // 강사 테이블에 정보 등록
        Instructor inst2 = new Instructor();
        inst2.setCate(files.getParameter("cate"));
        inst2.setIntro(files.getParameter("intro"));
        inst2.setName(files.getParameter("name"));
        inst2.setEmail(files.getParameter("email"));
        inst2.setTel(files.getParameter("tel"));
        inst2.setId(files.getParameter("id"));

        // 개발 서버 파일 저장 경로
//        String uploadDir = "D:/team_pro4/team14/src/main/webapp/resources/upload/"; // 회사
//        String uploadDir = "/Users/juncheol/Desktop/team_pro4/team14/src/main/webapp/resources/upload/"; // 백준철
        // String uploadDir = "E:/git/spring_study/pro04/src/main/webapp/resources/upload/"; // 집
        // 실제 서버 파일 저장 경로
        String uploadSev = req.getRealPath("/resources/upload/");

        if (!img.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = img.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            inst2.setImg(RandomFileName);

            try {
//                img.transferTo(new File(uploadDir + RandomFileName));
                img.transferTo(new File(uploadSev + RandomFileName));
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }
        instService.addInstructor(inst2);

        return "redirect:/admin/memberList.do";
    }

    // 회원 수정
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

        memberService.memberUpdate(member);
        model.addAttribute("member", member);

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('회원님의 정보가 수정되었습니다.');</script>");
        out.flush();

        List<Member> memberList = memberService.memberList();
        model.addAttribute("memberList", memberList);
        model.addAttribute("title", "회원 목록");

        return "/admin/memberList";
    }

    // 댓글 관리
    // 관리자의 전체 리뷰 목록
    @GetMapping("adminReviewList.do")
    public String adminReviewList(HttpServletRequest req, Model model) throws Exception{
        List<Review> rvList = reviewService.getReviewList();
        model.addAttribute("rvList", rvList);
        return "/admin/adminRevList";
    }

    // 관리자 리뷰 제거
    // 리뷰 제거
    @GetMapping("adminDeleteReview.do")
    public String adminDeleteReview(HttpServletRequest req,  Model model) throws Exception {
        Review review = new Review();
        String id = req.getParameter("id");
        int par = Integer.parseInt(req.getParameter("par"));
        review.setId(id);
        review.setPar(par);
        reviewService.deleteReview(review);
        return "redirect:/admin/adminReviewList.do";
    }

    // 리뷰 신고 목록
    @GetMapping("reviewReportList.do")
    public String getReviewReportList(HttpServletRequest request,Model model) throws Exception {
        List<ReviewVO> revList = reviewService.reviewReportList();
        model.addAttribute("revList", revList);
        return "/admin/reviewReportList";
    }

    // 신고된 리뷰 삭제
    @GetMapping("reviewReportDelete.do")
    public String reviewReportDelete(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));
        reviewService.adminbDeleteReview(no);
        return "redirect:/admin/reviewReportList.do";
    }

}
