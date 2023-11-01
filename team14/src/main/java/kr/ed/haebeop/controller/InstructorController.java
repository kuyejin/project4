package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.InstructorService;
import kr.ed.haebeop.service.LectureService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/instructor/*")
public class InstructorController {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private InstructorService instructorService;

    @Autowired
    HttpSession session;

    private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();


    //선생님 목록
    @GetMapping("instructorList")		// board/list.do
    public String getInstructorList(HttpServletRequest request,Model model) throws Exception {
        String instructor = request.getParameter("instructor");

        //활동 상태에 대한 컬럼이 필요? (선생님 목록에 노출 여부를 결정하기 위해)
        //정렬 기준 : 미정 / ex)누적 수강생 수?
        //
        //
        List<Instructor> instructorList = instructorService.getInstructorList();
        System.out.println(instructorList.toString());
        model.addAttribute("instructorList",instructorList);

        return "/instructor/instructorList";
    }

    //선생님 상세
    @GetMapping("instructorDetail.do")
    public String getInstructorDetail(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));
        model.addAttribute("no",no);

        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        //후기 목록
        List<Review> reviewList = instructorService.getReviewList(no);
        model.addAttribute("reviewList",reviewList);


        return "/instructor/instructorDetail";
    }

    //선생님 강의 목록
    @GetMapping("instructorLecture.do")
    public String getInstructorLecture(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        String sid = (String) session.getAttribute("sid");
        model.addAttribute("sid",sid);

        //강의 리스트
        List<Lecture> lectureList = instructorService.getInstructorLectureList(no);
        System.out.println("lec List : "+lectureList.toString());
        model.addAttribute("no",no);
        model.addAttribute("lecList", lectureList);
        return "/instructor/instructorLecture";
    }

    //선생님 공지 목록
    @GetMapping("instructorNotice.do")
    public String getInstructorNotice(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no")); //선생님 no

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        //공지 목록
        List<InstructorNotice> instructorNotices = instructorService.getInstructorNoticeList(no);
        model.addAttribute("instructorNotices",instructorNotices);
        System.out.println(instructorNotices.toString());


        return "/instructor/instructorNotice";
    }

    //공지 상세 보기
    @GetMapping("instructorNoticeDetail.do")
    public String getInstructorNoticeDetail(HttpServletRequest request, Model model) throws Exception {

        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
        InstructorNotice instructorNotice = instructorService.getInstructorNoticeDetail(noticeNo);
        model.addAttribute("instructorNotice",instructorNotice);


        HttpSession session = request.getSession();
        Cookie[] cookieFromRequest = request.getCookies();
        String cookieValue = null;
        for(int i = 0 ; i<cookieFromRequest.length; i++) {
            // 요청정보로부터 쿠키를 가져온다.
            cookieValue = cookieFromRequest[0].getValue();  // 테스트라서 추가 데이터나 보안사항은 고려하지 않으므로 1번째 쿠키만 가져옴
        }
        // 쿠키 세션 입력
        if (session.getAttribute(noticeNo+":cookie") == null) {
            session.setAttribute(noticeNo+":cookie", noticeNo + ":" + cookieValue);
        } else {
            session.setAttribute(noticeNo+":cookie ex", session.getAttribute(noticeNo+":cookie"));
            if (!session.getAttribute(noticeNo+":cookie").equals(noticeNo + ":" + cookieValue)) {
                session.setAttribute(noticeNo+":cookie", noticeNo + ":" + cookieValue);
            }
        }
// 쿠키와 세션이 없는 경우 조회수 카운트
        if (!session.getAttribute(noticeNo+":cookie").equals(session.getAttribute(noticeNo+":cookie ex"))) {
            instructorService.instructorNoticeCountUp(noticeNo);
            instructorNotice.setCnt(instructorNotice.getCnt()+1);
        }

        return "/instructor/instructorNoticeDetail";
    }

    //공지 작성
    @GetMapping("instructorNoticeAdd.do")
    public String insertForm(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);
        return"/instructor/instructorNoticeAdd";
    }

    //공지 작성 폼
    @PostMapping("instructorNoticeAdd.do")
    public String noticeInsert(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        InstructorNotice dto = new InstructorNotice();
        dto.setTitle(request.getParameter("title"));
        dto.setContent(request.getParameter("content"));
        dto.setInstructorno(no);
        instructorService.noticeInsert(dto);
        return "redirect:instructorNotice.do?no="+no;
    }

    //공지 삭제
    @GetMapping("instructorNoticeDelete.do")
    public String noticeDelete(HttpServletRequest request, Model model) throws Exception {
        int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
        int no = Integer.parseInt(request.getParameter("no"));
        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        instructorService.noticeDelete(noticeNo);
        return "redirect:instructorNotice.do?no="+no;
    }

    //공지 수정
    @GetMapping("instructorNoticeEdit.do")
    public String editQNAForm(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));
        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

        InstructorNotice dto = instructorService.getInstructorNoticeDetail(noticeNo);
        model.addAttribute("dto", dto);
        return "/instructor/instructorNoticeEdit";
    }

    //공지 수정 폼
    @PostMapping("instructorNoticeEdit.do")
    public String noticeEdit(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));
        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

        InstructorNotice dto = new InstructorNotice();

        dto.setNo(noticeNo);
        dto.setTitle(request.getParameter("title"));
        dto.setContent(request.getParameter("content"));
        dto.setInstructorno(no);

        instructorService.noticeEdit(dto);
        return "redirect:instructorNotice.do?no="+no;
    }


    //QNA List
    @GetMapping("instructorQNA.do")
    public String getInstructorQNA(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        //qna list
        List<InstructorQna> qnaList = instructorService.instructorQnaList(no);
        model.addAttribute("qnaList", qnaList);

        return "/instructor/instructorQNA";
    }

    //QNA 글 상세
    @GetMapping("instructorQNADetail.do")	// qna/detail.do?bno=1
    public String getqnaDetail(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        InstructorQna dto = instructorService.qnaDetail(bno);
        List<InstructorQna> comment = instructorService.commentList(bno);
        model.addAttribute("dto", dto);
        model.addAttribute("comment", comment);


        HttpSession session = request.getSession();
        Cookie[] cookieFromRequest = request.getCookies();
        String cookieValue = null;
        for(int i = 0 ; i<cookieFromRequest.length; i++) {
            // 요청정보로부터 쿠키를 가져온다.
            cookieValue = cookieFromRequest[0].getValue();  // 테스트라서 추가 데이터나 보안사항은 고려하지 않으므로 1번째 쿠키만 가져옴
        }
        // 쿠키 세션 입력
        if (session.getAttribute(bno+":cookie") == null) {
            session.setAttribute(bno+":cookie", bno + ":" + cookieValue);
        } else {
            session.setAttribute(bno+":cookie ex", session.getAttribute(bno+":cookie"));
            if (!session.getAttribute(bno+":cookie").equals(bno + ":" + cookieValue)) {
                session.setAttribute(bno+":cookie", bno + ":" + cookieValue);
            }
        }
// 쿠키와 세션이 없는 경우 조회수 카운트
        if (!session.getAttribute(bno+":cookie").equals(session.getAttribute(bno+":cookie ex"))) {
            instructorService.qnaCountUp(bno);
            dto.setCnt(dto.getCnt()+1);
            // 가시적으로  조회수 1 추가해줌  board.setVisited(board.getVisited() + 1);
        }





        System.out.println(comment.toString());
        return "/instructor/instructorQNADetail";
    }

    @GetMapping("instructorQNApw.do")
    public String qnaPw(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        model.addAttribute("bno", request.getParameter("bno"));
        return "/instructor/instructorQNAPw";
    }

    @PostMapping("instructorQNACheck.do")
    public String signIn(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        String pw = request.getParameter("pw");
        boolean check = instructorService.check(bno, pw);
        if(check) { // 비밀번호 일치
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호 확인');</script>");
            out.flush();
            InstructorQna dto = instructorService.qnaDetail(bno);
            List<InstructorQna> comment = instructorService.commentList(bno);
            model.addAttribute("dto", dto);
            model.addAttribute("comment", comment);
            System.out.println(comment.toString());
            return "/instructor/instructorQNADetail";
        } else { // 비밀번호 불 일치
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 일치하지 않습니다.');</script>");
            out.flush();
            model.addAttribute("bno", bno);
            return "/instructor/instructorQNAPw";
        }
    }


    @GetMapping("instructorQNAInsert.do")
    public String insertQNAForm(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        return "/instructor/instructorQNAInsert";
    }

    @RequestMapping(value="instructorQNAInsert.do", method = RequestMethod.POST)
    public String memberWrite(HttpServletRequest request, InstructorQna qna, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        System.out.println(qna.toString());
        qna.setInstructorno(no);
        qna.setAuthor((String) session.getAttribute("sid"));
        if(qna.getPw() != null && !qna.getPw().equals("")) {
            String ppw = qna.getPw();
            String pw = pwEncoder.encode(ppw);
            qna.setPw(pw);
        }
        instructorService.qnaInsert(qna);

        return "redirect:/instructor/instructorQNA.do?no="+no;
    }

    @PostMapping("instructorQNACommentInsert.do")
    public String commentInsert(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        InstructorQna dto = new InstructorQna();
        dto.setAuthor(request.getParameter("id"));
        dto.setBno(Integer.parseInt(request.getParameter("bno")));
        dto.setContent(request.getParameter("content"));
        dto.setInstructorno(no);
        instructorService.commentInsert(dto);
        return "redirect:/instructor/instructorQNADetail.do?bno="+dto.getBno()+"&no="+no;
    }

    @GetMapping("instructorQNADelete.do")
    public String qnaDelete(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        InstructorQna dto = new InstructorQna();
        instructorService.qnaDelete(bno);
        instructorService.commentDeleteAll(bno);
        return "redirect:instructorQNA.do?no="+no;

    }

    //댓글 삭제
    @GetMapping("instructorQNAComDelete.do")
    public String qnaComDelete(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        int par = Integer.parseInt(request.getParameter("par"));
        InstructorQna dto = new InstructorQna();
        dto.setPar(par);
        instructorService.qnaDelete(bno);

        return "redirect:/instructor/instructorQNADetail.do?bno="+par+"&no="+no;
//        instructorQNADetail.do?bno=2&no=1
    }

    @GetMapping("instructorQNAEdit.do")
    public String editForm(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        InstructorQna dto = instructorService.qnaDetail(bno);
        model.addAttribute("dto", dto);
        return "/instructor/instructorQNAEdit";
    }

    @PostMapping("instructorQNAEdit.do")
    public String qnaEdit(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        InstructorQna dto = new InstructorQna();
        dto.setBno(bno);
        dto.setTitle(request.getParameter("title"));
        dto.setContent(request.getParameter("content"));
        instructorService.qnaEdit(dto);
        return "redirect:/instructor/instructorQNAEetail.do?bno="+dto.getBno()+"&no="+no;
    }

    @GetMapping("instructorQNACommentEdit.do")
    public String editCommentForm(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        InstructorQna dto = instructorService.qnaDetail(bno);
        model.addAttribute("dto", dto);
        return "/instructor/qnaComEdit";
    }

    @PostMapping("instructorQNACommentEdit.do")
    public String qnaCommentEdit(HttpServletRequest request, Model model) throws Exception {
        //선생님 정보
        int no = Integer.parseInt(request.getParameter("no"));
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        int bno = Integer.parseInt(request.getParameter("bno"));
        int par = Integer.parseInt(request.getParameter("par"));
        InstructorQna dto = new InstructorQna();
        dto.setBno(bno);
        dto.setPar(par);
        dto.setTitle(request.getParameter("title"));
        dto.setContent(request.getParameter("content"));
        System.out.println(dto.toString());
        instructorService.qnaEdit(dto);
        return "redirect:/instructor/detail.do?bno="+dto.getPar();
    }







    //자료실
    @GetMapping("instructorFile.do")
    public String getInstructorFile(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);


        //자료실 목록
        List<InstructorFile> instructorFiles = instructorService.getInstructorFileList(no);
        model.addAttribute("instructorFiles",instructorFiles);

        return "/instructor/instructorFile";
    }

    @GetMapping("instructorFileAdd.do")
    public String instructorFileAddForm(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        return "/instructor/instructorFileAdd";
    }

    @PostMapping("instructorFileAdd.do")
    public String instructorFileAdd(HttpServletRequest req, Model model) {
        MultipartHttpServletRequest files = (MultipartHttpServletRequest) req;
        int no = Integer.parseInt(req.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);
        // 파일 처리
        MultipartFile sfile1 = files.getFile("sfile1");
        MultipartFile sfile2 = files.getFile("sfile2");
        MultipartFile sfile3 = files.getFile("sfile3");

        // 다른 폼 필드 처리
        InstructorFile instructorFile = new InstructorFile();
        instructorFile.setTitle(files.getParameter("title"));
        instructorFile.setContent(files.getParameter("content"));
        instructorFile.setInstructorno(no);


        // 개발 서버 파일 저장 경로
//        String uploadDir = "D:/spring_study/pro04/src/main/webapp/resources/upload/"; // 회사
        String uploadDir = "/Users/juncheol/Desktop/team_pro4/team14/src/main/webapp/resources/upload/"; // 회사
        // String uploadDir = "E:/git/spring_study/pro04/src/main/webapp/resources/upload/"; // 집
        // 실제 서버 파일 저장 경로
        String uploadSev = req.getRealPath("/resources/upload/");

        // 실제 파일 이름 db 저장
        InstFile instFile = new InstFile();



        if (!sfile1.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile1.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            instructorFile.setSfile1(RandomFileName);

            try {
                sfile1.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile1.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                instFile.setSfile(RandomFileName);
                instFile.setRealName(OriginalFilename);
                instructorService.setInstFile(instFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile2.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile2.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            instructorFile.setSfile2(RandomFileName);

            try {
                sfile2.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile2.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                instFile.setSfile(RandomFileName);
                instFile.setRealName(OriginalFilename);
                instructorService.setInstFile(instFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        if (!sfile3.isEmpty()) {
            String randomUUID = UUID.randomUUID().toString(); // 파일 이름 중복 방지를 위한 랜덤 설정
            String OriginalFilename = sfile3.getOriginalFilename();
            String Extension = OriginalFilename.substring(OriginalFilename.lastIndexOf("."));
            String RandomFileName = randomUUID + Extension;
            instructorFile.setSfile3(RandomFileName);

            try {
                sfile3.transferTo(new File(uploadDir + RandomFileName)); // 개발 서버용
                sfile3.transferTo(new File(uploadSev + RandomFileName)); // 운영 서버용
                instFile.setSfile(RandomFileName);
                instFile.setRealName(OriginalFilename);
                instructorService.setInstFile(instFile);
            } catch (IOException e) {
                e.printStackTrace(); // 오류 처리
            }
        }

        instructorService.addInstructorFile(instructorFile);

        return "redirect:/instructor/instructorFile.do?no="+no;
    }

    //자료실 상세
    @RequestMapping(value = "instructorFileDetail.do", method = RequestMethod.GET)
    public String instructorFileDetail(HttpServletRequest req,Model model, @RequestParam("fileNo") int fileNo) {
        int no = Integer.parseInt(req.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);




//        instructorService.countUp(fileNo); // 조회수 갱신
        InstructorFile instructorFile = instructorService.getInstructorFile(fileNo);

        List<String> fileList = new ArrayList<>();
        int cnt = 0;
        String realName1 = "";
        String realName2 = "";
        String realName3 = "";
        if(instructorFile.getSfile1()!=null) {
            cnt += 1;
             realName1 = instructorService.getInstFileName(instructorFile.getSfile1());
//            fileList.add(realName1);

        }
        if(instructorFile.getSfile2()!=null) {
            cnt += 1;
             realName2 = instructorService.getInstFileName(instructorFile.getSfile2());
//            fileList.add(realName);
        }
        if(instructorFile.getSfile3()!=null) {
            cnt += 1;
             realName3 = instructorService.getInstFileName(instructorFile.getSfile3());
//            fileList.add(realName);
        }
        model.addAttribute("realName1",realName1);
        model.addAttribute("realName2",realName2);
        model.addAttribute("realName3",realName3);
        model.addAttribute("fileList",fileList);
        model.addAttribute("instructorFile",instructorFile);

        HttpSession session = req.getSession();
        Cookie[] cookieFromRequest = req.getCookies();
        String cookieValue = null;
        for(int i = 0 ; i<cookieFromRequest.length; i++) {
            // 요청정보로부터 쿠키를 가져온다.
            cookieValue = cookieFromRequest[0].getValue();  // 테스트라서 추가 데이터나 보안사항은 고려하지 않으므로 1번째 쿠키만 가져옴
        }
        // 쿠키 세션 입력
        if (session.getAttribute(fileNo+":cookieInst") == null) {
            session.setAttribute(fileNo+":cookieInst", fileNo + ":" + cookieValue);
        } else {
            session.setAttribute(fileNo+":cookieInst ex", session.getAttribute(fileNo+":cookieInst"));
            if (!session.getAttribute(fileNo+":cookieInst").equals(fileNo + ":" + cookieValue)) {
                session.setAttribute(fileNo+":cookieInst", fileNo + ":" + cookieValue);
            }
        }
// 쿠키와 세션이 없는 경우 조회수 카운트
        if (!session.getAttribute(fileNo+":cookieInst").equals(session.getAttribute(fileNo+":cookieInst ex"))) {
            instructorService.fileCountUp(fileNo);
            instructorFile.setCnt(instructorFile.getCnt()+1);
            // 가시적으로  조회수 1 추가해줌  board.setVisited(board.getVisited() + 1);
        }


        return "/instructor/instructorFileDetail";
    }

    //자료실 글 삭제
    @RequestMapping(value = "instructorFileDelete.do", method = RequestMethod.GET)
    public String instructorFileDelete(HttpServletRequest request, @RequestParam("fileNo") int fileNo, Model model) {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);


        instructorService.instructorFileDelete(fileNo); //

        return "redirect:/instructor/instructorFile.do?no="+no;
    }

    //후기
    @GetMapping("instructorReview.do")
    public String getInstructorReview(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));

        //선생님 정보
        Instructor instructor = instructorService.getInstructor(no);
        model.addAttribute("instructor", instructor);

        //후기 목록
        List<Review> reviewList = instructorService.getReviewList(no);
        model.addAttribute("reviewList",reviewList);


        return "/instructor/instructorReview";
    }

    // 선생님 담당 과목
    @PostMapping("getInstCate.do")
    public void getInstCate(HttpServletRequest req, HttpServletResponse res, Model model) throws Exception {
        int ino = Integer.parseInt(req.getParameter("ino"));

        System.out.println("ino "+ino);
        Report report = new Report();

        String cate = instructorService.getInstCate(ino);

        JSONObject json = new JSONObject();
        json.put("result", cate);
        PrintWriter out = res.getWriter();
        out.println(json.toString());
        System.out.println(json.toString());
    }


}
