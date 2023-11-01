package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Grade;
import kr.ed.haebeop.domain.Instructor;
import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.service.GradeServiceImpl;
import kr.ed.haebeop.service.InstructorService;
import kr.ed.haebeop.service.MemberService;
import kr.ed.haebeop.service.MyclassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

// /grade/gradeList.do
@Controller
@RequestMapping("/grade/*")
public class GradeController {
    @Autowired
    private GradeServiceImpl gradeService;

    @Autowired
    private MyclassService myclassService;

    @Autowired
    private MemberService memberService;
    @Autowired
    private InstructorService instructorService;

    @Autowired
    HttpSession session; // 세션 생성

    @GetMapping("list.do") // 수정, 입력, 삭제 가능한 성적표 게시판
    public String gradeList(HttpServletResponse response, HttpServletRequest request ,Model model) throws Exception {
        Grade grade = new Grade();
        System.out.println("버튼 클릭");
        if(session.getAttribute("sid") != null && !"".equals(session.getAttribute("sid"))) {
            int no = Integer.parseInt(request.getParameter("no"));
            String id = (String) session.getAttribute("sid");

            //선생님 정보
            Instructor instructor = instructorService.getInstructor(no);
            model.addAttribute("instructor", instructor);
            List<Grade> gradeList = gradeService.gradeList(id);
            model.addAttribute("gradeList", gradeList);
            return "/instructor/instructorGradeList";
        } else {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('해당 페이지는 회원만 접근 가능합니다.');</script>");
            out.flush();
            return "/index";
        }
    }

    @GetMapping("slist.do") // 학생 전용 성적표 게시판 (상세보기까지만 가능)
    public String sgradeList(HttpServletResponse response, HttpServletRequest request ,Model model) throws Exception {
        System.out.println("버튼 클릭");
        if(session.getAttribute("sid") != null && !"".equals(session.getAttribute("sid"))) {
            String stuid = (String)session.getAttribute("sid");

            //topbar정보
            Member member = memberService.getMember(stuid);
            System.out.println("내 정보: " + member);
            model.addAttribute("member", member);

            //최근 수강 중인 강의 수
            int count = myclassService.takingCount(stuid);
            model.addAttribute("count",count);






            List<Grade> sgradeList = gradeService.sgradeList(stuid);
            model.addAttribute("sgradeList", sgradeList);
            return "/grade/sgradeList";
        } else {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('해당 페이지는 회원만 접근 가능합니다.');</script>");
            out.flush();
            return "/index";
        }
    }


    @GetMapping("gradedetail.do")	//info/detail.do?bno=1
    public String gradeDetail(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));
        Grade grade = gradeService.gradeDetail(no);
        model.addAttribute("grade", grade);
        return "/grade/gradeDetail";
    }

    @GetMapping("gradeinsert.do")
    public String insertForm(HttpServletRequest request, Model model) throws Exception {
        return "/grade/gradeInsert";
    }

    @PostMapping("gradeinsert.do")
    public String gradeInsert(HttpServletRequest request, Model model) throws Exception {
        Grade grade = new Grade();
        //grade.setNo(Integer.parseInt(request.getParameter("no")));
        grade.setStuname(request.getParameter("stuname"));
        grade.setStuid(request.getParameter("stuid"));
        grade.setKor(Integer.parseInt(request.getParameter("kor")));
        grade.setMath(Integer.parseInt(request.getParameter("math")));
        grade.setEng(Integer.parseInt(request.getParameter("eng")));
        grade.setSocial(Integer.parseInt(request.getParameter("social")));
        grade.setScience(Integer.parseInt(request.getParameter("science")));
        grade.setExam(request.getParameter("exam"));
        grade.setTname(request.getParameter("tname"));
        grade.setTid(request.getParameter("tid"));
        gradeService.gradeInsert(grade);



        return "/grade/gblankpage";
    }

    @GetMapping("gradedelete.do")
    public String gradeDelete(HttpServletRequest request, Model model) throws Exception {
    int no = Integer.parseInt(request.getParameter("no"));
        gradeService.gradeDelete(no);
        int instNo = (Integer) session.getAttribute("instNo");
        return "redirect:list.do?no="+instNo;
    }

    @GetMapping("gradeedit.do")
    public String updateForm(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));
        Grade grade = gradeService.gradeDetail(no);
        model.addAttribute("grade", grade);
        return "/grade/gradeEdit";
    }

    @PostMapping("gradeedit.do")
    public String gradeEdit(HttpServletRequest request, Model model) throws Exception {
        int no = Integer.parseInt(request.getParameter("no"));
        Grade grade = new Grade();
        grade.setExam(request.getParameter("exam"));
        grade.setKor(Integer.parseInt(request.getParameter("kor")));
        grade.setMath(Integer.parseInt(request.getParameter("math")));
        grade.setEng(Integer.parseInt(request.getParameter("eng")));
        grade.setSocial(Integer.parseInt(request.getParameter("social")));
        grade.setScience(Integer.parseInt(request.getParameter("science")));
        grade.setNo(no);
        gradeService.gradeEdit(grade);
        return "/grade/gblankpage";
    }

}
