package com.springboot.myapp.eds.erp.controller.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.springboot.myapp.util.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class baseCorpController {
    
    @Autowired
    private baseCorpService baseCorpService;

    @RequestMapping("/BASE_CORP_REG_VIEW")
	public String BASE_CORP_REG_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_CORP_REG";
    }
    @RequestMapping("/BASE_CORP_REG/selectCorpList")
	@ResponseBody
	public Map selectCorpList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseCorpService.selectCorpList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
    @RequestMapping("/BASE_CORP_REG/cudCorpList")
	@ResponseBody
	public Map cudCorpList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				row.put("corpNo", Util.removeMinusChar((String) row.get("corpNo")));
				row.put("corpRegNo", Util.removeMinusChar((String) row.get("corpRegNo")));
				row.put("telNo", Util.removeMinusChar((String) row.get("telNo")));
				row.put("faxNo", Util.removeMinusChar((String) row.get("faxNo")));
				switch (row.get("status").toString()){
					case "C": updatedCnt += baseCorpService.insertCorpList(row); break;
					case "U": updatedCnt += baseCorpService.updateCorpList(row); break;
					case "D": updatedCnt += baseCorpService.deleteCorpList(row); break;
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
