package com.springboot.myapp.eds.erp.controller.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class baseDepaController {
    
    @Autowired
    private baseDepaService baseDepaService;

    @RequestMapping("/BASE_DEPA_REG_VIEW")
	public String BASE_DEPA_REG_VIEW(Model model) throws Exception{		

		return "/eds/erp/base/BASE_DEPA_REG";
    }

	@RequestMapping("/BASE_DEPA_REG_POP_VIEW")
	public String BASE_DEPA_REG_POP_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_DEPA_REG_POP";
	}

    @RequestMapping("/BASE_DEPA_REG/selectDepaList")
	@ResponseBody
	public Map selectDepaList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseDepaService.selectDepaList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/BASE_DEPA_REG/selectDepaPopList")
	@ResponseBody
	public Map selectDepaPopList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseDepaService.selectDepaPopList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
    @RequestMapping("/BASE_DEPA_REG/cudDepaList")
	@ResponseBody
	public Map cudDepaList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				switch (row.get("status").toString()){
					case "C": updatedCnt += baseDepaService.insertDepaList(row); break;
					case "U": updatedCnt += baseDepaService.updateDepaList(row); break;
					case "D": updatedCnt += baseDepaService.deleteDepaList(row); break;
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
