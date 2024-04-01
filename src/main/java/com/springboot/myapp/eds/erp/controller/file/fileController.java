package com.springboot.myapp.eds.erp.controller.file;

import com.springboot.myapp.util.SessionUtil;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class fileController {

	@Autowired
	private fileService fileService;

	@RequestMapping("/SYSTEM_FILE_DOWNLOAD_SCH_VIEW")
	public String SYSTEM_FILE_DOWNLOAD_SCH_VIEW(Model model) throws Exception {

		return "/eds/erp/system/SYSTEM_FILE_DOWNLOAD_SCH";
	}

	@RequestMapping("/SYSTEM_MGT/selectFileDownloadHistory")
	@ResponseBody
	public Map selectFileDownloadHistory(@RequestBody HashMap<String, Object> map) throws Exception {
		Map mp = new HashMap();
		try {
			List li = fileService.selectFileDownloadHistory(map);
			mp.put("data", li);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@GetMapping(value = "/fileDownLoad/{params}")
	public void fileDownLoad(HttpServletRequest req, HttpServletResponse res,@PathVariable("params") String params) throws Exception {

		params = URLDecoder.decode(params,"utf-8");
		String[] paramArr = params.split(":");
		String downloadName = paramArr[0]+"."+paramArr[1];
		String downloadPath = ((String) paramArr[2]).replace("'","\\");
		File f = new File(downloadPath);

		String browser = req.getHeader("User-Agent");
		//파일 인코딩
		if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
			//브라우저 확인 파일명 encode
			downloadName = URLEncoder.encode(downloadName, "UTF-8").replaceAll("\\+", "%20");
		}else{
			downloadName = new String(downloadName.getBytes("UTF-8"), "ISO-8859-1");
		}
		res.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName +"\"");
		res.setContentType("application/octer-stream");
		res.setHeader("Content-Transfer-Encoding", "binary;");

		try(FileInputStream fis = new FileInputStream(f);
			ServletOutputStream sos = res.getOutputStream();	){

			byte[] b = new byte[1024];
			int data = 0;

			while((data=(fis.read(b, 0, b.length))) != -1){
				sos.write(b, 0, data);
			}

			sos.flush();
		} catch(Exception e) {
			throw e;
		}

		/* 파일 다운로드 완료시 이력 저장*/
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("corpCd",SessionUtil.getUser().getCorpCd());
		param.put("busiCd",SessionUtil.getUser().getBusiCd());
		param.put("userId", SessionUtil.getUser().getEmpCd());
		param.put("saveRoot",downloadPath);
		param.put("menuPath",paramArr[3]);

		/* 파일 디코딩 */
		if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
			//브라우저 확인 파일명 encode
			downloadName = URLDecoder.decode(downloadName, "UTF-8");
		}else{
			downloadName = new String(downloadName.getBytes("ISO-8859-1"), "UTF-8");
		}

		param.put("origNm", downloadName);
		fileService.insertFileDownloadHistory(param);

	}
}
