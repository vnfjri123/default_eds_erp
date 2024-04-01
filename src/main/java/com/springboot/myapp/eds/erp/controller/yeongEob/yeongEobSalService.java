package com.springboot.myapp.eds.erp.controller.yeongEob;

import com.springboot.myapp.eds.erp.controller.email.emailMapper;
import com.springboot.myapp.eds.erp.vo.email.emailFileVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobSalListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class yeongEobSalService {

    @Autowired
    private yeongEobSalMapper yeongEobSalMapper;

    @Autowired
    private emailMapper emailMapper;

    @Value("${eds.backs.file.path}")
    private String realPath;

    public List<yeongEobSalListVO> selectSalMgtList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<yeongEobSalListVO> result = yeongEobSalMapper.selectSalMgtList(map);
        return result;
    }

    public int insertSalMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return yeongEobSalMapper.insertSalMgtList(map);
    }

    public int updateSalMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return yeongEobSalMapper.updateSalMgtList(map);
    }

    public int deleteSalMgtList(Map<String, Object> map) throws Exception {
        return yeongEobSalMapper.deleteSalMgtList(map);
    }

    public int deleteSalEmailList(Map<String, Object> map) throws Exception {
        
        try {
            /* 서버 파일 삭제 */
            AES256Util aes256Util = new AES256Util();
            map.put("secretKey", aes256Util.getKey());
            map.put("emailSeq",map.get("seq"));
            map.put("authDivi", SessionUtil.getUser().getAuthDivi());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());
            map.put("empCd", SessionUtil.getUser().getEmpCd());
            map.put("divi", "sales");

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
        return yeongEobSalMapper.deleteSalEmailList(map);
    }

    public int aProjMgtList(Map<String, Object> map) throws Exception {

        int returnData = 0;

        try{
            map.put("userId", SessionUtil.getUser().getEmpCd());

            /* 매출 전표 생성*/
            yeongEobSalMapper.aProjMgtList(map);

            returnData = 1;

        }catch (Exception e){

            String exc = e.toString();
            System.out.println(exc);
            e.printStackTrace();
            returnData = 0;

        }

        return returnData;
    }

    public int deadLineSalMgtList(Map<String, Object> map) throws Exception {

        int returnData = 0;
        try {

            List saveData = (List) map.get("data");

            for (int i = 0; i < saveData.size(); i++) {yeongEobSalMapper.deadLineSalMgtList((Map) saveData.get(i));}

            returnData = 1;
        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.toString());
            returnData = 0;
        }

        return returnData;

    }
}
