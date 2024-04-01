package com.springboot.myapp.eds.erp.controller.base;

import com.springboot.myapp.util.Util;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.*;

@Controller
public class baseUserController {
    
    private final baseUserService baseUserService;

	public baseUserController(baseUserService baseUserService) {
		this.baseUserService = baseUserService;
	}

	@RequestMapping("/BASE_USER_MGT_LIST_VIEW")
	public String BASE_USER_LIST_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_USER_MGT_LIST";
    }

    @RequestMapping("/BASE_USER_MGT_LIST_POP_VIEW")
	public String BASE_USER_MGT_LIST_POP_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_USER_MGT_LIST_POP";
    }
	    @RequestMapping("/BASE_USER_MGT_LIST_POP_DUAL_VIEW")
	public String BASE_USER_MGT_LIST_POP_DUAL_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_USER_MGT_LIST_POP_DUAL";
    }

    @RequestMapping("/BASE_USER_EMAIL_LIST_POP_VIEW")
	public String BASE_USER_EMAIL_LIST_POP_VIEW(Model model) throws Exception{

		return "/eds/erp/base/BASE_USER_EMAIL_LIST_POP";
    }

    @RequestMapping("/BASE_USER_MGT_LIST/selectUserMgtList")
	@ResponseBody
	public Map selectUserMgtList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseUserService.selectUserMgtList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

    @RequestMapping("/BASE_USER_EMAIL_LIST/selectUserEmailList")
	@ResponseBody
	public Map selectUserEmailList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseUserService.selectUserEmailList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
    @RequestMapping("/BASE_USER_MGT_LIST/cudUserMgtList")
	@ResponseBody
	public Map cudUserMgtList(@RequestBody Map param, Model model) throws Exception{

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);

				row.put("resiNo", Util.removeMinusChar((String) row.get("resiNo")));
				row.put("biryrMd", Util.removeMinusChar((String) row.get("biryrMd")));
				row.put("ecoDt", Util.removeMinusChar((String) row.get("ecoDt")));
				row.put("rcoDt", Util.removeMinusChar((String) row.get("rcoDt")));

				switch (row.get("status").toString()){
					case "C":
						// 신규 등록 초기 비밀번호
						if(row.get("resiNo").equals("") || row.get("resiNo")==null || row.get("resiNo")==""){	// 주민등록 번호가 없는경우
							row.put("pwd", "123"); // 임의 비밀번호
						}else{	// 주민등록 번호가 있는경우 생년월일 기본 설정
							row.put("pwd", ((String) row.get("resiNo")).substring(0,6));
						}
						updatedCnt += baseUserService.insertUserMgtList(row); break;
					case "U": updatedCnt += baseUserService.updateUserMgtList(row); break;
					case "D": updatedCnt += baseUserService.deleteUserMgtList(row); break;
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

	@PostMapping("/BASE_USER_MGT_LIST/selectEmpCdCheck")
	@ResponseBody
	public String selectEmpCdCheck(@RequestParam Map<String, Object> map,
						   HttpServletRequest request, HttpSession session) throws Exception{

		return baseUserService.selectEmpCdCheck(map);
	}

	@PostMapping("/BASE_USER_MGT_LIST/selectEmpIdCheck")
	@ResponseBody
	public String selectEmpIdCheck(@RequestParam Map<String, Object> map,
								   HttpServletRequest request, HttpSession session) throws Exception{

		return baseUserService.selectEmpIdCheck(map);
	}

	@RequestMapping("/BASE_USER_MGT_LIST/userCheckByGroup")
	@ResponseBody
	public Map userCheckByGroup(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		try {
			List li = baseUserService.userCheckByGroup(map);
			System.out.println(li);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@PostMapping("/BASE_USER_MGT_LIST/duplicateUserCheck")
	@ResponseBody
	public String duplicateUserCheck(@RequestParam Map<String, Object> map,
									 HttpServletRequest request, HttpSession session) throws Exception{

		return baseUserService.duplicateUserCheck(map);
	}

	@PostMapping(value = "/BASE_USER_MGT_LIST/uploadUserFaceImage")
	@ResponseBody
	public String uploadUserFaceImage(MultipartHttpServletRequest multiRequest) throws IllegalStateException, IOException {

		try{

			baseUserService.uploadUserFaceImage(multiRequest);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return "redirect:/";
	}

	@RequestMapping(value = "/BASE_USER_MGT_LIST/selectUserFaceImage/{params}")
	public ResponseEntity<byte[]> selectUserFaceImage(@PathVariable("params") String params) throws IOException {

		try{

			return baseUserService.selectUserFaceImage(params);

		}catch (Exception e ){

			e.printStackTrace();

		}
        return null;
    }
	@RequestMapping(value = "/BASE_USER_MGT_LIST/selectUserFaceImageEdms/{params}")
	public ResponseEntity<byte[]> selectUserFaceImageEdms(@PathVariable("params") String params) throws IOException {

		try{

			return baseUserService.selectUserFaceImageEdms(params);

		}catch (Exception e ){

			e.printStackTrace();

		}
        return null;
    }
}