package com.springboot.myapp.eds.erp.controller.erpNotice;

import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeFileVO;
import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeImageVO;
import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeVO;
import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeImageVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeFileVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class erpNoticeService {

  @Autowired
  private erpNoticeMapper erpNoticeMapper;

  @Value("${eds.backs.file.path}")
  private String realPath;

  public List<erpNoticeVO> selectERPNotice(Map<String, Object> map) throws Exception {
    List<erpNoticeVO> result = erpNoticeMapper.selectERPNotice(map);
    return result;
  }

  public List<erpNoticeImageVO> selectERPNoticeImageList(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<erpNoticeImageVO> result = erpNoticeMapper.selectERPNoticeImageList(map);
    return result;
  }

  public List<erpNoticeFileVO> selectERPNoticeFiles(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<erpNoticeFileVO> result = erpNoticeMapper.selectERPNoticeFiles(map);
    return result;
  }

  public List<erpNoticeVO> selectERPNoticeByIndex(Map<String, Object> map) throws Exception {

    List<erpNoticeVO> result = erpNoticeMapper.selectERPNoticeByIndex(map);
    return result;
  }

  public int insertERPNotice(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return erpNoticeMapper.insertERPNotice(map);
  }

  @Transactional
  public int insertERPNoticeImage(List<MultipartFile> files, Map<String, Object> map) throws Exception {

    StringBuilder response = new StringBuilder();
    int result = 0;
    AES256Util aes256Util = new AES256Util();
    String corpCd = SessionUtil.getUser().getCorpCd();
    String empCd = SessionUtil.getUser().getEmpCd();
    String empNm = SessionUtil.getUser().getEmpNm();

    try {
      String path = realPath;
      /* 파일 경로 확인 및 생성*/
      path += "file\\";     final File fileDir = new File(path);
      path += corpCd + "\\";  final File corpDir = new File(path);
      path += "erp\\";    final File projectDir = new File(path);
      path += "0001" + "\\" + "erpNotice\\";
      final File empCdDir = new File(path);
      if (!fileDir.exists()) {
        fileDir.mkdir();
      }
      if (!corpDir.exists()) {
        corpDir.mkdir();
      }
      if (!projectDir.exists()) {
        projectDir.mkdir();
      }
      if (!empCdDir.exists()) {
        empCdDir.mkdir();
      }

      List<String> imageNames = extractERPImageFilenames((String) map.get("content"));

      for (int i = 0; i < files.size(); i++) {
        MultipartFile file = files.get(i);
        if (file.isEmpty()) {
          response.append("Failed to upload ")
                  .append(file.getOriginalFilename());
        } else {
          try {
            String saveNm = imageNames.get(i); // 이미지 이름으로 대체
            String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
            String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
            byte[] bytes = file.getBytes();

            /* 첨부파일 db 저장을 위한 파라미터 세팅*/
            Map<String, Object> test = new HashMap<String, Object>();
            test.put("corpCd", map.get("corpCd"));
            test.put("busiCd", map.get("busiCd"));
            test.put("noticeIndex", map.get("noticeIndex"));
            test.put("saveNm", saveNm);
            test.put("origNm", origNm);
            test.put("saveRoot", path + saveNm + "." + ext);
            test.put("ext", ext);
            test.put("size", file.getSize());
            test.put("userId", empCd);
            test.put("empNm", empNm);
            test.put("secretKey", aes256Util.getKey());

            result += erpNoticeMapper.insertERPNoticeImage(test);
            response.append("Successfully uploaded ")
                    .append(file.getOriginalFilename())
                    .append(". ");
          } catch (IOException e) {
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
  public int insertERPNoticeFile(List<MultipartFile> files, Map<String, Object> map) throws Exception {
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
      path+="erp\\";    final File projectDir = new File(path);
      path+="0001"+"\\"+"erpNoticeFiles\\";
      final File empCdDir = new File(path);
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
            test.put("noticeIndex",map.get("noticeIndex"));
            test.put("saveNm",saveNm);
            test.put("origNm",origNm);
            test.put("saveRoot",path+saveNm+"."+ext);
            test.put("ext",ext);
            test.put("size",file.getSize());
            test.put("userId",empCd);
            test.put("empNm",empNm);
            test.put("secretKey", aes256Util.getKey());
            result+=erpNoticeMapper.insertERPNoticeFile(test);
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

  // 이미지 src에서 saveNm만 가져오는 메서드
  private static List<String> extractERPImageFilenames(String htmlContent) {
    List<String> imageNames = new ArrayList<>();

    // 정규식을 사용하여 <img> 태그의 src 속성에서 파일 이름 추출
    Pattern pattern = Pattern.compile("(<img[^>]*src\s*=\s*[\"']?([^>\"\']+)[\"']?[^>]*>)");
    Matcher matcher = pattern.matcher(htmlContent);

    while (matcher.find()) {
      String imageName = matcher.group(2);
      String[] test = imageName.split("\\\\");
      // 확장자 자르기
      int lastDotIndex = test[test.length - 1].lastIndexOf('.');
      imageNames.add(test[test.length - 1].substring(0, lastDotIndex));
    }

    return imageNames;
  }

  public int updateERPNotice(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return erpNoticeMapper.updateERPNotice(map);
  }

  public int readERPNotice(Map<String, Object> map) throws Exception {
    return erpNoticeMapper.readERPNotice(map);
  }
  public int deleteERPNotice(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return erpNoticeMapper.deleteERPNotice(map);
  }

  @Transactional
  public int deleteERPNoticeImageList(ArrayList<Object> map) throws Exception {
    int result = 0;
    System.out.println("이미지 삭제 서비스 실행");
    System.out.println(map);
    try {
      for (Object key : map) {// 빈값 null 변경
        Map<String, Object> row = (Map<String, Object>) key;
        result += erpNoticeMapper.deleteERPNoticeImageList(row);
      }
    } catch (Exception e) {
      // 예외 처리
      e.printStackTrace();
    }
    return result;
  }

  @Transactional
  public int deleteERPNoticeFile(ArrayList<Object> map) throws Exception {
    int result=0;
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        result+=erpNoticeMapper.deleteERPNoticeFile(row);
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return result;
  }

  @Transactional
  public int deleteERPNoticeFilesAll(ArrayList<Object> map) throws Exception {
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        erpNoticeMapper.deleteERPNoticeFilesAll(row);
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return 1;
  }

}
