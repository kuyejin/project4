package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.persistence.InstructorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InstructorServiceImpl implements InstructorService{

    @Autowired
    InstructorMapper instructorMapper;

    private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

    @Override
    public List<Lecture> getInstructorLectureList(int no) {
        return instructorMapper.getInstructorLectureList(no);
    }

    @Override
    public List<InstructorNotice> getInstructorNoticeList(int no) {
        return instructorMapper.getInstructorNoticeList(no);
    }

    @Override
    public InstructorNotice getInstructorNoticeDetail(int noticeNo) {
//        instructorMapper.instructorNoticeCountUp(noticeNo);
        return instructorMapper.getInstructorNoticeDetail(noticeNo);
    }

    @Override
    public void noticeInsert(InstructorNotice dto) throws Exception {
        instructorMapper.noticeInsert(dto);
    }

    @Override
    public void noticeDelete(int no) throws Exception {
        instructorMapper.noticeDelete(no);
    }

    @Override
    public void noticeEdit(InstructorNotice dto) throws Exception {
        instructorMapper.noticeEdit(dto);
    }

    @Override
    public void instructorNoticeCountUp(int noticeNo) {
        instructorMapper.instructorNoticeCountUp(noticeNo);
    }

    //선생님 리스트
    @Override
    public List<Instructor> getInstructorList() {
        return instructorMapper.getInstructorList();
    }

    @Override
    public Instructor getInstructor(int no) {
        return instructorMapper.getInstructor(no);
    }

    @Override
    public Instructor getInstructorById(String id) {
        return instructorMapper.getInstructorById(id);
    }

    //QNA

    @Override
    public List<InstructorQna> instructorQnaList(int no) {
        return instructorMapper.instructorQnaList(no);
    }
    @Override
    public InstructorQna qnaDetail(int bno) throws Exception {
//        instructorMapper.qnaCountUp(bno);
        return instructorMapper.qnaDetail(bno);
    }

    @Override
    public void qnaInsert(InstructorQna dto) throws Exception {
        instructorMapper.qnaInsert(dto);
    }

    @Override
    public void qnaDelete(int bno) throws Exception {
        instructorMapper.qnaDelete(bno);
    }

    @Override
    public void qnaEdit(InstructorQna dto) throws Exception {
        instructorMapper.qnaEdit(dto);
    }

    @Override
    public void commentInsert(InstructorQna dto) throws Exception {
        instructorMapper.commentInsert(dto);
    }

    @Override
    public List<InstructorQna> commentList(int bno) throws Exception {
        return instructorMapper.commentList(bno);
    }

    @Override
    public void commentDeleteAll(int bno) throws Exception {
        instructorMapper.commentDeleteAll(bno);
    }

    @Override
    public boolean check(int bno, String pw) throws Exception {
        boolean comp = false;
        InstructorQna qna = instructorMapper.qnaDetail(bno);
        boolean check = pwEncoder.matches(pw, qna.getPw()); // 입력된 비밀번호와 db의 암호화된 비밀번호 비교
        if(qna != null && check) {
            comp = true;
        }
        return comp;
    }

    @Override
    public void qnaCountUp(int bno) {
        instructorMapper.qnaCountUp(bno);
    }

    @Override
    public List<InstructorFile> getInstructorFileList(int no) {
        return instructorMapper.getInstructorFileList(no);
    }

    @Override
    public void setInstFile(InstFile instFile) {
        instructorMapper.setInstFile(instFile);
    }

    @Override
    public void addInstructorFile(InstructorFile instructorFile) {
       instructorMapper.addInstructorFile(instructorFile);
    }

    @Override
    public InstructorFile getInstructorFile(int fileNo) {
//        instructorMapper.fileCountUp(fileNo);
        return instructorMapper.getInstructorFile(fileNo);
    }

    @Override
    public void fileCountUp(int fileNo) {
        instructorMapper.fileCountUp(fileNo);
    }

    @Override
    public String getInstFileName(String sfile) {
        return instructorMapper.getInstFileName(sfile);
    }

    @Override
    public void instructorFileDelete(int no) {
        instructorMapper.instructorFileDelete(no);
    }

    @Override
    public List<Review> getReviewList(int no) {
        return instructorMapper.getReviewList(no);
    }

    // 선생님 과목 추출

    @Override
    public String getInstCate(int no) {
        return instructorMapper.getInstCate(no);
    }
}
