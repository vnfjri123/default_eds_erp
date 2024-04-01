package com.springboot.myapp.eds.erp.controller.base;

import com.springboot.myapp.util.Util;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class baseCarController {
    
    private final baseCarService baseCarService;

	public baseCarController(baseCarService baseCarService) {
		this.baseCarService = baseCarService;
	}

	@RequestMapping("/BASE_CAR_MGT_LIST_VIEW")
	public String BASE_CAR_LIST_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_CAR_MGT_LIST";
    }

    @RequestMapping("/BASE_CAR_MGT_LIST_POP_VIEW")
	public String BASE_CAR_MGT_LIST_POP_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_CAR_MGT_LIST_POP";
    }

    @RequestMapping("/BASE_CAR_MGT_USE_LIST_POP_VIEW")
	public String BASE_CAR_MGT_USE_LIST_POP_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_CAR_MGT_USE_LIST_POP";
    }

    @RequestMapping("/BASE_CAR_MGT_LIST/selectCarMgtList")
	@ResponseBody
	public Map selectCarMgtList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseCarService.selectCarMgtList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

    @RequestMapping("/BASE_CAR_MGT_LIST/selectCarMgtUseList")
	@ResponseBody
	public Map selectCarMgtUseList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseCarService.selectCarMgtUseList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

    @RequestMapping("/BASE_CAR_MGT_LIST/selectCarExpeList")
	@ResponseBody
	public Map selectCarExpeList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseCarService.selectCarExpeList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/BASE_CAR_MGT_LIST/selectCarExpeFileList")
	@ResponseBody
	public Map selectCarExpeFileList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = baseCarService.selectCarExpeFileList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
    @RequestMapping("/BASE_CAR_MGT_LIST/cudCarMgtList")
	@ResponseBody
	public Map cudCarMgtList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				row.put("periInspExpiDt", Util.removeMinusChar((String) row.get("periInspExpiDt")));
				row.put("insuExpiDt", Util.removeMinusChar((String) row.get("insuExpiDt")));
				row.put("buyDt", Util.removeMinusChar((String) row.get("buyDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += baseCarService.insertCarMgtList(row); break;
					case "U": updatedCnt += baseCarService.updateCarMgtList(row); break;
					case "D":
						updatedCnt += baseCarService.deleteCarExpeFileList(row);
						updatedCnt += baseCarService.deleteCarExpeList(row);
						updatedCnt += baseCarService.deleteCarMgtList(row); break;
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

    @RequestMapping("/BASE_CAR_MGT_LIST/cudCarExpeList")
	@ResponseBody
	public Map cudCarExpeList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				row.put("expeDt", Util.removeMinusChar((String) row.get("expeDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += baseCarService.insertCarExpeList(row); break;
					case "U": updatedCnt += baseCarService.updateCarExpeList(row); break;
					case "D":
						updatedCnt += baseCarService.deleteCarExpeFileList(row);
						updatedCnt += baseCarService.deleteCarExpeList(row); break;
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

	@RequestMapping("/BASE_CAR_MGT_LIST/cCarExpeFileList")
	@ResponseBody
	public Map<String, Object> sendEmail(MultipartHttpServletRequest mtfRequest) throws IllegalStateException, IOException {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try{

			returnData = baseCarService.insertCarExpeFileList(mtfRequest);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/BASE_CAR_MGT_LIST/udCarExpeFileList")
	@ResponseBody
	public Map cudProjFileList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("costDt", Util.removeMinusChar((String) row.get("costDt")));
				switch (row.get("status").toString()){
					case "U": updatedCnt += baseCarService.updateCarExpeFileList(row); break;
					case "D": updatedCnt += baseCarService.deleteCarExpeFileList(row); break;
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

	@RequestMapping(value = "/BASE_CAR_MGT_LIST/selectCarExpeImage/{params}")
	public ResponseEntity<byte[]> selectCarFaceImage(@PathVariable("params") String params) throws IOException {

		try{

			return baseCarService.selectCarExpeImage(params);

		}catch (Exception e ){

			e.printStackTrace();

		}
        return null;
    }
}