package com.springboot.myapp.eds.erp.controller.login;

import com.springboot.myapp.eds.erp.controller.com.COMMONService;
import com.springboot.myapp.eds.erp.vo.base.baseUserListVO;
import com.springboot.myapp.eds.notice.NotificationController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.checkerframework.checker.units.qual.s;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LOGINController {

	@Autowired
	private LOGINService loginService;

	@Autowired
	private COMMONService commonService;

	public static Map<String, Object> loginUsers = new HashMap<String, Object>();
	private NotificationController notificationController=new NotificationController();

	/* ERP 로그인 */
	@RequestMapping("/LOGIN_VIEW")
	public String selectLOGINView(Model model) throws Exception{

		return "/eds/main/login/LOGIN";
	}
	
	
	/* 로그인 체크 */
	@RequestMapping("/LOGIN/selectLOGINCheck")
	@ResponseBody
	public Map<String, Object> selectLOGINCheck(@RequestParam Map<String, Object> map,
												HttpServletRequest request, HttpSession session) throws Exception{


		Map<String, Object> hashMap = new HashMap<String, Object>();
		int cnt = loginService.selectLOGINCnt(map);

		if(cnt > 0){ // 로그인 성공
			List<baseUserListVO> list = loginService.selectLOGINInfo(map);
			baseUserListVO baseUserListVO = list.get(0);
			if(baseUserListVO.getAccDivi().equals("02")) { // 접속제한 : 미사용

				Map<String, Object> loginLog = new HashMap<String, Object>();
				loginLog.put("empCd", baseUserListVO.getEmpCd());
				loginLog.put("accIp", request.getRemoteAddr());
				loginLog.put("accState", "login");
				loginService.insertLOGINLOG(loginLog);
				loginUsers.put(session.getId(), baseUserListVO.getEmpCd());

				session.setMaxInactiveInterval(60*60);
				session.setAttribute("LoginInfo", list.get(0));
				System.out.println("------------------------------------------------------------------------");
				// pwd 변경주기 체크
				if(commonService.selectDATEDIFF(map) > 90 || commonService.selectDATEDIFF(map) == -1){
					hashMap.put("code", "reset");
				}else{
					hashMap.put("code", "success");
				}
			} else if (baseUserListVO.getAccDivi().equals("01")){ // 접속제한 : 사용
				hashMap.put("code", "fail_acc");
			}
		}else{// 로그인 실패
			hashMap.put("code", "fail");
		}
		return hashMap;
	}

	/* 로그아웃 */
	@RequestMapping("/LOGIN/LOGOUT")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception{
		baseUserListVO baseUserListVO = (baseUserListVO) session.getAttribute("LoginInfo");

		Map<String, Object> loginLog = new HashMap<String, Object>();
		loginLog.put("empCd", baseUserListVO.getEmpCd());
		loginLog.put("accIp", request.getRemoteAddr());
		loginLog.put("accState", "logout");
		loginService.insertLOGINLOG(loginLog);

		session.removeAttribute("LoginInfo");
		loginUsers.remove(baseUserListVO.getEmpCd());	
		notificationController.closeEmitters(session.getId());
		session.invalidate();
		return "/eds/main/login/LOGIN";
	}

	/* 비밀번호 변경 페이지 */
	@RequestMapping("/LOGIN/RESET")
	public String selectRESETView(Model model) throws Exception{
		return "/eds/main/login/RESET";
	}

	/* 비밀번호 변경 */
	@RequestMapping("/LOGIN/updatePASSWORD")
	@ResponseBody
	public Map<String, Object> updatePASSWORD(@RequestParam Map<String, Object> map) throws Exception{

		Map<String, Object> hashMap = new HashMap<String, Object>();
		try {
			int cnt = loginService.updatePASSWORD(map);
			hashMap.put("code", "success");
		}catch (Exception e){
			hashMap.put("code", "fail");
			System.out.println(e);
		}

		return hashMap;
	}

	/* 비밀번호 다음에 변경 */
	@RequestMapping("/LOGIN/updatePASSWORDNext")
	@ResponseBody
	public Map<String, Object> updatePASSWORDNext(@RequestParam Map<String, Object> map) throws Exception{

		Map<String, Object> hashMap = new HashMap<String, Object>();
		try {
			int cnt = loginService.updatePASSWORDNext(map);
			hashMap.put("code", "success");
		}catch (Exception e){
			hashMap.put("code", "fail");
			System.out.println(e);
		}

		return hashMap;
	}

	/*
	* server session check
	* */
	@RequestMapping("/LOGIN/selectSESSCheck")
	@ResponseBody
	public boolean selectSESSCheck(HttpSession session) throws Exception{
		boolean sess = true;

		if(session.getAttribute("LoginInfo") == null){
			sess = false;
		}

		return sess;
	}

	/*
	* commute check
	* */
	@PostMapping("/LOGIN/selectCommute")
	@ResponseBody
	public Map<String, Object> selectCommute(@RequestParam Map<String, Object> map) throws Exception{
		Map<String, Object> hashMap = new HashMap<String, Object>();
		try {
			hashMap.put("data", loginService.selectCommute(map));
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return hashMap;
	}

	/*
	 * password check
	 * */
	@RequestMapping("/LOGIN/checkPASSWORD")
	@ResponseBody
	public Map checkPASSWORD(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = loginService.checkPASSWORD(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
}
