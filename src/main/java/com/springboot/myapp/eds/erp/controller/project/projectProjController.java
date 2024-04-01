package com.springboot.myapp.eds.erp.controller.project;

import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class projectProjController {

	@Autowired
	private projectProjService projectProjService;

	@RequestMapping("/PROJECT_MGT_VIEW")
	public String projectMgtView(Model model) throws Exception {

		return "/eds/erp/project/PROJECT_MGT";
	}

	@RequestMapping("/PROJECT_MGT_POP_VIEW")
	public String projectMgtPopView(Model model) throws Exception {

		return "/eds/erp/project/PROJECT_MGT_POP";
	}
	@RequestMapping("/PROJECT_EDMS_MGT_POP_VIEW")
	public String projectEdmsMgtPopView(Model model) throws Exception {

		return "/eds/erp/project/PROJECT_EDMS_MGT_POP";
	}

	@RequestMapping("/PROJECT_SCH_MGT_VIEW")
	public String projectSchMgtView(Model model) throws Exception {

		return "/eds/erp/project/PROJECT_SCH_MGT";
	}

	@RequestMapping("/PROJECT_COMP_MGT_VIEW")
	public String projectCompMgtView(Model model) throws Exception {

		return "/eds/erp/project/PROJECT_COMP_MGT";
	}

	@RequestMapping("/PROJECT_MGT/selectProjMgtList")
	@ResponseBody
	public Map selectProjMgtList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjMgtList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjSchList")
	@ResponseBody
	public Map selectProjSchList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjSchList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjItemList")
	@ResponseBody
	public Map selectProjItemList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjItemList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjPartList")
	@ResponseBody
	public Map selectProjPartList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjPartList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjFileList")
	@ResponseBody
	public Map selectFileMemoList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjFileList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjCostList")
	@ResponseBody
	public Map selectCostMemoList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjCostList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjMemoList")
	@ResponseBody
	public Map selectProjMemoList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjMemoList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjCostTot")
	@ResponseBody
	public Map selectProjCostTot(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjCostTot(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjCostDet")
	@ResponseBody
	public Map selectProjCostDet(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjCostDet(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjCompMgtList")
	@ResponseBody
	public Map selectProjCompMgtList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjCompMgtList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjCompPartList")
	@ResponseBody
	public Map selectProjCompPartList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjCompPartList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/selectProjCompCostList")
	@ResponseBody
	public Map selectProjCompCostList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = projectProjService.selectProjCompCostList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/PROJECT_MGT/cudProjMgtList")
	@ResponseBody
	public Map cudProjMgtList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("estDt", Util.removeMinusChar((String) row.get("estDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));
				row.put("cntDt", Util.removeMinusChar((String) row.get("cntDt")));
				row.put("initiateDt", Util.removeMinusChar((String) row.get("initiateDt")));
				row.put("dueDt", Util.removeMinusChar((String) row.get("dueDt")));
				row.put("endDt", Util.removeMinusChar((String) row.get("endDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += projectProjService.insertProjMgtList(row); break;
					case "U": updatedCnt += projectProjService.updateProjMgtList(row); break;
					case "D":
						updatedCnt += projectProjService.deleteProjEmailList(row);
						updatedCnt += projectProjService.deleteProjItemList(row);
						updatedCnt += projectProjService.deleteProjPartList(row);
						updatedCnt += projectProjService.deleteProjFileList(row);
						updatedCnt += projectProjService.deleteProjCostList(row);
						updatedCnt += projectProjService.deleteProjMemoList(row);
						updatedCnt += projectProjService.deleteProjMgtList(row);
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
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

	@RequestMapping("/PROJECT_MGT/cudProjItemList")
	@ResponseBody
	public Map cudProjItemList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += projectProjService.insertProjItemList(row); break;
					case "U": updatedCnt += projectProjService.updateProjItemList(row); break;
					case "D": updatedCnt += projectProjService.deleteProjItemList(row); break;
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

	@RequestMapping("/PROJECT_MGT/cudProjPartList")
	@ResponseBody
	public Map cudProjPartList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += projectProjService.insertProjPartList(row); break;
					case "U": updatedCnt += projectProjService.updateProjPartList(row); break;
					case "D": updatedCnt += projectProjService.deleteProjPartList(row); break;
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

	@RequestMapping("/PROJECT_MGT/cudProjMgtList2")
	@ResponseBody
	public Map cudProjMgtList2(@RequestBody Map param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			System.out.println(param);
			returnData = projectProjService.cudProjMgtList2(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/PROJECT_MGT/cudProjPartList2")
	@ResponseBody
	public Map cudProjPartList2(@RequestBody Map param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			System.out.println(param);
			returnData = projectProjService.cudProjPartList2(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/PROJECT_MGT/cudProjMemoList2")
	@ResponseBody
	public Map cudProjMemoList2(@RequestBody Map param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			System.out.println(param);
			returnData = projectProjService.cudProjMemoList2(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/PROJECT_MGT/cProjFileList")
	@ResponseBody
	public Map<String, Object> sendEmail(MultipartHttpServletRequest mtfRequest) throws IllegalStateException, IOException {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try{

			returnData = projectProjService.insertProjFileList(mtfRequest);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/PROJECT_MGT/udProjFileList")
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
					case "U": updatedCnt += projectProjService.updateProjFileList(row); break;
					case "D": updatedCnt += projectProjService.deleteProjFileList(row); break;
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

	@RequestMapping("/PROJECT_MGT/cudProjCostList")
	@ResponseBody
	public Map cudProjCostList(@RequestBody Map param, Model model) throws Exception {

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
					case "C": updatedCnt += projectProjService.insertProjCostList(row); break;
					case "U": updatedCnt += projectProjService.updateProjCostList(row); break;
					case "D": updatedCnt += projectProjService.deleteProjCostList(row); break;
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

	@RequestMapping("/PROJECT_MGT/cudProjMemoList")
	@ResponseBody
	public Map cudProjMemoList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += projectProjService.insertProjMemoList(row); break;
					case "U": updatedCnt += projectProjService.updateProjMemoList(row); break;
					case "D": updatedCnt += projectProjService.deleteProjMemoList(row); break;
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

	@RequestMapping("/PROJECT_MGT/cudProjEmailList")
	@ResponseBody
	public Map cudProjEmailList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			System.out.println(saveData.size());

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				switch (row.get("status").toString()){
					case "D": updatedCnt += projectProjService.deleteProjEmailList(row); break;
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

	@RequestMapping("/PROJECT_MGT/cudProjCompMgtList")
	@ResponseBody
	public Map cudProjCompMgtList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("estDt", Util.removeMinusChar((String) row.get("estDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));
				row.put("cntDt", Util.removeMinusChar((String) row.get("cntDt")));
				row.put("dueDt", Util.removeMinusChar((String) row.get("dueDt")));
				row.put("endDt", Util.removeMinusChar((String) row.get("endDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += projectProjService.insertProjCompMgtList(row); break;
					case "U": updatedCnt += projectProjService.updateProjCompMgtList(row); break;
					case "D":
						updatedCnt += projectProjService.deleteProjCompCostList(row);
						updatedCnt += projectProjService.deleteProjCompPartList(row);
						updatedCnt += projectProjService.deleteProjCompMgtList(row);
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
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

	@RequestMapping("/PROJECT_MGT/cudProjCompPartList")
	@ResponseBody
	public Map cudProjCompPartList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += projectProjService.insertProjCompPartList(row); break;
					case "U": updatedCnt += projectProjService.updateProjCompPartList(row); break;
					case "D": updatedCnt += projectProjService.deleteProjCompPartList(row); break;
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

	@RequestMapping("/PROJECT_MGT/cudProjCompCostList")
	@ResponseBody
	public Map cudProjCompCostList(@RequestBody Map param, Model model) throws Exception {

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
					case "C": updatedCnt += projectProjService.insertProjCompCostList(row); break;
					case "U": updatedCnt += projectProjService.updateProjCompCostList(row); break;
					case "D": updatedCnt += projectProjService.deleteProjCompCostList(row); break;
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

	@RequestMapping("/PROJECT_MGT/aEstMgtList")
	@ResponseBody
	public Map aEstMgtList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			System.out.println(saveData.size());

			for (int i = 0; i < saveData.size(); i++) { updatedCnt += projectProjService.aEstMgtList((Map) saveData.get(i)); }
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

	@RequestMapping("/PROJECT_MGT/deadLineProjMgtList")
	@ResponseBody
	public Map deadLineProjMgtList(@RequestBody Map<String, Object> map, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {

			int updatedCnt = projectProjService.deadLineProjMgtList(map);

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
