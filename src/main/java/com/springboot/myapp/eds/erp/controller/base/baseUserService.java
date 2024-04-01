package com.springboot.myapp.eds.erp.controller.base;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.myapp.eds.erp.vo.base.baseUserListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class baseUserService {

    @Value("${eds.front.file.path}")
    private String filePath;

    private final baseUserMapper baseUserMapper;

    public baseUserService(baseUserMapper baseUserMapper) {
        this.baseUserMapper = baseUserMapper;
    }

    public List<baseUserListVO> selectUserMgtList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        if (!map.containsKey("corpCd")){map.put("corpCd", SessionUtil.getUser().getCorpCd());}
        List<baseUserListVO> result = baseUserMapper.selectUserMgtList(map);
        return result;
    }

    public List<baseUserListVO> selectUserEmailList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseUserListVO> result = baseUserMapper.selectUserEmailList(map);
        return result;
    }

    public int insertUserMgtList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseUserMapper.insertUserMgtList(map);
    }

    public int updateUserMgtList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseUserMapper.updateUserMgtList(map);
    }

    public int deleteUserMgtList(Map<String, Object> map) throws Exception {

        String savePath = filePath + "file\\" + map.get("corpCd").toString() + "\\user\\face\\";

        //기존 파일 불러오기
        File file = new File(savePath + map.get("saveNm") + "." + map.get("ext"));

        //기존 파일 삭제
        if( file.exists()){ file.delete();}

        return baseUserMapper.deleteUserMgtList(map);
    }

    public String selectEmpCdCheck(Map<String, Object> map) throws Exception {
        return baseUserMapper.selectEmpCdCheck(map);
    }

    public String selectEmpIdCheck(Map<String, Object> map) throws Exception {
        return baseUserMapper.selectEmpIdCheck(map);
    }

    public List<baseUserListVO> userCheckByGroup(Map<String, Object> map) throws Exception {
        List<baseUserListVO> result = baseUserMapper.userCheckByGroup(map);
        return result;
    }

    public String duplicateUserCheck(Map<String, Object> map) throws Exception {
        return baseUserMapper.duplicateUserCheck(map);
    }

    public String uploadUserFaceImage(MultipartHttpServletRequest mtfRequest) throws Exception {

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
        path+="user\\";      final File userDir = new File(path);
        path+="face\\";      final File faceDir = new File(path);
//        path+=yyyyMM+"\\";   final File yyyyMMDir = new File(path);

        if(!fileDir.exists()){ fileDir.mkdir();}
        if(!corpDir.exists()){ corpDir.mkdir();}
        if(!userDir.exists()){ userDir.mkdir();}
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
                baseUserMapper.uploadUserFaceImage(row);

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
//                baseUserMapper.deleteUserFaceImage(row);
                baseUserMapper.uploadUserFaceImage(row);
                return "redirect:/";
            }

        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/";
    }

    public ResponseEntity<byte[]> selectUserFaceImage(@PathVariable("params") String params) throws Exception {

        String[] param = params.split(":"); // params
        String corpCd = param[0]; // 회사코드별 파일업로드 관리
        String saveNm = param[1] + "." + param[2]; // 저장명.확장자

        String path = new File(filePath+"/file/").getCanonicalPath()
                +File.separatorChar +corpCd
                +File.separatorChar +"user"
                +File.separatorChar +"face"
                +File.separatorChar +saveNm
                ;
        InputStream imageStream = null;
        byte[] imageByteArray = null;
        File file = new File(path);
        if( file.exists()){
            imageStream = new FileInputStream(path);
            imageByteArray = IOUtils.toByteArray(imageStream);
            imageStream.close();
        }else{

        }
        return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
    }
    public ResponseEntity<byte[]> selectUserFaceImageEdms(@PathVariable("params") String params) throws Exception {
        Map map = new HashMap();
        String[] param = params.split(":"); // params
        String corpCd = param[0]; // 회사코드별 파일업로드 관리
        String empCd = param[1];
        AES256Util aes256Util = new AES256Util();
        
        map.put("secretKey", aes256Util.getKey());
        map.put("corpCd", corpCd);
        map.put("empCd", empCd);
        List<baseUserListVO> result = baseUserMapper.selectUserMgtList(map);
 
        if(!(result.size()>0)) return null; 
        String path = new File(filePath+"/file/").getCanonicalPath()
                +File.separatorChar +corpCd
                +File.separatorChar +"user"
                +File.separatorChar +"face"
                +File.separatorChar +result.get(0).getSaveNm()+"."+result.get(0).getExt()
                ;
        InputStream imageStream = null;
        byte[] imageByteArray = null;
        File file = new File(path);
        if( file.exists()){
            imageStream = new FileInputStream(path);
            imageByteArray = IOUtils.toByteArray(imageStream);
            imageStream.close();
        }else{

        }
        return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
    }
}
