package com.springboot.myapp.eds.ims.controller.calendar;

import com.springboot.myapp.eds.groupware.vo.edms.edmsHomeListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CalendarController {

  @Autowired
  private CalendarService calendarService;

  @RequestMapping("/CALENDAR_VIEW")
  public String calendarView() throws Exception {
    return "/eds/ims/calendar/calendarView";
  }

  @RequestMapping("/calendarView/selectTodayCalendar")
  @ResponseBody
  public Map selectTodayCalendar(@RequestBody HashMap<String, Object> map) throws Exception{
    Map mp = new HashMap();

    try {
      List li = calendarService.selectTodayCalendar(map);
      mp.put("data", li);
    }catch(Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/calendarView/selectCalendar")
  @ResponseBody
  public Map selectCalendar(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();
    try {
      List li = calendarService.selectCalendar(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/calendarView/selectCalendarOnPopup")
  @ResponseBody
  public Map selectCalendarOnPopup(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();
    try {
      List li = calendarService.selectCalendarOnPopup(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/calendarView/cudCalendar")
  @ResponseBody
  public Map cudCalendar(@RequestBody Map param, Model model) throws Exception {

    Map mp = new HashMap();
    Map rtn = new HashMap();
    int updatedCnt = 0;
    try {
      // ibsheet에서 넘어온 내용
      List saveData = (List) param.get("data");

      for (int i = 0; i < saveData.size(); i++) {
        Map row = (Map) saveData.get(i);
//        row.put("estDt", Util.removeMinusChar((String) row.get("estDt")));
//        row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));

        switch (row.get("status").toString()) {
          case "C":
            updatedCnt += calendarService.insertCalendar(row);
            break;
          case "U": updatedCnt += calendarService.updateCalendar(row);
          break;
          case "D":
            updatedCnt += calendarService.deleteCalendar(row);
            break;
        }
      }
      if (updatedCnt > 0) { // 정상 저장
        rtn.put("Result", 0);
        rtn.put("Message", "저장 되었습니다.");
      } else { // 저장 실패
        rtn.put("Result", -100); // 음수값은 모두 실패
        rtn.put("Message", "저장에 실패하였습니다.");
      }
    } catch (Exception ex) {
      rtn.put("Result", -100); // 음수값은 모두 실패
      rtn.put("Message", "오류입니다.");
    }
    mp.put("IO", rtn);
    return mp;
  }

}
