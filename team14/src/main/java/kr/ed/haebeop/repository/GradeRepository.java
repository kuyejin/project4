package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Grade;

import java.util.List;

public interface GradeRepository {
    public List<Grade> gradeList(String id) throws Exception;
    public List<Grade> sgradeList(String id) throws Exception; //학생 전용 게시판
    public Grade gradeDetail(int no) throws Exception;
    public void gradeInsert(Grade grade) throws Exception;
    public void gradeDelete(int no) throws Exception;
    public void gradeEdit(Grade grade) throws Exception;
}