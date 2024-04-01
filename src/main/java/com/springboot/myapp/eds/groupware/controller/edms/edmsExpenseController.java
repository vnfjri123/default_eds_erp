package com.springboot.myapp.eds.groupware.controller.edms;

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
public class edmsExpenseController {

	@Autowired
	private edmsExpenseService edmsExpenseService;

	@RequestMapping("/EDMS_EXPENSE_REPORT_VIEW")
	public String edmsExpenseView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EXPENSE_REPORT";
	}
	@RequestMapping("/EDMS_EXPENSE_REPORT_CONF_VIEW")
	public String edmsExpenseConfView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EXPENSE_REPORT_CONF";
	}

	@RequestMapping("/EDMS_EXPENSE_REPORT_TEMP_VIEW")
	public String edmsExpenseTempView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EXPENSE_REPORT_TEMP";
	}
	
	@RequestMapping("/EDMS_EXPENSE_REPORT_INS_VIEW")
	public String edmsExpenseInsView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EXPENSE_REPORT_INS";
	}


	@RequestMapping("/EDMS_EXPENSE_REPORT/selectExpenseList")
	@ResponseBody
	public Map selectExpenseList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = edmsExpenseService.selectExpenseList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EDMS_EXPENSE_REPORT/selectExpenseItemList")
	@ResponseBody
	public Map selectExpenseItemList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = edmsExpenseService.selectExpenseItemList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EDMS_EXPENSE_REPORT/cudExpenseList")
	@ResponseBody
	public Map cudExpenseList(@RequestParam(value = "file",required=false) List<MultipartFile> files, @RequestParam HashMap<String, Object> param) throws Exception {
		Map mp = new HashMap();
		Map rtn = new HashMap();

		System.out.println(param.get("data"));
		JSONParser p = new JSONParser();
		JSONArray obj = (JSONArray)p.parse((String) param.get("data"));


		// System.out.println(obj.toString());
		try {
			// ibsheet에서 넘어온 내용
			List saveData=(List)obj;

			int updatedCnt = 0;
			System.out.println(saveData);
			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				row.put("estiDt", Util.removeMinusChar((String) row.get("estiDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));
				switch (row.get("status").toString()){
					case "C": updatedCnt += edmsExpenseService.insertExpenseList(files,row); break;
					case "D":
						updatedCnt += edmsExpenseService.deleteExpenseList(row);
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
			ex.printStackTrace();
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

	@RequestMapping("/EDMS_EXPENSE_REPORT/cudExpenseItemList")
	@ResponseBody
	public Map cudExpenseItemList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				switch (row.get("status").toString()){
					case "C": updatedCnt += edmsExpenseService.insertExpenseItemList(row); break;
					case "U": updatedCnt += edmsExpenseService.updateExpenseItemList(row); break;
					case "D": updatedCnt += edmsExpenseService.deleteExpenseItemList(row); break;
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