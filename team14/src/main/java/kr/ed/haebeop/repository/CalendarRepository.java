package kr.ed.haebeop.repository;

import kr.ed.haebeop.domain.Calendar;

import java.util.ArrayList;
import java.util.List;

public interface CalendarRepository {
    //캘린더 일정 조회
    public List<Calendar> calendarList(String id) throws Exception;

    //캘린더 일정 상세보기
    public Calendar getCalendar(int no) throws Exception;

    //캘린더 일정 추가하기
    public void calendarInsert(Calendar calendar) throws Exception;

    //캘린더 일정 수정하기
    public void calendarEdit(Calendar calendar) throws Exception;

    //캘린더 일정 삭제하기
    public void calendarDelete(int no) throws Exception;

}
