package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.LecFile;
import kr.ed.haebeop.domain.Lecture;
import kr.ed.haebeop.domain.LectureLikes;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface LectureMapper {
    @Select("SELECT * FROM lecture")
    public List<Lecture> getLectureList();
    @Select("SELECT * FROM lecture WHERE no = #{no}")
    public Lecture getLecture(int no);
    @Insert("INSERT INTO lecture VALUES (default, #{cate}, #{slevel}, #{title}, #{content}, #{simg}, #{sfile1}, #{sfile2}, #{sfile3}, #{sfile4}, #{sfile5}, #{price}, #{ino}, default, default, #{lec_max}, #{aplctClss1}, #{aplctClss2}, #{studyStart}, #{studyEnd}, #{endDay})")
    @Options(useGeneratedKeys=true, keyProperty="no")
    public void addLecture(Lecture lec);
    @Update("UPDATE lecture SET cate=#{cate}, slevel=#{slevel}, title=#{title}, content=#{content}, simg=#{simg}, sfile1=#{sfile1}, sfile2=#{sfile2}, sfile3=#{sfile3}, sfile4=#{sfile4}, sfile5=#{sfile5}, ino=#{ino} WHERE no=#{no}")
    public void updateLecture(Lecture lec);
    @Delete("DELETE FROM lecture WHERE no = #{no}")
    public void delLecture(int no);
    @Select("SELECT * FROM lecture ORDER BY price DESC")
    public List<Lecture> getLectureListBest();
    @Select("SELECT * FROM lecture ORDER BY resdate DESC")
    public List<Lecture> getLectureListNew();
    @Update("update lecture set cnt=cnt+1 where no=#{no}")
    public void countUp(int no);

    // 수강인원 +1
    @Update("update lecture set lec=lec+1 where no=#{no}")
    public void countUpLec(int no);

    // 수강인원 -1
    @Update("update lecture set lec=lec-1 where no=#{no}")
    public void countDownLec(int no);

    // 실제 파일 이름 저장
    @Insert("insert into lecfile values(default, #{sfile}, #{realName})")
    public void setLecFile(LecFile lecFile);

    // 실제 파일 이름 수정
    @Update("update lecfile set sfile=#{sfile}, realname=#{realName} where no=#{no}")
    public void updateLecFile(LecFile lecFile);

    // 기존 파일의 no 출력
    @Select("select no from lecfile where sfile=#{sfile}")
    public int selectLecFile(String sfile);
    
    // 현재 파일이 있는지 없는지 확인
    @Select("select count(*) from lecfile where sfile=#{sfile}")
    public int selectLecFileCheck(String sfile);

    // 기존 파일 이름 추출
    @Select("select realname from lecfile where sfile=#{sfile}")
    public String getLecFileName(String sfile);

    // 좋아요 유뮤 확인
    @Select("SELECT count(*) FROM lecturelikes WHERE userid = #{userid} AND lno = #{lno}")
    public int checkLiked(LectureLikes lectureLikes);
    
    // 좋아요 추가
    @Insert("INSERT INTO lecturelikes(userid, lno) VALUES(#{userid}, #{lno})")
    public void addLike(LectureLikes lectureLikes);

    // 좋아요 취소
    @Delete("DELETE FROM lecturelikes WHERE userid = #{userid} AND lno = #{lno}")
    public void removeLike(LectureLikes lectureLikes);
    
    // 좋아요 누른 상품의 id 목록 반환
    @Select("SELECT lno FROM lecturelikes WHERE userid = #{userid}")
    public List<Integer> getLikedProductsByUser(String userid);

    // 유저의 좋아요 목록 출력
    @Select("select * from lecturelikes where userid=#{userid}")
    public List<LectureLikes> getByIdLikeList(String userid);
}
