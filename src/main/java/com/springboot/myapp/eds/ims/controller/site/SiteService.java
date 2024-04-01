package com.springboot.myapp.eds.ims.controller.site;

import com.springboot.myapp.eds.erp.vo.project.projectProjListVO;
import com.springboot.myapp.eds.ims.vo.site.siteFileVO;
import com.springboot.myapp.eds.ims.vo.site.siteImageVO;
import com.springboot.myapp.eds.ims.vo.site.siteMemoVO;
import com.springboot.myapp.eds.ims.vo.site.siteVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.annotations.Param;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class SiteService {

  @Autowired
  private SiteMapper siteMapper;

  @Value("${eds.backs.file.path}")
  private String realPath;

  public List<siteVO> selectSite(Map<String, Object> map) throws Exception {

    List<siteVO> result = siteMapper.selectSite(map);
    return result;
  }

  public int insertSite(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return siteMapper.insertSite(map);
  }

  public int insertCarryOverDivi(ArrayList<Object> map) throws Exception {
    try {
      for( Object key :map){
        Map<String, Object> row= (Map<String, Object>) key;
        siteMapper.insertCarryOverDivi(row);
      }
    } catch (Exception e) {

    }
    return 1;
  }
  public int updateCarryOverDivi(ArrayList<Object> map) throws Exception {
    try {
      for( Object key :map){
        Map<String, Object> row= (Map<String, Object>) key;
        siteMapper.updateCarryOverDivi(row);
      }
    } catch (Exception e) {

    }
    return 1;
  }

  public List<siteImageVO> selectSiteImageList(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<siteImageVO> result = siteMapper.selectSiteImageList(map);
    return result;
  }

  @Transactional
  public int insertSiteImage(List<MultipartFile> files,Map<String, Object> map) throws Exception {
    StringBuilder response = new StringBuilder();
    int result=0;
    AES256Util aes256Util = new AES256Util();
    String corpCd = SessionUtil.getUser().getCorpCd();
    String empCd = SessionUtil.getUser().getEmpCd();
    String empNm = SessionUtil.getUser().getEmpNm();
    try {
      String path = realPath;
      /* 파일 경로 확인 및 생성*/
      path+="file\\";     final File fileDir = new File(path);
      path+=corpCd+"\\";  final File corpDir = new File(path);
      path+="ims\\";    final File projectDir = new File(path);
      path+="0001"+"\\"+"images\\";   final File empCdDir = new File(path);
      if(!fileDir.exists()){ fileDir.mkdir();}
      if(!corpDir.exists()){ corpDir.mkdir();}
      if(!projectDir.exists()){ projectDir.mkdir();}
      if(!empCdDir.exists()){ empCdDir.mkdir();}
      for (MultipartFile file : files) {
        if (file.isEmpty()) {
          response.append("Failed to upload ")
                  .append(file.getOriginalFilename());
        }
        else {
          try
          {
            /* 랜덤 저장 명 파라미터 생성*/
            SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
            /* 첨부파일 생성 */

            String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
            String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
            String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
            byte[] bytes = file.getBytes();

            Path filePath = Paths.get(path + saveNm+"."+ext);
            Files.write(filePath, bytes);
            /* 첨부파일 db 저장을 위한 파라미터 세팅*/
            Map<String, Object> test = new HashMap<String, Object>();
            test.put("corpCd",map.get("corpCd"));
            test.put("busiCd",map.get("busiCd"));
            test.put("siteIndex",map.get("siteIndex"));
            test.put("saveNm",saveNm);
            test.put("origNm",origNm);
            test.put("saveRoot",path+saveNm+"."+ext);
            test.put("ext",ext);
            test.put("size",file.getSize());
            test.put("userId",empCd);
            test.put("empNm",empNm);
            test.put("secretKey", aes256Util.getKey());
            System.out.println("인덱스 확인");
            System.out.println(test);
            result+=siteMapper.insertSiteImage(test);
            response.append("Successfully uploaded ")
                    .append(file.getOriginalFilename())
                    .append(". ");
          }
          catch (IOException e) {
            response.append("Failed to upload ")
                    .append(file.getOriginalFilename())
                    .append(" due to an error: ")
                    .append(e.getMessage());
          }
        }
      }
    } catch (Exception e) {
      // TODO: handle exception
    }

    return result;
  }

  @Transactional
  public int deleteSiteImageList(ArrayList<Object> map) throws Exception {
    int result=0;
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        result+=siteMapper.deleteSiteImageList(row);
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return result;
  }

  @Transactional
  public int deleteAllSiteImage(ArrayList<Object> map) throws Exception {
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        siteMapper.deleteAllSiteImage(row);
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return 1;
  }


  public int updateSite(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return siteMapper.updateSite(map);
  }

  public int deleteSite(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return siteMapper.deleteSite(map);
  }
  public List<siteVO> selectSitePop(Map<String, Object> map) throws Exception {

    List<siteVO> result = siteMapper.selectSitePop(map);
    return result;
  }
  public List<siteVO> selectSiteByIndex(Map<String, Object> map) throws Exception {

    List<siteVO> result = siteMapper.selectSiteByIndex(map);
    return result;
  }

  public List<siteFileVO> selectSiteFileList(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("secretKey", aes256Util.getKey());

//    map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
//    map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
//
//    map.put("authDivi", SessionUtil.getUser().getAuthDivi());
//    map.put("depaCd", SessionUtil.getUser().getDepaCd());
//    map.put("empCd", SessionUtil.getUser().getEmpCd());
    List<siteFileVO> result = siteMapper.selectSiteFileList(map);
    return result;
  }

  public Map<String, Object> insertSiteFileList(MultipartHttpServletRequest mtfRequest, @RequestParam Map<String, Object> param) {

    /**
     * 클라이언트 리턴 데이터
     * */
    Map<String, Object> returnData = new HashMap<String, Object>();

    try {
      // 파라미터세팅
      AES256Util aes256Util = new AES256Util();

      String corpCd = SessionUtil.getUser().getCorpCd();
      String empCd = SessionUtil.getUser().getEmpCd();
      String empNm = SessionUtil.getUser().getEmpNm();

//      String estCd = mtfRequest.getParameter("estCd");
//      String projCd = mtfRequest.getParameter("projCd");

      // 파일 읽기: 클라이언트 input[type='file']의 name이랑 getFiles의 명과 동일해야함
      List<MultipartFile> fileList = mtfRequest.getFiles("files");
      int fileListSize = fileList.size();

      /* 이메일 첨부파일 기본명 세팅 마친 후 삭제 작업*/
      File[] tempFile = new File[fileListSize];

      /* 첨부파일 db 저장을 위한 파라미터 */
      Map<String, Object>[] atchFile = new HashMap[fileListSize];

      /* 첨부파일 파일 객체 생성 */
      String path = realPath;

      /* 파일 경로 확인 및 생성*/
      path+="file\\";     final File fileDir = new File(path);
      path+=corpCd+"\\";  final File corpDir = new File(path);
      path+="ims\\";    final File imsDir = new File(path);
//      path+="0001"+"\\";   final File empCdDir = new File(path);
      path+="0001"+"\\"+"files\\";   final File empCdDir = new File(path);
      /* 이메일 첨부파일 이 존재할 시 실행 */
      if(fileListSize > 0){

        if(!fileDir.exists()){ fileDir.mkdir();}
        if(!corpDir.exists()){ corpDir.mkdir();}
        if(!imsDir.exists()){ imsDir.mkdir();}
        if(!empCdDir.exists()){ empCdDir.mkdir();}

        Map<String, Object> map = null;
        /* 이메일 첨부파일 세팅*/
        for (int i = 0; i < fileListSize; i++) {

          /* 랜덤 저장 명 파라미터 생성*/
          SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format

          /* 첨부파일 생성 */
          File realFile = null;
          String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
          String origNm = FilenameUtils.getBaseName(fileList.get(i).getOriginalFilename()); // 원본명
          String ext = FilenameUtils.getExtension(fileList.get(i).getOriginalFilename()); // 확장자

          realFile = new File(path+saveNm+"."+ext);

          FileOutputStream fos = new FileOutputStream(realFile);
          fos.write(fileList.get(i).getBytes());
          fos.close();

          /* 첨부파일 db 저장을 위한 파라미터 세팅*/
          map = new HashMap<>();
          map.put("siteIndex", param.get("siteIndex"));
          map.put("corpCd",SessionUtil.getUser().getCorpCd());
          map.put("busiCd",SessionUtil.getUser().getBusiCd());
          map.put("saveNm",saveNm);
          map.put("origNm",origNm);
          map.put("saveRoot",path+saveNm+"."+ext);
          map.put("ext",ext);
          map.put("size",realFile.length());
          map.put("userId",empCd);
          map.put("empNm", empNm);
          map.put("secretKey", aes256Util.getKey());
          siteMapper.insertSiteFileList(map);
        }
      }else{
        returnData.put("status","success");
        returnData.put("note","저장할 파일이 없습니다.");
      }

      returnData.put("status","success");
      returnData.put("note","성공적으로 파일을 저장하였습니다.");

    }catch (Exception e){
      String exc = e.toString();
      returnData.put("status","fail");
      returnData.put("exc",exc);
      returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
      e.printStackTrace();
    }
    return returnData;
  }

  public int updateSiteFileList(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("updNm", SessionUtil.getUser().getEmpNm());
    return siteMapper.updateSiteFileList(map);
  }

  public int deleteSiteFileList(Map<String, Object> map) {
    /**
     * 클라이언트 리턴 데이터
     * */
    int returnData = 0;

    try {
      /* 서버 파일 삭제 */
      AES256Util aes256Util = new AES256Util();
      map.put("secretKey", aes256Util.getKey());
//      map.put("authDivi", SessionUtil.getUser().getAuthDivi());
//      map.put("depaCd", SessionUtil.getUser().getDepaCd());
//      map.put("empCd", SessionUtil.getUser().getEmpCd());
      if (map.get("status").equals("D")){
      List<siteFileVO> result = siteMapper.selectSiteFileListForDelete(map);
        int resultSize = result.size();
        for (int i = 0; i < resultSize; i++) {
          /* 실제 파일 삭제 */
          Files.delete(Paths.get(result.get(i).getSaveRoot()));
          /* DB 파일 삭제 */
          siteMapper.deleteSiteFileList(map);
        }
      }
      else if (map.get("status").equals("DA")){
      List<siteFileVO> result = siteMapper.selectSiteFileListForDeleteALL(map);
        int resultSize = result.size();
        for (int i = 0; i < resultSize; i++) {
          /* 실제 파일 삭제 */
          Files.delete(Paths.get(result.get(i).getSaveRoot()));
          /* DB 파일 삭제 */
          siteMapper.deleteSiteFileList(map);
        }
      }

      returnData = 1;

    }catch (Exception e){
      String exc = e.toString();
      e.printStackTrace();

      returnData = 0;
    }

    /* DB 파일 삭제 */
    return returnData;
  }

  public List<siteMemoVO> selectSiteMemoList(Map<String, Object> map) throws Exception {

    List<siteMemoVO> result = siteMapper.selectSiteMemoList(map);
    return result;
  }

  public int insertSiteMemoList(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return siteMapper.insertSiteMemoList(map);
  }

  public int updateSiteMemoList(Map<String, Object> map) throws Exception {
    map.put("updId", SessionUtil.getUser().getEmpNm());
    return siteMapper.updateSiteMemoList(map);
  }
  public int deleteSiteMemoList(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return siteMapper.deleteSiteMemoList(map);
  }

  public List<projectProjListVO> selectProjMgtListInIms(Map<String, Object> map) throws Exception {
    map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
    map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

    map.put("authDivi", SessionUtil.getUser().getAuthDivi());
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    List<projectProjListVO> result = siteMapper.selectProjMgtListInIms(map);
    return result;
  }

}
