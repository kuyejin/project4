package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Report;
import kr.ed.haebeop.domain.Review;
import kr.ed.haebeop.domain.ReviewVO;
import kr.ed.haebeop.persistence.ReviewMapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    private ReviewMapper reviewMapper;
    public List<Review> getReviewList() {return reviewMapper.getReviewList();}

    // 특정 강의 리뷰만 불러오기
    public List<Review> getReviewListPar(int par) {return reviewMapper.getReviewListPar(par);}

    // 특정 회원의 리뷰만 불러오기
    public List<Review> getReviewListId(String id) {return reviewMapper.getReviewListId(id);}

    // 특정 회원의 강의 리뷰 불러오기
    public Review getReview(Review review) {return reviewMapper.getReview(review);}

    // 특정 회원이 해당 강의에 리뷰를 작성했는지 안했는지 확인
    public int reviewCheck(Review review) {return reviewMapper.reviewCheck(review);}

    // 리뷰 작성
    public void insertReview(Review review) {reviewMapper.insertReview(review);}

    // 리뷰 업데이트
    public void updateReview(Review review) {reviewMapper.updateReview(review);}

    // 리뷰 삭제
    public void deleteReview(Review review) {reviewMapper.deleteReview(review);}

    // 평균 점수
    public String avgScore(int par) {return reviewMapper.avgScore(par);}

    // 관리자가 리뷰 삭제
    public void adminbDeleteReview(int no) {reviewMapper.adminbDeleteReview(no);}

    // 리뷰 신고 추가
    public void insertReportReview(Report report) {reviewMapper.insertReportReview(report);}

    // 리뷰 신고 글 수
    public int selectCheckReportCnt(Report report) { return reviewMapper.selectCheckReportCnt(report);}

    // 리뷰 신고 목록
    public List<ReviewVO> reviewReportList() {return reviewMapper.reviewReportList();}
}
