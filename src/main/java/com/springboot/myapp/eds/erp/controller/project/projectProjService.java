package com.springboot.myapp.eds.erp.controller.project;

import com.springboot.myapp.eds.erp.controller.email.emailMapper;
import com.springboot.myapp.eds.erp.vo.email.emailFileVO;
import com.springboot.myapp.eds.erp.vo.project.*;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import jakarta.mail.internet.MimeBodyPart;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class projectProjService {

    @Autowired
    private projectProjMapper projectProjMapper;

    @Autowired
    private emailMapper emailMapper;

    @Value("${eds.backs.file.path}")
    private String realPath;

    public List<projectProjListVO> selectProjMgtList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjListVO> result = projectProjMapper.selectProjMgtList(map);
        return result;
    }

    public List<projectProjSchListVO> selectProjSchList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjSchListVO> result = projectProjMapper.selectProjSchList(map);
        return result;
    }

    public List<projectProjItemListVO> selectProjItemList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjItemListVO> result = projectProjMapper.selectProjItemList(map);
        return result;
    }

    public List<projectProjPartListVO> selectProjPartList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjPartListVO> result = projectProjMapper.selectProjPartList(map);
        return result;
    }

    public List<projectProjFileListVO> selectProjFileList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());

        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjFileListVO> result = projectProjMapper.selectProjFileList(map);
        return result;
    }

    public List<projectProjCostListVO> selectProjCostList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjCostListVO> result = projectProjMapper.selectProjCostList(map);
        return result;
    }

    public List<projectProjMemoListVO> selectProjMemoList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjMemoListVO> result = projectProjMapper.selectProjMemoList(map);
        return result;
    }

    public List<projectProjCostListVO> selectProjCostTot(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjCostListVO> result = projectProjMapper.selectProjCostTot(map);
        return result;
    }

    public List<projectProjCostListVO> selectProjCostDet(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjCostListVO> result = projectProjMapper.selectProjCostDet(map);
        return result;
    }

    public List<projectProjCompListVO> selectProjCompMgtList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjCompListVO> result = projectProjMapper.selectProjCompMgtList(map);
        return result;
    }

    public List<projectProjCompPartListVO> selectProjCompPartList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjCompPartListVO> result = projectProjMapper.selectProjCompPartList(map);
        return result;
    }

    public List<projectProjCompCostListVO> selectProjCompCostList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<projectProjCompCostListVO> result = projectProjMapper.selectProjCompCostList(map);
        return result;
    }

    public int insertProjMgtList(Map<String, Object> map) throws Exception {
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjMgtList(map);
    }

    public int insertProjItemList(Map<String, Object> map) throws Exception {
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjItemList(map);
    }

    public int insertProjPartList(Map<String, Object> map) throws Exception {
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjPartList(map);
    }

    public Map<String, Object> insertProjFileList(MultipartHttpServletRequest mtfRequest) throws Exception {

        /**
         * 클라이언트 리턴 데이터
         * */
        Map<String, Object> returnData = new HashMap<String, Object>();

        try {
            // 파라미터세팅
            AES256Util aes256Util = new AES256Util();

            String corpCd = SessionUtil.getUser().getCorpCd();
            String empCd = SessionUtil.getUser().getEmpCd();

            String estCd = mtfRequest.getParameter("estCd");
            String projCd = mtfRequest.getParameter("projCd");

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
            path+="project\\";    final File projectDir = new File(path);
            path+=empCd+"\\";   final File empCdDir = new File(path);

            /* 이메일 첨부파일 이 존재할 시 실행 */
            if(fileListSize > 0){

                if(!fileDir.exists()){ fileDir.mkdir();}
                if(!corpDir.exists()){ corpDir.mkdir();}
                if(!projectDir.exists()){ projectDir.mkdir();}
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
                    map.put("corpCd",SessionUtil.getUser().getCorpCd());
                    map.put("busiCd",SessionUtil.getUser().getBusiCd());
                    map.put("estCd",estCd);
                    map.put("projCd",projCd);
                    map.put("saveNm",saveNm);
                    map.put("origNm",origNm);
                    map.put("saveRoot",path+saveNm+"."+ext);
                    map.put("ext",ext);
                    map.put("size",realFile.length());
                    map.put("depaCd", SessionUtil.getUser().getDepaCd());
                    map.put("empCd", SessionUtil.getUser().getEmpCd());
                    map.put("userId",empCd);
                    map.put("secretKey", aes256Util.getKey());
                    projectProjMapper.insertProjFileList(map);
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

    public int insertProjCostList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjCostList(map);
    }

    public int insertProjMemoList(Map<String, Object> map) throws Exception {
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjMemoList(map);
    }

    public int insertProjCompMgtList(Map<String, Object> map) throws Exception {
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjCompMgtList(map);
    }

    public int insertProjCompPartList(Map<String, Object> map) throws Exception {
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjCompPartList(map);
    }

    public int insertProjCompCostList(Map<String, Object> map) throws Exception {
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.insertProjCompCostList(map);
    }

    public int updateProjMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());

        map.put("supAmt", String.valueOf(map.get("supAmt")).replaceAll("[^0-9]",""));
        map.put("vatAmt", String.valueOf(map.get("vatAmt")).replaceAll("[^0-9]",""));
        map.put("totAmt", String.valueOf(map.get("totAmt")).replaceAll("[^0-9]",""));
        map.put("supAmt2", String.valueOf(map.get("supAmt2")).replaceAll("[^0-9]",""));
        map.put("vatAmt2", String.valueOf(map.get("vatAmt2")).replaceAll("[^0-9]",""));
        map.put("totAmt2", String.valueOf(map.get("totAmt2")).replaceAll("[^0-9]",""));
        map.put("supAmt3", String.valueOf(map.get("supAmt3")).replaceAll("[^0-9]",""));
        map.put("vatAmt3", String.valueOf(map.get("vatAmt3")).replaceAll("[^0-9]",""));
        map.put("totAmt3", String.valueOf(map.get("totAmt3")).replaceAll("[^0-9]",""));
        map.put("supAmt4", String.valueOf(map.get("supAmt4")).replaceAll("[^0-9]",""));
        map.put("vatAmt4", String.valueOf(map.get("vatAmt4")).replaceAll("[^0-9]",""));
        map.put("totAmt4", String.valueOf(map.get("totAmt4")).replaceAll("[^0-9]",""));
        map.put("supAmt5", String.valueOf(map.get("supAmt5")).replaceAll("[^0-9]",""));
        map.put("vatAmt5", String.valueOf(map.get("vatAmt5")).replaceAll("[^0-9]",""));
        map.put("totAmt5", String.valueOf(map.get("totAmt5")).replaceAll("[^0-9]",""));

        return projectProjMapper.updateProjMgtList(map);
    }

    public int updateProjItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjItemList(map);
    }

    public int updateProjPartList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjPartList(map);
    }

    public int updateProjFileList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjFileList(map);
    }

    public int updateProjCostList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjCostList(map);
    }

    public int updateProjMemoList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjMemoList(map);
    }

    public int updateProjCompMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjCompMgtList(map);
    }

    public int updateProjCompPartList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjCompPartList(map);
    }

    public int updateProjCompCostList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return projectProjMapper.updateProjCompCostList(map);
    }

    public int deleteProjMgtList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjMgtList(map);
    }

    public int deleteProjItemList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjItemList(map);
    }

    public int deleteProjPartList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjPartList(map);
    }

    public int deleteProjFileList(Map<String, Object> map) throws Exception {

        /**
         * 클라이언트 리턴 데이터
         * */
        int returnData = 0;

        try {
            /* 서버 파일 삭제 */
            AES256Util aes256Util = new AES256Util();
            map.put("secretKey", aes256Util.getKey());
            map.put("authDivi", SessionUtil.getUser().getAuthDivi());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());
            map.put("empCd", SessionUtil.getUser().getEmpCd());

            List<projectProjFileListVO> result = projectProjMapper.selectProjFileList(map);
            int resultSize = result.size();
            File file = null;
            for (int i = 0; i < resultSize; i++) {
                file = new File(String.valueOf(Paths.get(result.get(i).getSaveRoot())));
                /* 실제 파일 삭제 */
                if(file.exists()) Files.delete(Paths.get(result.get(i).getSaveRoot()));
                /* DB 파일 삭제 */
                projectProjMapper.deleteProjFileList(map);
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

    public int deleteProjCostList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjCostList(map);
    }

    public int deleteProjMemoList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjMemoList(map);
    }

    public int deleteProjEmailList(Map<String, Object> map) throws Exception {
        
        try {
            /* 서버 파일 삭제 */
            AES256Util aes256Util = new AES256Util();
            map.put("secretKey", aes256Util.getKey());
            map.put("emailSeq",map.get("seq"));
            map.put("authDivi", SessionUtil.getUser().getAuthDivi());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());
            map.put("empCd", SessionUtil.getUser().getEmpCd());
            map.put("divi", "project");

            List<emailFileVO> result = emailMapper.selectSendEmailFileInfo(map);
            int resultSize = result.size();
            for (int i = 0; i < resultSize; i++) {
                Files.delete(Paths.get(result.get(i).getSaveRoot()));
            }

        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.toString());
        }

        /* DB 파일 삭제 */
        return projectProjMapper.deleteProjEmailList(map);
    }

    public int deleteProjCompMgtList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjCompMgtList(map);
    }

    public int deleteProjCompPartList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjCompPartList(map);
    }

    public int deleteProjCompCostList(Map<String, Object> map) throws Exception {
        return projectProjMapper.deleteProjCompCostList(map);
    }

    public int aEstMgtList(Map<String, Object> map) throws Exception {

        int returnData = 0;

        try{
            map.put("depaCd", SessionUtil.getUser().getDepaCd());
            map.put("empCd", SessionUtil.getUser().getEmpCd());
            map.put("userId", SessionUtil.getUser().getEmpCd());

            /* 프로젝트 전표 생성*/
            projectProjMapper.aEstMgtList(map);
            String projCd = (String) map.get("projCd");

            /* 프로젝트  품목 추가*/
            map.put("projCd", projCd);
            projectProjMapper.aEstItemList(map);

            returnData = 1;

        }catch (Exception e){

            String exc = e.toString();
            System.out.println(exc);
            e.printStackTrace();
            returnData = 0;

        }

        return returnData;
    }

    public int deadLineProjMgtList(Map<String, Object> map) throws Exception {

        int returnData = 0;
        try {

            List saveData = (List) map.get("data");

            for (int i = 0; i < saveData.size(); i++) {projectProjMapper.deadLineProjMgtList((Map) saveData.get(i));}

            returnData = 1;
        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.toString());
            returnData = 0;
        }

        return returnData;

    }

    @Transactional
    public Map<String, Object> cudProjMgtList2(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            Map<String, Object> form = (Map<String, Object>) map.get("formData");

            form.put("userId", SessionUtil.getUser().getEmpCd());
            form.put("cntDt", Util.removeMinusChar((String) form.get("cntDt")));
            form.put("initiateDt", Util.removeMinusChar((String) form.get("initiateDt")));
            form.put("dueDt", Util.removeMinusChar((String) form.get("dueDt")));
            form.put("estDt", Util.removeMinusChar((String) form.get("estDt")));
            form.put("endDt", Util.removeMinusChar((String) form.get("endDt")));
            form.put("validDt", Util.removeMinusChar((String) form.get("validDt"))); // 여기

            form.put("supAmt", String.valueOf(form.get("supAmt")).replaceAll("[^0-9]",""));
            form.put("vatAmt", String.valueOf(form.get("vatAmt")).replaceAll("[^0-9]",""));
            form.put("totAmt", String.valueOf(form.get("totAmt")).replaceAll("[^0-9]",""));
            form.put("supAmt2", String.valueOf(form.get("supAmt2")).replaceAll("[^0-9]",""));
            form.put("vatAmt2", String.valueOf(form.get("vatAmt2")).replaceAll("[^0-9]",""));
            form.put("totAmt2", String.valueOf(form.get("totAmt2")).replaceAll("[^0-9]",""));
            form.put("supAmt3", String.valueOf(form.get("supAmt3")).replaceAll("[^0-9]",""));
            form.put("vatAmt3", String.valueOf(form.get("vatAmt3")).replaceAll("[^0-9]",""));
            form.put("totAmt3", String.valueOf(form.get("totAmt3")).replaceAll("[^0-9]",""));
            form.put("supAmt4", String.valueOf(form.get("supAmt4")).replaceAll("[^0-9]",""));
            form.put("vatAmt4", String.valueOf(form.get("vatAmt4")).replaceAll("[^0-9]",""));
            form.put("totAmt4", String.valueOf(form.get("totAmt4")).replaceAll("[^0-9]",""));
            form.put("supAmt5", String.valueOf(form.get("supAmt5")).replaceAll("[^0-9]",""));
            form.put("vatAmt5", String.valueOf(form.get("vatAmt5")).replaceAll("[^0-9]",""));
            form.put("totAmt5", String.valueOf(form.get("totAmt5")).replaceAll("[^0-9]",""));

            switch (((String) form.get("projCd")).length()) {
                case 0 -> {
                    projectProjMapper.insertProjMgtList(form);
                    break;
                }
                default -> {
                    projectProjMapper.updateProjMgtList(form);
                    break;
                }
            }

            returnData.put("status","success");
            returnData.put("note","성공적으로 처리되었습니다.");

        }catch (Exception e){

            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();

        }

        return returnData;
    }

    @Transactional
    public Map<String, Object> cudProjPartList2(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            Map<String, Object> form = (Map<String, Object>) map.get("formData");

            form.put("userId", SessionUtil.getUser().getEmpCd());
            form.put("cntDt", Util.removeMinusChar((String) form.get("cntDt")));
            form.put("initiateDt", Util.removeMinusChar((String) form.get("initiateDt")));
            form.put("dueDt", Util.removeMinusChar((String) form.get("dueDt")));
            form.put("estDt", Util.removeMinusChar((String) form.get("estDt")));
            form.put("endDt", Util.removeMinusChar((String) form.get("endDt")));
            form.put("validDt", Util.removeMinusChar((String) form.get("validDt")));

            form.put("supAmt", String.valueOf(form.get("supAmt")).replaceAll("[^0-9]",""));
            form.put("vatAmt", String.valueOf(form.get("vatAmt")).replaceAll("[^0-9]",""));
            form.put("totAmt", String.valueOf(form.get("totAmt")).replaceAll("[^0-9]",""));
            form.put("supAmt2", String.valueOf(form.get("supAmt2")).replaceAll("[^0-9]",""));
            form.put("vatAmt2", String.valueOf(form.get("vatAmt2")).replaceAll("[^0-9]",""));
            form.put("totAmt2", String.valueOf(form.get("totAmt2")).replaceAll("[^0-9]",""));
            form.put("supAmt3", String.valueOf(form.get("supAmt3")).replaceAll("[^0-9]",""));
            form.put("vatAmt3", String.valueOf(form.get("vatAmt3")).replaceAll("[^0-9]",""));
            form.put("totAmt3", String.valueOf(form.get("totAmt3")).replaceAll("[^0-9]",""));
            form.put("supAmt4", String.valueOf(form.get("supAmt4")).replaceAll("[^0-9]",""));
            form.put("vatAmt4", String.valueOf(form.get("vatAmt4")).replaceAll("[^0-9]",""));
            form.put("totAmt4", String.valueOf(form.get("totAmt4")).replaceAll("[^0-9]",""));
            form.put("supAmt5", String.valueOf(form.get("supAmt5")).replaceAll("[^0-9]",""));
            form.put("vatAmt5", String.valueOf(form.get("vatAmt5")).replaceAll("[^0-9]",""));
            form.put("totAmt5", String.valueOf(form.get("totAmt5")).replaceAll("[^0-9]",""));


            switch (((String) form.get("projCd")).length()) {
                case 0 -> {
                    projectProjMapper.insertProjMgtList(form);
                    break;
                }
                default -> {
                    projectProjMapper.updateProjMgtList(form);
                    break;
                }
            }

            List rows = (List) form.get("rows");
            for (Object o : rows) {
                Map<String, Object> row = (Map<String, Object>) o;

                row.put("corpCd", form.get("corpCd"));
                row.put("busiCd", form.get("busiCd"));
                row.put("estCd", form.get("estCd"));
                row.put("projCd", form.get("projCd"));
                row.put("userId", SessionUtil.getUser().getEmpCd());
                System.out.println(row);
                switch ((String) row.get("status")) {
                    case "C" -> {
                    projectProjMapper.insertProjPartList(row);
                        break;
                    }
                    case "U" -> {
                    projectProjMapper.updateProjPartList(row);
                        break;
                    }
                    case "D" -> {
                        projectProjMapper.deleteProjPartList(row);
                        break;
                    }
                }
            }

            returnData.put("status","success");
            returnData.put("note","성공적으로 처리되었습니다.");

        }catch (Exception e){

            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();

        }

        return returnData;
    }

    @Transactional
    public Map<String, Object> cudProjMemoList2(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            Map<String, Object> form = (Map<String, Object>) map.get("formData");

            form.put("userId", SessionUtil.getUser().getEmpCd());
            form.put("cntDt", Util.removeMinusChar((String) form.get("cntDt")));
            form.put("initiateDt", Util.removeMinusChar((String) form.get("initiateDt")));
            form.put("dueDt", Util.removeMinusChar((String) form.get("dueDt")));
            form.put("estDt", Util.removeMinusChar((String) form.get("estDt")));
            form.put("endDt", Util.removeMinusChar((String) form.get("endDt")));
            form.put("validDt", Util.removeMinusChar((String) form.get("validDt")));

            form.put("supAmt", String.valueOf(form.get("supAmt")).replaceAll("[^0-9]",""));
            form.put("vatAmt", String.valueOf(form.get("vatAmt")).replaceAll("[^0-9]",""));
            form.put("totAmt", String.valueOf(form.get("totAmt")).replaceAll("[^0-9]",""));
            form.put("supAmt2", String.valueOf(form.get("supAmt2")).replaceAll("[^0-9]",""));
            form.put("vatAmt2", String.valueOf(form.get("vatAmt2")).replaceAll("[^0-9]",""));
            form.put("totAmt2", String.valueOf(form.get("totAmt2")).replaceAll("[^0-9]",""));
            form.put("supAmt3", String.valueOf(form.get("supAmt3")).replaceAll("[^0-9]",""));
            form.put("vatAmt3", String.valueOf(form.get("vatAmt3")).replaceAll("[^0-9]",""));
            form.put("totAmt3", String.valueOf(form.get("totAmt3")).replaceAll("[^0-9]",""));
            form.put("supAmt4", String.valueOf(form.get("supAmt4")).replaceAll("[^0-9]",""));
            form.put("vatAmt4", String.valueOf(form.get("vatAmt4")).replaceAll("[^0-9]",""));
            form.put("totAmt4", String.valueOf(form.get("totAmt4")).replaceAll("[^0-9]",""));
            form.put("supAmt5", String.valueOf(form.get("supAmt5")).replaceAll("[^0-9]",""));
            form.put("vatAmt5", String.valueOf(form.get("vatAmt5")).replaceAll("[^0-9]",""));
            form.put("totAmt5", String.valueOf(form.get("totAmt5")).replaceAll("[^0-9]",""));


            switch (((String) form.get("projCd")).length()) {
                case 0 -> {
                    projectProjMapper.insertProjMgtList(form);
                    break;
                }
                default -> {
                    projectProjMapper.updateProjMgtList(form);
                    break;
                }
            }

            List rows = (List) form.get("rows");
            for (Object o : rows) {
                Map<String, Object> row = (Map<String, Object>) o;

                row.put("corpCd", form.get("corpCd"));
                row.put("busiCd", form.get("busiCd"));
                row.put("estCd", form.get("estCd"));
                row.put("projCd", form.get("projCd"));
                row.put("userId", SessionUtil.getUser().getEmpCd());
                System.out.println(row);
                switch ((String) row.get("status")) {
                    case "C" -> {
                    projectProjMapper.insertProjMemoList(row);
                        break;
                    }
                    case "U" -> {
                    projectProjMapper.updateProjMemoList(row);
                        break;
                    }
                    case "D" -> {
                        projectProjMapper.deleteProjMemoList(row);
                        break;
                    }
                }
            }

            returnData.put("status","success");
            returnData.put("note","성공적으로 처리되었습니다.");

        }catch (Exception e){

            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();

        }

        return returnData;
    }
}
