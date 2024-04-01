package com.springboot.myapp.eds.erp.controller.rule;

import com.springboot.myapp.eds.erp.controller.file.fileService;
import com.springboot.myapp.util.SessionUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.*;

@Controller
public class RuleController {

  @Value("${eds.backs.file.path}")
  private String realPath;

  @Autowired
  private RuleService ruleService;

  @Autowired
  private fileService fileService;

  @Autowired
  private ResourceLoader resourceLoader;

//  @GetMapping("/ruleView/ruleFileLoad/{pdfFileName}.{ext}")
//  public ResponseEntity<Resource> ruleFileLoad(@PathVariable String pdfFileName, @PathVariable String ext, @RequestParam(required = false) String origNm) throws IOException {
//    // 파일 경로 설정
//    String path = new File(realPath, "file")
//            + File.separator + "1001"
//            + File.separator + "erp"
//            + File.separator + "0001"
//            + File.separator + "ruleFiles"
//            + File.separator + pdfFileName + "." + ext;
//
//    // 파일이 존재하는지 확인
//    Resource resource = resourceLoader.getResource("file:" + path);
//
//    System.out.println("path");
//    System.out.println(path);
//
//    if (!resource.exists()) {
//      // 파일이 존재하지 않으면 404 응답
//      return ResponseEntity.notFound().build();
//    }
//
//    System.out.println("resource");
//    System.out.println(resource);
//
//    // Content-Type을 application/pdf로 설정
//    MediaType mediaType = MediaType.APPLICATION_PDF;
//
//    // 응답 헤더 설정
//    HttpHeaders headers = new HttpHeaders();
//    headers.setContentType(MediaType.parseMediaType("application/pdf"));
//    headers.setContentDisposition(ContentDisposition.builder("inline").filename(new String(origNm.getBytes("UTF-8"), "ISO-8859-1") + "." + ext).build());
//
//    System.out.println("응답--header");
//    System.out.println(ResponseEntity.ok().headers(headers));
//    System.out.println("응답--body");
//    System.out.println(ResponseEntity.ok().body(resource));
//
//    // ResponseEntity를 사용하여 파일을 클라이언트에 응답
//    return ResponseEntity.ok()
//            .headers(headers)
//            .contentLength(resource.contentLength())
//            .body(resource);
//  }

  @GetMapping("/ruleView/ruleFileLoad/{origNm}.{ext}")
  public ResponseEntity<Resource> ruleFileLoad(@PathVariable String origNm, @PathVariable String ext, @RequestParam(required = false) String saveNm) throws IOException {
    // 파일 경로 설정
    String path = new File(realPath, "file")
            + File.separator + "1001"
            + File.separator + "erp"
            + File.separator + "0001"
            + File.separator + "ruleFiles"
            + File.separator + saveNm + "." + ext;

    // 파일이 존재하는지 확인
    Resource resource = resourceLoader.getResource("file:" + path);

    if (!resource.exists()) {
      // 파일이 존재하지 않으면 404 응답
      return ResponseEntity.notFound().build();
    }

    // Content-Type을 application/pdf로 설정
    MediaType mediaType = MediaType.APPLICATION_PDF;

    // 응답 헤더 설정
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.parseMediaType("application/pdf"));
    headers.setContentDisposition(ContentDisposition.builder("inline").filename(new String(origNm.getBytes("UTF-8"), "ISO-8859-1") + "." + ext).build());

