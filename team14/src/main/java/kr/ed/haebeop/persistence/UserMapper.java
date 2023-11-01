package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.User;

import java.util.List;

public interface UserMapper {

    public List<User> userList() throws Exception;
    public User getUser(String id) throws Exception;
    public void userInsert(User dto) throws Exception;
    public User signIn(User mdto) throws Exception;
    public User loginCheck(User mdto) throws Exception;
    public User login(User mdto) throws Exception;
    public void userUpdate(User mdto) throws Exception;
    public void userDelete(String id) throws Exception;
}
