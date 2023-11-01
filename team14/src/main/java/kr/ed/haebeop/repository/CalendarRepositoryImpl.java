package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Calendar;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

@Repository
public class CalendarRepositoryImpl implements CalendarRepository{
    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Calendar> calendarList(String id) throws Exception {
        return sqlSession.selectList("calendar.calendarList", id);
    }
    @Override
    public Calendar getCalendar(int no) throws Exception {
        return sqlSession.selectOne("calendar.getCalendar", no);
    }

    @Override
    public void calendarInsert(Calendar calendar) throws Exception {
        sqlSession.insert("calendar.calendarInsert", calendar);
    }

    @Override
    public void calendarEdit(Calendar calendar) throws Exception {
        sqlSession.update("calendar.calendarEdit", calendar);
    }

    @Override
    public void calendarDelete(int no) throws Exception {
        sqlSession.delete("calendar.calendarDelete", no);
    }
}
