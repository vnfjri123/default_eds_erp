package com.springboot.myapp.eds.erp.controller.archive;

import com.springboot.myapp.eds.erp.vo.archive.archiveFileVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveThumVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveVideoVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FilenameUtils;
import org.apache.xalan.xsltc.dom.SortingIterator;
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

@Service
public class archiveService {
  private int archiveiIndex;
  @Autowired
  private archiveMapper archiveMapper;

  @Value("${eds.backs.file.path}")
  private String realPath;

  public List<archiveVO> selectArchive(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("secretKey", aes256Util.getKey());
    List<archiveVO> result = archiveMapper.selectArchive(map);
    return result;
  }

  public int readArchive(Map<String, Object> map) throws Exception {
    return archiveMapper.readArchive(map);
  }

//  public int insertArchive(Map<String, Object> map) throws Exception {
//    map.put("userId", SessionUtil.getUser().getEmpCd());
//    return archiveMapper.insertArchive(map);
//  }

  public List<archiveVideoVO> selectArchiveVideo(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<archiveVideoVO> result = archiveMapper.selectArchiveVideo(map);
    return result;
  }

  public List<archiveThumVO> selectArchiveThum(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<archiveThumVO> result = archiveMapper.selectArchiveThum(map);
    return result;
  }

  public List<archiveFileVO> selectArchiveFiles(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<archiveFileVO> result = archiveMapper.selectArchiveFiles(map);
    return result;
  }

  public int insertArchive(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return archiveMapper.insertArchive(map);
  }

  @Transactional
  public int insertArchiveFiles(Map<String, Object> map, List<MultipartFile> video, List<MultipartFile> thumbnail, List<MultipartFile> files) throws Exception {
    System.out.println("인설트 서비스");
    System.out.println(map);
    StringBuilder response = new StringBuilder();
    int result = 0;
    AES256Util aes256Util = new AES256Util();
    String corpCd = SessionUtil.getUser().getCorpCd();
    String empCd = SessionUtil.getUser().getEmpCd();
    String empNm = SessionUtil.getUser().getEmpNm();
    String path = realPath;

    // video 처리
    if (video != null && !video.isEmpty()) {
      String pathParam = "archiveVideo";
      for (MultipartFile file : video) {
        processFile(file, path, pathParam, corpCd, empCd, empNm, aes256Util, map, response, result);
      }
    }

    // thumbnail 처리
    if (thumbnail != null && !thumbnail.isEmpty()) {
      String pathParam = "archiveThumbnail";
      for (MultipartFile file : thumbnail) {
        processFile(file, path, pathParam, corpCd, empCd, empNm, aes256Util, map, response, result);
      }
    }

    // files 처리
    if (files != null && !files.isEmpty()) {
      String pathParam = "archiveFiles";
      for (MultipartFile file : files) {
        processFile(file, path, pathParam, corpCd, empCd, empNm, aes256Util, map, response, result);
      }
    }

    return result;
  }

