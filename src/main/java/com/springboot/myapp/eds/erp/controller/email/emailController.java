package com.springboot.myapp.eds.erp.controller.email;

import com.springboot.myapp.util.Util;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class emailController {

	@Autowired
	private emailService emailService;

	@Value("${eds.front.file.path}")
	private String filePath;

	@Value("${eds.backs.file.path}")
	private String realPath;

	@RequestMapping("/file/{corpCd}/email/image/{divi}/{empCd}/{file}")
	@ResponseBody
	public ResponseEntity<byte[]> readEmailImage(@PathVariable("corpCd") String corpCd,
							   @PathVariable("divi") String divi,
							   @PathVariable("empCd") String empCd,
							   @PathVariable("file") String file
							   ) throws Exception {
		File realFile = new File(filePath+"/file/"+corpCd+"/email/image/"+divi+"/"+empCd+"/"+file);
		if(!realFile.exists()){
			realFile = new File(realPath+"/file/"+corpCd+"/email/image/"+divi+"/"+empCd+"/"+file);
		}
		InputStream imageStream = new FileInputStream(realFile);
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
	}

	@RequestMapping("/EMAIL_MGT/selectSendEmailInfo")
	@ResponseBody
	public Map selectSendEmailInfo(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = emailService.selectSendEmailInfo(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EMAIL_MGT/selectSendEmailInfo2")
	@ResponseBody
	public Map selectSendEmailInfo2(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = emailService.selectSendEmailInfo2(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EMAIL_MGT/selectSendEmailFileInfo")
	@ResponseBody
	public Map selectSendEmailFileInfo(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = emailService.selectSendEmailFileInfo(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EMAIL_MGT/selectSendEmailJasperInfo")
	@ResponseBody
	public Map selectSendEmailJasperInfo(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = emailService.selectSendEmailJasperInfo(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EMAIL_MGT/selectSendEmailFileInfoAll")
	@ResponseBody
	public Map selectSendEmailFileInfoAll(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = emailService.selectSendEmailFileInfoAll(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@PostMapping(value = "/EMAIL_MGT/beforeUploadImageFile")
	@ResponseBody
	public String beforeUploadImageFile(MultipartHttpServletRequest multiRequest) throws IllegalStateException, IOException {

		String rst = "";
		try{

			rst = emailService.beforeUploadImageFile(multiRequest);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return rst;
	}

	@PostMapping(value = "/EMAIL_MGT/sendEmail")
	@ResponseBody
	public Map<String, Object> sendEmail(MultipartHttpServletRequest multiRequest) throws IllegalStateException, IOException {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try{

			returnData = emailService.sendEmail(multiRequest);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@PostMapping(value = "/EMAIL_MGT/onlySendEmail")
	@ResponseBody
	public Map<String, Object> onlySendEmail(MultipartHttpServletRequest multiRequest) throws IllegalStateException, IOException {

		Map<String, Object> returnData = new HashMap<String, Object>();

		try{

			returnData = emailService.onlySendEmail(multiRequest);

		}catch (Exception e ){
			e.printStackTrace();
		}

		return returnData;
	}

	@RequestMapping("/EMAIL_MGT/applySendEmail")
	@ResponseBody
	public Map applySendEmail(@RequestBody Map param, Model model) throws Exception {

		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			// ibsheet에서 넘어온 내용
			List saveData = (List) param.get("data");
			int updatedCnt = 0;

			System.out.println(saveData.size());

			for (int i = 0; i < saveData.size(); i++) {
				Map row = (Map) saveData.get(i);
				updatedCnt += emailService.applySendEmail(row);
			}
			if (updatedCnt > 0) { // 정상 저장
				rtn.put("Result", 0);
				rtn.put("Message", "발송 되었습니다.");
			} else { // 저장 실패
				rtn.put("Result", -100); // 음수값은 모두 실패
				rtn.put("Message", "발송에 실패하였습니다.");
			}
		} catch (Exception ex) {
			rtn.put("Result", -100); // 음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);

		return mp;
	}
}
