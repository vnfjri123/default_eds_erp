package com.springboot.myapp.eds.erp.controller.archive;

import com.springboot.myapp.eds.erp.vo.archive.archiveThumVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveVO;
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

@Service
public class archiveService {
  private int archiveiIndex;
  @Autowired
  private archiveMapper archiveMapper;

  @Value("${eds.backs.file.path}")
  private String realPath;

  public List<archiveVO> selectArchive(Map<String, Object> map) throws Exception {
    List<archiveVO> result = archiveMapper.selectArchive(map);
    return result;
  }

//  public int insertArchive(Map<String, Object> map) throws Exception {
//    map.put("userId", SessionUtil.getUser().getEmpCd());
//    return archiveMapper.insertArchive(map);
//  }

  public List<archiveThumVO> selectArchiveThum(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<archiveThumVO> result = archiveMapper.selectArchiveThum(map);
    return result;
  }

  public int insertArchive(List<MultipartFile> files, Map<String, Object> map) throws Exception {
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
      path+="0001"+"\\"+"archive\\";
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
//            test.put("noticeIndex",map.get("noticeIndex"));
            test.put("saveNm",saveNm);
            test.put("origNm",origNm);
            test.put("saveRoot",path+saveNm+"."+ext);
            test.put("ext",ext);
            test.put("size",file.getSize());
            test.put("userId",empCd);
//            test.put("empNm",empNm);
            test.put("secretKey", aes256Util.getKey());
            test.put("title", map.get("title"));
            test.put("content", map.get("content"));
            test.put("depaCd", map.get("depaCd"));
            test.put("depaNm", map.get("depaNm"));
            result+=archiveMapper.insertArchive(test);
            archiveiIndex = (int) test.get("archiveIndex");
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
  public int insertArchiveFile(List<MultipartFile> files, Map<String, Object> map) throws Exception {
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
            if (map.get("archiveIndex") == null) {
              test.put("archiveIndex", archiveiIndex);
            } else {
              test.put("archiveIndex", map.get("archiveIndex"));
            }
            test.put("saveNm",saveNm);
            test.put("origNm",origNm);
            test.put("saveRoot",path+saveNm+"."+ext);
            test.put("ext",ext);
            test.put("size",file.getSize());
            test.put("userId",empCd);
            test.put("empNm",empNm);
            test.put("secretKey", aes256Util.getKey());
            result+=archiveMapper.insertArchiveFile(test);
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
  public int updateArchiveFile(List<MultipartFile> files, Map<String, Object> map) throws Exception {
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
            result+=archiveMapper.updateArchiveFile(test);
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

  public int updateArchive(List<MultipartFile> files, Map<String, Object> map) throws Exception {
    Map<String, Object> test = new HashMap<String, Object>();
    StringBuilder response = new StringBuilder();
    int result=0;
    AES256Util aes256Util = new AES256Util();
    String corpCd = SessionUtil.getUser().getCorpCd();
    String empCd = SessionUtil.getUser().getEmpCd();
    String empNm = SessionUtil.getUser().getEmpNm();
    if (files == null) {
//      map.put("userId", SessionUtil.getUser().getEmpCd());

      test.put("corpCd",map.get("corpCd"));
      test.put("busiCd",map.get("busiCd"));
      test.put("index",map.get("index"));
      test.put("title",map.get("title"));
      test.put("content",map.get("content"));
      test.put("userId",SessionUtil.getUser().getEmpCd());

      result += archiveMapper.updateArchive(test);
    } else {
      try {
        String path = realPath;
        /* 파일 경로 확인 및 생성*/
        path+="file\\";     final File fileDir = new File(path);
        path+=corpCd+"\\";  final File corpDir = new File(path);
        path+="erp\\";    final File projectDir = new File(path);
        path+="0001"+"\\"+"archive\\";
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
              test.put("corpCd",map.get("corpCd"));
              test.put("busiCd",map.get("busiCd"));
              test.put("index",map.get("index"));
              test.put("title",map.get("title"));
              test.put("content",map.get("content"));
              test.put("saveNm",saveNm);
              test.put("origNm",origNm);
              test.put("saveRoot",path+saveNm+"."+ext);
              test.put("ext",ext);
              test.put("size",file.getSize());
              test.put("userId",SessionUtil.getUser().getEmpCd());
              test.put("empNm",empNm);
              test.put("secretKey", aes256Util.getKey());

//              map.put("userId", SessionUtil.getUser().getEmpCd());
//              map.put("saveNm",saveNm);
//              map.put("origNm",origNm);
//              map.put("saveRoot",path+saveNm+"."+ext);
//              map.put("saveRoot", Paths.get(path, saveNm + "." + ext).toString());
//              map.put("ext",ext);
//              map.put("size",file.getSize());
//              map.put("secretKey", aes256Util.getKey());

//              result += archiveMapper.updateArchive(map);
              result += archiveMapper.updateArchive(test);
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
    }
    return result;
  }

  public int deleteArchive(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return archiveMapper.deleteArchive(map);
  }

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
