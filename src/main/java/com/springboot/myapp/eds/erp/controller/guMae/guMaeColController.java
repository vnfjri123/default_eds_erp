package com.springboot.myapp.eds.erp.controller.guMae;

import com.springboot.myapp.util.Util;
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
public class guMaeColController {

	@Autowired
	private guMaeColService guMaeColService;

	@RequestMapping("/GUMAE_COL_MGT_VIEW")
	public String guMaeMgtView(Model model) throws Exception {

		return "/eds/erp/guMae/GUMAE_COL_MGT";
	}

	@RequestMapping("/GUMAE_COL_MGT/selectColMgtList")
	@ResponseBody
	public Map selectColMgtList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = guMaeColService.selectColMgtList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/GUMAE_COL_MGT/cudColMgtList")
	@ResponseBody
	public Map cudColMgtList(@RequestBody Map param, Model model) throws Exception {

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
				row.put("colDt", Util.removeMinusChar((String) row.get("colDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += guMaeColService.insertColMgtList(row); break;
					case "U": updatedCnt += guMaeColService.updateColMgtList(row); break;
					case "D":
						updatedCnt += guMaeColService.deleteColEmailList(row);
						updatedCnt += guMaeColService.deleteColMgtList(row);
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

	@RequestMapping("/GUMAE_COL_MGT/cudColEmailList")
	@ResponseBody
	public Map cudColEmailList(@RequestBody Map param, Model model) throws Exception {

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
					case "D": updatedCnt += guMaeColService.deleteColEmailList(row); break;
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
	@RequestMapping("/GUMAE_COL_MGT/aRecMgtList")
	@ResponseBody
	public Map aRecMgtList(@RequestBody Map param, Model model) throws Exception {

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

				updatedCnt += guMaeColService.aRecMgtList(row);
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

	@RequestMapping("/GUMAE_COL_MGT/deadLineColMgtList")
	@ResponseBody
	public Map deadLineColMgtList(@RequestBody Map<String, Object> map, Model model) throws Exception {


		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {

			int updatedCnt = guMaeColService.deadLineColMgtList(map);

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
