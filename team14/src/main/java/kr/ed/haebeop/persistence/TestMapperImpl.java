package kr.ed.haebeop.persistence;
import kr.ed.haebeop.domain.TestVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TestMapperImpl implements TestMapper {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<TestVO> testList() throws Exception {
        return sqlSession.selectList("test.testList");
    }

    @Override
    public TestVO getTest(int num) throws Exception {
        return sqlSession.selectOne("test.getTest");
    }

    @Override
    public void testInsert(TestVO test) throws Exception {
        sqlSession.insert("test.testInsert", test);
    }

    @Override
    public List<TestVO> testList2() {
        return sqlSession.selectList("testList2");
    }

    @Override
    public TestVO getTest2(int num) {
        return null;
    }

    @Override
    public void insert2(TestVO test) {

    }

    @Override
    public void update2(TestVO test) {

    }

    @Override
    public void delete2(int num) {

    }
}
