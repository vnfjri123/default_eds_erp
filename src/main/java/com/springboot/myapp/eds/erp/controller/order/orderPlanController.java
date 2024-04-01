package com.springboot.myapp.eds.erp.controller.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.springboot.myapp.util.Util;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class orderPlanController {

	@Autowired
	private orderPlanService orderPlanService;

	@RequestMapping("/ORDER_PLAN_LIST_VIEW")
	public String orderPlanView2(Model model) throws Exception {

		return "/eds/erp/order/ORDER_PLAN_LIST";
	}

	@RequestMapping("/ORDER_PLAN_LIST/selectOrderPlanList")
	@ResponseBody
	public Map selectOrderPlanList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = orderPlanService.selectOrderPlanList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/ORDER_PLAN_LIST/selectOrderPlanListForList")
	@ResponseBody
	public Map selectOrderPlanListForList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = orderPlanService.selectOrderPlanListForList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/ORDER_PLAN_LIST/selectOrderPlanSetList")
	@ResponseBody
	public Map selectOrderPlanSetList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = orderPlanService.selectOrderPlanSetList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/ORDER_PLAN_LIST/cuOrderPlanList")
	@ResponseBody
	public Map<String, Object> cuOrderPlanList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = orderPlanService.cuOrderPlanList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/ORDER_PLAN_LIST/cuOrderPlanSetList")
	@ResponseBody
	public Map<String, Object> cuOrderPlanSetList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = orderPlanService.cuOrderPlanSetList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/ORDER_PLAN_LIST/dOrderPlanList")
	@ResponseBody
	public Map dOrderPlanList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				switch (row.get("status").toString()) {
					case "D": updatedCnt += orderPlanService.deleteOrderPlanList(row); break;
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