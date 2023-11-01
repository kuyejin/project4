package kr.ed.haebeop.service;


import kr.ed.haebeop.domain.*;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface InstructorService {
    public List<Lecture> getInstructorLectureList(int no);

    //공지
    public List<InstructorNotice> getInstructorNoticeList(int no);
    public InstructorNotice getInstructorNoticeDetail(int noticeNo);
    public void noticeInsert(InstructorNotice dto) throws Exception;
    public void noticeDelete(int no) throws Exception;
    public void noticeEdit(InstructorNotice dto) throws Exception;
    void instructorNoticeCountUp(int noticeNo);

    //
    public List<Instructor> getInstructorList();
    public Instructor getInstructor(int no);
    public Instructor getInstructorById(String id);

    //QNA
    public List<InstructorQna> instructorQnaList(int no);
    public InstructorQna qnaDetail(int bno) throws Exception;
    public void qnaInsert(InstructorQna dto) throws Exception;
    public void qnaDelete(int bno) throws Exception;
    public void qnaEdit(InstructorQna dto) throws Exception;
    public void commentInsert(InstructorQna dto) throws Exception;
    public List<InstructorQna> commentList(int bno) throws Exception;
    public void commentDeleteAll(int bno) throws Exception;
    public boolean check(int bno, String pw) throws Exception;
    void qnaCountUp(int bno);

    //자료실 리스트
    public List<InstructorFile> getInstructorFileList(int no);
    public void setInstFile(InstFile instFile);

    public void addInstructorFile(InstructorFile instructorFile);
    public InstructorFile getInstructorFile(int fileNo);
    // 파일의 실제 이름 출력
    public String getInstFileName(String sfile);

    //자료실 글 삭제
    void instructorFileDelete(int no);
    List<Review> getReviewList(int no);
    //자료실 조회수
    void fileCountUp(int fileNo);

    // 선생님 과목 추출
    public String getInstCate(int no);
}
