package com.springboot.myapp.eds.ims.controller.site;

import com.springboot.myapp.eds.erp.controller.file.fileService;
import com.springboot.myapp.eds.ims.controller.inspection.InspectionService;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.codec.DecoderException;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.sound.midi.Soundbank;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

@Controller
public class SiteController {

  @Value("${eds.backs.file.path}")
  private String realPath;

  @Autowired
  private SiteService siteService;

  @Autowired
  private fileService fileService;

  // 추가
  @Autowired
  private InspectionService inspectionService;

  @RequestMapping("/SITE_VIEW")
  public String siteView() {

    return "/eds/ims/site/siteView";
  }

  @RequestMapping("/SITE_POP_VIEW")
  public String sitePopView() {

    return "/eds/ims/site/sitePopView";
  }

  @RequestMapping("/siteView/selectSite")
  @ResponseBody
  public Map selectSite(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = siteService.selectSite(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/siteView/selectSitePop")
  @ResponseBody
  public Map selectSitePop(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = siteService.selectSitePop(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/siteView/selectSiteByIndex")
  @ResponseBody
  public Map selectSiteByIndex(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = siteService.selectSiteByIndex(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

//  @RequestMapping("/siteView/cudSite")
//  @ResponseBody
//  public Map cudSite(@RequestBody Map param) {
//    System.out.println("진행됐음");
//    Map mp = new HashMap();
//    Map rtn = new HashMap();
//    int updatedCnt = 0;
//    try {
//      // ibsheet에서 넘어온 내용
//      List saveData = (List) param.get("data");
//
//      for (int i = 0; i < saveData.size(); i++) {
//        Map row = (Map) saveData.get(i);
//
//        switch (row.get("status").toString()) {
//          case "C":
//            updatedCnt += siteService.insertSite(row);
//            break;
//          case "U": updatedCnt += siteService.updateSite(row);
//            break;
//          case "D":
//            System.out.println("-------------cud Site d d d d----------------");
//            System.out.println(row);
//            System.out.println("--------------row-----------------");
//            updatedCnt += siteService.deleteSiteFileList(row);
//            updatedCnt += siteService.deleteSite(row);
//            break;
//          case "DA":
//            System.out.println("-------------cud Site DA DA----------------");
//            System.out.println(row);
//            System.out.println("--------------row-----------------");
//            updatedCnt += siteService.deleteSiteFileList(row);
//            updatedCnt += siteService.deleteSite(row);
//            break;
//        }
//      }
//      if (updatedCnt > 0) { // 정상 저장
//        rtn.put("Result", 0);
//        rtn.put("Message", "저장 되었습니다.");
//      } else { // 저장 실패
//        rtn.put("Result", -100); // 음수값은 모두 실패
//        rtn.put("Message", "저장에 실패하였습니다.");
//      }
//    } catch (Exception ex) {
//      rtn.put("Result", -100); // 음수값은 모두 실패
//      rtn.put("Message", "오류입니다.");
//    }
//    mp.put("IO", rtn);
//    System.out.println("mp 머임" + mp);
//    System.out.println("param 머임" + param);
//    System.out.println("index 머임");
//    System.out.println("param.get(data)");
//    System.out.println(param.get("data"));
//    System.out.println("길이");
//    System.out.println(param.size());
//    System.out.println("updatedCnt");
//    System.out.println(updatedCnt);
//    return mp;
//  }

//  @RequestMapping("/siteView/cudSite")
//  @ResponseBody
//  public Map cudSite(@RequestBody Map param) {
//    System.out.println("진행됐음");
//    Map mp = new HashMap();
//    Map rtn = new HashMap();
//    int updatedCnt = 0;
//    try {
//      // ibsheet에서 넘어온 내용
//      List saveData = (List) param.get("data");
//
//      for (int i = 0; i < saveData.size(); i++) {
//        Map row = (Map) saveData.get(i);
//
//        switch (row.get("status").toString()) {
//          case "C":
//            updatedCnt += siteService.insertSite(row);
//            break;
//          case "U": updatedCnt += siteService.updateSite(row);
//            break;
//          case "D":
//            System.out.println("-------------cud Site d d d d----------------");
//            System.out.println(row);
//            System.out.println("--------------row-----------------");
//            updatedCnt += siteService.deleteSiteFileList(row);
//            updatedCnt += siteService.deleteSite(row);
//            break;
//          case "DA":
//            System.out.println("-------------cud Site DA DA----------------");
//            System.out.println(row);
//            System.out.println("--------------row-----------------");
//            updatedCnt += siteService.deleteSiteFileList(row);
//            updatedCnt += siteService.deleteSite(row);
//            break;
//        }
//      }
//      if (updatedCnt > 0) { // 정상 저장
//        rtn.put("Result", 0);
//        rtn.put("Message", "저장 되었습니다.");
//      } else { // 저장 실패
//        rtn.put("Result", -100); // 음수값은 모두 실패
//        rtn.put("Message", "저장에 실패하였습니다.");
//      }
//    } catch (Exception ex) {
//      rtn.put("Result", -100); // 음수값은 모두 실패
//      rtn.put("Message", "오류입니다.");
//    }
//    mp.put("IO", rtn);
//    System.out.println("mp 머임" + mp);
//    System.out.println("param 머임" + param);
//    System.out.println("index 머임");
//    System.out.println("param.get(data)");
//    System.out.println(param.get("data"));
//    System.out.println("길이");
//    System.out.println(param.size());
//    System.out.println("updatedCnt");
//    System.out.println(updatedCnt);
//    return mp;
//  }

  @RequestMapping("/siteView/selectSiteImageList")
  @ResponseBody
  public Map selectSiteImageList(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = siteService.selectSiteImageList(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/siteView/siteImageload/{params}")
  @ResponseBody
  public ResponseEntity<byte[]> loadSiteImage(@PathVariable("params") String params) throws IOException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, DecoderException {
    String[] param = params.split(","); // params
    String saveNm = "";
    saveNm = param[1] + "." + param[2];
    String corpCd = param[0]; // 회사코드별 파일업로드 관리
    String path = new File(realPath + "/file/").getCanonicalPath()
            + File.separatorChar + corpCd
            + File.separatorChar + "ims"
            + File.separatorChar + "0001"
            + File.separatorChar + "images"
            + File.separatorChar + saveNm;
    InputStream imageStream = new FileInputStream(path);
    byte[] imageByteArray = IOUtils.toByteArray(imageStream);
    imageStream.close();
    return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
  }

  @PostMapping("/siteView/siteImageDownload")
  public ResponseEntity<byte[]> siteImageDownload(@RequestBody Map<String, Object> params) throws Exception {

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
      param.put("menuPath", "ims");
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

  @RequestMapping("/siteView/cudSite")
  @ResponseBody
  public Map cudSite(@RequestParam(value = "file", required = false) List<MultipartFile> files, @RequestParam HashMap<String, Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    JSONParser p = new JSONParser();
    JSONArray obj = (JSONArray) p.parse((String) param.get("data"));

    try {
      // ibsheet에서 넘어온 내용
      List saveData = (List) obj;

      int updatedCnt = 0;
      for (int i = 0; i < saveData.size(); i++) {
        Map row = (Map) saveData.get(i);
        switch (row.get("status").toString()) {
          case "C":
            updatedCnt += siteService.insertSite(row);
            updatedCnt += siteService.insertSiteImage(files, row);
            if (!row.get("checkCycle").equals("X")) {
              updatedCnt += inspectionService.insertInspectionList(row);
            }
            break;
          case "U":
            updatedCnt += siteService.updateSite(row);
            updatedCnt += siteService.insertSiteImage(files, row);
            if (row.get("checkCycle").equals("X")) {
              updatedCnt += inspectionService.resetInspectionList(row);
            } else if (!row.get("checkCycle").equals("X") && row.get("updateFlag") == null) {
              updatedCnt += inspectionService.resetInspectionList(row);
              updatedCnt += inspectionService.insertInspectionList(row);
            }
            break;
          case "D":
            updatedCnt += siteService.deleteSite(row);
//            updatedCnt += siteService.deleteSiteImage(row);
            break;
          case "DA":
            updatedCnt += siteService.deleteSiteFileList(row);
            updatedCnt += siteService.deleteSite(row);
            break;
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
      ex.printStackTrace();
      rtn.put("Result", -100); // 음수값은 모두 실패
      rtn.put("Message", "오류입니다.");
    }
    mp.put("IO", rtn);

    return mp;
  }

  @RequestMapping("/siteView/insertCarryOverDivi")
  @ResponseBody
  public Map insertCarryOverDivi(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();

    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += siteService.insertCarryOverDivi(saveData);
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

  @RequestMapping("/siteView/updateCarryOverDivi")
  @ResponseBody
  public Map updateCarryOverDivi(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();

    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += siteService.updateCarryOverDivi(saveData);
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

  @RequestMapping("/siteView/siteImageDelete")
  @ResponseBody
  public Map siteImageDelete(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += siteService.deleteSiteImageList(saveData);
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

  @RequestMapping("/siteView/siteImageDeleteAll")
  @ResponseBody
  public Map siteImageDeleteAll(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();

    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += siteService.deleteAllSiteImage(saveData);
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

  @RequestMapping("/siteView/selectSiteFileList")
  @ResponseBody
  public Map selectSiteFileList(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = siteService.selectSiteFileList(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/siteView/insertSiteFileList")
  @ResponseBody
  public Map<String, Object> insertSiteFileList(MultipartHttpServletRequest mtfRequest, @RequestParam Map<String, Object> param) throws IllegalStateException {

    Map<String, Object> returnData = new HashMap<String, Object>();

    try {

      returnData = siteService.insertSiteFileList(mtfRequest, param);

    } catch (Exception e) {
      e.printStackTrace();
    }
    return returnData;
  }

  @RequestMapping("/siteView/udSiteFileList")
  @ResponseBody
  public Map udSiteFileList(@RequestBody Map param) {

    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      // ibsheet에서 넘어온 내용
      List saveData = (List) param.get("data");
      int updatedCnt = 0;

      for (int i = 0; i < saveData.size(); i++) {
        Map row = (Map) saveData.get(i);

        row.put("costDt", Util.removeMinusChar((String) row.get("costDt")));
        switch (row.get("status").toString()) {
          case "U":
            updatedCnt += siteService.updateSiteFileList(row);
            break;
          case "D":
            updatedCnt += siteService.deleteSiteFileList(row);
            break;
          case "DA":
            updatedCnt += siteService.deleteSiteFileList(row);
            break;
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

  @RequestMapping("/siteView/selectSiteMemoList")
  @ResponseBody
  public Map selectSiteMemoList(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = siteService.selectSiteMemoList(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/siteView/cudSiteMemoList")
  @ResponseBody
  public Map cudSiteMemoList(@RequestBody Map param, Model model) throws Exception {

    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      // ibsheet에서 넘어온 내용
      List saveData = (List) param.get("data");
      int updatedCnt = 0;

      for (int i = 0; i < saveData.size(); i++) {
        Map row = (Map) saveData.get(i);

        switch (row.get("status").toString()) {
          case "C":
            updatedCnt += siteService.insertSiteMemoList(row);
            break;
          case "U":
            updatedCnt += siteService.updateSiteMemoList(row);
            break;
          case "D":
            updatedCnt += siteService.deleteSiteMemoList(row);
            break;
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

  @RequestMapping("/PROJECT_MGT/selectProjMgtListInIms")
  @ResponseBody
  public Map selectProjMgtListInIms(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = siteService.selectProjMgtListInIms(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

}
