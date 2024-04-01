package com.springboot.myapp.eds.pda.salma;

import com.springboot.myapp.util.Util;
import org.apache.tomcat.util.buf.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SALMA4500Controller {

	@Autowired
	private SALMA4500Service salma4500Service;

	@RequestMapping("/eds/pda/salma/selectSALMA4500View")
	public String selectSALMA4500View(Model model) throws Exception {

		return "/eds/pda/salma/SALMA4500View";
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4502View")
	public String selectSALMA4502View(Model model) throws Exception {

		return "/eds/pda/salma/SALMA4502View";
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4503View")
	public String selectSALMA4503View(Model model) throws Exception {

		return "/eds/pda/salma/SALMA4503View";
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4500")
	@ResponseBody
	public Map selectSALMA4500(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma4500Service.selectSALMA4500(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4501")
	@ResponseBody
	public Map selectSALMA4501(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma4500Service.selectSALMA4501(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4502")
	@ResponseBody
	public Map selectSALMA4502(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma4500Service.selectSALMA4502(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4503")
	@ResponseBody
	public Map selectSALMA4503(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma4500Service.selectSALMA4503(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4504")
	@ResponseBody
	public Map selectSALMA4504(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma4500Service.selectSALMA4504(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4505")
	@ResponseBody
	public Map selectSALMA4505(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma4500Service.selectSALMA4505(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA4506")
	@ResponseBody
	public Map selectSALMA4506(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma4500Service.selectSALMA4506(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/insertSALMA4500")
	@ResponseBody
	public Map insertSALMA4500(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("exRetuDt", Util.removeMinusChar((String) row.get("exRetuDt")));

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.updateSALMA4500(row);
				} else if("D".equals(row.get("sStatus"))) {
					// updatedCnt += salma4500Service.deleteSALMA4502(row);
					updatedCnt += salma4500Service.deleteSALMA4501(row);
					updatedCnt += salma4500Service.deleteSALMA4500(row);
				} else if("I".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.insertSALMA4500(row);
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

	@RequestMapping("/eds/pda/salma/insertSALMA4501")
	@ResponseBody
	public Map insertSALMA4501(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("deliCloseDt", Util.removeMinusChar((String) row.get("deliCloseDt")));
				row.put("exDueDt", Util.removeMinusChar((String) row.get("exDueDt")));

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.updateSALMA4501(row);
				} else if("D".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.deleteSALMA4501(row);
				} else if("I".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.insertSALMA4501(row);
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

	@RequestMapping("/eds/pda/salma/insertSALMA4502")
	@ResponseBody
	public Map insertSALMA4502(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("deliCloseDt", Util.removeMinusChar((String) row.get("deliCloseDt")));
				row.put("exDueDt", Util.removeMinusChar((String) row.get("exDueDt")));

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.updateSALMA4502(row);
				} else if("D".equals(row.get("sStatus"))) {
					// updatedCnt += salma4500Service.deleteSALMA4502(row);
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

	@RequestMapping("/eds/pda/salma/insertSALMA4503")
	@ResponseBody
	public Map insertSALMA4503(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			// Map app = new HashMap();
			// app = (Map) saveData.get(0);
			// salma4500Service.resetSALMA4503(app);

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				if (i == 0) {
					salma4500Service.resetSALMA4503(row);
				}

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.updateSALMA4503(row);
				}

				if (i == saveData.size() - 1) {
					salma4500Service.applySALMA4503(row);
				}
			}
			if (updatedCnt > 0) { // 정상 저장
				// salma4500Service.applySALMA4503(app);
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

	@RequestMapping("/eds/pda/salma/insertSALMA4505")
	@ResponseBody
	public Map insertSALMA4505(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			// Map app = new HashMap();
			// app = (Map) saveData.get(0);
			// salma4500Service.resetSALMA4505(app);

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				if (i == 0) {
					salma4500Service.resetSALMA4505(row);
				}

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma4500Service.updateSALMA4505(row);
				}

				if (i == saveData.size() - 1) {
					salma4500Service.applySALMA4505(row);
				}
			}
			if (updatedCnt > 0) { // 정상 저장
				// salma4500Service.applySALMA4505(app);
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

	@RequestMapping("/eds/pda/salma/insertSALMA4504")
	@ResponseBody
	public Map insertSALMA4504(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			int updatedCnt = 0;

			updatedCnt += salma4500Service.insertSALMA4504(param);

			if (updatedCnt > 0) { // 정상 저장
				// salma4500Service.applySALMA4505(app);
				rtn.put("Result", 0);
				rtn.put("Message", "저장 되었습니다.");
			} else if (updatedCnt == -1) { // 출고처리되지 않은 바코드
				rtn.put("Result", -1);
				rtn.put("Message", "출고 처리되지 않은 바코드 입니다.");
			} else if (updatedCnt == -2) {  // 중복 바코드
				rtn.put("Result", -2);
				rtn.put("Message", "이미 처리된 바코드입니다.");
			} else if (updatedCnt == -3) {  // 이외에 예외사항
				rtn.put("Result", -3);
				rtn.put("Message", "관리자에게 문의하세요.");
			} else { // 저장 실패
				rtn.put("Result", -100);
				rtn.put("Message", "저장에 실패하였습니다.");
			}

		} catch (Exception ex) {
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

	@RequestMapping("/eds/pda/salma/deleteSALMA4503")
	@ResponseBody
	public Map deleteSALMA4501(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			int updatedCnt = 0;

			updatedCnt += salma4500Service.deleteSALMA4503(param);

			if (updatedCnt > 0) { // 정상 저장
				// salma4500Service.applySALMA4505(app);
				rtn.put("Result", 0);
				rtn.put("Message", "저장 되었습니다.");
			} else if (updatedCnt == -1) { // 실적처리되지 않은 바코드
				rtn.put("Result", -1);
				rtn.put("Message", "실적 처리되지 않은 바코드 입니다.");
			} else if (updatedCnt == -2) {  // 중복 바코드
				rtn.put("Result", -2);
				rtn.put("Message", "출고 처리되지 않은 바코드 입니다.");
			} else if (updatedCnt == -3) {  // 이외에 예외사항
				rtn.put("Result", -3);
				rtn.put("Message", "관리자에게 문의하세요.");
			} else { // 저장 실패
				rtn.put("Result", -100);
				rtn.put("Message", "저장에 실패하였습니다.");
			}

		} catch (Exception ex) {
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

	@RequestMapping("/eds/pda/salma/closeYnSALMA4500")
	@ResponseBody
	public Map closeYnSALMA4500(@RequestParam Map<String, Object> map, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			int updatedCnt = salma4500Service.closeYnSALMA4500(map);

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

	@RequestMapping("/eds/pda/salma/saleCloseSALMA4500")
	@ResponseBody
	public Map saleCloseSALMA4500(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();

		try {

			// 거래처별 List 정보
			List<String> list = new ArrayList<String>();
			List<String> list2 = new ArrayList<String>();
			List<String> list3 = new ArrayList<String>();

			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				if ("U".equals(row.get("sStatus"))) {
					if("0".equals(row.get("closeYn"))){
						switch ((String) row.get("saleCloseDivi"))
						{
							case "01":
								list.add(row.get("custCd").toString());
								break;
							case "02":
								updatedCnt += salma4500Service.saleCloseSALMA4500(row);
								break;
							default:
								break;
						}
					}
				}
			}

			// 중복 거래처 제거
			if(list != null){
				for(int i=0; i<list.size(); i++) {
					if(!list2.contains(list.get(i))) {
						list2.add(list.get(i));
					}
				}
			}

			String corpCd = "";
			if(list2 != null) {
				for (int j = 0; j < list2.size(); j++) {
					for (int i = 0; i < saveData.size(); i++) {
						Map row = (Map) saveData.get(i);
						if ("U".equals(row.get("sStatus"))) {
							if("0".equals(row.get("closeYn"))){
								switch ((String) row.get("saleCloseDivi"))
								{
									case "01":
										if (row.get("custCd").toString().contains(list2.get(j))) {
											list3.add(row.get("exNo").toString());
											corpCd = row.get("corpCd").toString();
										}
										break;
									default:
										break;
								}
							}
						}
					}
					Map<String, Object> hashMap = new HashMap<String, Object>();
					hashMap.put("corpCd", corpCd);
					hashMap.put("exNo", list3.get(0));
					hashMap.put("exNoList", StringUtils.join(list3, ','));
					updatedCnt += salma4500Service.saleCloseSALMA4501(hashMap);
					list3.clear();
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

	@RequestMapping("/eds/pda/salma/applySALMA4506")
	@ResponseBody
	public Map applySALMA4506(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		try {

			mp = salma4500Service.applySALMA4506(param);

		} catch (Exception ex) {
			mp.put("Result", -100); // 음수값은 모두 실패
			mp.put("Message", "오류입니다.");
		}

		return mp;
	}

	@RequestMapping("/eds/pda/salma/resetSALMA4506")
	@ResponseBody
	public Map resetSALMA4506(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		try {

			mp = salma4500Service.resetSALMA4506(param);

		} catch (Exception ex) {
			mp.put("Result", -100); // 음수값은 모두 실패
			mp.put("Message", "오류입니다.");
		}

		return mp;
	}
}