package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.User;
import kr.ed.haebeop.service.UserService;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

@Controller
@RequestMapping("/user/")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    BCryptPasswordEncoder pwdEncoder;

    @Autowired
    HttpSession session;

    //본인의 회원 정보 보기
    @RequestMapping(value="read", method = RequestMethod.GET)
    public String userRead(Model model, HttpServletRequest request) throws Exception {
        String id = request.getParameter("id");
        User user = userService.getUser(id);
        model.addAttribute("user", user);
        return "/user/userRead";
    }

    //약관 동의 페이지 로딩
    @GetMapping("agree")
    public String getAgree(Model model) throws Exception {
        return "/user/agree";
    }

    //회원가입폼 페이지 로딩
    @GetMapping("join")
    public String getJoin(Model model) throws Exception {
        return "/user/userInsert";
    }

    //ajax 아이디 중복 체크
    @RequestMapping(value="idCheck", method=RequestMethod.POST)
    public void idCheck(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        boolean result = false;
        User dto = new User();
        dto = userService.getUser(id);
        if(dto!=null){	//이미 있는 아이디임
            result = false;
        } else {
            result = true;
        }
        JSONObject json = new JSONObject();
        json.put("result", result);
        PrintWriter out = response.getWriter();
        out.println(json.toString());
    }

    //회원 가입 처리
    @RequestMapping(value="insert", method = RequestMethod.POST)
    public String userWrite(User user, Model model) throws Exception {
        //비밀번호 암호화
        String userpw = user.getPw();
        String pwd = pwdEncoder.encode(userpw);
        user.setPw(pwd);
        userService.userInsert(user);
        return "redirect:/";
    }

    //로그인 폼 로딩
    @RequestMapping("loginForm")
    public String userLoginForm(Model model) throws Exception {
        return "/user/loginForm";
    }

    //로그인 	- 컨트롤러에서 세션 처리
    @RequestMapping(value="signin", method = RequestMethod.POST)
    public String userSignin(@RequestParam String id, @RequestParam String pw, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
        session.invalidate();
        User mdto = new User();
        mdto.setPw(pw);
        mdto.setId(id);
        User login = userService.signIn(mdto);
        boolean loginSuccess = pwdEncoder.matches(mdto.getPw(), login.getPw());
        if(loginSuccess && login!=null) {
            session.setAttribute("user", login);
            session.setAttribute("sid", id);
            return "redirect:/";
        } else {
            return "redirect:loginForm";
        }
    }

    //로그인 - Service에서 세션 처리
    @RequestMapping(value="login", method = RequestMethod.POST)
    public String userLogin(User mdto, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
        boolean loginSuccess = userService.login(req);
        if(loginSuccess) {
            return "redirect:/";
        } else {
            return "redirect:loginForm";
        }
    }

    //Ajax를 이용하는 방법
    @RequestMapping(value="loginCheck.do", method = RequestMethod.POST)
    public String userLoginCtrl(User mdto, RedirectAttributes rttr) throws Exception {
        session.getAttribute("user");
        User user = userService.loginCheck(mdto);
        boolean mat = pwdEncoder.matches(mdto.getPw(), user.getPw());
        if(mat==true && user!=null) {
            logger.info("로그인 성공");
            session.setAttribute("user", user);
            session.setAttribute("sid", user.getId());
            rttr.addFlashAttribute("msg", "로그인 성공");
            return "redirect:/";
        } else {
            logger.info("로그인 실패");
            session.setAttribute("member", null);
            rttr.addFlashAttribute("msg", false);
            return "redirect:loginForm";
        }
    }

    //회원 정보 변경
    @RequestMapping(value="update", method = RequestMethod.POST)
    public String userUpdate(User mdto, Model model) throws Exception {
        String pwd = pwdEncoder.encode(mdto.getPw());
        mdto.setPw(pwd);
        userService.userUpdate(mdto);
        return "redirect:/";
    }

    //회원 탈퇴
    @RequestMapping(value="delete", method = RequestMethod.GET)
    public String userDelete(@RequestParam String id, Model model, HttpSession session) throws Exception {
        userService.userDelete(id);
        session.invalidate();
        return "redirect:/";
    }

    //로그아웃
    @RequestMapping("logout")
    public String userLogout(HttpSession session) throws Exception {
        session.invalidate();
        return "redirect:/";
    }
}