  private void processFile(MultipartFile file, String path, String pathParam, String corpCd, String empCd, String empNm, AES256Util aes256Util, Map<String, Object> map, StringBuilder response, int result) {
    try {
      path+="file\\";     final File fileDir = new File(path);
      path+=corpCd+"\\";  final File corpDir = new File(path);
      path+="erp\\";    final File projectDir = new File(path);
      path+="0001"+"\\"+pathParam+"\\";
      final File empCdDir = new File(path);
      if(!fileDir.exists()){ fileDir.mkdir();}
      if(!corpDir.exists()){ corpDir.mkdir();}
      if(!projectDir.exists()){ projectDir.mkdir();}
      if(!empCdDir.exists()){ empCdDir.mkdir();}

      if (file.isEmpty()) {
        response.append("Failed to upload ").append(file.getOriginalFilename());
      } else {
        SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
        String saveNm = seventeenFormat.format(new Date()) + Util.removeMinusChar(UUID.randomUUID().toString());
        String origNm = FilenameUtils.getBaseName(file.getOriginalFilename());
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        byte[] bytes = file.getBytes();

        Path filePath = Paths.get(path + saveNm + "." + ext);
        Files.write(filePath, bytes);

        Map<String, Object> test = new HashMap<>();
        test.put("corpCd", map.get("corpCd"));
        test.put("busiCd", map.get("busiCd"));
        if (map.get("archiveIndex") == null) {
          test.put("archiveIndex", archiveiIndex);
        } else {
          test.put("archiveIndex", map.get("archiveIndex"));
        }
        test.put("saveNm", saveNm);
        test.put("origNm", origNm);
        test.put("saveRoot", path + saveNm + "." + ext);
        test.put("ext", ext);
        test.put("size", file.getSize());
        test.put("userId", empCd);
        test.put("empNm", empNm);
        test.put("secretKey", aes256Util.getKey());
        if (path.contains("archiveVideo")) {
          result += archiveMapper.insertArchiveVideo(test);
        }
        if (path.contains("archiveThumbnail")) {
          result += archiveMapper.insertArchiveThumbnail(test);
        }
        if (path.contains("archiveFiles")) {
          result += archiveMapper.insertArchiveFiles(test);
        }
        response.append("Successfully uploaded ").append(file.getOriginalFilename()).append(". ");
      }
    } catch (Exception e) {
      response.append("Failed to upload ").append(file.getOriginalFilename()).append(" due to an error: ").append(e.getMessage());
    }
  }

//  @Transactional
//  public int insertArchiveThumbnail(Map<String, Object> map, List<MultipartFile> files) throws Exception {
//    StringBuilder response = new StringBuilder();
//    int result=0;
//    AES256Util aes256Util = new AES256Util();
//    String corpCd = SessionUtil.getUser().getCorpCd();
//    String empCd = SessionUtil.getUser().getEmpCd();
//    String empNm = SessionUtil.getUser().getEmpNm();
//    try {
//      String path = realPath;
//      /* 파일 경로 확인 및 생성*/
//      path+="file\\";     final File fileDir = new File(path);
//      path+=corpCd+"\\";  final File corpDir = new File(path);
//      path+="erp\\";    final File projectDir = new File(path);
//      path+="0001"+"\\"+"archiveThumbnail\\";
//      final File empCdDir = new File(path);
//      if(!fileDir.exists()){ fileDir.mkdir();}
//      if(!corpDir.exists()){ corpDir.mkdir();}
//      if(!projectDir.exists()){ projectDir.mkdir();}
//      if(!empCdDir.exists()){ empCdDir.mkdir();}
//      for (MultipartFile file : files) {
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
//            String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
//            String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
//            String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
//            byte[] bytes = file.getBytes();
//
//            Path filePath = Paths.get(path + saveNm+"."+ext);
//            Files.write(filePath, bytes);
//            /* 첨부파일 db 저장을 위한 파라미터 세팅*/
//            Map<String, Object> test = new HashMap<String, Object>();
//            test.put("corpCd",map.get("corpCd"));
//            test.put("busiCd",map.get("busiCd"));
//            if (map.get("archiveIndex") == null) {
//              test.put("archiveIndex", archiveiIndex);
//            } else {
//              test.put("archiveIndex", map.get("archiveIndex"));
//            }
//            test.put("saveNm",saveNm);
//            test.put("origNm",origNm);
//            test.put("saveRoot",path+saveNm+"."+ext);
//            test.put("ext",ext);
//            test.put("size",file.getSize());
//            test.put("userId",empCd);
//            test.put("empNm",empNm);
//            test.put("secretKey", aes256Util.getKey());
//            result+=archiveMapper.insertArchiveThumbnail(test);
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
//        }
//      }
//    } catch (Exception e) {
//      // TODO: handle exception
//    }
//
//    return result;
//  }
//
//  @Transactional
//  public int insertArchiveFiles(Map<String, Object> map, List<MultipartFile> files) throws Exception {
//    StringBuilder response = new StringBuilder();
//    int result=0;
//    AES256Util aes256Util = new AES256Util();
//    String corpCd = SessionUtil.getUser().getCorpCd();
//    String empCd = SessionUtil.getUser().getEmpCd();
//    String empNm = SessionUtil.getUser().getEmpNm();
//    try {
//      String path = realPath;
//      /* 파일 경로 확인 및 생성*/
//      path+="file\\";     final File fileDir = new File(path);
//      path+=corpCd+"\\";  final File corpDir = new File(path);
//      path+="erp\\";    final File projectDir = new File(path);
//      path+="0001"+"\\"+"archiveFiles\\";
//      final File empCdDir = new File(path);
//      if(!fileDir.exists()){ fileDir.mkdir();}
//      if(!corpDir.exists()){ corpDir.mkdir();}
//      if(!projectDir.exists()){ projectDir.mkdir();}
//      if(!empCdDir.exists()){ empCdDir.mkdir();}
//      for (MultipartFile file : files) {
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
//            String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
//            String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
//            String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
//            byte[] bytes = file.getBytes();
//
//            Path filePath = Paths.get(path + saveNm+"."+ext);
//            Files.write(filePath, bytes);
//            /* 첨부파일 db 저장을 위한 파라미터 세팅*/
//            Map<String, Object> test = new HashMap<String, Object>();
//            test.put("corpCd",map.get("corpCd"));
//            test.put("busiCd",map.get("busiCd"));
//            if (map.get("archiveIndex") == null) {
//              test.put("archiveIndex", archiveiIndex);
//            } else {
//              test.put("archiveIndex", map.get("archiveIndex"));
//            }
//            test.put("saveNm",saveNm);
//            test.put("origNm",origNm);
//            test.put("saveRoot",path+saveNm+"."+ext);
//            test.put("ext",ext);
//            test.put("size",file.getSize());
//            test.put("userId",empCd);
//            test.put("empNm",empNm);
//            test.put("secretKey", aes256Util.getKey());
//            result+=archiveMapper.insertArchiveFiles(test);
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
//        }
//      }
//    } catch (Exception e) {
//      // TODO: handle exception
//    }
//
//    return result;
//  }

