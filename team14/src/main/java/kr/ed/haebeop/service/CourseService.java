package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Course;
import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.domain.Payment;
import kr.ed.haebeop.persistence.CourseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseService {
    @Autowired
    private CourseMapper courseMapper;

    //모든 수강신청 정보
    public List<Course> courseList() {
        return courseMapper.courseList();
    }


    // 해당 회원의 수강신청 정보
    public Course getCourse(String id){
        return courseMapper.getCourse(id);
    }

    public void courseInsert(Course course) {
        courseMapper.courseInsert(course);
    }


    // 1.수강중 , 2.수강정지 , 3.수강완료 update
    public void checkUpdate(Course course) {
        courseMapper.checkUpdate(course);
    }

}
