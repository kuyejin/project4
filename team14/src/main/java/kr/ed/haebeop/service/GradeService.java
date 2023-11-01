package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Grade;

import java.util.List;

public interface GradeService {
    public List<Grade> gradeList(String id) throws Exception;
    public List<Grade> sgradeList(String id) throws Exception;
    public Grade gradeDetail(int no) throws Exception;
    public void gradeInsert(Grade grade) throws Exception;
    public void gradeDelete(int no) throws Exception;
    public void gradeEdit(Grade grade) throws Exception;
}