    // ResponseEntity를 사용하여 파일을 클라이언트에 응답
    return ResponseEntity.ok()
            .headers(headers)
            .contentLength(resource.contentLength())
            .body(resource);
  }

  @RequestMapping("/ruleView/loadRuleFiles/{params}")
  @ResponseBody
  public ResponseEntity<byte[]> loadRuleFiles(@PathVariable("params") String params) throws IOException {
    String[] param = params.split(","); // params
    String saveNm = "";
    saveNm = param[1] + "." + param[2];
    String corpCd = param[0]; // 회사코드별 파일업로드 관리
    String path = new File(realPath + "/file/").getCanonicalPath()
            + File.separatorChar + corpCd
            + File.separatorChar + "erp"
            + File.separatorChar + "0001"
            + File.separatorChar + "ruleFiles"
            + File.separatorChar + saveNm;
    InputStream imageStream = new FileInputStream(path);
    byte[] imageByteArray = IOUtils.toByteArray(imageStream);
    imageStream.close();
    return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
  }

  @PostMapping("/ruleView/ruleFileDownload")
  public ResponseEntity<byte[]> ruleFileDownload(@RequestBody Map<String, Object> params) throws Exception {

    Map<String, Object> row = (Map<String, Object>) params;

    String downloadName = row.get("name").toString();
    String filePath = row.get("saveRoot").toString(); // Provide the path to the file

    try {
      File file = new File(filePath);

      byte[] fileContent = Files.readAllBytes(file.toPath());

      HttpHeaders headers = new HttpHeaders();
      headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + downloadName);
      Map<String, Object> param = new HashMap<String, Object>();
      param.put("corpCd", SessionUtil.getUser().getCorpCd());
      param.put("userId", SessionUtil.getUser().getEmpCd());
      param.put("busiCd", SessionUtil.getUser().getBusiCd());
      param.put("saveRoot", row.get("saveRoot").toString());
      param.put("menuPath", "erp");
      param.put("origNm", downloadName);
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

  @RequestMapping("/RULE_VIEW")
  public String ruleView() {

    return "/eds/erp/rule/ruleView";
  }

  @RequestMapping("/ruleView/selectRule")
  @ResponseBody
  public Map selectRule(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = ruleService.selectRule(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/ruleView/selectRuleFile")
  @ResponseBody
  public Map selectRuleFile(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = ruleService.selectRuleFile(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/ruleView/selectUserInfo")
  @ResponseBody
  public Map selectUserInfo(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = ruleService.selectUserInfo(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/ruleView/cudRule")
  @ResponseBody
  public Map cudRule(@RequestParam(value = "attachedFile", required = false) List<MultipartFile> attachedFile, MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String, Object> param) throws Exception {
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
            updatedCnt += ruleService.insertRule(row);
            updatedCnt += ruleService.insertRuleFile(attachedFile, row);
            break;
          case "U":
            updatedCnt += ruleService.updateRule(row);
            if (attachedFile != null) {
              System.out.println("수정 서비스로 ㄱㄱ");
              updatedCnt += ruleService.updateRuleFile(attachedFile, row);
            }
            break;
          case "D":
            deletedCnt += ruleService.deleteRule(row);
            break;
        }
      }
      if (updatedCnt > 0) { // 정상 저장
//        errorService.test(multiRequest);
        rtn.put("Result", 0);
        rtn.put("Message", "저장 되었습니다.");
      } else if (deletedCnt > 0) {
//        errorService.deleteErrorImage(multiRequest);
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

  @RequestMapping("/ruleView/updateRead")
  @ResponseBody
  public Map updateRead(@RequestParam HashMap<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
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
        updatedCnt += ruleService.updateRead(row);
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

  @RequestMapping("/ruleView/readRule")
  @ResponseBody
  public Map<String, Object> readRule(@RequestBody Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) {
    Map<String, Object> result = new HashMap<>();
    Map rtn = new HashMap();
    int index = (int) map.get("index");
    result.put("index", index);

    try {
      increaseReadCount(map,request, response);
      rtn.put("Result", 0);
    } catch (Exception ex) {
      ex.printStackTrace();
      rtn.put("Result", -100);
    }
    result.put("IO", rtn);
    return result;
  }

  private void increaseReadCount(Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
    int index = (int) param.get("index");
    String cookieName = "|" + index + "|";
    Cookie[] cookies = request.getCookies();

    // 쿠키 확인
    boolean cookieExists = false;
    if (cookies != null) {
      for (Cookie cookie : cookies) {
        if (cookie.getName().equals(cookieName)) {
          cookieExists = true;
          break;
        }
      }
    }

    // 쿠키가 없을 때
    if (!cookieExists) {
      // 쿠키 생성
      Calendar calendar = Calendar.getInstance();
      calendar.add(Calendar.DAY_OF_MONTH, 1);
      calendar.set(Calendar.HOUR_OF_DAY, 0);
      calendar.set(Calendar.MINUTE, 0);
      calendar.set(Calendar.SECOND, 0);
      Date nextDay = calendar.getTime();
      Cookie newCookie = new Cookie(cookieName, "OK");
      newCookie.setMaxAge((int) (nextDay.getTime() - System.currentTimeMillis()) / 1000);
      response.addCookie(newCookie);

      // 증가 로직 진행
      ruleService.readRule(param);
    } else {
      // 쿠키가 이미 존재하면 로그 출력
      String value = request.getParameter(String.valueOf(index));
      System.out.println("viewCookie 확인 : 쿠키 value : " + value);
    }
  }

  @RequestMapping("/ruleView/deleteRuleFile")
  @ResponseBody
  public Map deleteRuleFile(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += ruleService.deleteRuleFile(saveData);
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

}
