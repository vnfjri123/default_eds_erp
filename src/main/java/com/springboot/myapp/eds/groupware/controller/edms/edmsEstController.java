package com.springboot.myapp.eds.groupware.controller.edms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.myapp.eds.groupware.vo.edms.edmsSubmitListVO;
import com.springboot.myapp.util.Util;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Controller
public class edmsEstController {

	@Autowired
	private edmsEstService edmsEstService;

	@RequestMapping("/EDMS_EST_REPORT_VIEW")
	public String edmsEstView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EST_REPORT";
	}
	@RequestMapping("/EDMS_EST_REPORT_CONF_VIEW")
	public String edmsEstConfView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EST_REPORT_CONF";
	}

	@RequestMapping("/EDMS_EST_REPORT_TEMP_VIEW")
	public String edmsEstTempView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EST_REPORT_TEMP";
	}
	
	@RequestMapping("/EDMS_EST_REPORT_INS_VIEW")
	public String edmsEstInsView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EST_REPORT_INS";
	}

	@RequestMapping("/EDMS_PROJECT_REPORT_VIEW")
	public String edmsProjectView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_REPORT";
	}
	@RequestMapping("/EDMS_PROJECT_REPORT_CONF_VIEW")
	public String edmsProjectConfView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_REPORT_CONF";
	}

	@RequestMapping("/EDMS_PROJECT_REPORT_TEMP_VIEW")
	public String edmsProjectTempView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_REPORT_TEMP";
	}
	
	@RequestMapping("/EDMS_PROJECT_REPORT_INS_VIEW")
	public String edmsProjectInsView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_REPORT_INS";
	}
	@RequestMapping("/EDMS_PROJECT_COM_REPORT_VIEW")
	public String edmsProjectComView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_COM_REPORT";
	}
	@RequestMapping("/EDMS_PROJECT_COM_REPORT_CONF_VIEW")
	public String edmsProjectComConfView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_COM_REPORT_CONF";
	}

	@RequestMapping("/EDMS_PROJECT_COM_REPORT_TEMP_VIEW")
	public String edmsProjectComTempView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_COM_REPORT_TEMP";
	}
	
	@RequestMapping("/EDMS_PROJECT_COM_REPORT_INS_VIEW")
	public String edmsProjectComInsView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_COM_REPORT_INS";
	}

	@RequestMapping("/EDMS_PROJECT_UPDATE_REPORT_VIEW")
	public String edmsProjectUpdateView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_UPDATE_REPORT";
	}
	@RequestMapping("/EDMS_PROJECT_UPDATE_REPORT_CONF_VIEW")
	public String edmsProjectUpdateConfView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_UPDATE_REPORT_CONF";
	}

	@RequestMapping("/EDMS_PROJECT_UPDATE_REPORT_TEMP_VIEW")
	public String edmsProjectUpdateTempView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_UPDATE_REPORT_TEMP";
	}
	
	@RequestMapping("/EDMS_PROJECT_UPDATE_REPORT_INS_VIEW")
	public String edmsProjectUpdatensView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_PROJECT_UPDATE_REPORT_INS";
	}

	@RequestMapping("/EDMS_EST_REPORT/selectEstList")
	@ResponseBody
	public Map selectEstList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = edmsEstService.selectEstList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EDMS_EST_REPORT/selectEstItemList")
	@ResponseBody
	public Map selectEstItemList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = edmsEstService.selectEstItemList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EDMS_EST_REPORT/cudEstList")
	@ResponseBody
	public Map cudEstList(@RequestParam(value = "file",required=false) List<MultipartFile> files, @RequestParam HashMap<String, Object> param) throws Exception {
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
			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				row.put("estiDt", Util.removeMinusChar((String) row.get("estiDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));
				row.put("manCd", Util.removeMinusChar((String) row.get("empCd")));
				switch (row.get("status").toString()){
					case "C": updatedCnt += edmsEstService.insertEstList(files,row); break;
					case "D":
						updatedCnt += edmsEstService.deleteEstList(row);
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

	@RequestMapping("/EDMS_EST_REPORT/cudEstItemList")
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
					case "C": updatedCnt += edmsEstService.insertEstItemList(row); break;
					case "U": updatedCnt += edmsEstService.updateEstItemList(row); break;
					case "D": updatedCnt += edmsEstService.deleteEstItemList(row); break;
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