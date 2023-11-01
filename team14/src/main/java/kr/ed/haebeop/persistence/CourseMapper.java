package kr.ed.haebeop.persistence;


import kr.ed.haebeop.domain.Course;
import kr.ed.haebeop.domain.MyClassVO;
import kr.ed.haebeop.domain.TestVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface CourseMapper {

    @Select("SELECT * FROM course")
    public List<Course> courseList();


    @Select("SELECT * FROM course WHERE id = #{id};")
    public Course getCourse(String id);


    @Insert("INSERT INTO course VALUES(DEFAULT, ${lec_no}, #{sid}, DEFAULT, DEFAULT);")
    void courseInsert(Course course);

    @Update("UPDATE course SET CHECK1 = #{check} WHERE sid = #{sid} AND lec_no = ${lec_no};")
    public void checkUpdate(Course course);
}