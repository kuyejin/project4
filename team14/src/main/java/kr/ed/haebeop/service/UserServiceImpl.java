package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.User;
import kr.ed.haebeop.persistence.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserMapper userMapper;
    
    BCryptPasswordEncoder pwdEncoder;

    @Override
    public List<User> userList() throws Exception {
        return userMapper.userList();
    }

    @Override
    public User getUser(String id) throws Exception {
        return userMapper.getUser(id);
    }

    @Override
    public void userInsert(User dto) throws Exception {
        userMapper.userInsert(dto);
    }

    @Override
    public User signIn(User mdto) throws Exception {
        return userMapper.signIn(mdto);
    }

    @Override
    public User loginCheck(User mdto) throws Exception {
        return userMapper.loginCheck(mdto);
    }

    @Override
    public boolean login(HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        boolean loginSuccess = false;
        User mdto = new User();

        mdto.setId(request.getParameter("id"));
        mdto.setPw(request.getParameter("pw"));

        User login = userMapper.login(mdto);

        loginSuccess =  pwdEncoder.matches(mdto.getPw(), login.getPw());
        if(login != null && loginSuccess==true) {
            session.setAttribute("user", login);
            session.setAttribute("sid", login.getId());
            loginSuccess = true;
        }
        return loginSuccess;
    }

    @Override
    public void userUpdate(User mdto) throws Exception {
        userMapper.userUpdate(mdto);
    }

    @Override
    public void userDelete(String id) throws Exception {
        userMapper.userDelete(id);
    }
}
