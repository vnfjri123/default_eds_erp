package com.springboot.myapp.eds.groupware.controller.commute;

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
public class commuteLogController {

	@Autowired
	private com.springboot.myapp.eds.groupware.controller.commute.commuteLogService commuteLogService;

	@RequestMapping("/COMMUTE_LOG_CALENDAR_VIEW")
	public String commuteEstView(Model model) throws Exception {

		return "/eds/groupware/commute/COMMUTE_LOG_CALENDAR";
	}

	@RequestMapping("/COMMUTE_LOG/selectCommuteLogList")
	@ResponseBody
	public Map selectCommuteLogList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = commuteLogService.selectCommuteLogList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/COMMUTE_LOG/cudCommuteLogList")
	@ResponseBody
	public Map<String, Object> cudCommuteLogList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = commuteLogService.cudCommuteLogList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}
}