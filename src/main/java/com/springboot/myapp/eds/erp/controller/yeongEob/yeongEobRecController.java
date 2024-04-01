package com.springboot.myapp.eds.erp.controller.yeongEob;

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
public class yeongEobRecController {

	@Autowired
	private yeongEobRecService yeongEobRecService;

	@RequestMapping("/YEONGEOB_REC_MGT_POP_VIEW")
	public String yeongEobMgtView(Model model) throws Exception {

		return "/eds/erp/yeongEob/YEONGEOB_REC_MGT_POP";
	}

	@RequestMapping("/YEONGEOB_REC_MGT/selectRecMgtList")
	@ResponseBody
	public Map selectRecMgtList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = yeongEobRecService.selectRecMgtList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
}
