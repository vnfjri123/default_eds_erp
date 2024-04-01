package com.springboot.myapp.eds.ims.controller.error;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

@Controller
public class ErrorController {

  @Autowired
  private ErrorService errorService;

  @Value("${eds.front.file.path}")
  private String filePath;

  @Value("${eds.backs.file.path}")
  private String realPath;

  @RequestMapping("/ERROR_VIEW")
  public String siteView() {

    return "/eds/ims/error/errorView";
  }

  //  @RequestMapping("/file/{corpCd}/error/image/{divi}/{empCd}/{file}")
  @RequestMapping("/file/{corpCd}/{moduleDivi}/0001/{divi}/{file}")
  @ResponseBody
  public ResponseEntity<byte[]> readEmailImage(@PathVariable("corpCd") String corpCd,
                                               @PathVariable("divi") String divi,
                                               @PathVariable("moduleDivi") String moduleDivi,
//                                               @PathVariable("empCd") String empCd,
                                               @PathVariable("file") String file
  ) throws Exception {
//    File realFile = new File(filePath+"/file/"+corpCd+"/error/image/"+divi+"/"+empCd+"/"+file);
    File realFile = new File(filePath + "/file/" + corpCd + "/" + moduleDivi + "/0001/" + divi + "/" + file);
    if (!realFile.exists()) {
      // realFile = new File(realPath+"/file/"+corpCd+"/error/image/"+divi+"/"+empCd+"/"+file);
      realFile = new File(realPath + "/file/" + corpCd + "/" + moduleDivi + "/0001/" + divi + "/" + file);
    }
    InputStream imageStream = new FileInputStream(realFile);
    byte[] imageByteArray = IOUtils.toByteArray(imageStream);
    imageStream.close();
    return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
  }

  @RequestMapping("/errorView/selectError")
  @ResponseBody
  public Map selectError(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = errorService.selectError(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/errorView/selectErrorByIndex")
  @ResponseBody
  public Map selectErrorByIndex(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = errorService.selectErrorByIndex(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/errorView/selectErrorImageList")
  @ResponseBody
  public Map selectErrorImageList(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = errorService.selectErrorImageList(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

//  @PostMapping(value = "/errorView/test")
//  @ResponseBody
//  public Map<String, Object> test(MultipartHttpServletRequest multiRequest) throws IllegalStateException, IOException {
//
//    Map<String, Object> returnData = new HashMap<String, Object>();
//
//    try{
//
//      returnData = errorService.test(multiRequest);
//
//    }catch (Exception e ){
//      e.printStackTrace();
//    }
//
//    return returnData;
//  }

  @PostMapping(value = "/errorView/beforeUploadImageFile")
  @ResponseBody
  public String beforeUploadImageFile(MultipartHttpServletRequest multiRequest) throws IllegalStateException, IOException {
    String rst = "";
    try {

      rst = errorService.beforeUploadImageFile(multiRequest);

    } catch (Exception e) {
      e.printStackTrace();
    }

    return rst;
  }


//  @RequestMapping("/errorView/cudError")
//  @ResponseBody
//  public Map cudError(@RequestParam(value = "file", required = false) List<MultipartFile> files, @RequestParam HashMap<String, Object> param) throws Exception {
//    Map mp = new HashMap();
//    Map rtn = new HashMap();
//    System.out.println("--------------------data--------------------");
//    System.out.println("---param---");
//    System.out.println(param);
//    System.out.println("---param---");
//    System.out.println("get data");
//    System.out.println(param.get("data"));
//    System.out.println("get data");
//    System.out.println("--------------------data--------------------");
//    JSONParser p = new JSONParser();
//    JSONArray obj = (JSONArray) p.parse((String) param.get("data"));
//    System.out.println("-----obj-----");
//    System.out.println(obj);
//    System.out.println(obj.toString());
//    System.out.println("-----obj-----");
//
//    try {
//      // ibsheet에서 넘어온 내용
//      List saveData = (List) obj;
//
//      int updatedCnt = 0;
//      System.out.println("-----save Data-----");
//      System.out.println(saveData);
//      System.out.println("-----save Data-----");
//      for (int i = 0; i < saveData.size(); i++) {
//        Map row = (Map) saveData.get(i);
//        System.out.println("-----row-----");
//        System.out.println(row);
//        System.out.println("-----row-----");
//        switch (row.get("status").toString()) {
//          case "C":
//            updatedCnt += errorService.insertError(row);
//            updatedCnt += errorService.test(files, row);
//            break;
//          case "U":
////            updatedCnt += errorService.updateError(row);
////            updatedCnt += errorService.insertErrorImage(files, row);
//            break;
//          case "D":
////            updatedCnt += errorService.deleteError(row);
////            updatedCnt += errorService.deleteErrorImage(row);
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
//      ex.printStackTrace();
//      rtn.put("Result", -100); // 음수값은 모두 실패
//      rtn.put("Message", "오류입니다.");
//    }
//    mp.put("IO", rtn);
//
//    return mp;
//  }

  @RequestMapping("/errorView/cudError")
  @ResponseBody
  public Map cudError(@RequestParam(value = "file", required = false) List<MultipartFile> files, MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String, Object> param) throws Exception {

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
            updatedCnt += errorService.insertError(row);
            updatedCnt += errorService.insertErrorImage(files, row);
            break;
          case "U":
            updatedCnt += errorService.updateError(row);
            updatedCnt += errorService.insertErrorImage(files, row);
            break;
          case "D":
            deletedCnt += errorService.deleteError(row);
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

  @RequestMapping("/errorView/errorImageDelete")
  @ResponseBody
  public Map errorImageDelete(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += errorService.deleteErrorImageList(saveData);
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
