package com.springboot.myapp.eds.erp.controller.base;

import com.springboot.myapp.eds.erp.vo.base.baseCarExpeFileListVO;
import com.springboot.myapp.eds.erp.vo.base.baseCarExpeListVO;
import com.springboot.myapp.eds.erp.vo.base.baseCarListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class baseCarService {

    @Value("${eds.front.file.path}")
    private String filePath;

    @Value("${eds.backs.file.path}")
    private String realPath;

    private final baseCarMapper baseCarMapper;

    public baseCarService(baseCarMapper baseCarMapper) {
        this.baseCarMapper = baseCarMapper;
    }

    public List<baseCarListVO> selectCarMgtList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        if (!map.containsKey("corpCd")){map.put("corpCd", SessionUtil.getUser().getCorpCd());}
        List<baseCarListVO> result = baseCarMapper.selectCarMgtList(map);
        return result;
    }

    public List<baseCarListVO> selectCarMgtUseList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseCarListVO> result = baseCarMapper.selectCarMgtUseList(map);
        return result;
    }

    public List<baseCarExpeListVO> selectCarExpeList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseCarExpeListVO> result = baseCarMapper.selectCarExpeList(map);
        return result;
    }

    public List<baseCarExpeFileListVO> selectCarExpeFileList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());

        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<baseCarExpeFileListVO> result = baseCarMapper.selectCarExpeFileList(map);
        return result;
    }

    public int insertCarMgtList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());

        map.put("sumCumuMile", Util.removeCommaChar((String) map.get("sumCumuMile")));
        map.put("cumuMile", Util.removeCommaChar((String) map.get("cumuMile")));
        return baseCarMapper.insertCarMgtList(map);
    }

    public int insertCarExpeList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCarMapper.insertCarExpeList(map);
    }

    public Map<String, Object> insertCarExpeFileList(MultipartHttpServletRequest mtfRequest) throws Exception {

        /**
         * 클라이언트 리턴 데이터
         * */
        Map<String, Object> returnData = new HashMap<String, Object>();

        try {
            // 파라미터세팅
            AES256Util aes256Util = new AES256Util();

            String corpCd = SessionUtil.getUser().getCorpCd();
            String empCd = SessionUtil.getUser().getEmpCd();

            String carCd = mtfRequest.getParameter("carCd");
            String expeCd = mtfRequest.getParameter("expeCd");

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
            path+="base\\";    final File baseDir = new File(path);
            path+=empCd+"\\";   final File empCdDir = new File(path);

            /* 이메일 첨부파일 이 존재할 시 실행 */
            if(fileListSize > 0){

                if(!fileDir.exists()){ fileDir.mkdir();}
                if(!corpDir.exists()){ corpDir.mkdir();}
                if(!baseDir.exists()){ baseDir.mkdir();}
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
                    map.put("carCd",carCd);
                    map.put("expeCd",expeCd);
                    map.put("saveNm",saveNm);
                    map.put("origNm",origNm);
                    map.put("saveRoot",path+saveNm+"."+ext);
                    map.put("ext",ext);
                    map.put("size",realFile.length());
                    map.put("userId",empCd);
                    map.put("secretKey", aes256Util.getKey());
                    baseCarMapper.insertCarExpeFileList(map);
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

    public int updateCarMgtList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());

        map.put("sumCumuMile", Util.removeCommaChar((String) map.get("sumCumuMile")));
        map.put("cumuMile", Util.removeCommaChar((String) map.get("cumuMile")));
        return baseCarMapper.updateCarMgtList(map);
    }

    public int updateCarExpeList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCarMapper.updateCarExpeList(map);
    }

    public int updateCarExpeFileList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCarMapper.updateCarExpeFileList(map);
    }

    public int deleteCarMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCarMapper.deleteCarMgtList(map);
    }

    public int deleteCarExpeList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCarMapper.deleteCarExpeList(map);
    }

    public int deleteCarExpeFileList(Map<String, Object> map) throws Exception {

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

            List<baseCarExpeFileListVO> result = baseCarMapper.selectCarExpeFileList(map);
            int resultSize = result.size();
            File file = null;
            for (int i = 0; i < resultSize; i++) {
                file = new File(String.valueOf(Paths.get(result.get(i).getSaveRoot())));
                /* 실제 파일 삭제 */
                if(file.exists()) Files.delete(Paths.get(result.get(i).getSaveRoot()));
                /* DB 파일 삭제 */
                baseCarMapper.deleteCarExpeFileList(map);
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

    public String selectEmpCdCheck(Map<String, Object> map) throws Exception {
        return baseCarMapper.selectEmpCdCheck(map);
    }

    public String selectEmpIdCheck(Map<String, Object> map) throws Exception {
        return baseCarMapper.selectEmpIdCheck(map);
    }

    public List<baseCarListVO> carCheckByGroup(Map<String, Object> map) throws Exception {
        List<baseCarListVO> result = baseCarMapper.carCheckByGroup(map);
        return result;
    }

    public String duplicateCarCheck(Map<String, Object> map) throws Exception {
        return baseCarMapper.duplicateCarCheck(map);
    }

    public String uploadCarFaceImage(MultipartHttpServletRequest mtfRequest) throws Exception {

        // 파라미터 세팅
        String corpCd = mtfRequest.getParameter("corpCd");
        String empCd = mtfRequest.getParameter("empCd");
        String exisOrigNm = mtfRequest.getParameter("exisOrigNm");
        String exisExt = mtfRequest.getParameter("exisExt");
        String origNm = mtfRequest.getParameter("origNm");
        String ext = mtfRequest.getParameter("ext");
        String size = mtfRequest.getParameter("size");

        /* 경로 세팅 */
        String path = filePath;

        /* 시간 세팅 */
        SimpleDateFormat yyyMMFormat = new SimpleDateFormat("yyyyMM");
//        String yyyyMM = yyyMMFormat.format(new Date());

        SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format

        /* 파일 경로 확인 및 생성*/
        path+="file\\";      final File fileDir = new File(path);
        path+=corpCd+"\\";   final File corpDir = new File(path);
        path+="car\\";      final File carDir = new File(path);
        path+="face\\";      final File faceDir = new File(path);
//        path+=yyyyMM+"\\";   final File yyyyMMDir = new File(path);

        if(!fileDir.exists()){ fileDir.mkdir();}
        if(!corpDir.exists()){ corpDir.mkdir();}
        if(!carDir.exists()){ carDir.mkdir();}
        if(!faceDir.exists()){ faceDir.mkdir();}
//        if(!yyyyMMDir.exists()){ yyyyMMDir.mkdir();}

        // 저장 파일 경로 적용
        String savePath = new File(path).getCanonicalPath()+File.separatorChar; // File path to be saved

        // 파일 읽기
        List<MultipartFile> fileList = mtfRequest.getFiles("btnImage");


        try {

            String saveNm = "";
            MultipartFile mf= fileList.get(0);
            ext = FilenameUtils.getExtension(mf.getOriginalFilename()); // 확장자
            saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명

            Map row = new HashMap<>();
            AES256Util aes256Util = new AES256Util();
            row.put("secretKey", aes256Util.getKey());
            row.put("corpCd",corpCd);
            row.put("empCd",empCd);
            row.put("saveNm",saveNm);
            row.put("origNm",origNm);
            row.put("ext",ext);
            row.put("size",size);

            if(exisOrigNm.equals("null") && exisExt.equals("null")){
                // 신규 파일 저장
                System.out.println("sin");
                mf.transferTo(new File(savePath + saveNm + "." + ext));
                baseCarMapper.uploadCarFaceImage(row);

                return "redirect:/";
            }else{
                
                // 기존 파일 불러오기
                File file = new File(savePath + exisOrigNm + "." + exisExt);
                
                // 기존 파일 삭제
                if( file.exists()){ file.delete();}


                // 신규 파일 불러오기
                file =new File(savePath + saveNm + "." + ext);

                // 신규 파일 생성
                mf.transferTo(file);
//                baseCarMapper.deleteCarFaceImage(row);
                baseCarMapper.uploadCarFaceImage(row);
                return "redirect:/";
            }

        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/";
    }

    public ResponseEntity<byte[]> selectCarExpeImage(@PathVariable("params") String params) throws Exception {

        String param = params.replace(":","\\"); // params

        String path = String.valueOf(new File(param));


        System.out.println("첸지");
        InputStream imageStream = null;
        byte[] imageByteArray = null;
        File file = new File(path);
        if( file.exists()){
            imageStream = new FileInputStream(path);
            imageByteArray = IOUtils.toByteArray(imageStream);
            imageStream.close();

        }else{

        }
        System.out.println(imageByteArray);
        return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
    }
}
