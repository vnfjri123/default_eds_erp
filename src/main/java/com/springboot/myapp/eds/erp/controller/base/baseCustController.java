package com.springboot.myapp.eds.erp.controller.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.springboot.myapp.eds.erp.vo.base.baseCustListVO;
import com.springboot.myapp.util.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class baseCustController {

	@Autowired
	private baseCustService baseCustService;

	@RequestMapping("/BASE_CUST_REG_VIEW")
	public String BASE_CUST_REG_VIEW(Model model) throws Exception {

		return "/eds/erp/base/BASE_CUST_REG";
	}

	@RequestMapping("/BASE_CUST_REG_POPUP_VIEW")
	public String BASE_CUST_REG_POPUP_VIEW(Model model) throws Exception {

		return "/eds/erp/base/BASE_CUST_REG_POP";
	}

	@RequestMapping("/BASE_CUST_REG/selectCustList")
	@ResponseBody
	public Map selectCustList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List<baseCustListVO> li = baseCustService.selectCustList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/BASE_CUST_REG/selectCustPopList")
	@ResponseBody
	public Map selectCustPopList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = baseCustService.selectCustPopList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/BASE_CUST_REG/cudCustList")
	@ResponseBody
	public Map cudCustList(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				// ' - '를 제거
				row.put("corpNo", Util.removeMinusChar((String) row.get("corpNo")));// 사업자등록번호
				row.put("corpRegNo", Util.removeMinusChar((String) row.get("corpRegNo")));// 법인등록번호
				row.put("telNo", Util.removeMinusChar((String) row.get("telNo")));// 전화번호
				row.put("faxNo", Util.removeMinusChar((String) row.get("faxNo")));// 팩스번호
				row.put("accoNo", Util.removeMinusChar((String) row.get("accoNo")));// 계좌번호
				row.put("validStDt", Util.removeMinusChar((String) row.get("validStDt")));// 유효시작일자
				row.put("validEdDt", Util.removeMinusChar((String) row.get("validEdDt")));// 유효종료일자

				switch (row.get("status").toString()){
					case "C": updatedCnt += baseCustService.insertCustList(row); break;
					case "U": updatedCnt += baseCustService.updateCustList(row); break;
					case "D": updatedCnt += baseCustService.deleteCustList(row); break;
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
			ex.printStackTrace();
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

	@PostMapping("/BASE_CUST_REG/selectCorpNoCheck")
	@ResponseBody
	public String selectCorpNoCheck(@RequestParam Map<String, Object> map, HttpServletRequest request,
			HttpSession session) throws Exception {

		return baseCustService.selectCorpNoCheck(map);
	}
}
