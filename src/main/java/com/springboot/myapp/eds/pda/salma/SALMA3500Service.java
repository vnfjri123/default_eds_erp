package com.springboot.myapp.eds.pda.salma;

import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SALMA3500Service {

    @Autowired
    private SALMA3500Mapper salma3500Mapper;

    public List<SALMA3500VO> selectSALMA3500(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<SALMA3500VO> result = salma3500Mapper.selectSALMA3500(map);
        return result;
    }

    public List<SALMA3501VO> selectSALMA3501(Map<String, Object> map) throws Exception {
        List<SALMA3501VO> result = salma3500Mapper.selectSALMA3501(map);
        return result;
    }

    public List<SALMA3502VO> selectSALMA3502(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<SALMA3502VO> result = salma3500Mapper.selectSALMA3502(map);
        return result;
    }

    public List<SALMA3503VO> selectSALMA3503(Map<String, Object> map) throws Exception {
        List<SALMA3503VO> result = salma3500Mapper.selectSALMA3503(map);
        return result;
    }

    public List<SALMA3504VO> selectSALMA3504(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<SALMA3504VO> result = salma3500Mapper.selectSALMA3504(map);
        return result;
    }

    public List<SALMA3505VO> selectSALMA3505(Map<String, Object> map) throws Exception {
        List<SALMA3505VO> result = salma3500Mapper.selectSALMA3505(map);
        return result;
    }

    public List<SALMA3501VO> selectSALMA3506(Map<String, Object> map) throws Exception {

        String qty = salma3500Mapper.countSALMA3506(map).get(0).getQty();

        List<SALMA3501VO> result = null;

        if(qty.equals("0")){ result = salma3500Mapper.selectSALMA3506(map);}
        else{ result = salma3500Mapper.selectSALMA3507(map);}

        return result;
    }

    public int insertSALMA3500(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.insertSALMA3500(map);
    }

    public int insertSALMA3501(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.insertSALMA3501(map);
    }

    public int updateSALMA3500(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.updateSALMA3500(map);
    }

    public int updateSALMA3501(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.updateSALMA3501(map);
    }

    public int updateSALMA3502(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.updateSALMA3502(map);
    }

    public int updateSALMA3503(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.updateSALMA3503(map);
    }

    public int updateSALMA3505(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.updateSALMA3505(map);
    }

    public int resetSALMA3503(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.resetSALMA3503(map);
    }

    public int resetSALMA3505(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.resetSALMA3505(map);
    }

    public int closeYnSALMA3500(Map<String, Object> map) throws Exception {
        return salma3500Mapper.closeYnSALMA3500(map);
    }

    public int deleteSALMA3500(Map<String, Object> map) throws Exception {
        return salma3500Mapper.deleteSALMA3500(map);
    }

    public int deleteSALMA3501(Map<String, Object> map) throws Exception {
        return salma3500Mapper.deleteSALMA3501(map);
    }

    public int deleteSALMA3502(Map<String, Object> map) throws Exception {
        return salma3500Mapper.deleteSALMA3502(map);
    }

    public int applySALMA3503(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.applySALMA3503(map);
    }

    public int insertSALMA3504(Map<String, Object> map) throws Exception {
        List saveData = (List) map.get("data");

        Map row = (Map) saveData.get(0);
        row.put("userId", SessionUtil.getUser().getEmpCd());

        try{
            /**
             * 1. 실적 데이터 인지 확인
             * @return -1 {int} 저장되지 않은 바코드
             * */
            List<SALMA3501VO> result = salma3500Mapper.selectSALMA3508(row);
            String qty = result.get(0).getQty();

            if(Integer.parseInt(qty) > 0){
                /**
                 * 2. 등록된 데이터 인지 확인
                 * @return -2 {int} 중복 바코드
                 * */
                result = salma3500Mapper.selectSALMA3509(row);
                qty = result.get(0).getQty();

                if(Integer.parseInt(qty) == 0){
                    /**
                     * 3. 출고 등록
                     * */
                    return salma3500Mapper.insertSALMA3501(row);
                }else{
                    /**
                     * 4. 중복 처리
                     * */
                    return -2; // 중복 바코드
                }
            }else{
                return -1; // 실적처리되지 않은 바코드
            }


        }catch (Exception ex) {
            return -3; // 실적처리되지 않은 바코드
        }
    }

    public int deleteSALMA3503(Map<String, Object> map) throws Exception {

        List saveData = (List) map.get("data");

        Map row = (Map) saveData.get(0);
        row.put("userId", SessionUtil.getUser().getEmpCd());

        try{
            /**
             * 1. 실적 데이터 인지 확인
             * @return -1 {int} 저장되지 않은 바코드
             * */
            List<SALMA3501VO> result = salma3500Mapper.selectSALMA3508(row);
            String qty = result.get(0).getQty();

            if(Integer.parseInt(qty) > 0){
                /**
                 * 2. 등록된 데이터 인지 확인
                 * @return -2 {int} 중복 바코드
                 * */
                result = salma3500Mapper.selectSALMA3509(row);
                qty = result.get(0).getQty();

                if(Integer.parseInt(qty) > 0){
                    /**
                     * 3. 출고 등록
                     * */
                    return salma3500Mapper.deleteSALMA3503(row);
                }else{
                    /**
                     * 4. 저장되지 않은 바코드
                     * */
                    return -2; // 중복 바코드
                }
            }else{
                return -1; // 실적처리되지 않은 바코드
            }


        }catch (Exception ex) {
            return -3; // 실적처리되지 않은 바코드
        }
    }

    public int applySALMA3505(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.applySALMA3505(map);
    }

    public int applySALMADcAtmTax(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.applySALMADcAtmTax(map);
    }

    public int saleCloseSALMA3500(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.saleCloseSALMA3500(map);
    }

    public int saleCloseSALMA3501(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma3500Mapper.saleCloseSALMA3501(map);
    }

    public List<SALMA3506VO> applyBarcode2Item(Map<String, Object> map) throws Exception {
        List<SALMA3506VO> result = salma3500Mapper.applyBarcode2Item(map);
        return result;
    }

    @Transactional
    public Map applySALMA3506(Map<String, Object> map) throws Exception {

        Map mp = new HashMap();
        Map rtn = new HashMap();

        // 전체 데이터
        List saveData = (List) map.get("data");
        int saveDataLen = saveData.size();

        int updatedCnt = 0;
        try {
            /** 집계 데이터 삭제
             * */
            try {
                Map row = (Map) saveData.get(0);
                updatedCnt += salma3500Mapper.resetSALMA3507(row);
                System.out.println(updatedCnt);
            }catch (Exception ex) {
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "오류입니다.");
            }

            /** 상세 데이터 셋팅
             * */
            try {
                for(int i=0; i<saveDataLen; i++){
                    Map row = (Map) saveData.get(i);
                    System.out.println(row);
                    updatedCnt += salma3500Mapper.applySALMA3506(row);
                }
            }catch (Exception ex) {
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "오류입니다.");
            }

            if (updatedCnt > 0) { // 정상 저장
                // salma3500Service.applySALMA3505(app);
                rtn.put("Result", 0);
                rtn.put("Message", "저장 되었습니다.");
            } else { // 저장 실패
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "저장에 실패하였습니다.");
            }
        } catch (Exception ex) {
            rtn.put("Result", -100); // 음수값은 모두 실패
            rtn.put("Message", "오류입니다.");
        }

        mp.put("IO", rtn);
        return mp;
    }

    @Transactional
    public Map resetSALMA3506(Map<String, Object> map) throws Exception {

        Map mp = new HashMap();
        Map rtn = new HashMap();
        int updatedCnt = 0;
        try {
            /** 상세 데이터 리셋
             * */
            try {
                updatedCnt += salma3500Mapper.resetSALMA3506(map);
            }catch (Exception ex) {
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "오류입니다.");
            }

            /** 집계 데이터 삭제
             * */
            try {
                updatedCnt += salma3500Mapper.resetSALMA3507(map);
            }catch (Exception ex) {
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "오류입니다.");
            }

            if (updatedCnt > 0) { // 정상 저장
                // salma3500Service.applySALMA3505(app);
                rtn.put("Result", 0);
                rtn.put("Message", "저장 되었습니다.");
            } else { // 저장 실패
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "저장에 실패하였습니다.");
            }
        } catch (Exception ex) {
            rtn.put("Result", -100); // 음수값은 모두 실패
            rtn.put("Message", "오류입니다.");
        }

        mp.put("IO", rtn);
        return mp;
    }
}