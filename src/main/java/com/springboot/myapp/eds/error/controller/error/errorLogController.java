package com.springboot.myapp.eds.error.controller.error;

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
public class errorLogController {

	@Autowired
	private com.springboot.myapp.eds.error.controller.error.errorLogService errorLogService;

	@RequestMapping("/ERROR_LOG_MGT_VIEW")
	public String errorEstView(Model model) throws Exception {

		return "/eds/error/ERROR_LOG_MGT";

	}

	@RequestMapping("/ERROR_LOG/selectErrorLogList")
	@ResponseBody
	public Map selectErrorLogList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = errorLogService.selectErrorLogList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/ERROR_LOG/cudErrorLogList")
	@ResponseBody
	public Map<String, Object> cudErrorLogList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = errorLogService.cudErrorLogList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}
}