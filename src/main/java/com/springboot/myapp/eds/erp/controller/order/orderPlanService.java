package com.springboot.myapp.eds.erp.controller.order;
import java.util.*;
import java.util.stream.Collectors;

import com.springboot.myapp.eds.erp.vo.order.orderPlanListVO;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class orderPlanService {

    @Autowired
    private orderPlanMapper orderPlanMapper;
    public List<Map<String,Object>> selectOrderPlanList(Map<String, Object> map) throws Exception {
        long startTime = System.nanoTime();
        // 조회 조건 값
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("ordPlanSetDt", Util.removeMinusChar((String) map.get("ordPlanSetDt")));
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());

        // 결과 정보 구조 생성
        List<Map<String,Object>> reResult = new LinkedList<>();

        // 조회 값 생성
        List<orderPlanListVO> originList = orderPlanMapper.selectOrderPlanList(map);
        int originListSize = originList.size();

        // 조회 값 월별 묶음 생성
        Map<String, List<orderPlanListVO>> monthlyGroupedList = originList.stream()
                .collect(Collectors.groupingBy(orderPlanListVO::getOrdPlanMonth));
        int monthlyGroupedListSize = monthlyGroupedList.size();
        // 맵에 데이터 추가
        List<String> monthKeys = new ArrayList<>(monthlyGroupedList.keySet());
        List<List<orderPlanListVO>> listValues = new ArrayList<>(monthlyGroupedList.values());

        // 구분 값 생성
        List<orderPlanListVO> diviItemList = orderPlanMapper.selectOrderPlanDiviItem(map);
        int diviItemListSize = diviItemList.size();

        // row index
        String ordPlanDivi = "";
        String ordPlanItem = "";
        String ordPlanDiviPart = "";
        String ordPlanItemPart = "";
        divi:for (int i = 0; i < diviItemListSize; i++) { // divi item 기준 for문
            ordPlanDivi = diviItemList.get(i).getOrdPlanDivi();
            ordPlanItem = diviItemList.get(i).getOrdPlanItem();
            row:for (int j = 0; j < originListSize; j++) { // row index 설정 및 row 생성
                Map<String, Object> emptyRow = new HashMap<>();
                cell:for (int k = 0; k < monthKeys.size(); k++) { // 월 기준 col 생성
                    String month = monthKeys.get(k);
                    List<orderPlanListVO> originListPart = listValues.get(k);
                    if(!originListPart.isEmpty()){
                        orderPlanListVO cell = originListPart.get(0);
                        ordPlanDiviPart = cell.getOrdPlanDivi();
                        ordPlanItemPart = cell.getOrdPlanItem();
                        if(ordPlanDivi.equals(ordPlanDiviPart) && ordPlanItem.equals(ordPlanItemPart)){
                            emptyRow.put("ordPlanDivi", cell.getOrdPlanDivi());               // 수주계획구분 헤더 데이터
                            emptyRow.put("ordPlanItem", cell.getOrdPlanItem());               // 수주계획항목 헤더 데이터
                            emptyRow.put("corpCd"+month, cell.getCorpCd());                   // 회사코드
                            emptyRow.put("ordPlanCd"+month, cell.getOrdPlanCd());             // 수주계획코드
                            emptyRow.put("ordPlanYear"+month, cell.getOrdPlanYear());         // 수주계획연도
                            emptyRow.put("ordPlanMonth"+month, cell.getOrdPlanMonth());       // 수주계획월
                            emptyRow.put("ordPlanDivi"+month, cell.getOrdPlanDivi());         // 수주계획구분
                            emptyRow.put("ordPlanItem"+month, cell.getOrdPlanItem());         // 수주계획항목
                            emptyRow.put("ordPlanBusiCd"+month, cell.getOrdPlanBusiCd());     // 수주계획사업장
                            emptyRow.put("ordPlanDepaCd"+month, cell.getOrdPlanDepaCd());     // 수주계획부서
                            emptyRow.put("ordPlanEmpCd"+month, cell.getOrdPlanEmpCd());       // 수주계획담당자
                            emptyRow.put("ordPlanBusiDivi"+month, cell.getOrdPlanBusiDivi()); // 수주계획사업구분
                            emptyRow.put("ordPlanCustCd"+month, cell.getOrdPlanCustCd());     // 수주계획거래처코드
                            emptyRow.put("ordPlanAmt"+month, cell.getOrdPlanAmt());           // 수주계획금액
                            emptyRow.put("ordPlanGr"+month, cell.getOrdPlanGr());             // 수주계획등록
                            emptyRow.put("ordPlanNote"+month, cell.getOrdPlanNote());         // 수주계획메모

                            // 사용된 part는 삭제
                            // 이로인한 3중 for문 이더라도 2중포문처럼 사용
                            // 추가적으로 listValues 값이 줄어들기 때문에 일반 2중포문 보다 e의 2승만큼 빨라진다.
                            originListPart.remove(0);
                        }
                    }
                }
                if(emptyRow.isEmpty()){
                    // break row; < 이거 안먹혀서 j 기준값을 최댓값으로 설정하여 빠져나오게함
//                    j = originListSize; // row end
                }else{
                    reResult.add(emptyRow); // add row
                }
            }
        }

        long endTime = System.nanoTime();
        long duration = endTime - startTime; // 실행 시간을 나노초 단위로 계산

        System.out.println("실행 시간(나노초): " + duration);
        System.out.println("실행 시간(밀리초): " + duration / 1_000_000.0);

        return reResult;
    }
    public List<orderPlanListVO> selectOrderPlanListForList(Map<String, Object> map) throws Exception {
        long startTime = System.nanoTime();
        // 조회 조건 값
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("ordPlanYear", ((String) map.get("ordPlanSetDt")).split("-")[0]);
        map.put("ordPlanMonth", ((String) map.get("ordPlanSetDt")).split("-")[1]);
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());

        // 조회 값 생성
        List<orderPlanListVO> originList = orderPlanMapper.selectOrderPlanListForList(map);

        long endTime = System.nanoTime();
        long duration = endTime - startTime; // 실행 시간을 나노초 단위로 계산

        System.out.println("실행 시간(나노초): " + duration);
        System.out.println("실행 시간(밀리초): " + duration / 1_000_000.0);

        return originList;
    }

    public List<orderPlanListVO> selectOrderPlanSetList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<orderPlanListVO> result = orderPlanMapper.selectOrderPlanSetList(map);
        return result;
    }

    @Transactional
    public Map<String, Object> cuOrderPlanList(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            Map<String, Object> params = (Map<String, Object>) map.get("formData");
            String status = params.get("status").toString();
            params.put("corpCd", SessionUtil.getUser().getCorpCd()); // 회사코드 추가
            params.put("userId", SessionUtil.getUser().getEmpCd()); // 입력자 추가
            params.put("ordPlanYear", params.get("ordPlanDt").toString().split("-")[0]); // 날짜 분개 후 추가
            params.put("ordPlanMonth", params.get("ordPlanDt").toString().split("-")[1]); // 날짜 분개 후 추가

            switch (status){
                case "C" -> {
                    params.put("saveDivi", "01"); // 저장 구분
                    orderPlanMapper.insertOrderPlanList(params);
                    returnData.put("note","성공적으로 내역이 저장되었습니다.");
                }
                case "U" -> {
                    orderPlanMapper.updateOrderPlanList(params);
                    returnData.put("note","성공적으로 내역이 수정되었습니다.");
                }
                case "D" -> {
                    params.put("saveDivi", "02"); // 저장 구분
                    orderPlanMapper.deleteOrderPlanList(params);
                    returnData.put("note","성공적으로 내역이 삭제되었습니다.");
                }
            }

            returnData.put("status","success");

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
    public Map<String, Object> cuOrderPlanSetList(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {

            map.put("userId", SessionUtil.getUser().getEmpCd());
            orderPlanMapper.cuOrderPlanSetList(map);
            returnData.put("note","성공적으로 내역이 저장되었습니다.");

            returnData.put("status","success");

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
    public int deleteOrderPlanList(Map<String, Object> map) throws Exception {
        return orderPlanMapper.deleteOrderPlanList(map);
    }
}
