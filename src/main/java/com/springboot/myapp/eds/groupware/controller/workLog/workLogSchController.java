package com.springboot.myapp.eds.groupware.controller.workLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class workLogSchController {

	@Autowired
	private workLogSchService WorkLogSchService;

	@RequestMapping("/WORK_LOG_SCH_MGT_VIEW")
	public String WorkLogSchYearMgtView(Model model) throws Exception {

		return "/eds/groupware/workLog/WORK_LOG_SCH_MGT";

	}

	@RequestMapping("/WORK_LOG/selectWorkLogSchList")
	@ResponseBody
	public Map selectWorkLogSchList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = WorkLogSchService.selectWorkLogSchList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogSchComment")
	@ResponseBody
	public Map selectWorkLogSchComment(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = WorkLogSchService.selectWorkLogSchComment(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogSchPlanningKeyResult")
	@ResponseBody
	public Map selectWorkLogSchPlanningKeyResult(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = WorkLogSchService.selectWorkLogSchPlanningKeyResult(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getWorkLogSchPlanningKeyResultChart")
	@ResponseBody
	public Map getWorkLogSchPlanningKeyResultChart(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = WorkLogSchService.getWorkLogSchPlanningKeyResultChart(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogSchCheckInKeyResult")
	@ResponseBody
	public Map selectWorkLogSchCheckInKeyResult(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = WorkLogSchService.selectWorkLogSchCheckInKeyResult(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getWorkLogSchCheckInKeyResultChart")
	@ResponseBody
	public Map getWorkLogSchCheckInKeyResultChart(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = WorkLogSchService.getWorkLogSchCheckInKeyResultChart(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/cdWorkLogSchComment")
	@ResponseBody
	public Map<String, Object> cdWorkLogSchComment(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = WorkLogSchService.cdWorkLogSchComment(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cudWorkLogSchPlanningKeyResult")
	@ResponseBody
	public Map<String, Object> cudWorkLogSchPlanningKeyResult(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = WorkLogSchService.cudWorkLogSchPlanningKeyResult(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cudWorkLogSchCheckInKeyResult")
	@ResponseBody
	public Map<String, Object> cudWorkLogCheckInKeyResult(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = WorkLogSchService.cudWorkLogSchCheckInKeyResult(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}
}