package com.springboot.myapp.eds.erp.controller.yeongEob;

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
public class yeongEobSalController {

	@Autowired
	private yeongEobSalService yeongEobSalService;

	@RequestMapping("/YEONGEOB_SAL_MGT_VIEW")
	public String yeongEobMgtView(Model model) throws Exception {

		return "/eds/erp/yeongEob/YEONGEOB_SAL_MGT";
	}

	@RequestMapping("/YEONGEOB_SAL_MGT/selectSalMgtList")
	@ResponseBody
	public Map selectSalMgtList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = yeongEobSalService.selectSalMgtList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/YEONGEOB_SAL_MGT/cudSalMgtList")
	@ResponseBody
	public Map cudSalMgtList(@RequestBody Map param, Model model) throws Exception {

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
				row.put("salDt", Util.removeMinusChar((String) row.get("salDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += yeongEobSalService.insertSalMgtList(row); break;
					case "U": updatedCnt += yeongEobSalService.updateSalMgtList(row); break;
					case "D":
						updatedCnt += yeongEobSalService.deleteSalEmailList(row);
						updatedCnt += yeongEobSalService.deleteSalMgtList(row);
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

	@RequestMapping("/YEONGEOB_SAL_MGT/cudSalEmailList")
	@ResponseBody
	public Map cudSalEmailList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			System.out.println(saveData.size());

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				System.out.println(i);
				System.out.println(row.get("status").toString());
				switch (row.get("status").toString()){
					case "D": updatedCnt += yeongEobSalService.deleteSalEmailList(row); break;
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

	@RequestMapping("/YEONGEOB_SAL_MGT/aProjMgtList")
	@ResponseBody
	public Map aProjMgtList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			System.out.println(saveData.size());

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("estDt", Util.removeMinusChar((String) row.get("estDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));
				row.put("cntDt", Util.removeMinusChar((String) row.get("cntDt")));
				row.put("dueDt", Util.removeMinusChar((String) row.get("dueDt")));
				row.put("endDt", Util.removeMinusChar((String) row.get("endDt")));

				updatedCnt += yeongEobSalService.aProjMgtList(row);
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

	@RequestMapping("/YEONGEOB_SAL_MGT/deadLineSalMgtList")
	@ResponseBody
	public Map deadLineSalMgtList(@RequestBody Map<String, Object> map, Model model) throws Exception {


		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {

			int updatedCnt = yeongEobSalService.deadLineSalMgtList(map);

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
