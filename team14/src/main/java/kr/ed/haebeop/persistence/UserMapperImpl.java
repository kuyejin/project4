package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserMapperImpl implements UserMapper {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<User> userList() throws Exception {
        return sqlSession.selectList("user.userList");
    }

    @Override
    public User getUser(String id) throws Exception {
        return sqlSession.selectOne("user.getUser", id);
    }

    @Override
    public void userInsert(User dto) throws Exception {
        sqlSession.insert("user.userInsert", dto);
    }

    @Override
    public User signIn(User mdto) throws Exception {
        return sqlSession.selectOne("user.signIn", mdto);
    }

    @Override
    public User loginCheck(User mdto) throws Exception {
        return sqlSession.selectOne("user.loginCheck", mdto);
    }

    @Override
    public User login(User mdto) throws Exception {
        return sqlSession.selectOne("user.login", mdto);
    }

    @Override
    public void userUpdate(User mdto) throws Exception {
        sqlSession.update("user.userUpdate", mdto);
    }

    @Override
    public void userDelete(String id) throws Exception {
        sqlSession.delete("user.userDelete");
    }
}
