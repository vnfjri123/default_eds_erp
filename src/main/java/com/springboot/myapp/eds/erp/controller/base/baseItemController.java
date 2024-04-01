package com.springboot.myapp.eds.erp.controller.base;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.myapp.eds.erp.controller.alarm.alarmService;
import com.springboot.myapp.eds.notice.NotificationService;
import com.springboot.myapp.util.SessionUtil;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class baseItemController {

	@Autowired
	private baseItemService baseItemService;


	@RequestMapping("/BASE_ITEM_REG_VIEW")
	public String BASE_ITEM_REG_VIEW(Model model) throws Exception {

		return "/eds/erp/base/BASE_ITEM_REG";
	}

	@RequestMapping("/BASE_ITEM_REG_POP_VIEW")
	public String BASE_ITEM_REG_POP_VIEW(Model model) throws Exception {

		return "/eds/erp/base/BASE_ITEM_REG_POP";
	}

	@RequestMapping("/BASE_ITEM_REG/selectItemList")
	@ResponseBody
	public Map selectItemList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = baseItemService.selectItemList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}


	@RequestMapping("/BASE_ITEM_REG/selectItemPopList")
	@ResponseBody
	public Map selectItemPopList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = baseItemService.selectItemPopList(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/BASE_ITEM_REG/cudItemList")
	@ResponseBody
	public Map cudItemList(@RequestBody Map param, Model model) throws Exception {
		System.out.println(param);
		Map mp = new HashMap();
		Map rtn = new HashMap();

		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			System.out.println(saveData);
			int updatedCnt = 0;

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				Map rowAlarm = new HashMap();
				switch (row.get("status").toString()){
					case "C": updatedCnt += baseItemService.insertItemList(row); break;
					case "U": updatedCnt += baseItemService.updateItemList(row); break;
					case "D": updatedCnt += baseItemService.deleteItemList(row); break;
				}
			}
			if (updatedCnt > 0) { // 정상 저장
				rtn.put("Result", 0);
				rtn.put("Message", "저장 되었습니다.");
			} else { // 저장 실패
				rtn.put("Result", -100); // 음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}
		catch(DuplicateKeyException  e){
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "중복된 품목코드 값이 존재합니다.");
		} 
		catch (Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}

}
