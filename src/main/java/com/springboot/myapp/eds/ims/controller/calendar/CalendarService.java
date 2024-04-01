package com.springboot.myapp.eds.ims.controller.calendar;

import com.springboot.myapp.eds.groupware.vo.edms.edmsHomeListVO;
import com.springboot.myapp.eds.ims.vo.calendar.calendarVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CalendarService {

  @Autowired
  private CalendarMapper calendarMapper;

  public List<calendarVO> selectCalendar(Map<String, Object> map) throws Exception {
//    map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
//    map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
//
//    map.put("authDivi", SessionUtil.getUser().getAuthDivi());
//    map.put("depaCd", SessionUtil.getUser().getDepaCd());
//    map.put("empCd", SessionUtil.getUser().getEmpCd());
    List<calendarVO> result = calendarMapper.selectCalendar(map);
    return result;
  }

  public List<calendarVO> selectTodayCalendar(Map<String, Object> map) throws Exception {
//    AES256Util aes256Util = new AES256Util();
//    map.put("secretKey", aes256Util.getKey());
//    map.put("authDivi", SessionUtil.getUser().getAuthDivi());
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    List<calendarVO> result = calendarMapper.selectTodayCalendar(map);
    return result;
  }

  public List<calendarVO> selectCalendarOnPopup(Map<String, Object> map) throws Exception {
//    map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
//    map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
//
//    map.put("authDivi", SessionUtil.getUser().getAuthDivi());
//    map.put("depaCd", SessionUtil.getUser().getDepaCd());
//    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    List<calendarVO> result = calendarMapper.selectCalendarOnPopup(map);
    return result;
  }

  public int insertCalendar(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return calendarMapper.insertCalendar(map);
  }

  public int updateCalendar(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return calendarMapper.updateCalendar(map);
  }

  public int deleteCalendar(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return calendarMapper.deleteCalendar(map);
  }

}