  @Transactional
  public int updateArchiveThumbnail(List<MultipartFile> files, Map<String, Object> map) throws Exception {
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
      path+="0001"+"\\"+"archiveThum\\";
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
            test.put("archiveIndex",map.get("archiveIndex"));
            test.put("saveNm",saveNm);
            test.put("origNm",origNm);
            test.put("saveRoot",path+saveNm+"."+ext);
            test.put("ext",ext);
            test.put("size",file.getSize());
            test.put("userId",empCd);
            test.put("empNm",empNm);
            test.put("secretKey", aes256Util.getKey());
            result+=archiveMapper.updateArchiveThumbnail(test);
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

  public int updateArchive(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return archiveMapper.updateArchive(map);
  }

//  public int updateArchive(List<MultipartFile> files, Map<String, Object> map) throws Exception {
//    Map<String, Object> test = new HashMap<String, Object>();
//    StringBuilder response = new StringBuilder();
//    int result=0;
//    AES256Util aes256Util = new AES256Util();
//    String corpCd = SessionUtil.getUser().getCorpCd();
//    String empCd = SessionUtil.getUser().getEmpCd();
//    String empNm = SessionUtil.getUser().getEmpNm();
//    if (files == null) {
////      map.put("userId", SessionUtil.getUser().getEmpCd());
//
//      test.put("corpCd",map.get("corpCd"));
//      test.put("busiCd",map.get("busiCd"));
//      test.put("index",map.get("index"));
//      test.put("title",map.get("title"));
//      test.put("content",map.get("content"));
//      test.put("userId",SessionUtil.getUser().getEmpCd());
//
//      result += archiveMapper.updateArchive(test);
//    } else {
//      try {
//        String path = realPath;
//        /* 파일 경로 확인 및 생성*/
//        path+="file\\";     final File fileDir = new File(path);
//        path+=corpCd+"\\";  final File corpDir = new File(path);
//        path+="erp\\";    final File projectDir = new File(path);
//        path+="0001"+"\\"+"archive\\";
//        final File empCdDir = new File(path);
//        if(!fileDir.exists()){ fileDir.mkdir();}
//        if(!corpDir.exists()){ corpDir.mkdir();}
//        if(!projectDir.exists()){ projectDir.mkdir();}
//        if(!empCdDir.exists()){ empCdDir.mkdir();}
//        for (MultipartFile file : files) {
//          if (file.isEmpty()) {
//            response.append("Failed to upload ")
//                    .append(file.getOriginalFilename());
//          }
//          else {
//            try
//            {
//              /* 랜덤 저장 명 파라미터 생성*/
//              SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
//              /* 첨부파일 생성 */
//
//              String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
//              String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
//              String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
//              byte[] bytes = file.getBytes();
//
//              Path filePath = Paths.get(path + saveNm+"."+ext);
//              Files.write(filePath, bytes);
//              /* 첨부파일 db 저장을 위한 파라미터 세팅*/
//              test.put("corpCd",map.get("corpCd"));
//              test.put("busiCd",map.get("busiCd"));
//              test.put("index",map.get("index"));
//              test.put("title",map.get("title"));
//              test.put("content",map.get("content"));
//              test.put("saveNm",saveNm);
//              test.put("origNm",origNm);
//              test.put("saveRoot",path+saveNm+"."+ext);
//              test.put("ext",ext);
//              test.put("size",file.getSize());
//              test.put("userId",SessionUtil.getUser().getEmpCd());
//              test.put("empNm",empNm);
//              test.put("secretKey", aes256Util.getKey());
//
////              map.put("userId", SessionUtil.getUser().getEmpCd());
////              map.put("saveNm",saveNm);
////              map.put("origNm",origNm);
////              map.put("saveRoot",path+saveNm+"."+ext);
////              map.put("saveRoot", Paths.get(path, saveNm + "." + ext).toString());
////              map.put("ext",ext);
////              map.put("size",file.getSize());
////              map.put("secretKey", aes256Util.getKey());
//
////              result += archiveMapper.updateArchive(map);
//              result += archiveMapper.updateArchive(test);
//              response.append("Successfully uploaded ")
//                      .append(file.getOriginalFilename())
//                      .append(". ");
//            }
//            catch (IOException e) {
//              response.append("Failed to upload ")
//                      .append(file.getOriginalFilename())
//                      .append(" due to an error: ")
//                      .append(e.getMessage());
//            }
//          }
//        }
//      } catch (Exception e) {
//        // TODO: handle exception
//      }
//    }
//    return result;
//  }

  public int deleteArchive(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return archiveMapper.deleteArchive(map);
  }

//  public int deleteFiles(Map<String, Object> map) throws Exception {
//    System.out.println("딜리트 서비스");
//    System.out.println(map);
//    return 0;
//  }

  public int deleteFiles(Map<String, Object> map) throws Exception {
    int result=0;
    List<String> removedVideo = (List<String>) map.get("removedVideo");
    List<String> removedThumbnail = (List<String>) map.get("removedTumbnail");
    List<String> removedFiles = (List<String>) map.get("removedFiles");
    List<String> fileIndexes = (List<String>) map.get("index");

    if (removedVideo != null && !removedVideo.contains(null)){
      map.put("videoIndex", removedVideo.get(0));
      Files.delete(Paths.get(removedVideo.get(1)));
      result += archiveMapper.deleteVideo(map);
    }
    if (removedThumbnail != null && !removedThumbnail.contains(null)) {
      map.put("thumbnailIndex", removedThumbnail.get(0));
      Files.delete(Paths.get(removedThumbnail.get(1)));
      result += archiveMapper.deleteThumbnail(map);
    }
    if (removedFiles != null && !removedFiles.contains(null)) {
      for (int i = 0; i < removedFiles.size(); i++) {
        String file = removedFiles.get(i);
        String index = fileIndexes != null ? fileIndexes.get(i) : null;
        Files.delete(Paths.get(file));
        if (index != null) {
          map.put("fileIndex", index);
          result += archiveMapper.deleteFiles(map);
        }
      }
    }
    return result;
  }

//  public int deleteFiles(Map<String, Object> map) throws Exception {
//    int result=0;
//    List<String> removedVideo = (List<String>) map.get("removedVideo");
//    List<String> removedThumbnail = (List<String>) map.get("removedTumbnail");
//    List<String> removedFiles = (List<String>) map.get("removedFiles");
//    List<String> fileIndexes = (List<String>) map.get("index");
//    System.out.println("리스트 확인");
////    System.out.println(removedVideo);
//    System.out.println(removedThumbnail);
//    System.out.println(removedThumbnail != null || !removedThumbnail.contains(null));
////    System.out.println(removedFiles);
////
////    System.out.println("리스트 조건 확인");
////    System.out.println(removedThumbnail != null);
////    System.out.println(!removedThumbnail.isEmpty() || removedThumbnail != null);
////    System.out.println(!removedVideo.contains(null));
////    System.out.println(removedThumbnail != null);
////    System.out.println(!removedFiles.contains(null));
//
//    if (!removedVideo.contains(null)){
//      map.put("videoIndex", removedVideo.get(0));
//      map.put("removedVideoFlag","true");
//      Files.delete(Paths.get(removedVideo.get(1)));
//      result += archiveMapper.deleteFiles(map);
//    }
//    if (removedThumbnail != null || !removedThumbnail.contains(null)) {
//      System.out.println("썸네일 지우기 실행");
//      map.put("thumbnailIndex", removedThumbnail.get(0));
//      System.out.println("map 확인");
//      System.out.println(map);
//      map.put("removedThumbnailFlag", "true");
//      System.out.println("1번 인덱스 확인");
//      System.out.println(removedThumbnail.get(1));
//      Files.delete(Paths.get(removedThumbnail.get(1)));
//      result += archiveMapper.deleteFiles(map);
//      System.out.println("썸네일 지우기 끝");
//    }
//    if (!removedFiles.contains(null)) {
//      for (int i = 0; i < removedFiles.size(); i++) {
//        String file = removedFiles.get(i);
//        String index = fileIndexes.get(i);
//
//        Files.delete(Paths.get(file));
//        map.put("removedFilesFlag", "true");
//        map.put("fileIndex", index);
//
//        result += archiveMapper.deleteFiles(map);
//      }
//    }
//
//    return result;
//  }

  public int deleteArchiveFile(ArrayList<Object> map) throws Exception {
    int result=0;
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return result;
  }

  public int deleteArchiveImageList(ArrayList<Object> map) throws Exception {
    int result=0;
    try {
      for( Object key :map){//빈값 null 변경
        Map<String, Object> row= (Map<String, Object>) key;
        if ((row.get("updateFlag") == null)) {
          result+=archiveMapper.deleteArchiveImageList(row);
        }
        String path = row.get("saveRoot").toString();
        Files.delete(Paths.get(path));
      }
    } catch (Exception e) {

    }
    return result;
  }

}
