package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Faq;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FaqRepositoryImpl implements FaqRepository {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Faq> faqList() throws Exception {
        return sqlSession.selectList("faq.faqList");
    }
}
