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
public class carBookController {

	@Autowired
	private carBookService carBookService;

	@RequestMapping("/CAR_BOOK_CALENDAR_VIEW")
	public String carEstView(Model model) throws Exception {

		return "/eds/groupware/car/CAR_BOOK_CALENDAR";
	}

	@RequestMapping("/CAR_BOOK/selectCarBookList")
	@ResponseBody
	public Map selectCarBookList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = carBookService.selectCarBookList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/CAR_BOOK/cudCarBookList")
	@ResponseBody
	public Map<String, Object> cudCarBookList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = carBookService.cudCarBookList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}
}