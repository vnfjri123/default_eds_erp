package com.springboot.myapp.eds.erp.controller.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class systemGpController {
    
    @Autowired
    private systemGpService systemGpService;

    @GetMapping("/SYSTEM_GP_MENU_MGT_VIEW")
	public String SYSTEM_GP_MENU_MGT_VIEW(Model model) throws Exception{

		return "/eds/erp/system/SYSTEM_GP_MENU_MGT";
    }

	@RequestMapping("/SYSTEM_GP_MENU_AUTH_POP_VIEW")
	public String projectMgtPopView(Model model) throws Exception {

		return "/eds/erp/system/SYSTEM_GP_MENU_AUTH_POP";
	}

	@GetMapping("/SYSTEM_GP_USER_MGT_VIEW")
	public String SYSTEM_GP_USER_MGT_VIEW(Model model) throws Exception{
		return "/eds/erp/system/SYSTEM_GP_USER_MGT";
	}

    @PostMapping("/SYSTEM_GP_MENU_MGT/selectGpMenuMgtList")
	@ResponseBody
	public Map selectGpMenuMgtList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemGpService.selectGpMenuMgtList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/SYSTEM_GP_MENU_AUTH/selectGpMenuAuthList")
	@ResponseBody
	public Map selectGpMenuAuthList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemGpService.selectGpMenuAuthList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@PostMapping("/SYSTEM_GP_USER_MGT/selectGpUserMgtList")
	@ResponseBody
	public Map selectGpUserMgtList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemGpService.selectGpUserMgtList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
    @RequestMapping("/SYSTEM_GP_MENU_MGT/cudGpGpMenuMgtList")
	@ResponseBody
	public Map cudGpGpMenuMgtList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += systemGpService.insertGpMenuMgtList(row); break;
					case "U": updatedCnt += systemGpService.updateGpMenuMgtList(row); break;
					case "D":
						updatedCnt += systemGpService.deleteGpUserMgtList(row);
						updatedCnt += systemGpService.deleteGpMenuAuthList(row);
						updatedCnt += systemGpService.deleteGpMenuMgtList(row);
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

	@RequestMapping("/SYSTEM_GP_MENU_AUTH/cudGpMenuAuthList")
	@ResponseBody
	public Map cudGpMenuAuthList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				switch (row.get("status").toString()){
					case "U": updatedCnt += systemGpService.updateGpMenuAuthList(row); break;
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

	@RequestMapping("/SYSTEM_GP_USER_MGT/cudGpUserMgtList")
	@ResponseBody
	public Map cudGpUserMgtList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += systemGpService.insertGpUserMgtList(row); break;
					case "U": updatedCnt += systemGpService.updateGpUserMgtList(row); break;
					case "D": updatedCnt += systemGpService.deleteGpUserMgtList(row); break;
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
