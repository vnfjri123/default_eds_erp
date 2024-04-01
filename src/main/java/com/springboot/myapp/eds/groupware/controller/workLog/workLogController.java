package com.springboot.myapp.eds.groupware.controller.workLog;

import com.springboot.myapp.util.Util;
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
public class workLogController {

	@Autowired
	private workLogService workLogService;

	@RequestMapping("/WORK_LOG_MGT_VIEW")
	public String workLogYearMgtView(Model model) throws Exception {

		return "/eds/groupware/workLog/WORK_LOG_MGT";

	}

	@RequestMapping("/WORK_LOG_DASHBOARD")
	public String workLogDashboardView(Model model) throws Exception {

		return "/eds/groupware/workLog/WORK_LOG_DASHBOARD";

	}

	@RequestMapping("/WORK_LOG/selectWorkLogList")
	@ResponseBody
	public Map selectWorkLogList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogObjectiveList")
	@ResponseBody
	public Map selectWorkLogObjectiveList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogObjectiveList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogKeyResultList")
	@ResponseBody
	public Map selectWorkLogKeyResultList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogKeyResultList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogActiveList")
	@ResponseBody
	public Map selectWorkLogActiveList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogActiveList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getLowKeyResultsActivitys")
	@ResponseBody
	public Map getLowKeyResultsActivitys(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getLowKeyResultsActivitys(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogComment")
	@ResponseBody
	public Map selectWorkLogComment(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogComment(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogActivity")
	@ResponseBody
	public Map selectWorkLogActivity(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogActivity(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogPlanningKeyResult")
	@ResponseBody
	public Map selectWorkLogPlanningKeyResult(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogPlanningKeyResult(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogPlanKeyResult")
	@ResponseBody
	public Map selectWorkLogPlanKeyResult(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogPlanKeyResult(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getWorkLogPlanningKeyResultChart")
	@ResponseBody
	public Map getWorkLogPlanningKeyResultChart(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getWorkLogPlanningKeyResultChart(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/selectWorkLogCheckInKeyResult")
	@ResponseBody
	public Map selectWorkLogCheckInKeyResult(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.selectWorkLogCheckInKeyResult(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getWorkLogCheckInKeyResultChart")
	@ResponseBody
	public Map getWorkLogCheckInKeyResultChart(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getWorkLogCheckInKeyResultChart(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getWorkLogSchDetailProgressChartPlanList")
	@ResponseBody
	public Map getWorkLogSchDetailProgressChartPlanList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getWorkLogSchDetailProgressChartPlanList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getWorkLogSchDetailProgressChart")
	@ResponseBody
	public Map getWorkLogSchDetailProgressChart(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getWorkLogSchDetailProgressChart(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getLowKeyResults")
	@ResponseBody
	public Map getLowKeyResults(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getLowKeyResults(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getLowKeyResultsForSch")
	@ResponseBody
	public Map getLowKeyResultsForSch(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getLowKeyResultsForSch(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getPlanCdRoot")
	@ResponseBody
	public Map<String,String> getPlanCdRoot(@RequestBody HashMap<String, Object> map) throws Exception {
		Map<String,String> mp = new HashMap<>();
		try {
			mp = workLogService.getPlanCdRoot(map);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getPartCds")
	@ResponseBody
	public Map getPartCds(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getPartCds(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/getWorkCds")
	@ResponseBody
	public Map getWorkCds(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = workLogService.getWorkCds(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/WORK_LOG/cudWorkLogList")
	@ResponseBody
	public Map<String, Object> cudWorkLogList(@RequestBody Map param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.cudWorkLogList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cdWorkLogComment")
	@ResponseBody
	public Map<String, Object> cdWorkLogComment(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.cdWorkLogComment(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cdWorkLogActivity")
	@ResponseBody
	public Map<String, Object> cdWorkLogActivity(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.cdWorkLogActivity(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cudWorkLogPlanningKeyResult")
	@ResponseBody
	public Map<String, Object> cudWorkLogPlanningKeyResult(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.cudWorkLogPlanningKeyResult(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cudWorkLogCheckInKeyResult")
	@ResponseBody
	public Map<String, Object> cudWorkLogCheckInKeyResult(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.cudWorkLogCheckInKeyResult(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cudWorkLogOrderPlanList")
	@ResponseBody
	public Map<String, Object> cudWorkLogOrderPlanList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.cudWorkLogOrderPlanList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/cudWorkLogKeyResultPlanList")
	@ResponseBody
	public Map<String, Object> cudWorkLogKeyResultPlanList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.cudWorkLogKeyResultPlanList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/WORK_LOG/synchronizationWorkLogList")
	@ResponseBody
	public Map<String, Object> synchronizationWorkLogList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = workLogService.synchronizationWorkLogList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}
}