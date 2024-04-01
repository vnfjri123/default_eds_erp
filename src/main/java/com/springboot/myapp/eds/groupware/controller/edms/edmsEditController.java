package com.springboot.myapp.eds.groupware.controller.edms;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.springboot.myapp.util.Util;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Controller
public class edmsEditController {

	@Autowired
	private edmsEditService edmsEditService;

	@RequestMapping("/EDMS_EDIT_REPORT_VIEW")
	public String edmsEditView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EDIT_REPORT";
	}
	@RequestMapping("/EDMS_EDIT_REPORT_CONF_VIEW")
	public String edmsEditConfView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EDIT_REPORT_CONF";
	}

	@RequestMapping("/EDMS_EDIT_REPORT_TEMP_VIEW")
	public String edmsEditTempView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EDIT_REPORT_TEMP";
	}
	
	@RequestMapping("/EDMS_EDIT_REPORT_INS_VIEW")
	public String edmsEditInsView(Model model) throws Exception {

		return "/eds/groupware/edms/EDMS_EDIT_REPORT_INS";
	}


	@RequestMapping("/EDMS_EDIT_REPORT/selectEditList")
	@ResponseBody
	public Map selectEditList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = edmsEditService.selectEditList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EDMS_EDIT_REPORT/cudEditList")
	@ResponseBody
	public Map cudEditList(@RequestParam(value = "file",required=false) List<MultipartFile> files,@RequestParam(value = "tempImage",required=false) List<MultipartFile> tempImage, @RequestParam HashMap<String, Object> param) throws Exception {
		Map mp = new HashMap();
		Map rtn = new HashMap();

		JSONParser p = new JSONParser();
		JSONArray obj = (JSONArray)p.parse((String) param.get("data"));
		// System.out.println(obj.toString());
		try {
			// ibsheet에서 넘어온 내용
			List saveData=(List)obj;

			int updatedCnt = 0;
			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				row.put("editDt", Util.removeMinusChar((String) row.get("editDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));
				row.put("manCd", Util.removeMinusChar((String) row.get("empCd")));
				switch (row.get("status").toString()){
					case "C": updatedCnt += edmsEditService.insertEditList(files,row,tempImage); break;
					case "D":
						updatedCnt += edmsEditService.deleteEditList(row);
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
			rtn.put("Message",ex.getMessage());
		}
		mp.put("IO", rtn);

		return mp;
	}
	@RequestMapping(value = "/EDMS_EDIT_REPORT/{params}")
	public ResponseEntity<byte[]> selectUserFaceImageEdms(@PathVariable("params") String params) throws IOException {
		try{
			return edmsEditService.selectEditImage(params);
		}catch (Exception e ){

			e.printStackTrace();

		}
        return null;
    }
}