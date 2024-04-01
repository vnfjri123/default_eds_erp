package com.springboot.myapp.eds.main.controller.home;

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
public class homeController {

	@Autowired
	private homeService homeService;

	@RequestMapping("/HOME_VIEW")
	public String carEstView(Model model) throws Exception {

		return "/eds/main/home/HOME";

	}

	@RequestMapping("/CAR_LOG/selectHomeList")
	@ResponseBody
	public Map selectHomeList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = homeService.selectHomeList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/CAR_LOG/cudHomeList")
	@ResponseBody
	public Map<String, Object> cudHomeList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = homeService.cudHomeList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}
}