package com.springboot.myapp.eds.erp.controller.yeongEob;

import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class yeongEobEstController {

	@Autowired
	private yeongEobEstService yeongEobEstService;

	@RequestMapping("/YEONGEOB_EST_MGT_VIEW")
	public String yeongEobEstMgtView(Model model) throws Exception {

		return "/eds/erp/yeongEob/YEONGEOB_EST_MGT";
	}

	@RequestMapping("/YEONGEOB_EST_MGT_POP_VIEW")
	public String yeongEobEstMgtPopView(Model model) throws Exception {

		return "/eds/erp/yeongEob/YEONGEOB_EST_MGT_POP";
	}

	@RequestMapping("/YEONGEOB_EST_MGT/selectEstMgtList")
	@ResponseBody
	public Map selectEstMgtList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = yeongEobEstService.selectEstMgtList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/YEONGEOB_EST_MGT/selectEstItemList")
	@ResponseBody
	public Map selectEstItemList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = yeongEobEstService.selectEstItemList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/YEONGEOB_EST_MGT/cudEstMgtList")
	@ResponseBody
	public Map cudEstMgtList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("estDt", Util.removeMinusChar((String) row.get("estDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += yeongEobEstService.insertEstMgtList(row); break;
					case "U": updatedCnt += yeongEobEstService.updateEstMgtList(row); break;
					case "D":
						updatedCnt += yeongEobEstService.deleteEstEmailList(row);
						updatedCnt += yeongEobEstService.deleteEstItemList(row);
						updatedCnt += yeongEobEstService.deleteEstMgtList(row);
						break;
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

	@RequestMapping("/YEONGEOB_EST_MGT/cudEstList")
	@ResponseBody
	public Map<String, Object> cudEstList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			System.out.println(param);
			returnData = yeongEobEstService.cudEstList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/YEONGEOB_EST_MGT/cudEstItemList")
	@ResponseBody
	public Map cudEstItemList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += yeongEobEstService.insertEstItemList(row); break;
					case "U": updatedCnt += yeongEobEstService.updateEstItemList(row); break;
					case "D": updatedCnt += yeongEobEstService.deleteEstItemList(row); break;
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

	@RequestMapping("/YEONGEOB_EST_MGT/cudEstEmailList")
	@ResponseBody
	public Map cudEstEmailList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				System.out.println(i);
				System.out.println(row.get("status").toString());
				switch (row.get("status").toString()){
					case "D": updatedCnt += yeongEobEstService.deleteEstEmailList(row); break;
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

	@RequestMapping("/YEONGEOB_EST_MGT/deadLineEstMgtList")
	@ResponseBody
	public Map deadLineEstMgtList(@RequestBody Map<String, Object> map, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {

			int updatedCnt = yeongEobEstService.deadLineEstMgtList(map);

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
