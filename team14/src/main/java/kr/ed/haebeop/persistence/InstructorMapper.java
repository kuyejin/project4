package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface InstructorMapper {

    //선생님 리스트
    @Select("select * from instructor")
    public List<Instructor> getInstructorList();

    @Select("select * from instructor where no=#{no}")
    public Instructor getInstructor(int no);

    @Select("select * from instructor where id=#{id}")
    public Instructor getInstructorById(String id);

    //강의 리스트
    @Select("select * from lecture where ino = #{no}")
    public List<Lecture> getInstructorLectureList(int no);

    //공지 목록
    @Select("select * from instructornotice where instructorno=#{no}")
    public List<InstructorNotice> getInstructorNoticeList(int no);

    //공지 상세
    @Select("select * from instructornotice where no=#{noticeNo}")
    public InstructorNotice getInstructorNoticeDetail(int noticeNo);
    //공지 조회수 증가
    @Select(" update instructornotice set cnt=cnt+1 where no=#{noticeNo}")
    public void instructorNoticeCountUp(int noticeNo);

    @Insert("insert into instructornotice(title, content,instructorno) values(#{title}, #{content}, #{instructorno})")
    public void noticeInsert(InstructorNotice dto);

    @Delete("delete from instructornotice where no=#{no}")
    public void noticeDelete(int no);

    @Update("update instructornotice set title=#{title}, content=#{content} where no=#{no}")
    public void noticeEdit(InstructorNotice dto);



    //instructor id
    @Select("select * from instructor where instructorname=#{instructorname}")
    public Instructor getInstructorId(String instructorname);


    @Insert("insert into instructor(no,instructorid,instructorname,category) values (default,#{instructorid},#{instructorname},#{category})")
    public void instructorInsert(Instructor instructor);

    @Delete("delete from instructor where instructorid=#{instructorid}")
    public void instructorDelete(String instructorid);

    @Update("update instructor set instructorid=#{instructorid},instructorname=#{instructorname},category=#{category}")
    public void instructorUpdate(Instructor instructor);


    //QNA list
    @Select(" select * from instructorqna where lev = 0 and instructorno = #{no} order by resdate")
    public List<InstructorQna> instructorQnaList(int no);

    //QNA 글 상세
    @Select(" select * from instructorqna where bno=#{bno}")
    public InstructorQna qnaDetail(int no);

    @Select("SELECT COUNT(*) FROM instructorqna")
    int totalCount();

    @Insert("INSERT INTO instructorqna(title, content, author, pw,instructorno) VALUES(#{title}, #{content}, #{author}, #{pw},#{instructorno})")
    int qnaInsert(InstructorQna dto);

    @Delete("DELETE FROM instructorqna WHERE bno = #{bno}")
    int qnaDelete(@Param("bno") int bno);

    @Update("UPDATE instructorqna SET title = #{title}, content = #{content} WHERE bno = #{bno}")
    int qnaEdit(InstructorQna dto);

    @Update("UPDATE instructorqna SET cnt = cnt + 1 WHERE bno = #{bno}")
    int qnaCountUp(@Param("bno") int bno);

    @Insert("INSERT INTO instructorqna(title, content, author, lev, par,instructorno) VALUES ('댓글', #{content}, #{author}, 1, #{bno},#{instructorno})")
    int commentInsert(InstructorQna dto);

    @Select("SELECT * FROM instructorqna WHERE par = #{bno} AND lev = 1 ORDER BY resdate DESC")
    List<InstructorQna> commentList(@Param("bno") int bno);

    @Delete("DELETE FROM instructorqna WHERE par = #{bno}")
    int commentDeleteAll(@Param("bno") int bno);

    //자료실
    @Select("select * from instructorfile where instructorno=#{no}")
    List<InstructorFile> getInstructorFileList(int no);
    @Insert("insert into instfile values(default, #{sfile}, #{realName})")
    public void setInstFile(InstFile instFile);
    @Insert("INSERT INTO instructorfile VALUES (default,  #{title}, #{content}, default,default,#{sfile1}, #{sfile2}, #{sfile3}, #{instructorno})")
    @Options(useGeneratedKeys=true, keyProperty="no")
    public void addInstructorFile(InstructorFile instructorFile);

    @Select("select * from instructorfile where no=#{fileNo}")
    InstructorFile getInstructorFile(int fileNo);
    @Delete("DELETE FROM instructorfile WHERE no = #{no}")
    public void instructorFileDelete(int no);
    // 기존 파일 이름 추출
    @Select("select realname from instfile where sfile=#{sfile}")
    public String getInstFileName(String sfile);
    //조회수
    @Update("UPDATE instructorfile SET cnt = cnt + 1 WHERE no = #{fileNo}")
    int fileCountUp(@Param("fileNo") int fileNo);


    //선생님 후기 목록
    @Select("select r.*, l.title ,l.no as lno, l.ino FROM review r join lecture l on r.par = l.no where ino = #{no} ORDER by resdate desc")
    List<Review> getReviewList(int no);
    
    
    // 선생님 과목 추출
    @Select("select cate from instructor where no=#{no}")
    public String getInstCate(int no);


}
