package com.springboot.myapp.eds.ims.controller.error;

import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeImageVO;
import com.springboot.myapp.eds.ims.vo.error.errorImageVO;
import com.springboot.myapp.eds.ims.vo.error.errorVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ErrorService {

  @Value("${eds.front.file.path}")
  private String filePath;

  @Value("${eds.backs.file.path}")
  private String realPath;

  @Autowired
  private ErrorMapper errorMapper;

  public List<errorVO> selectError(Map<String, Object> map) throws Exception {

    List<errorVO> result = errorMapper.selectError(map);
    return result;
  }

  public List<errorVO> selectErrorByIndex(Map<String, Object> map) throws Exception {

    List<errorVO> result = errorMapper.selectErrorByIndex(map);
    return result;
  }

  public List<errorImageVO> selectErrorImageList(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<errorImageVO> result = errorMapper.selectErrorImageList(map);
    return result;
  }

  @Transactional
  public int insertErrorImage(List<MultipartFile> files, Map<String, Object> map) throws Exception {
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
      path += "0001" + "\\" + "errors\\";
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

      List<String> imageNames = extractErrorImageFilenames((String) map.get("content"));

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
            test.put("errorIndex", map.get("errorIndex"));
            test.put("saveNm", saveNm);
            test.put("origNm", origNm);
            test.put("saveRoot", path + saveNm + "." + ext);
            test.put("ext", ext);
            test.put("size", file.getSize());
            test.put("userId", empCd);
            test.put("empNm", empNm);
            test.put("secretKey", aes256Util.getKey());

            result += errorMapper.insertErrorImage(test);
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

  // 이미지 src에서 saveNm만 가져오는 메서드
  private static List<String> extractErrorImageFilenames(String htmlContent) {
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

  public int updateError(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return errorMapper.updateError(map);
  }

  public int deleteError(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return errorMapper.deleteError(map);
  }

  public String beforeUploadImageFile(MultipartHttpServletRequest mtfRequest) throws Exception {
    // 파일 세팅
    List<MultipartFile> fileList = mtfRequest.getFiles("file");
    MultipartFile mf = fileList.get(0);

    // 파라미터 세팅
    JSONObject jsonObject = new JSONObject();

    String corpCd = SessionUtil.getUser().getCorpCd();
    String empCd = SessionUtil.getUser().getEmpCd();
    String[] fileName = fileList.get(0).getOriginalFilename().split(".");
    int fileNameLength = fileName.length;

    String origNm = FilenameUtils.getBaseName(mf.getOriginalFilename());
    String ext = FilenameUtils.getExtension(mf.getOriginalFilename()); // 확장자
    String size = String.valueOf(fileList.get(0).getSize());
    String divi = mtfRequest.getParameter("divi");
    String moduleDivi = mtfRequest.getParameter("moduleDivi");
    /* 경로 세팅 */
    String path = filePath;
    String returnPath = "\\file\\" + corpCd + "\\" + moduleDivi + "\\" + "0001\\" + divi + "\\";
//    String returnPath = "\\file\\" + corpCd + "\\" + "error\\" + "image\\" + divi + "\\" + empCd + "\\";

    /* 시간 세팅 */
    SimpleDateFormat yyyMMFormat = new SimpleDateFormat("yyyyMM");
    String yyyyMM = yyyMMFormat.format(new Date());

    SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format

    /* 파일 경로 확인 및 생성*/
    path += "file\\";
    final File fileDir = new File(path);
    path += corpCd + "\\";
    final File corpDir = new File(path);
    path += moduleDivi + "\\";
    final File emailDir = new File(path);
    path += "0001\\";
    final File imageDir = new File(path);
    path += divi + "\\";
    final File diviDir = new File(path);

    if (!fileDir.exists()) {
      fileDir.mkdir();
    }
    if (!corpDir.exists()) {
      corpDir.mkdir();
    }
    if (!emailDir.exists()) {
      emailDir.mkdir();
    }
    if (!imageDir.exists()) {
      imageDir.mkdir();
    }
    if (!diviDir.exists()) {
      diviDir.mkdir();
    }

    // 저장 파일 경로 적용
    String savePath = new File(path).getCanonicalPath() + File.separatorChar; // File path to be saved

    try {
      // 업로드된 파일의 InputStream 얻기
      InputStream fileStream = mtfRequest.getInputStream();

      // 저장명 적용 및 업로드된 파일을 지정된 경로에 저장
      String saveNm = seventeenFormat.format(new Date()) + Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
      mf.transferTo(new File(savePath + saveNm + "." + ext));

      // JSON 객체에 이미지 URL과 응답 코드 추가
      jsonObject.put("url", returnPath + saveNm + "." + ext);
      jsonObject.put("responseCode", "success");
      jsonObject.put("origNm", origNm);
      jsonObject.put("size", size);
      jsonObject.put("ext", ext);

    } catch (IOException e) {
      // 파일 저장 중 오류가 발생한 경우 해당 파일 삭제 및 에러 응답 코드 추가
      jsonObject.put("responseCode", "error");
      e.printStackTrace();
    }

    // JSON 객체를 문자열로 변환하여 반환
    return jsonObject.toString();
  }

  public int insertError(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return errorMapper.insertError(map);
  }

//  public Map<String, Object> test(MultipartHttpServletRequest mtfRequest) throws Exception {
//    System.out.println("test 실행됨");
//    System.out.println("mtfRequest");
//    System.out.println(mtfRequest);
//    /**
//     * 클라이언트 리턴 데이터
//     * */
//    Map<String, Object> returnData = new HashMap<String, Object>();
//
//    try {
//      String divi = mtfRequest.getParameter("divi");
//      System.out.println("divi");
//      System.out.println(divi);
//      String htmlToEmail = mtfRequest.getParameter("html");
//      System.out.println("체크 시작");
//      System.out.println(htmlToEmail);
//      System.out.println("체크 끝");
//
//      String checkImages = mtfRequest.getParameter("images");
//      System.out.println("전체 이미지 확인");
//      System.out.println(checkImages);
//      // file Root
//      String corpCd = SessionUtil.getUser().getCorpCd();
//      String empCd = SessionUtil.getUser().getEmpCd();
//
//      String tempRoot = filePath + "file\\" + corpCd + "\\" + "error\\" + "image\\" + divi + "\\" + empCd + "\\";
//      String realRoot = realPath + "file\\" + corpCd + "\\" + "ims\\" + "0001\\" + divi + "\\";
//      System.out.println("realPath123");
//      System.out.println(realRoot);
//
//      // 이미지 태그를 추출하기 위한 정규식.
//      Pattern imgSrcPattern = Pattern.compile("(<img[^>]*src\s*=\s*[\"']?([^>\"\']+)[\"']?[^>]*>)");
//
//      Matcher matcher = imgSrcPattern.matcher(htmlToEmail);
//
//      System.out.println("비교 시작");
//      System.out.println(matcher);
//      System.out.println("비교 끝");
//
//      String pathToImg = realPath;
//
//      /* 파일 경로 확인 및 생성*/
//      pathToImg += "file\\";
//      final File fileDirToImg = new File(pathToImg);
//      pathToImg += corpCd + "\\";
//      final File corpDirToImg = new File(pathToImg);
//      pathToImg += "ims\\";
//      final File emailDirToImg = new File(pathToImg);
//      pathToImg += "0001\\";
//      final File imageDirToImg = new File(pathToImg);
//      pathToImg += divi + "\\";
//      final File diviDirToImg = new File(pathToImg);
//
//      if (!fileDirToImg.exists()) {
//        fileDirToImg.mkdir();
//      }
//      if (!corpDirToImg.exists()) {
//        corpDirToImg.mkdir();
//      }
//      if (!emailDirToImg.exists()) {
//        emailDirToImg.mkdir();
//      }
//      if (!imageDirToImg.exists()) {
//        imageDirToImg.mkdir();
//      }
//      if (!diviDirToImg.exists()) {
//        diviDirToImg.mkdir();
//      }
////      if (!empCdDirToImg.exists()) {
////        empCdDirToImg.mkdir();
////      }
//
//      String imgSrc = "";
//      String imgSrc1 = "";
//      if (checkImages != null){
//        Matcher matcher1 = imgSrcPattern.matcher(checkImages);
//        while (matcher1.find()) {
//          imgSrc1 = matcher1.group(2).trim();
//          System.out.println("원래 이미지들");
//          System.out.println(imgSrc1);
//        }
////        Matcher matcher1 = imgSrcPattern.matcher(checkImages);
////        while (matcher1.find()) {
////          System.out.println("매쳐1 확인 시작");
////          imgSrc1 = matcher1.group(2).trim();
////          System.out.println(imgSrc1);
////          System.out.println("매쳐1 확인 끝");
////
////          System.out.println("삭제 전 비교하기");
////          System.out.println(imgSrc1);
////          System.out.println();
////
////          String testda = URLDecoder.decode(imgSrc1, StandardCharsets.UTF_8);
////          String[] imgSrcArr = testda.split("\\\\");
////          String filePath = realRoot + imgSrcArr[imgSrcArr.length - 1];
////          System.out.println("삭제 확인");
////          System.out.println(filePath);
////          File file = new File(filePath);
////          System.out.println("파일 확인");
////          System.out.println(file);
//////          if (file.exists()) {
//////            file.delete();
//////          }
////        }
//      }
//      while (matcher.find()) {
//        imgSrc = matcher.group(2).trim();
//        System.out.println("현재 이미지들");
//        System.out.println(imgSrc);
//      }
//
//      System.out.println("반복문 나온 원래 이미지");
//      System.out.println(imgSrc1);
//      System.out.println("반복문 나온 현재 이미지");
//      System.out.println(imgSrc);
//
//      while (matcher.find()) {
//        System.out.println("넘어 왔는지");
//        // 1. 임시 저장된 이미지를 서버 resource에 저장
//        imgSrc = matcher.group(2).trim();
//        System.out.println("이미지 소스 비교 시작");
//        System.out.println(imgSrc);
//        System.out.println(imgSrc1);
//        System.out.println("이미지 소스 비교 끝");
//
//        System.out.println("파일 확인 시작");
////        String[] imgSrcArr = imgSrc.split("\\\\");
////        String filePath = realRoot + imgSrcArr[imgSrcArr.length - 1];
////        File file = new File(filePath);
////        System.out.println(imgSrcArr);
//        System.out.println("파일 확인 시작");
//
//        String testda = URLDecoder.decode(imgSrc, StandardCharsets.UTF_8);
//
//        System.out.println("디코딩");
//        System.out.println(testda);
//
////        String[] imgSrcArr = imgSrc.split("\\\\");
//        String[] imgSrcArr = testda.split("\\\\");
//        System.out.println("이미지 소스 스플릿");
//        System.out.println(Arrays.toString(imgSrcArr));
//
//        File tempFile = new File(tempRoot + imgSrcArr[imgSrcArr.length - 1]);
//        File realFile = new File(realRoot + imgSrcArr[imgSrcArr.length - 1]);
//        System.out.println("여기 확인 필요");
//        System.out.println(Arrays.toString(imgSrcArr));
//
//        System.out.println("마지막 파일들 체크");
//        System.out.println(tempFile);
//        System.out.println(realFile);
//
//        if (!tempFile.exists()) tempFile = realFile;
//
//        Files.copy(
//                tempFile.toPath(),
//                realFile.toPath(),
//                StandardCopyOption.REPLACE_EXISTING); // REPLACE_EXISTING 이미 있으면 덮어쓰기 기능
//
//        byte[] fileContent = FileUtils.readFileToByteArray(realFile);
//        String encodedString = Base64.getEncoder().encodeToString(fileContent);
//        htmlToEmail = htmlToEmail.replace(matcher.group(2).trim(), "data:image/" + realFile.getName().substring(realFile.getName().lastIndexOf(".") + 1) + ";base64," + encodedString);
//      }
//
//      System.out.println("파일 비우기 전임");
//      // 2. temp 파일 비우기
//      File tempFiles = new File(tempRoot);
//      System.out.println("지울 파일임");
//      System.out.println(tempFiles);
//      FileUtils.deleteDirectory(tempFiles);
//    } catch (Exception e) {
//      System.out.print(e);
//    }
//    return returnData;
//  }

  public Map<String, Object> test(MultipartHttpServletRequest mtfRequest) throws Exception {
    /**
     * 클라이언트 리턴 데이터
     * */
    Map<String, Object> returnData = new HashMap<String, Object>();

    try {
      String divi = mtfRequest.getParameter("divi");
      String moduleDivi = mtfRequest.getParameter("moduleDivi");
      String htmlToEmail = mtfRequest.getParameter("html");
      String checkImages = mtfRequest.getParameter("images");

      // file Root
      String corpCd = SessionUtil.getUser().getCorpCd();
      String empCd = SessionUtil.getUser().getEmpCd();

//      String tempRoot = filePath + "file\\" + corpCd + "\\" + "error\\" + "image\\" + divi + "\\" + empCd + "\\";
      String tempRoot = filePath + "file\\" + corpCd + "\\" + moduleDivi + "\\" + "0001\\" + divi + "\\";
      String realRoot = realPath + "file\\" + corpCd + "\\" + moduleDivi + "\\" + "0001\\" + divi + "\\";
      String pathToImg = realPath;

      /* 파일 경로 확인 및 생성*/
      pathToImg += "file\\";
      final File fileDirToImg = new File(pathToImg);
      pathToImg += corpCd + "\\";
      final File corpDirToImg = new File(pathToImg);
      pathToImg += moduleDivi + "\\";
      final File emailDirToImg = new File(pathToImg);
      pathToImg += "0001\\";
      final File imageDirToImg = new File(pathToImg);
      pathToImg += divi + "\\";
      final File diviDirToImg = new File(pathToImg);

      if (!fileDirToImg.exists()) {
        fileDirToImg.mkdir();
      }
      if (!corpDirToImg.exists()) {
        corpDirToImg.mkdir();
      }
      if (!emailDirToImg.exists()) {
        emailDirToImg.mkdir();
      }
      if (!imageDirToImg.exists()) {
        imageDirToImg.mkdir();
      }
      if (!diviDirToImg.exists()) {
        diviDirToImg.mkdir();
      }

      String imgSrc = "";

      if (checkImages != null) {
        /* 이미지파일*/
        String existingFiles = mtfRequest.getParameter("images");  // 기존 html 값
        String modifiedFiles = mtfRequest.getParameter("html"); // 수정된 html 값

        // HTML 문자열로부터 Document 객체 생성
        Document existingDoc = Jsoup.parse(existingFiles);
        Document modifiedDoc = Jsoup.parse(modifiedFiles);

        // 모든 img 태그 찾기
        Elements existingImages = existingDoc.select("img");
        Elements modifiedImages = modifiedDoc.select("img");

        // 각 img 태그의 src 속성 출력
        File[] imgFileDb = new File[existingImages.size()];
        for (int i = 0; i < existingImages.size(); i++) {
          imgFileDb[i] = new File(realPath + existingImages.get(i).attr("src"));
        }

        File[] imgFile = new File[modifiedImages.size()];
        for (int i = 0; i < modifiedImages.size(); i++) {
          imgFile[i] = new File(realPath + modifiedImages.get(i).attr("src"));
        }

        // 중복되는 값을 찾아내는 메서드 호출
        File[] duplicateFile = findDuplicates(imgFileDb, imgFile);

        // 중복되지 않는 File 찾아 삭제
        for (File baseFile : imgFileDb) {
          boolean isDuplicate = false;

          for (File comparisonFile : duplicateFile) {
            if (baseFile.equals(comparisonFile)) {
              isDuplicate = true;
              break;
            }
          }
          if (!isDuplicate) {
            deleteFile(baseFile);
          }
        }
      }

      // 이미지 태그를 추출하기 위한 정규식.
      Pattern imgSrcPattern = Pattern.compile("(<img[^>]*src\s*=\s*[\"']?([^>\"\']+)[\"']?[^>]*>)");
      Matcher matcher = imgSrcPattern.matcher(htmlToEmail);

      while (matcher.find()) {
        // 1. 임시 저장된 이미지를 서버 resource에 저장
        imgSrc = matcher.group(2).trim();

        String testda = URLDecoder.decode(imgSrc, StandardCharsets.UTF_8);

//        String[] imgSrcArr = imgSrc.split("\\\\");
        String[] imgSrcArr = testda.split("\\\\");


        File tempFile = new File(tempRoot + imgSrcArr[imgSrcArr.length - 1]);
        File realFile = new File(realRoot + imgSrcArr[imgSrcArr.length - 1]);

        if (!tempFile.exists()) tempFile = realFile;

        Files.copy(
                tempFile.toPath(),
                realFile.toPath(),
                StandardCopyOption.REPLACE_EXISTING); // REPLACE_EXISTING 이미 있으면 덮어쓰기 기능

        byte[] fileContent = FileUtils.readFileToByteArray(realFile);
        String encodedString = Base64.getEncoder().encodeToString(fileContent);
        htmlToEmail = htmlToEmail.replace(matcher.group(2).trim(), "data:image/" + realFile.getName().substring(realFile.getName().lastIndexOf(".") + 1) + ";base64," + encodedString);
      }

//          2. temp 파일 비우기
      File tempFile = new File(tempRoot);
      FileUtils.deleteDirectory(tempFile);
    } catch (Exception e) {
      System.out.print(e);
    }
    return returnData;
  }

  // 중복된 값을 찾아 배열로 반환하는 메서드
  private static File[] findDuplicates(File[] array1, File[] array2) {
    Set<File> set1 = new HashSet<>();
    Set<File> duplicates = new HashSet<>();

    // 첫 번째 배열의 값을 set1에 저장
    for (File file : array1) {
      set1.add(file);
    }

    // 두 번째 배열의 값을 set1과 비교하여 중복된 값인 경우 duplicates에 추가
    for (File file : array2) {
      if (!set1.add(file)) {
        duplicates.add(file);
      }
    }

    // 중복된 값 배열로 반환
    return duplicates.toArray(new File[0]);
  }

  // File을 삭제하는 메서드
  private static void deleteFile(File file) {
    if (file.exists()) {
      if (file.delete()) {
        System.out.println("파일 삭제 성공: " + file.getAbsolutePath());
      } else {
        System.out.println("파일 삭제 실패: " + file.getAbsolutePath());
      }
    } else {
      System.out.println("파일이 존재하지 않습니다: " + file.getAbsolutePath());
    }
  }

  public Map<String, Object> deleteErrorImage(MultipartHttpServletRequest mtfRequest) throws Exception {
    /**
     * 클라이언트 리턴 데이터
     * */
    Map<String, Object> returnData = new HashMap<String, Object>();
    try {
      String divi = mtfRequest.getParameter("divi");
      String moduleDivi = mtfRequest.getParameter("moduleDivi");
      String htmlToEmail = mtfRequest.getParameter("html");

      String corpCd = SessionUtil.getUser().getCorpCd();

      // 이미지 태그를 추출하기 위한 정규식.
      Pattern imgSrcPattern = Pattern.compile("(<img[^>]*src\s*=\s*[\"']?([^>\"\']+)[\"']?[^>]*>)");

      Matcher matcher = imgSrcPattern.matcher(htmlToEmail);
      String realRoot = realPath + "file\\" + corpCd + "\\" +moduleDivi + "\\" + "0001\\" + divi + "\\";
      while (matcher.find()) {
        String imgSrc = matcher.group(2).trim();
        String testda = URLDecoder.decode(imgSrc, StandardCharsets.UTF_8);
        String[] imgSrcArr = testda.split("\\\\");
        String filePath = realRoot + imgSrcArr[imgSrcArr.length - 1];
        File file = new File(filePath);
        if (file.exists()) {
          file.delete();
        }
      }
    } catch (Exception e) {
      System.out.print(e);
    }
    return returnData;
  }

  @Transactional
  public int deleteErrorImageList(ArrayList<Object> map) throws Exception {
    int result = 0;
    try {
      for (Object key : map) {// 빈값 null 변경
        Map<String, Object> row = (Map<String, Object>) key;
        result += errorMapper.deleteErrorImageList(row);
      }
    } catch (Exception e) {
      // 예외 처리
      e.printStackTrace();
    }
    return result;
  }

}
