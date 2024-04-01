package com.springboot.myapp.eds.erp.controller.guMae;

import com.springboot.myapp.eds.erp.controller.email.emailMapper;
import com.springboot.myapp.eds.erp.vo.email.emailFileVO;
import com.springboot.myapp.eds.erp.vo.guMae.guMaeColListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

@Service
public class guMaeColService {

    @Autowired
    private guMaeColMapper guMaeColMapper;

    @Autowired
    private emailMapper emailMapper;

    @Value("${eds.backs.file.path}")
    private String realPath;

    public List<guMaeColListVO> selectColMgtList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<guMaeColListVO> result = guMaeColMapper.selectColMgtList(map);
        return result;
    }

    public int insertColMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return guMaeColMapper.insertColMgtList(map);
    }

    public int updateColMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return guMaeColMapper.updateColMgtList(map);
    }

    public int deleteColMgtList(Map<String, Object> map) throws Exception {
        return guMaeColMapper.deleteColMgtList(map);
    }

    public int deleteColEmailList(Map<String, Object> map) throws Exception {
        
        try {
            /* 서버 파일 삭제 */
            AES256Util aes256Util = new AES256Util();
            map.put("secretKey", aes256Util.getKey());
            map.put("emailSeq",map.get("seq"));
            map.put("authDivi", SessionUtil.getUser().getAuthDivi());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());
            map.put("empCd", SessionUtil.getUser().getEmpCd());
            map.put("divi", "collect");

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
        return guMaeColMapper.deleteColEmailList(map);
    }
    public int aRecMgtList(Map<String, Object> map) throws Exception {

        int returnData = 0;

        try{
            map.put("userId", SessionUtil.getUser().getEmpCd());

            /* 매출 전표 생성*/
            guMaeColMapper.aRecMgtList(map);

            returnData = 1;

        }catch (Exception e){

            String exc = e.toString();
            System.out.println(exc);
            e.printStackTrace();
            returnData = 0;

        }

        return returnData;
    }

    public int deadLineColMgtList(Map<String, Object> map) throws Exception {

        int returnData = 0;
        try {

            List saveData = (List) map.get("data");

            for (int i = 0; i < saveData.size(); i++) {guMaeColMapper.deadLineColMgtList((Map) saveData.get(i));}

            returnData = 1;
        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.toString());
            returnData = 0;
        }

        return returnData;

    }
}
