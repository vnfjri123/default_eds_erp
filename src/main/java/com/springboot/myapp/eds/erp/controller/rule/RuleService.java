package com.springboot.myapp.eds.erp.controller.rule;

import com.ctc.wstx.sw.SimpleOutputElement;
import com.springboot.myapp.eds.erp.vo.archive.archiveThumVO;
import com.springboot.myapp.eds.erp.vo.rule.RuleFileVO;
import com.springboot.myapp.eds.erp.vo.rule.RuleVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeVO;
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
public class RuleService {

  @Autowired
  private RuleMapper ruleMapper;

  @Value("${eds.backs.file.path}")
  private String realPath;

  public List<RuleVO> selectRule(Map<String, Object> map) throws Exception {
    List<RuleVO> result = ruleMapper.selectRule(map);
    return result;
  }

  public List<RuleFileVO> selectRuleFile(Map<String, Object> map) throws Exception {
    AES256Util aes256Util = new AES256Util();
    map.put("depaCd", SessionUtil.getUser().getDepaCd());
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("secretKey", aes256Util.getKey());
    List<RuleFileVO> result = ruleMapper.selectRuleFile(map);
    return result;
  }

  public List<RuleVO> selectUserInfo(Map<String, Object> map) throws Exception {
    System.out.println("유저 인포 서비스");
    System.out.println(map);
    List<RuleVO> result = ruleMapper.selectUserInfo(map);
    return result;
  }

  public int insertRule(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return ruleMapper.insertRule(map);
  }

  @Transactional
  public int insertRuleFile(List<MultipartFile> files, Map<String, Object> map) throws Exception {
    System.out.println("파일 서비스 실행");
    System.out.println("files");
    System.out.println(files);
    System.out.println("map");
    System.out.println(map);
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
      path+="0001"+"\\"+"ruleFiles\\";
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
//            /* 첨부파일 db 저장을 위한 파라미터 세팅*/
            Map<String, Object> test = new HashMap<String, Object>();
            test.put("corpCd",map.get("corpCd"));
            test.put("busiCd",map.get("busiCd"));
            test.put("ruleIndex",map.get("ruleIndex"));
            test.put("saveNm",saveNm);
            test.put("origNm",origNm);
            test.put("saveRoot",path+saveNm+"."+ext);
            test.put("ext",ext);
            test.put("size",file.getSize());
            test.put("userId",empCd);
            test.put("empNm",empNm);
            test.put("secretKey", aes256Util.getKey());
            result+=ruleMapper.insertRuleFile(test);
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

  public int updateRule(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return ruleMapper.updateRule(map);
  }

  @Transactional
  public int updateRuleFile(List<MultipartFile> files, Map<String, Object> map) throws Exception {
    System.out.println("수정 서비스 시작함");
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
      path+="0001"+"\\"+"ruleFiles\\";
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
            test.put("ruleIndex",map.get("index"));
            test.put("saveNm",saveNm);
            test.put("origNm",origNm);
            test.put("saveRoot",path+saveNm+"."+ext);
            test.put("ext",ext);
            test.put("size",file.getSize());
            test.put("userId",empCd);
            test.put("empNm",empNm);
            test.put("secretKey", aes256Util.getKey());
            System.out.println("test 확인");
            System.out.println(test);
            result+=ruleMapper.updateRuleFile(test);
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

  public int updateRead(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return ruleMapper.updateRead(map);
  }

  public int readRule(Map<String, Object> map) throws Exception {
    return ruleMapper.readRule(map);
  }

  public int deleteRule(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    String corpCd = SessionUtil.getUser().getCorpCd();
    String path = realPath;
    /* 파일 경로 확인 및 생성*/
    path+="file\\";     final File fileDir = new File(path);
    path+=corpCd+"\\";  final File corpDir = new File(path);
    path+="erp\\";    final File projectDir = new File(path);
    path+="0001"+"\\"+"ruleFiles\\";

    String filePath = path + map.get("saveNm");
    System.out.println("파일 확인");
    System.out.println(filePath);
    if (Files.exists(Paths.get(filePath))) {
      Files.delete(Paths.get(filePath));
    }

    System.out.println("딜리트 시작");
    System.out.println(map);
    return ruleMapper.deleteRule(map);
  }

  public int deleteRuleFile(ArrayList<Object> map) throws Exception {
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

}
