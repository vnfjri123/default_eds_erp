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
public class guMaeOrdController {

	@Autowired
	private guMaeOrdService guMaeOrdService;

	@RequestMapping("/GUMAE_ORD_MGT_VIEW")
	public String guMaeOrdMgtView(Model model) throws Exception {

		return "/eds/erp/guMae/GUMAE_ORD_MGT";
	}

	@RequestMapping("/GUMAE_ORD_SEND_VIEW")
	public String guMaeOrdSendView(Model model) throws Exception {

		return "/eds/erp/guMae/GUMAE_ORD_SEND";
	}

	@RequestMapping("/GUMAE_ORD_MGT/selectOrdMgtList")
	@ResponseBody
	public Map selectOrdMgtList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = guMaeOrdService.selectOrdMgtList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/GUMAE_ORD_MGT/selectOrdItemList")
	@ResponseBody
	public Map selectOrdItemList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = guMaeOrdService.selectOrdItemList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/GUMAE_ORD_MGT/cudOrdMgtList")
	@ResponseBody
	public Map cudOrdMgtList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("estDt", Util.removeMinusChar((String) row.get("estDt")));
				row.put("ordDt", Util.removeMinusChar((String) row.get("ordDt")));
				row.put("validDt", Util.removeMinusChar((String) row.get("validDt")));
				row.put("ordDueDt", Util.removeMinusChar((String) row.get("ordDueDt")));

				switch (row.get("status").toString()){
					case "C": updatedCnt += guMaeOrdService.insertOrdMgtList(row); break;
					case "U": updatedCnt += guMaeOrdService.updateOrdMgtList(row); break;
					case "D":
						updatedCnt += guMaeOrdService.deleteOrdEmailList(row);
						updatedCnt += guMaeOrdService.deleteOrdItemList(row);
						updatedCnt += guMaeOrdService.deleteOrdMgtList(row);
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

	@RequestMapping("/GUMAE_ORD_MGT/cudOrdList")
	@ResponseBody
	public Map<String, Object> cudOrdList(@RequestBody Map<String, Object> param, Model model) throws Exception {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try {

			returnData = guMaeOrdService.cudOrdList(param);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/GUMAE_ORD_MGT/cudOrdItemList")
	@ResponseBody
	public Map cudOrdItemList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				switch (row.get("status").toString()){
					case "C": updatedCnt += guMaeOrdService.insertOrdItemList(row); break;
					case "U": updatedCnt += guMaeOrdService.updateOrdItemList(row); break;
					case "D": updatedCnt += guMaeOrdService.deleteOrdItemList(row); break;
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

	@RequestMapping("/GUMAE_ORD_MGT/cudOrdEmailList")
	@ResponseBody
	public Map cudOrdEmailList(@RequestBody Map param, Model model) throws Exception {

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
					case "D": updatedCnt += guMaeOrdService.deleteOrdEmailList(row); break;
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

	@RequestMapping("/GUMAE_ORD_MGT/aProjMgtList")
	@ResponseBody
	public Map aOrdMgtList(@RequestBody Map param, Model model) throws Exception {

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

				updatedCnt += guMaeOrdService.aProjMgtList(row);
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

	@RequestMapping("/GUMAE_ORD_MGT/deadLineOrdMgtList")
	@ResponseBody
	public Map deadLineOrdMgtList(@RequestBody Map<String, Object> map, Model model) throws Exception {


		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {

			int updatedCnt = guMaeOrdService.deadLineOrdMgtList(map);

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