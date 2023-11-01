package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.util.DateCalculator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

// 강의 신청, 구매

@Controller
@RequestMapping("/payment/*")
public class PaymentController {
    @Autowired
    private LectureService lectureService;      // 강의
    @Autowired
    private MemberServiceImpl memberService;    // 회원
    @Autowired
    private InstService instService;            // 선생님, 강사
    @Autowired
    private PaymentService paymentService;      // 결제
    @Autowired
    private CartServiceImpl cartService;        // 장바구니
    @Autowired
    private CourseService courseService;    // 수강
    @Autowired
    HttpSession session;                        // 세션 생성

    // 수강 신청, 결제 폼
    @GetMapping("addPayment.do")
    public String addPayment(@RequestParam int lec_no, HttpServletRequest req, HttpServletResponse response, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        Payment payment = new Payment();
        payment.setId(id);
        payment.setLec_no(lec_no);
        int check1 = paymentService.checkPayment(payment); // 결제 내역에 있는지 확인

        // 강의 정보
        Lecture lecture = lectureService.getLecture(lec_no);

        if(check1 == 0 && lecture.getLec() < lecture.getLec_max()) {
            // 선생님 정보
            Instructor instructor = instService.getInstructorName(lecture.getIno());
            // 회원 정보
            Member member = memberService.getMember(id);
            model.addAttribute("pro", lecture);
            model.addAttribute("inst", instructor);
            model.addAttribute("member", member);

            return "/payment/addPayment";
        } else {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('이미 수강하고 있거나 수강생 한도가 초과된 강의 입니다.');");
            out.println("history.back();"); // 브라우저의 이전 페이지로 돌아가기
            out.println("</script>");
            out.flush();
            return null; // 더 이상의 액션을 실행하지 않도록 null을 반환
        }
    }
    
    // 강의 결제
    @PostMapping("addPayment.do")
    public String addPaymentPro(@ModelAttribute Payment payment, HttpServletResponse res, HttpServletRequest req, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        int lec_no = payment.getLec_no();

        Lecture lecture = lectureService.getLecture(lec_no);

        if(lecture.getLec() < lecture.getLec_max()) {
            lectureService.countUpLec(lec_no); // 수강 인원 현황 +1

            payment.setId(id);
            paymentService.paymentInsert(payment); // 결제 내역 추가
            Member member = memberService.getMember(id); // 결제한 회원정보 추출
            member.setPt(payment.getPt()); // 포인트
            memberService.memberPointSub(member); // 사용한 포인트 차감


            //수강 신청
            Course course = new Course();
            course.setSid(id);
            course.setLec_no(lec_no);
            courseService.courseInsert(course);


            Cart cart = new Cart();
            cart.setLec_no(lec_no);
            cart.setId(payment.getId());

            // 카트에 있으면 제거
            try {
                int cartno = cartService.getCart(cart);
                cartService.cartDelete(cartno);
            } catch (Exception e) {

            }
            return "redirect:/";
        } else {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = res.getWriter();
            out.println("<script>");
            out.println("alert('에러가 발생했습니다. 메인으로 이동합니다.');");
            out.println("location.href='"+req.getContextPath()+"/';"); // 메인페이지로 이동
            out.println("</script>");
            out.flush();
            return null; // 더 이상의 액션을 실행하지 않도록 null을 반환
        }
    }



    // 결제 목록
    @GetMapping("paymentList.do")
    public String paymentList(Model model) throws Exception{
        String id = (String) session.getAttribute("sid");
        List<Payment> payList =  paymentService.paymentMemList(id);
        model.addAttribute("payList", payList);
        return "/member/myPage/paymentList";
    }

    // 강의 구매 확정
    @GetMapping("buyPayment.do")
    public String buyPayment(HttpServletRequest req, Model model) throws Exception {
        int sno = Integer.parseInt(req.getParameter("sno"));
        DateCalculator dateCalculator = new DateCalculator();
        Member member = new Member();
        String id = (String) session.getAttribute("sid");
        int pt = (int) Double.parseDouble(req.getParameter("pt"));
        member.setId(id);
        member.setPt(pt);

        paymentService.buyPayemnt(sno);
        Payment payment = paymentService.getPayment(sno);
        String buyDate = payment.getBuydate(); // 사용자가 강의를 구매한 날
        Lecture lec = lectureService.getLecture(payment.getLec_no());
        int endDay = lec.getEndDay(); // 강의 정보에 게시된 수강일
        String endDate = dateCalculator.endDays(buyDate, endDay); // 마지막 날 구하기
        payment.setEnddate(endDate);
        memberService.memberPoint(member);
        paymentService.updateEndPayment(payment);
        return "redirect:/payment/paymentList.do";
    }
    
    // 환불, 취소
    @GetMapping("returnPayment.do")
    public String returnPayment(@RequestParam int sno) throws Exception{
        // 사용한 포인트 반환
        Payment payment = paymentService.getPayment(sno);
        Member member = memberService.getMember(payment.getId());
        member.setPt(payment.getPt());
        memberService.memberPoint(member);

        // 수강 인원 현황 -1
        lectureService.countDownLec(payment.getLec_no());
        
        // 결제 내역 삭제
        paymentService.paymentDelete(sno);

        return "redirect:/payment/paymentList.do";
    }

}
