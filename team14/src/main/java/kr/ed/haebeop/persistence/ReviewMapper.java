package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Report;
import kr.ed.haebeop.domain.Review;
import kr.ed.haebeop.domain.ReviewVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ReviewMapper {
    // 모든 리뷰 불러오기
    @Select("select * from review")
    public List<Review> getReviewList();
    
    // 특정 강의 리뷰만 불러오기
    @Select("select * from review where par=#{par}")
    public List<Review> getReviewListPar(int par);
    
    // 특정 회원의 리뷰만 불러오기
    @Select("select * from review where id=#{id}")
    public List<Review> getReviewListId(String id);
    
    // 특정 회원의 강의 리뷰 불러오기
    @Select("select * from review where par=#{par} and id=#{id}")
    public Review getReview(Review review);

    // 특정 회원이 해당 강의에 리뷰를 작성했는지 안했는지 확인
    @Select("select count(*) from review where par=#{par} and id=#{id}")
    public int reviewCheck(Review review);

    // 리뷰 작성
    @Insert("insert into review values(default, #{id}, #{content}, default, #{score}, #{par})")
    public void insertReview(Review review);
    
    // 리뷰 업데이트
    @Update("update review set content=#{content}, score=#{score} where id=#{id} and par=#{par}")
    public void updateReview(Review review);

    // 리뷰 삭제
    @Delete("delete from review where id=#{id} and par=#{par}")
    public void deleteReview(Review review);

    // 평균 점수
    @Select("select AVG(score) from review where par=#{par}")
    public String avgScore(int par);

    // 관리자가 리뷰 삭제
    @Delete("delete from review where no=#{no}")
    public void adminbDeleteReview(int no);

    // 리뷰 신고 추가
    @Insert("insert into report_rev values (default, #{board_bno}, #{reporter}, #{reason}, default)")
    public void insertReportReview(Report report);

    // 리뷰 신고 글 수
    @Select("SELECT COUNT(*) FROM report_rev WHERE board_bno = #{board_bno} AND reporter = #{reporter}")
    public int selectCheckReportCnt(Report report);

    // 리뷰 신고 목록
    @Select("SELECT" +
            "    b.*," +
            "    r.reason," +
            "    r.report_date," +
            "    sub.report_count" +
            "    FROM" +
            "            (SELECT board_bno, COUNT(board_bno) as report_count FROM report_rev GROUP BY board_bno) AS sub" +
            "    JOIN" +
            "    report_rev r ON sub.board_bno = r.board_bno" +
            "            JOIN" +
            "    review b ON r.board_bno = b.no" +
            "    ORDER BY" +
            "    r.report_date DESC;")
    public List<ReviewVO> reviewReportList();
}
