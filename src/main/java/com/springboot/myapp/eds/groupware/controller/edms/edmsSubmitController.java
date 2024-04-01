package com.springboot.myapp.eds.groupware.controller.edms;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import com.springboot.myapp.eds.erp.controller.file.fileService;
import com.springboot.myapp.util.SessionUtil;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.commons.codec.DecoderException;

@Controller
public class edmsSubmitController {

	@Value("${eds.front.file.path}")
    private String filePath;
	
    @Value("${eds.backs.file.path}")
    private String realPath;


    @Autowired
    private fileService fileService;
    
	
    
    @Autowired
    private edmsSubmitService edmsSubmitService;
	
	@RequestMapping("/EDMS_SUBMIT_HOME_VIEW")
	public String EDMS_SUBMIT_HOME_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_HOME";
    }

    @RequestMapping("/EDMS_SUBMIT_LIST_VIEW")
	public String EDMS_SUBMIT_LIST_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_LIST";
    }
	@RequestMapping("/EDMS_SUBMIT_TEMP_LIST_VIEW")
	public String EDMS_SUBMIT_TEMP_LIST_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_TEMP_LIST";
    }
	
	@RequestMapping("/EDMS_SUBMIT_LIST_INS_VIEW")
	public String EDMS_SUBMIT_LIST_INS_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_LIST_INS";
    }

	@RequestMapping("/EDMS_SUBMIT_REQ_LIST_VIEW")
	public String EDMS_SUBMIT_REQ_LIST_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_REQ_LIST";
    }
	@RequestMapping("/EDMS_SUBMIT_COMPLETE_LIST_VIEW")
	public String EDMS_SUBMIT_COMPLETE_LIST_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_COMPLETE_LIST";
    }
	@RequestMapping("/EDMS_SUBMIT_CC_LIST_VIEW")
	public String EDMS_SUBMIT_CC_LIST_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_CC_LIST";
    }
	@RequestMapping("/EDMS_SUBMIT_APPROVE_LIST_VIEW")
	public String EDMS_SUBMIT_APPROVE_LIST_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_APPROVE_LIST";
    }
		@RequestMapping("/EDMS_SUBMIT_DEPA_LIST_VIEW")
	public String EDMS_SUBMIT_DEPA_LIST_VIEW(Model model) throws Exception{
		return "/eds/groupware/edms/EDMS_SUBMIT_DEPA_LIST";
    }

	@RequestMapping("/EDMS_SUBMIT_LIST/selectHomeList")
	@ResponseBody
	public Map selectHomeList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		
		try {
			List li = edmsSubmitService.selectHomeList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

    @RequestMapping("/EDMS_SUBMIT_LIST/selectSubmitList")
	@ResponseBody
	public Map selectSubmitList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		
		try {
			List li = edmsSubmitService.selectSubmitList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
	@RequestMapping("/EDMS_SUBMIT_LIST/selectSubmitTempList")
	@ResponseBody
	public Map selectSubmitTempList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		
		try {
			List li = edmsSubmitService.selectSubmitTempList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
	
	@RequestMapping("/EDMS_SUBMIT_LIST/selectSubmitReqList")
	@ResponseBody
	public Map selectSubmitReqList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		
		try {
			List li = edmsSubmitService.selectSubmitReqList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EDMS_SUBMIT_LIST/selectSubmitComList")
	@ResponseBody
	public Map selectSubmitComList(@RequestBody HashMap<String, Object> map) throws Exception{
				Map mp = new HashMap();
		
		try {
			List li = edmsSubmitService.selectSubmitComList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}


	@RequestMapping("/EDMS_SUBMIT_LIST/selectEdmsFileList")
	@ResponseBody
	public Map selectEdmsFileList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		
		try {
			List li = edmsSubmitService.selectEdmsFileList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}

	@RequestMapping("/EDMS_SUBMIT_LIST/selectEdmsMessageList")
	@ResponseBody
	public Map selectEdmsMessageList(@RequestBody HashMap<String, Object> map) throws Exception{
		Map mp = new HashMap();
		
		try {
			List li = edmsSubmitService.selectEdmsMessageList(map);
			mp.put("data", li);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return mp;
	}
    
    @RequestMapping("/EDMS_SUBMIT_LIST/deleteSubmitList")
	@ResponseBody
	public Map cudSubmitList(@RequestBody Map param, Model model) throws Exception{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				updatedCnt += edmsSubmitService.deleteSubmitList(row);
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);
		return mp;
	}
	@RequestMapping("/EDMS_SUBMIT_LIST/approveSubmitList")
	@ResponseBody
	public Map approveSubmitList(@RequestBody Map param, Model model) throws Exception{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				updatedCnt += edmsSubmitService.insertApproveList(row);
				
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message",ex.getMessage());
		}
		mp.put("IO", rtn);
		return mp;
	}

	@RequestMapping("/EDMS_SUBMIT_LIST/ccConfirmList")
	@ResponseBody
	public Map ccConfirmList(@RequestBody Map param, Model model) throws Exception{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				updatedCnt += edmsSubmitService.insertCcConfirmList(row);
				
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message",ex.getMessage());
		}
		mp.put("IO", rtn);
		return mp;
	}
	@RequestMapping("/EDMS_SUBMIT_LIST/approveConfirmList")
	@ResponseBody
	public Map approveConfirmList(@RequestBody Map param, Model model) throws Exception{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				updatedCnt += edmsSubmitService.insertApproveConfirmList(row);
				
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message",ex.getMessage());
		}
		mp.put("IO", rtn);
		return mp;
	}
	@RequestMapping("/EDMS_SUBMIT_LIST/declineList")
	@ResponseBody
	public Map declineList(@RequestBody Map param, Model model) throws Exception{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				updatedCnt += edmsSubmitService.insertDeclineList(row);
				
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message",ex.getMessage());
		}
		mp.put("IO", rtn);
		return mp;
	}
	@RequestMapping("/EDMS_SUBMIT_LIST/cancelList")
	@ResponseBody
	public Map cancelList(@RequestBody Map param, Model model) throws Exception{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;

			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				updatedCnt += edmsSubmitService.insertCancelList(row);
				
			}
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message",ex.getMessage());
		}
		mp.put("IO", rtn);
		return mp;
	}
	@RequestMapping("/EDMS_SUBMIT_LIST/cudMessageList")
	@ResponseBody
	public Map cudMessageList(@RequestBody Map param, Model model) throws Exception{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		try {
			//ibsheet에서 넘어온 내용
			List saveData = (List)param.get("data");
			int updatedCnt = 0;
			for(int i=0;i<saveData.size();i++) {
				Map row = (Map)saveData.get(i);
				switch (row.get("status").toString()){
					case "C": updatedCnt += edmsSubmitService.insertMessageList(row); break;
					case "D": updatedCnt += edmsSubmitService.deleteMessageList(row); break;
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
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message",ex.getMessage());
		}
		mp.put("IO", rtn);
		return mp;
	}
	@RequestMapping("/EDMS_SUBMIT_LIST/Edmsfileload/{params}")
	@ResponseBody
    public ResponseEntity<byte[]> insertEdmsFile(@PathVariable("params") String params) throws IOException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, DecoderException 
	{
        String[] param = params.split(","); // params
        String saveNm="";
       	saveNm = param[1] + "." + param[2];
        String corpCd = param[0]; // 회사코드별 파일업로드 관리

        String path = new File(realPath+"/file/").getCanonicalPath()
                +File.separatorChar +corpCd
                +File.separatorChar +"edms"
                +File.separatorChar +param[3]
                +File.separatorChar +saveNm
                ;
        InputStream imageStream = new FileInputStream(path);
        byte[] imageByteArray = IOUtils.toByteArray(imageStream);
        imageStream.close();
        return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
    }
	@RequestMapping("/EDMS_SUBMIT_LIST/EdmsfileDelete")
	@ResponseBody
    public Map deleteEdmsFile(@RequestBody ArrayList<Object> param, Model model) throws Exception
	{
		Map mp = new HashMap();
		Map rtn = new HashMap();
		System.out.println(param);
		try {
			//ibsheet에서 넘어온 내용
			ArrayList<Object> saveData = (ArrayList<Object>)param;
			int updatedCnt = 0;

			updatedCnt += edmsSubmitService.deleteEdmsFileList(saveData); 
			if(updatedCnt>0) { //정상 저장
				rtn.put("Result",0);
				rtn.put("Message","저장 되었습니다.");
			}else { //저장 실패
				rtn.put("Result", -100); //음수값은 모두 실패
				rtn.put("Message", "저장에 실패하였습니다.");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			rtn.put("Result", -100); //음수값은 모두 실패
			rtn.put("Message", "오류입니다.");
		}
		mp.put("IO", rtn);


		return mp;
    }
	@PostMapping("/EDMS_SUBMIT_LIST/EdmsfileDownload")
	public ResponseEntity<byte[]> downloadEdmsFile(@RequestBody Map<String, Object> params) throws Exception {

		System.out.println(params);

		Map<String, Object> row= (Map<String, Object>) params;


		String downloadName = row.get("name").toString();
		String filePath = row.get("saveRoot").toString(); // Provide the path to the file


		try {
			File file = new File(filePath);
			byte[] fileContent = Files.readAllBytes(file.toPath());
	
			HttpHeaders headers = new HttpHeaders();
			headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + downloadName);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("corpCd",SessionUtil.getUser().getCorpCd());
			param.put("busiCd",SessionUtil.getUser().getBusiCd());
			param.put("userId", SessionUtil.getUser().getEmpCd());
			param.put("saveRoot",row.get("saveRoot").toString());
			param.put("menuPath","edms");
			param.put("origNm", downloadName);
			System.out.println(param);
			fileService.insertFileDownloadHistory(param);
	
			return ResponseEntity.ok()
				.headers(headers)
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.body(fileContent);
		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}


		}
	
}
