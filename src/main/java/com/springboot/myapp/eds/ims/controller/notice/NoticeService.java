package com.springboot.myapp.eds.ims.controller.notice;

import com.springboot.myapp.eds.ims.vo.error.errorVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeFileVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeImageVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeVO;
import com.springboot.myapp.eds.ims.vo.site.siteImageVO;
import com.springboot.myapp.eds.ims.vo.site.siteVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FilenameUtils;
import org.jfree.chart.labels.StandardPieToolTipGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class NoticeService {

  @Autowired
  private NoticeMapper noticeMapper;

  @Value("${eds.backs.file.path}")
  private String realPath;

  public List<noticeVO> selectNotice(Map<String, Object> map) throws Exception {
    List<noticeVO> result = noticeMapper.selectNotice(map);
    return result;
  }

  public List<noticeImageVO> selectNoticeImageList(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<noticeImageVO> result = noticeMapper.selectNoticeImageList(map);
    return result;
  }

  public List<noticeFileVO> selectNoticeFiles(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<noticeFileVO> result = noticeMapper.selectNoticeFiles(map);
    return result;
  }

  public List<noticeVO> selectNoticeByIndex(Map<String, Object> map) throws Exception {

    List<noticeVO> result = noticeMapper.selectNoticeByIndex(map);
    return result;
  }

  public int insertNotice(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return noticeMapper.insertNotice(map);
  }

  @Transactional
  public int insertNoticeImage(List<MultipartFile> files, Map<String, Object> map) throws Exception {

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
      path += "ims\\";    final File projectDir = new File(path);
      path += "0001" + "\\" + "notice\\";
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

      List<String> imageNames = extractImageFilenames((String) map.get("content"));

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

            result += noticeMapper.insertNoticeImage(test);
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
  public int insertNoticeFile(List<MultipartFile> files, Map<String, Object> map) throws Exception {
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
      path+="0001"+"\\"+"noticeFiles\\";
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
            result+=noticeMapper.insertNoticeFile(test);
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

//  @Transactional
//  public int insertNoticeImage(List<MultipartFile> files, Map<String, Object> map) throws Exception {
//    System.out.println("이미지 서비스 시작");
//    System.out.println("files");
//    System.out.println(files);
//    System.out.println("files");
//    System.out.println("map");
//    System.out.println(map);
//    System.out.println("map");
//
//    StringBuilder response = new StringBuilder();
//    int result=0;
//    AES256Util aes256Util = new AES256Util();
//    String corpCd = SessionUtil.getUser().getCorpCd();
//    String empCd = SessionUtil.getUser().getEmpCd();
//    String empNm = SessionUtil.getUser().getEmpNm();
//
//    try {
//      String path = realPath;
//      /* 파일 경로 확인 및 생성*/
//      path+="file\\";     final File fileDir = new File(path);
//      path+=corpCd+"\\";  final File corpDir = new File(path);
//      path+="ims\\";    final File projectDir = new File(path);
//      path+="0001"+"\\"+"notice\\";
//      final File empCdDir = new File(path);
//      if(!fileDir.exists()){ fileDir.mkdir();}
//      if(!corpDir.exists()){ corpDir.mkdir();}
//      if(!projectDir.exists()){ projectDir.mkdir();}
//      if(!empCdDir.exists()){ empCdDir.mkdir();}
//
//      System.out.println("files 길이");
//      System.out.println(files.size());
//
//      for (MultipartFile file : files) {
//        System.out.println(file.getOriginalFilename());
//        if (file.isEmpty()) {
//          response.append("Failed to upload ")
//                  .append(file.getOriginalFilename());
//        }
//        else {
//          try
//          {
//            /* 랜덤 저장 명 파라미터 생성*/
//            SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
//            /* 첨부파일 생성 */
//
//            String htmlContent = (String) map.get("content");
//            List<String> imageNames = extractImageFilenames(htmlContent);
//            System.out.println("이미지 확인");
//            System.out.println(imageNames);
//            System.out.println("이미지 길이");
//            System.out.println(imageNames.size());
//
//
//            String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
//            String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
//            String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
//            byte[] bytes = file.getBytes();
//
////            Path filePath = Paths.get(path + saveNm+"."+ext);
////            System.out.println(filePath);
////            Files.write(filePath, bytes);
//
//            /* 첨부파일 db 저장을 위한 파라미터 세팅*/
//            Map<String, Object> test = new HashMap<String, Object>();
//            test.put("corpCd",map.get("corpCd"));
//            test.put("busiCd",map.get("busiCd"));
//            System.out.println("::::noticeIndex:::::");
//            System.out.println(map.get("noticeIndex"));
//            test.put("noticeIndex",map.get("noticeIndex"));
//            test.put("saveNm",saveNm);
//            test.put("origNm",origNm);
//            test.put("saveRoot",path+saveNm+"."+ext);
//            System.out.println("이미지 확인");
//            System.out.println(saveNm);
//            System.out.println(path+saveNm+"."+ext);
//            System.out.println("이미지 확인");
//            test.put("ext",ext);
//            test.put("size",file.getSize());
//            test.put("userId",empCd);
//            test.put("empNm",empNm);
//            test.put("secretKey", aes256Util.getKey());
//            result += noticeMapper.insertNoticeImage(test);
//            response.append("Successfully uploaded ")
//                    .append(file.getOriginalFilename())
//                    .append(". ");
//          }
//          catch (IOException e) {
//            response.append("Failed to upload ")
//                    .append(file.getOriginalFilename())
//                    .append(" due to an error: ")
//                    .append(e.getMessage());
//          }
//          System.out.println("리스폰스");
//          System.out.println(response);
//          System.out.println("리스폰스");
//        }
//      }
//    } catch (Exception e) {
//      // TODO: handle exception
//    }
//    return result;
//  }

  // 이미지 src에서 saveNm만 가져오는 메서드
  private static List<String> extractImageFilenames(String htmlContent) {
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

  public int updateNotice(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return noticeMapper.updateNotice(map);
  }

  public int readNotice(Map<String, Object> map) throws Exception {
    return noticeMapper.readNotice(map);
  }
  public int deleteNotice(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return noticeMapper.deleteNotice(map);
  }

  @Transactional
  public int deleteNoticeImageList(ArrayList<Object> map) throws Exception {
    int result = 0;

    try {
      for (Object key : map) {// 빈값 null 변경
        Map<String, Object> row = (Map<String, Object>) key;
        result += noticeMapper.deleteNoticeImageList(row);
      }
    } catch (Exception e) {
      // 예외 처리
      e.printStackTrace();
    }
    return result;
  }

  @Transactional
  public int deleteNoticeImageListAll(ArrayList<Object> map) throws Exception {
    int result = 0;

    try {
      for (Object key : map) {// 빈값 null 변경
        Map<String, Object> row = (Map<String, Object>) key;
        result += noticeMapper.deleteNoticeImageListAll(row);
      }
    } catch (Exception e) {
      // 예외 처리
      e.printStackTrace();
    }
    return result;
  }

  @Transactional
  public int deleteNoticeFile(ArrayList<Object> map) throws Exception {
    int result=0;
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        result+=noticeMapper.deleteNoticeFile(row);
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return result;
  }

  @Transactional
  public int deleteNoticeFilesAll(ArrayList<Object> map) throws Exception {
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        noticeMapper.deleteNoticeFilesAll(row);
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return 1;
  }

  // 파일 삭제 메서드
//  private void deleteFile(String fileName) {
//    try {
//      // 서버 리소스 경로와 파일 이름을 합쳐서 파일 객체 생성
//      Path filePath = Paths.get(realPath, fileName);
//      System.out.println("파일 경로 확인");
//      System.out.println(filePath);
//      // 파일이 존재하는지 확인 후 삭제
//      if (Files.exists(filePath)) {
//        Files.delete(filePath);
//        System.out.println("파일이 성공적으로 삭제되었습니다.");
//      } else {
//        System.out.println("파일이 존재하지 않습니다.");
//      }
//    } catch (Exception e) {
//      // 예외 처리
//      e.printStackTrace();
//    }
//  }
}
