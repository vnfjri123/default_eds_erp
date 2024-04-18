package com.springboot.myapp.eds.erp.controller.erpNotice;

import com.springboot.myapp.eds.ims.controller.error.ErrorService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@Controller
public class erpNoticeController {

  @Value("${eds.backs.file.path}")
  private String realPath;

  @Autowired
  private erpNoticeService erpNoticeService;

  @Autowired
  private ErrorService errorService;

  @RequestMapping("/ERP_NOTICE_VIEW")
  public String erpNoticeView() {
    return "/eds/erp/erpNotice/erpNoticeView";
  }

  @RequestMapping("/erpNoticeView/selectERPNotice")
  @ResponseBody
  public Map selectERPNotice(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = erpNoticeService.selectERPNotice(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/erpNoticeView/selectERPNoticeImageList")
  @ResponseBody
  public Map selectERPNoticeImageList(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = erpNoticeService.selectERPNoticeImageList(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/erpNoticeView/selectERPNoticeFiles")
  @ResponseBody
  public Map selectERPNoticeFiles(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = erpNoticeService.selectERPNoticeFiles(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/erpNoticeView/erpNoticeFilesLoad/{params}")
  @ResponseBody
  public ResponseEntity<byte[]> loadSiteImage(@PathVariable("params") String params) throws IOException {
    String[] param = params.split(","); // params
    String saveNm = "";
    saveNm = param[1] + "." + param[2];
    String corpCd = param[0]; // 회사코드별 파일업로드 관리

    String fileType = param[2];
    String fileName = "";
    if (fileType.equals("pdf")) {
      fileName = "pdfimg.jpg";
    } else if (fileType.equals("xlsx")) {
      fileName = "exclimg.jpg";
    } else if (fileType.equals("doc")){
      fileName = "wordimg.jpg";
    } else if (fileType.equals("hwp")) {
      fileName = "hwpimg.jpg";
    }

    if (!fileName.isEmpty()) {
      String pdfPath = new File(realPath + "/static/").getCanonicalPath()
              + File.separatorChar + "img"
              + File.separatorChar + "fileImage"
              + File.separatorChar + fileName;
      InputStream pdfImageStream = new FileInputStream(pdfPath);
      byte[] pdfImageByteArray = IOUtils.toByteArray(pdfImageStream);
      pdfImageStream.close();
      return new ResponseEntity<byte[]>(pdfImageByteArray, HttpStatus.OK);
    } else{
      String path = new File(realPath + "/file/").getCanonicalPath()
              + File.separatorChar + corpCd
              + File.separatorChar + "erp"
              + File.separatorChar + "0001"
              + File.separatorChar + "erpNoticeFiles"
              + File.separatorChar + saveNm;
      InputStream imageStream = new FileInputStream(path);
      byte[] imageByteArray = IOUtils.toByteArray(imageStream);
      imageStream.close();

      return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
    }
  }

  @RequestMapping("/erpNoticeView/selectERPNoticeByIndex")
  @ResponseBody
  public Map selectERPNoticeByIndex(@RequestBody HashMap<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {
    // 현재 날짜와 시간을 구합니다.
    Calendar calendar = Calendar.getInstance();
    // 현재 날짜에 1을 더해 다음날로 설정합니다.
    calendar.add(Calendar.DAY_OF_MONTH, 1);
    // 시, 분, 초를 0으로 설정하여 다음날 00시 00분 00초로 만듭니다.
    calendar.set(Calendar.HOUR_OF_DAY, 0);
    calendar.set(Calendar.MINUTE, 0);
    calendar.set(Calendar.SECOND, 0);

    // 쿠키의 만료시간을 설정하기 위해 Date 객체를 생성합니다.
    Date nextDay = calendar.getTime();

    Map mp = new HashMap();
    try {
      List li = erpNoticeService.selectERPNoticeByIndex(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }

    Cookie viewCookie = null;
    Cookie[] cookies = request.getCookies(); // 클라이언트가 보낸 데이터에서 쿠키값을 가져온다.

    Object index = map.get("index");
    mp.put("index", index);

    if (cookies != null) {  // 쿠키의 값이 있을 경우
      for (int i = 0; i < cookies.length; i++) {
        if (cookies[i].getName().equals("|" + index + "|")) {
          // 찾은 쿠키를 변수에 저장
          viewCookie = cookies[i];
          break;  // 쿠키를 찾았으면 더 이상 반복할 필요가 없으므로 반복문 종료
        }
      }
    } else {  // 쿠키가 없으면 실행
      erpNoticeService.readERPNotice(map);
    }

    // 만들어진 쿠키가 없음을 확인
    if (viewCookie == null) {  // 쿠키가 없을 때 실행
      try {
        // 이 페이지에 왔음을 증명하는 쿠키 생성
        Cookie newCookie = new Cookie("|" + index + "|", "OK");
        newCookie.setMaxAge((int) (nextDay.getTime() - System.currentTimeMillis()) / 1000);
        response.addCookie(newCookie);  // 쿠키 값을 다시 클라이언트에 보냄

        // 쿠키가 없으니 증가 로직 진행
        erpNoticeService.readERPNotice(map);

      } catch (Exception e) {
        e.printStackTrace();  // 예외 스택 트레이스 출력
      }
    } else {
      String value = viewCookie.getValue();
      System.out.println("viewCookie 확인 : 쿠키 value : " + value);
    }

    return mp;
  }

  @RequestMapping("/erpNoticeView/cudERPNotice")
  @ResponseBody
  public Map cudERPNotice(@RequestParam(value = "file", required = false) List<MultipartFile> files, @RequestParam(value = "attachedFile", required = false) List<MultipartFile> attachedFile, MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String, Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    Map<String, Object> returnData = new HashMap<String, Object>();

    JSONParser p = new JSONParser();
    JSONArray obj = (JSONArray) p.parse((String) param.get("data"));

    try {
      // ibsheet에서 넘어온 내용
      List saveData = (List) obj;

      int updatedCnt = 0;
      int deletedCnt = 0;

      for (int i = 0; i < saveData.size(); i++) {
        Map row = (Map) saveData.get(i);

        switch (row.get("status").toString()) {
          case "C":
            updatedCnt += erpNoticeService.insertERPNotice(row);
            updatedCnt += erpNoticeService.insertERPNoticeImage(files, row);
            updatedCnt += erpNoticeService.insertERPNoticeFile(attachedFile, row);
            break;
          case "U":
            updatedCnt += erpNoticeService.updateERPNotice(row);
            updatedCnt += erpNoticeService.insertERPNoticeImage(files, row);
            updatedCnt += erpNoticeService.insertERPNoticeFile(attachedFile, row);
            break;
          case "D":
            deletedCnt += erpNoticeService.deleteERPNotice(row);
            break;
        }
      }
      if (updatedCnt > 0) { // 정상 저장
        errorService.test(multiRequest);
        rtn.put("Result", 0);
        rtn.put("Message", "저장 되었습니다.");
      } else if (deletedCnt > 0) {
        errorService.deleteErrorImage(multiRequest);
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

  @RequestMapping("/erpNoticeView/erpNoticeImageDelete")
  @ResponseBody
  public Map erpNoticeImageDelete(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += erpNoticeService.deleteERPNoticeImageList(saveData);
      if (updatedCnt > 0) { //정상 저장
        rtn.put("Result", 0);
        rtn.put("Message", "저장 되었습니다.");
      } else { //저장 실패
        rtn.put("Result", -100); //음수값은 모두 실패
        rtn.put("Message", "저장에 실패하였습니다.");
      }
    } catch (Exception ex) {
      ex.printStackTrace();
      rtn.put("Result", -100); //음수값은 모두 실패
      rtn.put("Message", "오류입니다.");
    }
    mp.put("IO", rtn);

    return mp;
  }

  @RequestMapping("/erpNoticeView/deleteERPNoticeFile")
  @ResponseBody
  public Map deleteERPNoticeFile(@RequestBody ArrayList<Object> param) throws Exception
  {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>)param;
      int updatedCnt = 0;
      updatedCnt += erpNoticeService.deleteERPNoticeFile(saveData);
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

  @RequestMapping("/erpNoticeView/deleteERPNoticeFilesAll")
  @ResponseBody
  public Map deleteERPNoticeFilesAll(@RequestBody ArrayList<Object> param) throws Exception
  {
    Map mp = new HashMap();
    Map rtn = new HashMap();

    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>)param;
      int updatedCnt = 0;
      updatedCnt += erpNoticeService.deleteERPNoticeFilesAll(saveData);
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
}
