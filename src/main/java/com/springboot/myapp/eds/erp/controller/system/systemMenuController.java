package com.springboot.myapp.eds.erp.controller.system;

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
public class systemMenuController {

	@Autowired
	private systemMenuService systemMenuService;

	@RequestMapping("/SYSTEM_MENU_MGT_VIEW")
	public String SYSTEM_MENU_MGT_VIEW(Model model) throws Exception{

		return "/eds/erp/system/SYSTEM_MENU_MGT";
	}

	@RequestMapping("/SYSTEM_MENU_MGT/selectManuMgtList")
	@ResponseBody
	public Map selectManuMgtList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemMenuService.selectManuMgtList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/SYSTEM_MENU_MGT/selectManuMgtDet")
	@ResponseBody
	public Map selectManuMgtDet(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemMenuService.selectManuMgtDet(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/SYSTEM_MENU_MGT/cudManuMgtList")
	@ResponseBody
	public Map cudManuMgtList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += systemMenuService.insertManuMgtList(row); break;
					case "U": updatedCnt += systemMenuService.updateManuMgtList(row); break;
					case "D":
						updatedCnt += systemMenuService.deleteManuGpAuth(row);
						updatedCnt += systemMenuService.deleteManuMgtDet(row);
						updatedCnt += systemMenuService.deleteManuMgtList(row);
						break;
				}
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

	@RequestMapping("/SYSTEM_MENU_MGT/cudManuMgtDet")
	@ResponseBody
	public Map cudManuMgtDet(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += systemMenuService.insertManuMgtDet(row); break;
					case "U": updatedCnt += systemMenuService.updateManuMgtDet(row); break;
					case "D":
						updatedCnt += systemMenuService.deleteManuGpAuth(row);
						updatedCnt += systemMenuService.deleteManuMgtDet(row);
						break;
				}
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}
}
