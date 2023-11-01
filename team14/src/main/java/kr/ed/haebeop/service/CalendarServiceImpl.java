package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Calendar;
import kr.ed.haebeop.repository.CalendarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class CalendarServiceImpl implements CalendarService{
    @Autowired
    private CalendarRepository calendarRepository;
    @Autowired
    private HttpSession session;

    @Override
    public List<Calendar> calendarList(String id) throws Exception {
        return calendarRepository.calendarList(id);
    }

    @Override
    public Calendar getCalendar(int no) throws Exception {
        return calendarRepository.getCalendar(no);
    }

    @Override
    public void calendarInsert(Calendar calendar) throws Exception {
        calendarRepository.calendarInsert(calendar);
    }

    @Override
    public void calendarEdit(Calendar calendar) throws Exception {
        calendarRepository.calendarEdit(calendar);
    }

    @Override
    public void calendarDelete(int no) throws Exception {
        calendarRepository.calendarDelete(no);
    }
}
