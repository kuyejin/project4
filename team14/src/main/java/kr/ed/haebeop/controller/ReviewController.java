package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Report;
import kr.ed.haebeop.domain.Review;
import kr.ed.haebeop.service.ReviewService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/review/*")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;
    @Autowired
    HttpSession session; // 세션 생성
    
    // 리뷰 추가
    @PostMapping("insertReview.do")
    public String insertReview(HttpServletRequest req, HttpServletResponse res, Review review, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        review.setId(id);
        int ck = reviewService.reviewCheck(review);
        if(ck == 0) {
            reviewService.insertReview(review);
        } else {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = res.getWriter();
            out.println("<script>");
            out.println("alert('이미 리뷰를 작성하였습니다.');");
            out.println("location.href='"+req.getContextPath()+"/lecture/getLecture?no=" + review.getPar() + "';");
            out.println("</script>");
            out.flush();
        }
        return "redirect:/lecture/getLecture?no=" + review.getPar();
    }
    
    // 리뷰 제거
    @GetMapping("deleteReview.do")
    public String deleteReview(HttpServletRequest req,  Model model) throws Exception {
        Review review = new Review();
        String id = (String) session.getAttribute("sid");
        int par = Integer.parseInt(req.getParameter("par"));
        review.setId(id);
        review.setPar(par);
        reviewService.deleteReview(review);
        return "redirect:/lecture/getLecture?no=" + par;
    }
    
    // 유저가 자신이 쓴 리뷰 목록
    @GetMapping("memReviewList.do")
    public String memReviewList(HttpServletRequest req, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        List<Review> rvList = reviewService.getReviewListId(id);
        model.addAttribute("rvList", rvList);
        return "/member/mypage/revList";
    }
    
    // 리뷰 수정 폼 이동
    @GetMapping("updateReviewForm.do")
    public String updateReviewForm(HttpServletRequest req, Model model) throws Exception {
        int par = Integer.parseInt(req.getParameter("par"));
        String id = (String) session.getAttribute("sid");

        Review review = new Review();
        review.setPar(par);
        review.setId(id);

        Review noti = reviewService.getReview(review);
        model.addAttribute("noti", noti);
        return "/review/updateReview";
    }
    
    // 리뷰 수정
    @PostMapping("updateReview.do")
    public String updateReview(HttpServletRequest req, Review review, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        review.setId(id);
        reviewService.updateReview(review);
        return "redirect:/lecture/getLecture?no=" + review.getPar();
    }

    //리뷰 신고 팝업 창
    @RequestMapping("reportPopup.do")
    public String reportPopup(HttpServletRequest request, Model model) throws Exception {
        return "/review/reportPopup";
    }

    //팝업창에서 리뷰 신고 버튼 눌렀을때 처리
    @RequestMapping(value = "report.do", method = RequestMethod.POST)
    public void report(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        String reason = request.getParameter("reason");
        int bno = Integer.parseInt(request.getParameter("bno"));

        System.out.println("id "+id);
        System.out.println("rea "+reason);
        System.out.println("bno "+bno);
        Report report = new Report();
        report.setReporter(id);
        report.setReason(reason);
        report.setBoard_bno(bno);
        boolean result = false;
        int chk1 = reviewService.selectCheckReportCnt(report);
        if (chk1 == 0) {
            reviewService.insertReportReview(report);
            result = true;
        } else {
            result = false;
        }

        JSONObject json = new JSONObject();
        json.put("result", result);
        PrintWriter out = response.getWriter();
        out.println(json.toString());
        System.out.println(json.toString());
    }

    @PostMapping(value = "chkReported.do")
    public void chkReported(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        int bno = Integer.parseInt(request.getParameter("no"));
        Report report = new Report();
        report.setReporter(id);
        report.setBoard_bno(bno);
        System.out.println(report.toString());
        int chk = reviewService.selectCheckReportCnt(report);

        boolean result = false;
        if (chk != 0) {
            result = true;
        } else {
            result = false;
        }
        JSONObject json = new JSONObject();
        json.put("result", result);
        PrintWriter out = response.getWriter();
        out.println(json.toString());
    }


}
