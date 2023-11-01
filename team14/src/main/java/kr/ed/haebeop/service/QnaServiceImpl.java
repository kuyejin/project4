package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Qna;
import kr.ed.haebeop.repository.QnaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QnaServiceImpl implements QnaService{

    @Autowired
    private QnaRepository qnaRepository;

    private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

    @Override
    public List<Qna> qnaList() throws Exception {
        return qnaRepository.qnaList();
    }

    @Override
    public Qna qnaDetail(int bno) throws Exception {
        return qnaRepository.qnaDetail(bno);
    }

    @Override
    public void qnaInsert(Qna dto) throws Exception {
        qnaRepository.qnaInsert(dto);
    }

    @Override
    public void qnaDelete(int bno) throws Exception {
        qnaRepository.qnaDelete(bno);
    }

    @Override
    public void qnaEdit(Qna dto) throws Exception {
        qnaRepository.qnaEdit(dto);
    }

    @Override
    public void commentInsert(Qna dto) throws Exception {
        qnaRepository.commentInsert(dto);
    }

    @Override
    public List<Qna> commentList(int bno) throws Exception {
        return qnaRepository.commentList(bno);
    }

    @Override
    public void commentDeleteAll(int bno) throws Exception {
        qnaRepository.commentDeleteAll(bno);
    }

    @Override
    public boolean check(int bno, String pw) throws Exception {
        boolean comp = false;
        Qna qna = qnaRepository.qnaDetail(bno);
        boolean check = pwEncoder.matches(pw, qna.getPw()); // 입력된 비밀번호와 db의 암호화된 비밀번호 비교
        if(qna != null && check) {
            comp = true;
        }
        return comp;
    }

    @Override
    public void countUp(int bno) throws Exception {
        qnaRepository.countUp(bno);
    }
}
