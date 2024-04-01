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
public class SALMA4500Service {

    @Autowired
    private SALMA4500Mapper salma4500Mapper;

    public List<SALMA4500VO> selectSALMA4500(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<SALMA4500VO> result = salma4500Mapper.selectSALMA4500(map);
        return result;
    }

    public List<SALMA4501VO> selectSALMA4501(Map<String, Object> map) throws Exception {
        List<SALMA4501VO> result = salma4500Mapper.selectSALMA4501(map);
        return result;
    }

    public List<SALMA4502VO> selectSALMA4502(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<SALMA4502VO> result = salma4500Mapper.selectSALMA4502(map);
        return result;
    }

    public List<SALMA4503VO> selectSALMA4503(Map<String, Object> map) throws Exception {
        List<SALMA4503VO> result = salma4500Mapper.selectSALMA4503(map);
        return result;
    }

    public List<SALMA4504VO> selectSALMA4504(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<SALMA4504VO> result = salma4500Mapper.selectSALMA4504(map);
        return result;
    }

    public List<SALMA4505VO> selectSALMA4505(Map<String, Object> map) throws Exception {
        List<SALMA4505VO> result = salma4500Mapper.selectSALMA4505(map);
        return result;
    }

    public List<SALMA4501VO> selectSALMA4506(Map<String, Object> map) throws Exception {

        String qty = salma4500Mapper.countSALMA4506(map).get(0).getQty();

        List<SALMA4501VO> result = null;

        if(qty.equals("0")){ result = salma4500Mapper.selectSALMA4506(map);}
        else{ result = salma4500Mapper.selectSALMA4507(map);}

        return result;
    }

    public int insertSALMA4500(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.insertSALMA4500(map);
    }

    public int insertSALMA4501(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.insertSALMA4501(map);
    }

    public int updateSALMA4500(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.updateSALMA4500(map);
    }

    public int updateSALMA4501(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.updateSALMA4501(map);
    }

    public int updateSALMA4502(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.updateSALMA4502(map);
    }

    public int updateSALMA4503(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.updateSALMA4503(map);
    }

    public int updateSALMA4505(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.updateSALMA4505(map);
    }

    public int resetSALMA4503(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.resetSALMA4503(map);
    }

    public int resetSALMA4505(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.resetSALMA4505(map);
    }

    public int closeYnSALMA4500(Map<String, Object> map) throws Exception {
        return salma4500Mapper.closeYnSALMA4500(map);
    }

    public int deleteSALMA4500(Map<String, Object> map) throws Exception {
        return salma4500Mapper.deleteSALMA4500(map);
    }

    public int deleteSALMA4501(Map<String, Object> map) throws Exception {
        return salma4500Mapper.deleteSALMA4501(map);
    }

    /*public int deleteSALMA4502(Map<String, Object> map) throws Exception {
        return salma4500Mapper.deleteSALMA4502(map);
    }*/

    public int applySALMA4503(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.applySALMA4503(map);
    }

    public int insertSALMA4504(Map<String, Object> map) throws Exception {
        List saveData = (List) map.get("data");

        Map row = (Map) saveData.get(0);
        row.put("userId", SessionUtil.getUser().getEmpCd());

        try{
            /**
             * 1. 실적 데이터 인지 확인
             * @return -1 {int} 저장되지 않은 바코드
             * */
            List<SALMA4501VO> result = salma4500Mapper.selectSALMA4508(row);
            String qty = result.get(0).getQty();

            if(Integer.parseInt(qty) > 0){
                /**
                 * 2. 등록된 데이터 인지 확인
                 * @return -2 {int} 중복 바코드
                 * */
                result = salma4500Mapper.selectSALMA4509(row);
                qty = result.get(0).getQty();

                if(Integer.parseInt(qty) == 0){
                    /**
                     * 3. 출고 등록
                     * */
                    return salma4500Mapper.insertSALMA4501(row);
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

    public int deleteSALMA4503(Map<String, Object> map) throws Exception {

        List saveData = (List) map.get("data");

        Map row = (Map) saveData.get(0);
        row.put("userId", SessionUtil.getUser().getEmpCd());

        try{
            /**
             * 1. 실적 데이터 인지 확인
             * @return -1 {int} 저장되지 않은 바코드
             * */
            List<SALMA4501VO> result = salma4500Mapper.selectSALMA4508(row);
            String qty = result.get(0).getQty();

            if(Integer.parseInt(qty) > 0){
                /**
                 * 2. 등록된 데이터 인지 확인
                 * @return -2 {int} 중복 바코드
                 * */
                result = salma4500Mapper.selectSALMA4509(row);
                qty = result.get(0).getQty();

                if(Integer.parseInt(qty) > 0){
                    /**
                     * 3. 출고 등록
                     * */
                    return salma4500Mapper.deleteSALMA4503(row);
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

    public int applySALMA4505(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.applySALMA4505(map);
    }

    public int applySALMADcAtmTax(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.applySALMADcAtmTax(map);
    }

    public int saleCloseSALMA4500(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.saleCloseSALMA4500(map);
    }

    public int saleCloseSALMA4501(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return salma4500Mapper.saleCloseSALMA4501(map);
    }

    public List<SALMA4506VO> applyBarcode2Item(Map<String, Object> map) throws Exception {
        List<SALMA4506VO> result = salma4500Mapper.applyBarcode2Item(map);
        return result;
    }

    @Transactional
    public Map applySALMA4506(Map<String, Object> map) throws Exception {

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
                updatedCnt += salma4500Mapper.resetSALMA4507(row);
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
                    updatedCnt += salma4500Mapper.applySALMA4506(row);
                }
            }catch (Exception ex) {
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "오류입니다.");
            }

            if (updatedCnt > 0) { // 정상 저장
                // salma4500Service.applySALMA4505(app);
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
    public Map resetSALMA4506(Map<String, Object> map) throws Exception {

        Map mp = new HashMap();
        Map rtn = new HashMap();
        int updatedCnt = 0;
        try {
            /** 상세 데이터 리셋
             * */
            try {
                updatedCnt += salma4500Mapper.resetSALMA4506(map);
            }catch (Exception ex) {
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "오류입니다.");
            }

            /** 집계 데이터 삭제
             * */
            try {
                updatedCnt += salma4500Mapper.resetSALMA4507(map);
            }catch (Exception ex) {
                rtn.put("Result", -100); // 음수값은 모두 실패
                rtn.put("Message", "오류입니다.");
            }

            if (updatedCnt > 0) { // 정상 저장
                // salma4500Service.applySALMA4505(app);
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