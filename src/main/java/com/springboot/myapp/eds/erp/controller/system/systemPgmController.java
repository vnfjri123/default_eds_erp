package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemPgmDetVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class systemPgmController {

	@Autowired
	private systemPgmService systemPgmService;
	private HashMap<String, Object> map;

	@GetMapping(value = "/SYSTEM_PGM_MGT_VIEW")
	public String SYSTEM_PGM_MGT_VIEW(Model model) throws Exception{
		return "/eds/erp/system/SYSTEM_PGM_MGT";
	}

	@GetMapping("/SYSTEM_PGM_MGT_POPUP_VIEW")
	public String SYSTEM_PGM_MGT_POPUP_VIEW(Model model) throws Exception{

		return "/eds/erp/system/SYSTEM_PGM_MGT_POPUP";
	}

	@PostMapping("/SYSTEM_PGM_MGT/selectPmgMgtList")
	@ResponseBody
	public Map selectPmgMgtList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemPgmService.selectPmgMgtList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/SYSTEM_PGM_MGT_POPUP/selectPmgMgtListPopup")
	@ResponseBody
	public Map selectPmgMgtListPopup(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = systemPgmService.selectPmgMgtListPopup(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@PostMapping("/SYSTEM_PGM_MGT/checkedMenuList")
	@ResponseBody
	public Map checkedMenuList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map<String, Object> mp = new HashMap<>();
		try {

			List<Map<String,Object>> rows = (List<Map<String,Object>>) map.get("data");

			int rowsLen = rows.size();
			String menuNm = "";
			String pgmNm = "";
			String cnt = "";

			for(int i=0;i<rowsLen;i++){
				Map<String, Object> row = rows.get(i);

				List<systemPgmDetVO> rst = systemPgmService.checkedMenuList(row);

				if(rst.isEmpty()){
					System.out.println("cnt = 0");
					mp.put("code", "success");
					return mp;
				}else{

					menuNm = rst.get(0).getMenuNm();
					pgmNm = rst.get(0).getPgmNm();

					System.out.println("cnt > 0");
					mp.put("code", "fail");
					mp.put("menuNm", menuNm);
					mp.put("pgmNm", pgmNm);
					return mp;
				}
			}
//			List li = sysma0000Service.selectSYSMA0000(map);
//			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@PostMapping("/SYSTEM_PGM_MGT/cudPmgMgtList")
	@ResponseBody
	public Map cudPmgMgtList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				switch (row.get("status").toString()){
					case "C": updatedCnt += systemPgmService.insertPmgMgtList(row); break;
					case "U": updatedCnt += systemPgmService.updatePmgMgtList(row); break;
					case "D": updatedCnt += systemPgmService.deletePmgMgtList(row); break;
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
