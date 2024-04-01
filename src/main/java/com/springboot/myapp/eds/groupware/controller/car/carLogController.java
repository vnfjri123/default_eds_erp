package com.springboot.myapp.eds.groupware.controller.car;

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
public class carLogController {

	@Autowired
	private carLogService carLogService;

	@RequestMapping("/CAR_LOG_MGT_VIEW")
	public String carEstView(Model model) throws Exception {

		return "/eds/groupware/car/CAR_LOG_MGT";

	}

	@RequestMapping("/CAR_LOG/selectCarLogList")
	@ResponseBody
	public Map selectCarLogList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = carLogService.selectCarLogList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/CAR_LOG/cudCarLogList")
	@ResponseBody
	public Map<String, Object> cudCarLogList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = carLogService.cudCarLogList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}
}