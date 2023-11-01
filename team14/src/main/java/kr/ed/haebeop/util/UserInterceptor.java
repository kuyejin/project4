package kr.ed.haebeop.util;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class UserInterceptor extends HandlerInterceptorAdapter {

    // 호출되기 전에 사전 작업
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        boolean flag = false;
        HttpSession session = request.getSession(false); // 자동 로그인 방지
        if(session.getAttribute("sid")!=null && session !=null) {
            flag = true;
            System.out.println("** 인터셉터 통과 , 요청 주소 **"+request.getRequestURI());
        } else {
            flag = false;
            System.out.println("** 인터셉터 실패 **"+request.getRequestURI());
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('해당 페이지는 회원만 접근 가능합니다.');");
            out.println("location.href='"+request.getContextPath()+"/member/login.do';"); // 페이지 리디렉션을 JavaScript로 수행
            out.println("</script>");
            out.flush();


//            response.sendRedirect(request.getContextPath()+"/member/login.do");
        }
        return flag;
    }
}
