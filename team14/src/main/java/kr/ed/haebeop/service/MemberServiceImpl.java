package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService{
    @Autowired
    private MemberRepository memberRepository;
    
    // spring security 이용
    private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

    @Override
    public List<Member> memberList() throws Exception {
        return memberRepository.memberList();
    }

    @Override
    public Member getMember(String id) throws Exception {
        return memberRepository.getMember(id);
    }

    @Override
    public int memberCount() throws Exception {
        return memberRepository.memberCount();
    }

    @Override
    public void memberInsert(Member member) throws Exception {
        memberRepository.memberInsert(member);
    }

    @Override
    public void memberUpdate(Member member) throws Exception {
        memberRepository.memberUpdate(member);
    }

    @Override
    public void memberDelete(String id) throws Exception {
        memberRepository.memberDelete(id);
    }

    @Override
    public Member signIn(String id) throws Exception {
        return memberRepository.signIn(id);
    }
    
    // 서비스에서 로그인 처리
    @Override
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
    
    // Ajax로 로그인 처리 (컨트롤러)
    @Override
    public Member login(String id) throws Exception {
        return memberRepository.login(id);
    }

    /*비밀번호 찾기 할때 */
    @Override
    public Member selectMember(String email) throws Exception {
        System.out.println(email);
        Member member = memberRepository.selectMember(email);
        if(member != null) {
            System.out.println("전화번호 : " + member.getTel());
            StringBuffer str = new StringBuffer(member.getTel());
            str.insert(0, "0");

            String phone = str.substring(0);
            if(phone.substring(0,2).equals("00")) {
                phone = phone.substring(1);
            }
            member.setTel(phone);

            System.out.println("전화번호는 : " + member.getTel());
        }
        System.out.println(member);
        return member;
    }


    @Override
    public int pwUpdate(Member member) throws Exception {
        int result = memberRepository.pwUpdate(member);

        return result;
    }

    @Override
    public void updateAuthStatus ( Map<String, Integer> map) throws Exception{
        memberRepository.updateAuthStatus(map);
    }


    /*내가 쓴 글*/
    @Override
    public List<BoardlistVO> getWriteList(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList(id);
        if(list!=null) {
            System.out.println("list");
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment(String id) {
        List<CommentlistVO> list = memberRepository.getWriteComment(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }

    /*자유게시판*/@Override
    public List<BoardlistVO> getWriteList1(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList1(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }


    /*선생님게시판*/
    @Override
    public List<BoardlistVO> getWriteList2(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList2(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }

    /*학부모 게시판*/
    @Override
    public List<BoardlistVO> getWriteList3(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList3(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }

    @Override
    public List<BoardlistVO> getWriteList4(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList4(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<BoardlistVO> getWriteList5(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList5(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<BoardlistVO> getWriteList6(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList6(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<BoardlistVO> getWriteList7(String id) {
        List<BoardlistVO> list = memberRepository.getWriteList7(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment1(String id) {
        List<CommentlistVO> list = memberRepository.getWriteComment1(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment2(String id) {
        List<CommentlistVO> list = memberRepository.getWriteComment2(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment3(String id) {
        List<CommentlistVO> list =memberRepository.getWriteComment3(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment4(String id) {
        List<CommentlistVO> list = memberRepository.getWriteComment4(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment5(String id) {
        List<CommentlistVO> list = memberRepository.getWriteComment5(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment6(String id) {
        List<CommentlistVO> list = memberRepository.getWriteComment6(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }
    @Override
    public List<CommentlistVO> getWriteComment7(String id) {
        List<CommentlistVO> list = memberRepository.getWriteComment7(id);
        if(list!=null) {
            System.out.println(list);
        }
        return list;
    }

    // 내가 신고한 게시글
    @Override
    public List<Board> myReportList(String id) throws Exception {
        return memberRepository.myReportList(id);
    }

    @Override
    public void boardReportCancel(Report report) throws Exception {
        memberRepository.boardReportCancel(report);
    }

    @Override
    public void teaReportCancel(int bno) throws Exception {
        memberRepository.teaReportCancel(bno);
    }

    @Override
    public void parReportCancel(int bno) throws Exception {
        memberRepository.parReportCancel(bno);
    }

    // 내가 추천한 게시글
    @Override
    public List<BoardLikes> myLikeList(String id) throws Exception {
        return memberRepository.myLikeList(id);
    }

    @Override
    public void boardLikeRemove(int bno) throws Exception {
        memberRepository.boardLikeRemove(bno);
    }

    @Override
    public void teaLikeRemove(int bno) throws Exception {
        memberRepository.teaLikeRemove(bno);
    }

    @Override
    public void parLikeRemove(int bno) throws Exception {
        memberRepository.parLikeRemove(bno);
    }

    // 회원 이메일 가져오기
    @Override
    public Member getMemberEmail(String email)  throws Exception {
        return memberRepository.getMemberEmail(email);
    }

    @Override
    public String regSocialUser(Member member) throws Exception {
        return memberRepository.regSocialUser( member );
    }
    
    // 포인트 추가
    @Override
    public void memberPoint(Member member) throws Exception {
        memberRepository.memberPoint(member);
    }

    @Override
    public void memberPointSub(Member member) throws Exception {
        memberRepository.memberPointSub(member);
    }


}
