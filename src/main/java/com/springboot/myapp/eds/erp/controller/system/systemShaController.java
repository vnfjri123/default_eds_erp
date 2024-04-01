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
public class systemShaController {
    
    @Autowired
    private systemShaService systemShaService;

    @RequestMapping("/SYSTEM_SHA_CODE_VIEW")
	public String selectShaListView(Model model) throws Exception{

		return "/eds/erp/system/SYSTEM_SHA_CODE";
    }

    @RequestMapping("/SYSTEM_SHA_CODE/selectShaList")
	@ResponseBody
	public Map selectShaList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemShaService.selectShaList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/SYSTEM_SHA_CODE/selectShaDet")
	@ResponseBody
	public Map selectShaDet(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemShaService.selectShaDet(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
    @RequestMapping("/SYSTEM_SHA_CODE/cudShaList")
	@ResponseBody
	public Map insertShaList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				switch (row.get("status").toString()){
					case "C": updatedCnt += systemShaService.insertShaList(row); break;
					case "U": updatedCnt += systemShaService.updateShaList(row); break;
					case "D":
						updatedCnt += systemShaService.deleteShaDet(row);
						updatedCnt += systemShaService.deleteShaList(row);
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

	@RequestMapping("/SYSTEM_SHA_CODE/cudShaDet")
	@ResponseBody
	public Map insertShaDet(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				switch (row.get("status").toString()){
					case "C": updatedCnt += systemShaService.insertShaDet(row); break;
					case "U": updatedCnt += systemShaService.updateShaDet(row); break;
					case "D": updatedCnt += systemShaService.deleteShaDet(row); break;
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
