package com.springboot.myapp.eds.erp.controller.archive;

import com.springboot.myapp.eds.ims.controller.error.ErrorService;
import org.apache.commons.io.IOUtils;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

  @RequestMapping("/archiveView/archiveFilesLoad/{params}")
  @ResponseBody
  public ResponseEntity<byte[]> loadArchiveImage(@PathVariable("params") String params) throws IOException {
    String[] param = params.split(","); // params
    String saveNm = "";
    saveNm = param[1] + "." + param[2];
    String corpCd = param[0]; // 회사코드별 파일업로드 관리
    String path = new File(realPath + "/file/").getCanonicalPath()
            + File.separatorChar + corpCd
            + File.separatorChar + "erp"
            + File.separatorChar + "0001"
            + File.separatorChar + "archiveThum"
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
            + File.separatorChar + "archive"
            + File.separatorChar + saveNm;

    Path videoPath = Paths.get(path);
    Resource videoResource = new UrlResource(videoPath.toUri());

    return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_TYPE, "video/mp4")
            .body(videoResource);
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

  @RequestMapping("/archiveView/cudArchive")
  @ResponseBody
  public Map cudArchive(@RequestParam(value = "removedFile", required = false) List<MultipartFile> removedFile, @RequestParam(value = "file", required = false) List<MultipartFile> files, @RequestParam(value = "attachedFile", required = false) List<MultipartFile> attachedFile, MultipartHttpServletRequest multiRequest, @RequestParam HashMap<String, Object> param) throws Exception {
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
            updatedCnt += archiveService.insertArchive(files, row);
            updatedCnt += archiveService.insertArchiveFile(attachedFile, row);
            break;
          case "U":
            updatedCnt += archiveService.updateArchive(files, row);

            if (attachedFile != null && row.get("fileFlag").equals("true")) {
              updatedCnt += archiveService.updateArchiveFile(attachedFile, row);
            } else if (attachedFile != null && row.get("fileFlag").equals("false")) {
              updatedCnt += archiveService.insertArchiveFile(attachedFile, row);
            }
            break;
          case "D":
            deletedCnt += archiveService.deleteArchive(row);
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

  @RequestMapping("/archiveView/deleteArchiveFile")
  @ResponseBody
  public Map deleteArchiveFile(@RequestBody ArrayList<Object> param) throws Exception {
    //todo : 삭제가 아니고 업데이트가 될 수 있도록 해야겠다.
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
