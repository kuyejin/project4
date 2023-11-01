package kr.ed.haebeop.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AuthRepositoryImpl implements AuthRepository{
    @Autowired
    SqlSession sqlsession;

   /* private static String nameSpace = "kr.ed.haebeop.mapper.AuthMapper.";
    @Override
    public List<String> getAuthList(int auth_id) throws Exception{
        return session.selectList(nameSpace + "getAuthList", auth_id);
    }*/

    public List<String> getAuthList(int state_cd) throws Exception{
        return sqlsession.selectList("auth.getAuthList" , state_cd);
    }
}
