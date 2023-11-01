package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Grade;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GradeRepositoryImpl implements GradeRepository {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Grade> gradeList(String id) throws Exception {
        return sqlSession.selectList("grade.gradeList", id);
    }
    @Override
    public List<Grade> sgradeList(String id) throws Exception {
        return sqlSession.selectList("grade.sgradeList", id);
    }

    @Override
    public Grade gradeDetail(int no) throws Exception {
        return sqlSession.selectOne("grade.gradeDetail", no);
    }


    @Override
    public void gradeInsert(Grade grade) throws Exception {
        sqlSession.insert("grade.gradeInsert", grade);
    }

    @Override
    public void gradeDelete(int no) throws Exception {
        sqlSession.delete("grade.gradeDelete", no);
    }

    @Override
    public void gradeEdit(Grade grade) throws Exception {
        sqlSession.update("grade.gradeEdit", grade);
    }

}
