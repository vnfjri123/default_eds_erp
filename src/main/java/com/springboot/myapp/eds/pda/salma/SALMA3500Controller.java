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
public class SALMA3500Controller {

	@Autowired
	private SALMA3500Service salma3500Service;

	@RequestMapping("/eds/pda/salma/selectSALMA3500View")
	public String selectSALMA3500View(Model model) throws Exception {

		return "/eds/pda/salma/SALMA3500View";
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3502View")
	public String selectSALMA3502View(Model model) throws Exception {

		return "/eds/pda/salma/SALMA3502View";
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3503View")
	public String selectSALMA3503View(Model model) throws Exception {

		return "/eds/pda/salma/SALMA3503View";
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3500")
	@ResponseBody
	public Map selectSALMA3500(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma3500Service.selectSALMA3500(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3501")
	@ResponseBody
	public Map selectSALMA3501(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma3500Service.selectSALMA3501(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3502")
	@ResponseBody
	public Map selectSALMA3502(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma3500Service.selectSALMA3502(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3503")
	@ResponseBody
	public Map selectSALMA3503(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma3500Service.selectSALMA3503(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3504")
	@ResponseBody
	public Map selectSALMA3504(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma3500Service.selectSALMA3504(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3505")
	@ResponseBody
	public Map selectSALMA3505(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma3500Service.selectSALMA3505(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/selectSALMA3506")
	@ResponseBody
	public Map selectSALMA3506(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = salma3500Service.selectSALMA3506(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/insertSALMA3500")
	@ResponseBody
	public Map insertSALMA3500(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				row.put("exDt", Util.removeMinusChar((String) row.get("exDt")));

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.updateSALMA3500(row);
				} else if("D".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.deleteSALMA3502(row);
					updatedCnt += salma3500Service.deleteSALMA3501(row);
					updatedCnt += salma3500Service.deleteSALMA3500(row);
				} else if("I".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.insertSALMA3500(row);
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

	@RequestMapping("/eds/pda/salma/insertSALMA3501")
	@ResponseBody
	public Map insertSALMA3501(@RequestBody Map param, Model model) throws Exception {

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
					updatedCnt += salma3500Service.updateSALMA3501(row);
				} else if("D".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.deleteSALMA3501(row);
				} else if("I".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.insertSALMA3501(row);
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

	@RequestMapping("/eds/pda/salma/insertSALMA3502")
	@ResponseBody
	public Map insertSALMA3502(@RequestBody Map param, Model model) throws Exception {

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
					updatedCnt += salma3500Service.updateSALMA3502(row);
				} else if("D".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.deleteSALMA3502(row);
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

	@RequestMapping("/eds/pda/salma/insertSALMA3503")
	@ResponseBody
	public Map insertSALMA3503(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			// Map app = new HashMap();
			// app = (Map) saveData.get(0);
			// salma3500Service.resetSALMA3503(app);

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				if (i == 0) {
					salma3500Service.resetSALMA3503(row);
				}

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.updateSALMA3503(row);
				}

				if (i == saveData.size() - 1) {
					salma3500Service.applySALMA3503(row);
				}
			}
			if (updatedCnt > 0) { // 정상 저장
				// salma3500Service.applySALMA3503(app);
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

	@RequestMapping("/eds/pda/salma/insertSALMA3505")
	@ResponseBody
	public Map insertSALMA3505(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			// Map app = new HashMap();
			// app = (Map) saveData.get(0);
			// salma3500Service.resetSALMA3505(app);

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);

				if (i == 0) {
					salma3500Service.resetSALMA3505(row);
				}

				if ("U".equals(row.get("sStatus"))) {
					updatedCnt += salma3500Service.updateSALMA3505(row);
				}

				if (i == saveData.size() - 1) {
					salma3500Service.applySALMA3505(row);
				}
			}
			if (updatedCnt > 0) { // 정상 저장
				// salma3500Service.applySALMA3505(app);
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

	@RequestMapping("/eds/pda/salma/insertSALMA3504")
	@ResponseBody
	public Map insertSALMA3504(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			int updatedCnt = 0;

			updatedCnt += salma3500Service.insertSALMA3504(param);

			if (updatedCnt > 0) { // 정상 저장
				// salma3500Service.applySALMA3505(app);
				rtn.put("Result", 0);
				rtn.put("Message", "저장 되었습니다.");
			} else if (updatedCnt == -1) { // 실적처리되지 않은 바코드
				rtn.put("Result", -1);
				rtn.put("Message", "실적 처리되지 않은 바코드 입니다.");
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

	@RequestMapping("/eds/pda/salma/deleteSALMA3503")
	@ResponseBody
	public Map deleteSALMA3501(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			int updatedCnt = 0;

			updatedCnt += salma3500Service.deleteSALMA3503(param);

			if (updatedCnt > 0) { // 정상 저장
				// salma3500Service.applySALMA3505(app);
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

	@RequestMapping("/eds/pda/salma/applySALMADcAtmTax")
	@ResponseBody
	public Map applySALMADcAtmTax(@RequestBody Map param, Model model) throws Exception {


		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			updatedCnt += salma3500Service.applySALMADcAtmTax(param);

			if (updatedCnt > 0) { // 정상 저장
				// salma3500Service.applySALMA3505(app);
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

	@RequestMapping("/eds/pda/salma/closeYnSALMA3500")
	@ResponseBody
	public Map closeYnSALMA3500(@RequestParam Map<String, Object> map, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			int updatedCnt = salma3500Service.closeYnSALMA3500(map);

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

	@RequestMapping("/eds/pda/salma/saleCloseSALMA3500")
	@ResponseBody
	public Map saleCloseSALMA3500(@RequestBody Map param, Model model) throws Exception {

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
								updatedCnt += salma3500Service.saleCloseSALMA3500(row);
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
					updatedCnt += salma3500Service.saleCloseSALMA3501(hashMap);
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

	@RequestMapping("/eds/pda/salma/applyBarcode2Item")
	@ResponseBody
	public Map applyBarcode2Item(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			System.out.println(map);
			List li = salma3500Service.applyBarcode2Item(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/eds/pda/salma/applySALMA3506")
	@ResponseBody
	public Map applySALMA3506(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		try {

			mp = salma3500Service.applySALMA3506(param);

		} catch (Exception ex) {
			mp.put("Result", -100); // 음수값은 모두 실패
			mp.put("Message", "오류입니다.");
		}

		return mp;
	}

	@RequestMapping("/eds/pda/salma/resetSALMA3506")
	@ResponseBody
	public Map resetSALMA3506(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		try {

			mp = salma3500Service.resetSALMA3506(param);

		} catch (Exception ex) {
			mp.put("Result", -100); // 음수값은 모두 실패
			mp.put("Message", "오류입니다.");
		}

		return mp;
	}
}