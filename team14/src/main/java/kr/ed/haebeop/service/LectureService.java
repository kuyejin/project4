package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.LecFile;
import kr.ed.haebeop.domain.Lecture;
import kr.ed.haebeop.domain.LectureLikes;
import kr.ed.haebeop.persistence.LectureMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LectureService {

    @Autowired
    private LectureMapper lectureMapper;
    public List<Lecture> getLectureList() {
        return lectureMapper.getLectureList();
    }
    public Lecture getLecture(int no) {
        return lectureMapper.getLecture(no);
    }
    public void addLecture(Lecture lec) { lectureMapper.addLecture(lec);}
    public void updateLecture(Lecture lec) {lectureMapper.updateLecture(lec);}
    public void delLecture(int no) {
        lectureMapper.delLecture(no);
    }
    public void countUp(int no) {lectureMapper.countUp(no);}

    // 수강인원 +1
    public void countUpLec(int no) {
        lectureMapper.countUpLec(no);
    }

    // 수강인원 -1
    public void countDownLec(int no) {
        lectureMapper.countDownLec(no);
    }

    // 실제 파일 이름 저장
    public void setLecFile(LecFile lecFile) {lectureMapper.setLecFile(lecFile);}

    // 기존 파일 수정
    public void updateLecFile(LecFile lecFile) {lectureMapper.updateLecFile(lecFile);}

    // 기존 파일의 no 출력
    public int selectLecFile(String sfile) {return lectureMapper.selectLecFile(sfile);}

    // 현재 파일이 있는지 없는지 확인
    public int selectLecFileCheck(String sfile) {return lectureMapper.selectLecFileCheck(sfile);}

    // 파일의 실제 이름 출력
    public String getLecFileName(String sfile) {return lectureMapper.getLecFileName(sfile);}

    // 좋아요 유뮤 확인
    public int checkLiked(LectureLikes lectureLikes) {return lectureMapper.checkLiked(lectureLikes);}

    // 좋아요 추가
    public void addLike(LectureLikes lectureLikes) {lectureMapper.addLike(lectureLikes);}

    // 좋아요 취소
    public void removeLike(LectureLikes lectureLikes) {lectureMapper.removeLike(lectureLikes);}

    // 좋아요 누른 상품의 id 목록 반환
    public List<Integer> getLikedProductsByUser(String userid) {return lectureMapper.getLikedProductsByUser(userid);}

    // 유저의 좋아요 목록 출력
    public List<LectureLikes> getByIdLikeList(String userid) {return lectureMapper.getByIdLikeList(userid);}

//    public List<RedirectView> getReviewList(int no) {
//        ReviewDAO dao = new ReviewDAO();
//        return dao.getReviewList(no);
//    }
//
//    public List<Integer> getLikedLecturesByUser(String sid) {
//        LikeDAO likeDAO = new LikeDAO();
//        return likeDAO.getLikedLecturesByUser(sid);
//    }
//
//    public int getCntCart(String sid) {
//        CartDAO cartDAO = new CartDAO();
//        return cartDAO.cntCart(sid);
//    }
}

