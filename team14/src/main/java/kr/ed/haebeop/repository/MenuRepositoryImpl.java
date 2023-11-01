package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Menu;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MenuRepositoryImpl implements MenuRepository {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public Menu getMenu(String sc_name) {
        return sqlSession.selectOne("menu.getSchool", "%"+sc_name+"%");
    }
}
