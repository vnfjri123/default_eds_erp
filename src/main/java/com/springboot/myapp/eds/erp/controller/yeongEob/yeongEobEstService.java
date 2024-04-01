package com.springboot.myapp.eds.erp.controller.yeongEob;

import com.springboot.myapp.eds.erp.controller.email.emailMapper;

import com.springboot.myapp.eds.erp.vo.email.emailFileVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobEstListVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobEstItemListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class yeongEobEstService {

    @Autowired
    private yeongEobEstMapper yeongEobEstMapper;

    @Autowired
    private emailMapper emailMapper;

    @Value("${eds.backs.file.path}")
    private String realPath;

    public List<yeongEobEstListVO> selectEstMgtList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<yeongEobEstListVO> result = yeongEobEstMapper.selectEstMgtList(map);
        return result;
    }

    public List<yeongEobEstItemListVO> selectEstItemList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<yeongEobEstItemListVO> result = yeongEobEstMapper.selectEstItemList(map);
        return result;
    }

    public int insertEstMgtList(Map<String, Object> map) throws Exception {
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return yeongEobEstMapper.insertEstMgtList(map);
    }

    public int insertEstItemList(Map<String, Object> map) throws Exception {
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return yeongEobEstMapper.insertEstItemList(map);
    }

    public int updateEstMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return yeongEobEstMapper.updateEstMgtList(map);
    }

    public int updateEstItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return yeongEobEstMapper.updateEstItemList(map);
    }

    public int deleteEstMgtList(Map<String, Object> map) throws Exception {
        return yeongEobEstMapper.deleteEstMgtList(map);
    }

    public int deleteEstItemList(Map<String, Object> map) throws Exception {
        return yeongEobEstMapper.deleteEstItemList(map);
    }

    public int deleteEstEmailList(Map<String, Object> map) throws Exception {
        try {
            /* 서버 파일 삭제 */
            AES256Util aes256Util = new AES256Util();
            map.put("secretKey", aes256Util.getKey());
            map.put("emailSeq",map.get("seq"));
            map.put("authDivi", SessionUtil.getUser().getAuthDivi());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());
            map.put("empCd", SessionUtil.getUser().getEmpCd());
            map.put("divi", "estimate");

            /* 첨부파일*/
            List<emailFileVO> result = emailMapper.selectSendEmailFileInfo(map);
            int resultSize = result.size();
            for (int i = 0; i < resultSize; i++) {
                Files.delete(Paths.get(result.get(i).getSaveRoot()));
            }

            /* 양식파일*/
            List<emailFileVO> result2 = emailMapper.selectSendEmailJasperInfo(map);
            int resultSize2 = result2.size();
            for (int i = 0; i < resultSize2; i++) {
                Files.delete(Paths.get(result2.get(i).getSaveRoot()));
            }

            /* 이미지파일*/
            String note = (String) map.get("note");
            // HTML 문자열로부터 Document 객체 생성
            Document doc = Jsoup.parse(note);

            // 모든 img 태그 찾기
            Elements images = doc.select("img");

            // 각 img 태그의 src 속성 출력
            for (Element img : images) {
                File imgFile = new File(realPath+img.attr("src"));
                imgFile.delete();
            }

        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.toString());
        }

        /* DB 파일 삭제 */
        return yeongEobEstMapper.deleteEstEmailList(map);
    }

    public int deadLineEstMgtList(Map<String, Object> map) throws Exception {

        int returnData = 0;
        try {

            List saveData = (List) map.get("data");

            for (int i = 0; i < saveData.size(); i++) {yeongEobEstMapper.deadLineEstMgtList((Map) saveData.get(i));}

            returnData = 1;
        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.toString());
            returnData = 0;
        }

        return returnData;

    }

    @Transactional
    public Map<String, Object> cudEstList(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            Map<String, Object> form = (Map<String, Object>) map.get("formData");

            form.put("estDt", Util.removeMinusChar((String) form.get("estDt")));
            form.put("validDt", Util.removeMinusChar((String) form.get("validDt")));

            form.put("userId", SessionUtil.getUser().getEmpCd());
            form.put("supAmt", Util.removeCommaChar(String.valueOf(form.get("supAmt"))));
            form.put("vatAmt", Util.removeCommaChar(String.valueOf(form.get("vatAmt"))));
            form.put("totAmt", Util.removeCommaChar(String.valueOf(form.get("totAmt"))));
            form.put("supAmt2", Util.removeCommaChar(String.valueOf(form.get("supAmt2"))));
            form.put("vatAmt2", Util.removeCommaChar(String.valueOf(form.get("vatAmt2"))));
            form.put("totAmt2", Util.removeCommaChar(String.valueOf(form.get("totAmt2"))));

            switch (((String) form.get("estCd")).length()) {
                case 0 -> {
                    yeongEobEstMapper.insertEstMgtList(form);
                    break;
                }
                default -> {
                    yeongEobEstMapper.updateEstMgtList(form);
                    break;
                }
            }

            List rows = (List) form.get("rows");
            for (Object o : rows) {
                Map<String, Object> row = (Map<String, Object>) o;

                row.put("userId", SessionUtil.getUser().getEmpCd());
                row.put("estCd", form.get("estCd"));
                row.put("qty", Util.removeCommaChar(String.valueOf(row.get("qty"))));
                row.put("cost", Util.removeCommaChar(String.valueOf(row.get("cost"))));
                row.put("supAmt", Util.removeCommaChar(String.valueOf(row.get("supAmt"))));
                row.put("vatAmt", Util.removeCommaChar(String.valueOf(row.get("vatAmt"))));
                row.put("totAmt", Util.removeCommaChar(String.valueOf(row.get("totAmt"))));
                row.put("cost2", Util.removeCommaChar(String.valueOf(row.get("cost2"))));
                row.put("supAmt2", Util.removeCommaChar(String.valueOf(row.get("supAmt2"))));
                row.put("vatAmt2", Util.removeCommaChar(String.valueOf(row.get("vatAmt2"))));
                row.put("totAmt2", Util.removeCommaChar(String.valueOf(row.get("totAmt2"))));
                row.put("cost3", Util.removeCommaChar(String.valueOf(row.get("cost3"))));
                row.put("supAmt3", Util.removeCommaChar(String.valueOf(row.get("supAmt3"))));
                row.put("vatAmt3", Util.removeCommaChar(String.valueOf(row.get("vatAmt3"))));
                row.put("totAmt3", Util.removeCommaChar(String.valueOf(row.get("totAmt3"))));
                switch ((String) row.get("status")) {
                    case "C" -> {
                        yeongEobEstMapper.insertEstItemList(row);
                        break;
                    }
                    case "U" -> {
                        yeongEobEstMapper.updateEstItemList(row);
                        break;
                    }
                    case "D" -> {
                        yeongEobEstMapper.deleteEstItemList(row);
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