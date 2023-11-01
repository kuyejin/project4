package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Cart;
import kr.ed.haebeop.domain.Instructor;
import kr.ed.haebeop.domain.Lecture;
import kr.ed.haebeop.domain.Payment;
import kr.ed.haebeop.service.CartServiceImpl;
import kr.ed.haebeop.service.InstService;
import kr.ed.haebeop.service.LectureService;
import kr.ed.haebeop.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cart/*")
public class CartController {
    @Autowired
    private CartServiceImpl cartService;
    @Autowired
    private LectureService lectureService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private InstService instService;
    @Autowired
    HttpSession session;

    // 장바구니 목록
    @GetMapping("cartList.do")
    public String cartList(Model model) throws Exception {
        String id = (String) session.getAttribute("sid");

        // 장바구니에 들어있는 개수
        int cartCnt = cartService.cartCnt(id);
        // 해당 id의 장바구니 목록
        List<Cart> cartList = cartService.cartList(id);
        // 강의 제목, 과목, 강사이름 추출
        List<Lecture> lectureList = new ArrayList<>();
        List<Instructor> instList = new ArrayList<>();
        for (int i=0; i<cartList.size(); i++) {
            Lecture lecture = lectureService.getLecture(cartList.get(i).getLec_no());
            Instructor instructor = instService.getInstructorName(lecture.getIno());
            lectureList.add(lecture);
            instList.add(instructor);
        }

        model.addAttribute("cartCnt", cartCnt);
        model.addAttribute("cartList", cartList);
        model.addAttribute("lecList", lectureList);
        model.addAttribute("instList", instList);
        return "/cart/cartList";
    }

    // 장바구니 추가
    @GetMapping("cartInsert.do")
    public String cartInsert(@RequestParam int lec_no, HttpServletResponse res, HttpServletRequest req, Model model) throws Exception {
        String id = (String) session.getAttribute("sid");
        System.out.println(id);
        System.out.println(lec_no);

        // 장바구니에 들어있는 지 확인
        Cart cart = new Cart();
        cart.setId(id);
        cart.setLec_no(lec_no);
        int check = cartService.getCartCheck(cart);
//        System.out.println(check);

        // 이미 결제한 강의 인지 확인
        Payment payment = new Payment();
        payment.setId(id);
        payment.setLec_no(lec_no);
        int check2 = paymentService.checkPayment(payment);

        if(check == 0 && check2 == 0) {
            cartService.cartInsert(cart);
            return "redirect:/cart/cartList.do";
        } else {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = res.getWriter();
            out.println("<script>");
            out.println("alert('이미 수강중이거나 장바구니에 있는 강의 입니다.');");
            out.println("history.back();"); // 브라우저의 이전 페이지로 돌아가기
            out.println("</script>");
            out.flush();
            return null; // 더 이상의 액션을 실행하지 않도록 null을 반환
        }
    }

    // 장바구니 삭제
    @GetMapping("cartDelete.do")
    public String cartDelete(@RequestParam int cartno, Model model) throws Exception {
        cartService.cartDelete(cartno);
        return "redirect:/cart/cartList.do";
    }
}
