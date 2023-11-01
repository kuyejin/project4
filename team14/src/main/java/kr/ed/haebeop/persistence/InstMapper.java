package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Instructor;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface InstMapper {
    @Select("SELECT * FROM instructor")
    public List<Instructor> getInstructorList();
    @Select("SELECT * FROM instructor WHERE id = #{id}")
    public Instructor getInstructor(String id);
    @Select("SELECT * FROM instructor WHERE no = #{no}")
    public Instructor getInstructorName(int no);
    @Insert("INSERT INTO instructor VALUES (default, #{name}, #{tel}, #{email}, #{intro}, #{cate}, #{img}, #{id})")
    @Options(useGeneratedKeys=true, keyProperty="no")
    public void addInstructor(Instructor instructor);
    @Update("UPDATE instructor SET cate = #{cate}, name = #{name}, intro = #{intro}, img = #{img}, tel=#{tel}, email=#{email}  WHERE id = #{id}")
    public void updateInstructor(Instructor instructor);
    @Delete("DELETE FROM instructor WHERE no = #{no}")
    public void delInstructor(int no);
    @Select("select id, pw, name from instructor where id = #{id}")
    public Instructor loginCheck(String id);

}
