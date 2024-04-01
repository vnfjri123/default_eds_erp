package com.springboot.myapp.eds.ims.controller.calendar;

import com.springboot.myapp.eds.groupware.vo.edms.edmsHomeListVO;
import com.springboot.myapp.eds.ims.vo.calendar.calendarVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface CalendarMapper {

  List<calendarVO> selectCalendar(Map<String, Object> map) throws Exception;
  List<calendarVO> selectTodayCalendar(Map<String, Object> map) throws Exception;
  List<calendarVO> selectCalendarOnPopup(Map<String, Object> map) throws Exception;
  int insertCalendar(Map<String, Object> map) throws Exception;
  int updateCalendar(Map<String, Object> map) throws Exception;
  int deleteCalendar(Map<String, Object> map) throws Exception;
}
