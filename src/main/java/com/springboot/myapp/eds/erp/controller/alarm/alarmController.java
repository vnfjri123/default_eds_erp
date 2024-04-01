package com.springboot.myapp.eds.erp.controller.alarm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springboot.myapp.eds.notice.NotificationService;
import com.springboot.myapp.util.SessionUtil;

@Controller
public class alarmController {

	@Autowired
	private alarmService alarmService;

	@Autowired
	private NotificationService notificationService;


	@RequestMapping("/ALARM_REG/selectAlarmList")
	@ResponseBody
	public Map selectAlarmList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			map.put("corpCd", SessionUtil.getUser().getCorpCd());
			List li = alarmService.selectAlarmList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
	@RequestMapping("/ALARM_REG/selectAlarmSubmit")
	@ResponseBody
	public Map selectAlarmSubmit(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			map.put("corpCd", SessionUtil.getUser().getCorpCd());
			List li = alarmService.selectAlarmSubmit(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
	@RequestMapping("/ALARM_REG/updateAlarmList")
	@ResponseBody
	public Map updateAlarmList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				updatedCnt += alarmService.updateAlarmList(row);
			}
			if (updatedCnt > 0) { // 정상 저장
				rtn.put("Result", 0);
				rtn.put("Message", "삭제 되었습니다.");
			} else { // 저장 실패
				rtn.put("Result", -100); // 음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}
	@RequestMapping("/ALARM_REG/deleteAlarmList")
	@ResponseBody
	public Map cudAlarmList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				updatedCnt += alarmService.deleteAlarmList(row);
			}
			if (updatedCnt > 0) { // 정상 저장
				rtn.put("Result", 0);
				rtn.put("Message", "삭제 되었습니다.");
			} else { // 저장 실패
				rtn.put("Result", -100); // 음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

}
