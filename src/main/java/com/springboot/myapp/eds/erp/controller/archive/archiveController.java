package com.springboot.myapp.eds.erp.controller.archive;

import com.springboot.myapp.eds.ims.controller.error.ErrorService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.jfree.util.Log;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
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
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Controller
public class archiveController {

  @Value("${eds.backs.file.path}")
  private String realPath;

  @Autowired
  private archiveService archiveService;

  @Autowired
  private ErrorService errorService;

  @RequestMapping("/ARCHIVE_VIEW")
  public String archiveView() {
    return "/eds/erp/archive/archiveView";
  }

  @RequestMapping("/archiveView/archiveThumbLoad/{params}")
  @ResponseBody
  public ResponseEntity<byte[]> loadArchiveThumbnail(@PathVariable("params") String params) throws IOException {
    String[] param = params.split(","); // params
    String saveNm = "";
    saveNm = param[1] + "." + param[2];
    String corpCd = param[0]; // 회사코드별 파일업로드 관리
    String path = new File(realPath + "/file/").getCanonicalPath()
            + File.separatorChar + corpCd
            + File.separatorChar + "erp"
            + File.separatorChar + "0001"
            + File.separatorChar + "archiveThumbnail"
            + File.separatorChar + saveNm;
    InputStream imageStream = new FileInputStream(path);
    byte[] imageByteArray = IOUtils.toByteArray(imageStream);
    imageStream.close();
    return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
  }

  @RequestMapping("/archiveView/archiveVideoLoad/{params}")
  @ResponseBody
  public ResponseEntity<Resource> loadArchiveVideo(@PathVariable("params") String params) throws IOException {

    String[] param = params.split(",");
    String saveNm = param[1] + "." + param[2];
    String corpCd = param[0];

    String path = new File(realPath + "/file/")
            .getCanonicalPath() + File.separatorChar + corpCd
            + File.separatorChar + "erp"
            + File.separatorChar + "0001"
            + File.separatorChar + "archiveVideo"
            + File.separatorChar + saveNm;

    Path videoPath = Paths.get(path);
    Resource videoResource = new UrlResource(videoPath.toUri());

    return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_TYPE, "video/mp4")
            .body(videoResource);
  }

  @RequestMapping("/archiveView/archiveFilesLoad/{params}")
  @ResponseBody
  public ResponseEntity<byte[]> loadArchiveFiles(@PathVariable("params") String params) throws IOException {
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
    } else if (fileType.equals("pptx")) {
      fileName = "pptimg.jpg";
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
              + File.separatorChar + "archiveFiles"
              + File.separatorChar + saveNm;
      InputStream imageStream = new FileInputStream(path);
      byte[] imageByteArray = IOUtils.toByteArray(imageStream);
      imageStream.close();

      return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
    }
  }


  @RequestMapping("/archiveView/selectArchive")
  @ResponseBody
  public Map selectArchive(@RequestBody HashMap<String, Object> map) {
    Map mp = new HashMap();
    try {
      List li = archiveService.selectArchive(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/archiveView/readArchive")
  @ResponseBody
  public Map readArchive(@RequestBody HashMap<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {
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

    Cookie viewCookie = null;
    Cookie[] cookies = request.getCookies(); // 클라이언트가 보낸 데이터에서 쿠키값을 가져온다.

    Object index = map.get("archiveIndex");
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
      archiveService.readArchive(map);
    }

    // 만들어진 쿠키가 없음을 확인
    if (viewCookie == null) {  // 쿠키가 없을 때 실행
      try {
        // 이 페이지에 왔음을 증명하는 쿠키 생성
        Cookie newCookie = new Cookie("|" + index + "|", "OK");
        newCookie.setMaxAge((int) (nextDay.getTime() - System.currentTimeMillis()) / 1000);
        response.addCookie(newCookie);  // 쿠키 값을 다시 클라이언트에 보냄

        // 쿠키가 없으니 증가 로직 진행
        archiveService.readArchive(map);

      } catch (Exception e) {
        e.printStackTrace();  // 예외 스택 트레이스 출력
      }
    } else {
      String value = viewCookie.getValue();
      System.out.println("viewCookie 확인 : 쿠키 value : " + value);
    }

    return mp;
  }


  @RequestMapping("/archiveView/selectArchiveVideo")
  @ResponseBody
  public Map selectArchiveVideo(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = archiveService.selectArchiveVideo(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/archiveView/selectArchiveThum")
  @ResponseBody
  public Map selectArchiveThum(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = archiveService.selectArchiveThum(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/archiveView/selectArchiveFiles")
  @ResponseBody
  public Map selectArchiveFiles(@RequestBody HashMap<String, Object> map) throws Exception {
    Map mp = new HashMap();

    try {
      List li = archiveService.selectArchiveFiles(map);
      mp.put("data", li);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/archiveView/cudArchive")
  @ResponseBody
  public Map cudArchive(@RequestParam(value = "removedFile", required = false) List<MultipartFile> removedFile, @RequestParam(value = "video", required = false) List<MultipartFile> video, @RequestParam(value = "files", required = false) List<MultipartFile> files, @RequestParam(value = "thumbnail", required = false) List<MultipartFile> thumbnail,MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String, Object> param) throws Exception {

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
            updatedCnt += archiveService.insertArchive(row);
            updatedCnt += archiveService.insertArchiveFiles(row, video, thumbnail, files);
            break;
          case "U":
            updatedCnt += archiveService.updateArchive(row);
            updatedCnt += archiveService.insertArchiveFiles(row, video, thumbnail, files);
            break;
          case "D":
            deletedCnt += archiveService.deleteArchive(row);
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

  @RequestMapping("/archiveView/deleteFiles")
  @ResponseBody
  public Map deleteFiles(@RequestBody HashMap<String, Object> map) throws Exception {
    int deletedCnt = 0;

    Map mp = new HashMap();

    deletedCnt = archiveService.deleteFiles(map);

    return mp;
  }

  @RequestMapping("/archiveView/deleteArchiveFile")
  @ResponseBody
  public Map deleteArchiveFile(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += archiveService.deleteArchiveFile(saveData);
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

  @RequestMapping("/archiveView/deleteArchiveImageList")
  @ResponseBody
  public Map deleteArchiveImageList(@RequestBody ArrayList<Object> param) throws Exception {
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      ArrayList<Object> saveData = (ArrayList<Object>) param;
      int updatedCnt = 0;
      updatedCnt += archiveService.deleteArchiveImageList(saveData);
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
