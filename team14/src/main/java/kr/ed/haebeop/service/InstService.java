package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Instructor;
import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.persistence.InstMapper;
import kr.ed.haebeop.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InstService {
    @Autowired
    private InstMapper instMapper;
    @Autowired
    private MemberRepository memberRepository;
    private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();
    public List<Instructor> getInstructorList() {
        return instMapper.getInstructorList();
    }
    public Instructor getInstructor(String id) {
        return instMapper.getInstructor(id);
    }
    public Instructor getInstructorName(int no) {return instMapper.getInstructorName(no); }
    public void addInstructor(Instructor instructor) {
        instMapper.addInstructor(instructor);
    }
    public void updateInstructor(Instructor instructor) {
        instMapper.updateInstructor(instructor);
    }
    public void delInstructor(int no) {
        instMapper.delInstructor(no);
    }

    // 서비스에서 로그인 처리
    public boolean loginCheck(String id, String pw) throws Exception {
        boolean comp = false;
        Member member = memberRepository.loginCheck(id);
        try{
            boolean check = pwEncoder.matches(pw, member.getPw()); // 입력된 비밀번호와 db의 암호화된 비밀번호 비교
            if(check) {
                comp = true;
            }
        } catch (Exception e) {

        }
        return comp;
    }
}
