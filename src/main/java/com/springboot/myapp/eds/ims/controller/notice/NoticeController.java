package com.springboot.myapp.eds.ims.controller.notice;

import com.springboot.myapp.eds.ims.controller.error.ErrorService;
import com.springboot.myapp.util.SessionUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.CookieStore;
import java.net.HttpCookie;
import java.nio.file.Files;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

@Controller
public class NoticeController {

  @Value("${eds.backs.file.path}")
  private String realPath;

  @Autowired
  private NoticeService noticeService;

  @Autowired
  private ErrorService errorService;

  @RequestMapping("/NOTICE_VIEW")
  public String noticeView() {
    return "/eds/ims/notice/noticeView";
  }

  @RequestMapping("/noticeView/selectNotice")
  @ResponseBody
  public Map selectNotice(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = noticeService.selectNotice(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/noticeView/selectNoticeImageList")
  @ResponseBody
  public Map selectNoticeImageList(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = noticeService.selectNoticeImageList(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/noticeView/selectNoticeFiles")
  @ResponseBody
  public Map selectNoticeFiles(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = noticeService.selectNoticeFiles(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/noticeView/noticeFilesLoad/{params}")
  @ResponseBody
  public ResponseEntity<byte[]> loadSiteImage(@PathVariable("params") String params) throws IOException {
    String[] param = params.split(","); // params
    String saveNm = "";
    saveNm = param[1] + "." + param[2];
    String corpCd = param[0]; // 회사코드별 파일업로드 관리
    String path = new File(realPath + "/file/").getCanonicalPath()
            + File.separatorChar + corpCd
            + File.separatorChar + "ims"
            + File.separatorChar + "0001"
            + File.separatorChar + "noticeFiles"
            + File.separatorChar + saveNm;
    InputStream imageStream = new FileInputStream(path);
    byte[] imageByteArray = IOUtils.toByteArray(imageStream);
    imageStream.close();
    return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
  }

  @RequestMapping("/noticeView/selectNoticeByIndex")
  @ResponseBody
  public Map selectNoticeByIndex(@RequestBody HashMap<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {
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
      List li = noticeService.selectNoticeByIndex(map);
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
      noticeService.readNotice(map);
    }

    // 만들어진 쿠키가 없음을 확인
    if (viewCookie == null) {  // 쿠키가 없을 때 실행
      try {
        // 이 페이지에 왔음을 증명하는 쿠키 생성
        Cookie newCookie = new Cookie("|" + index + "|", "OK");
        newCookie.setMaxAge((int) (nextDay.getTime() - System.currentTimeMillis()) / 1000);
        response.addCookie(newCookie);  // 쿠키 값을 다시 클라이언트에 보냄

        // 쿠키가 없으니 증가 로직 진행
        noticeService.readNotice(map);

      } catch (Exception e) {
        e.printStackTrace();  // 예외 스택 트레이스 출력
      }
    } else {
      String value = viewCookie.getValue();
      System.out.println("viewCookie 확인 : 쿠키 value : " + value);
    }

    return mp;
  }

//  @RequestMapping("/noticeView/cudNotice")
//  @ResponseBody
//  public Map cudNotice(@RequestParam(value = "file", required = false) List<MultipartFile> files, MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String, Object> param) throws Exception {
//    Map mp = new HashMap();
//    Map rtn = new HashMap();
//    Map<String, Object> returnData = new HashMap<String, Object>();
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
//      int deletedCnt = 0;
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
//            System.out.println("파일");
//            System.out.println(files);
//            updatedCnt += noticeService.insertNotice(row);
////            updatedCnt += noticeService.insertNoticeImage(files, row);
//            break;
//          case "U":
//            updatedCnt += noticeService.updateNotice(row);
////            updatedCnt += errorService.insertErrorImage(files, row);
//            break;
//          case "D":
//            deletedCnt += noticeService.deleteNotice(row);
////            updatedCnt += errorService.deleteErrorImage(row);
//            break;
//        }
//      }
//      if (updatedCnt > 0) { // 정상 저장
//        System.out.println("서비스 실행");
//        errorService.test(multiRequest);
//        rtn.put("Result", 0);
//        rtn.put("Message", "저장 되었습니다.");
//      } else if (deletedCnt > 0) {
//        errorService.deleteErrorImage(multiRequest);
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

  @RequestMapping("/noticeView/cudNotice")
  @ResponseBody
  public Map cudNotice(@RequestParam(value = "file", required = false) List<MultipartFile> files, @RequestParam(value = "attachedFile", required = false) List<MultipartFile> attachedFile, MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String, Object> param) throws Exception {
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
            updatedCnt += noticeService.insertNotice(row);
            updatedCnt += noticeService.insertNoticeImage(files, row);
            updatedCnt += noticeService.insertNoticeFile(attachedFile, row);
            break;
          case "U":
            updatedCnt += noticeService.updateNotice(row);
            updatedCnt += noticeService.insertNoticeImage(files, row);
            updatedCnt += noticeService.insertNoticeFile(attachedFile, row);
            break;
          case "D":
            deletedCnt += noticeService.deleteNotice(row);
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

  @RequestMapping("/noticeView/noticeImageDelete")
  @ResponseBody
  public Map noticeImageDelete(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += noticeService.deleteNoticeImageList(saveData);
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

  @RequestMapping("/noticeView/noticeImageDeleteAll")
  @ResponseBody
  public Map noticeImageDeleteAll(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += noticeService.deleteNoticeImageListAll(saveData);
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

  @RequestMapping("/noticeView/deleteNoticeFile")
  @ResponseBody
  public Map deleteNoticeFile(@RequestBody ArrayList<Object> param) throws Exception
  {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>)param;
      int updatedCnt = 0;
      updatedCnt += noticeService.deleteNoticeFile(saveData);
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

  @RequestMapping("/noticeView/deleteNoticeFilesAll")
  @ResponseBody
  public Map deleteNoticeFilesAll(@RequestBody ArrayList<Object> param) throws Exception
  {
    Map mp = new HashMap();
    Map rtn = new HashMap();

    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>)param;
      int updatedCnt = 0;
      updatedCnt += noticeService.deleteNoticeFilesAll(saveData);
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
