package com.springboot.myapp.eds.groupware.controller.workLog;

import com.springboot.myapp.eds.erp.controller.alarm.alarmService;
import com.springboot.myapp.eds.messages.controller.send.sendController;
import com.springboot.myapp.eds.notice.NotificationService;

import com.springboot.myapp.eds.groupware.vo.workLog.workLogCommentVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogActivityVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogListVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogPlanningKeyResultVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogCheckInKeyResultVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogSchDetailProgressChartVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Array;
import java.sql.SQLOutput;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.DoubleStream;
import java.util.stream.Stream;

@Service
public class workLogService {

    @Autowired
    private alarmService alarmService;

    @Autowired
    private sendController sendController;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private workLogMapper workLogMapper;

    public List<workLogListVO> selectWorkLogList(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        String searchDivi = (String) map.get("searchDivi");
        List<workLogListVO> result = null;
        List<workLogListVO> subResult = null;
        if(searchDivi.equals("03")){ // 전사적 목표
            result = workLogMapper.selectWorkLogList(map);
        }else{ // 내목표, 부서별 최상위 부모 연동
            // planCdRoot 조회
            subResult = workLogMapper.selectWorkLogList(map);
            String subResultRoot = "";
            // planCdRoot 기반 최상위 부모까지 planCd 처리
            for (int i = 0,subResultLength = subResult.size(); i < subResultLength; i++) {
                if(i==0) subResultRoot = subResult.get(i).getPlanCdRoot();
                else subResultRoot = subResultRoot+","+subResult.get(i).getPlanCdRoot();
            }
            // planCdRoot 기반 최상위 부모까지 planCd 중복제거
            String[] subResultRootArr = subResultRoot.split(",");
            HashSet<String> hashSet = new HashSet<>(Arrays.asList(subResultRootArr));
            String[] resultArr = hashSet.toArray(new String[0]);
            map.put("planCdArr",resultArr);
            // planCdRoot 기반 최상위 부모까지 조회
            result = workLogMapper.selectWorkLogList(map);
        }

        for (int i = 0, length = result.size(); i < length; i++) {
            workLogListVO vo = result.get(i);
            String statusDivi = vo.getStatusDivi();
            Double rate = vo.getRate();
            if (statusDivi == null || statusDivi.isBlank()) vo.setStatusDivi("01");
            else if (statusDivi.contains("03")) vo.setStatusDivi("03");
            else if (statusDivi.contains("02")) vo.setStatusDivi("02");
            else if (statusDivi.contains("01")) vo.setStatusDivi("01");
            else {
                if(rate >= 100.0) vo.setStatusDivi("04");
                else vo.setStatusDivi("02");
            };
        }

        return result;
    }

    public List<workLogListVO> selectWorkLogObjectiveList(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        List<workLogListVO> result = workLogMapper.selectWorkLogObjectiveList(map);
        int resultLength = result.size();
        for (int i = 0; i < resultLength; i++) {
            // 활동 데이터 추적
            Map<String, Object> planCd = new HashMap<>();
            planCd = map;
            planCd.put("planCd", result.get(i).getPlanCd());
            planCd.put("OkrDiv", "01");
            Map<String, Object> cntMap = workLogMapper.selectWorkLogActivityCount(planCd);

            // 활동 수 세팅
            int cnt = 0;
            if(cntMap != null) cnt = Integer.parseInt(cntMap.get("cnt").toString());

            // 수 세팅에 따른 색상 세팅
            String cntColor = "#fff";
            if(cnt > 0) cntColor = "#dbdbdb";
            result.get(i).setCntColor(cntColor);
        }
        return result;
    }

    public List<workLogListVO> selectWorkLogKeyResultList(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        List<workLogListVO> result = workLogMapper.selectWorkLogKeyResultList(map);
        return result;
    }

    public List<workLogActivityVO> selectWorkLogActiveList(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        List<workLogActivityVO> result = workLogMapper.selectWorkLogActiveList(map);
        return result;
    }

    public List<workLogActivityVO> getLowKeyResultsActivitys(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogActivityVO> result = workLogMapper.getLowKeyResultsActivitys(map);
        return result;
    }

    public List<workLogCommentVO> selectWorkLogComment(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogCommentVO> result = workLogMapper.selectWorkLogComment(map);
        return result;
    }

    public List<workLogActivityVO> selectWorkLogActivity(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogActivityVO> result = workLogMapper.selectWorkLogActivity(map);
        return result;
    }

    public List<workLogPlanningKeyResultVO> selectWorkLogPlanningKeyResult(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        workLogListVO subResult = null;
        double edAmt = 0;
        double sum = 0;
        double rate = 0;
        List<workLogPlanningKeyResultVO> result = null;
        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = workLogMapper.selectWorkLogList(map).get(0);
        NumberFormat format = NumberFormat.getInstance();
        Number number = format.parse(subResult.getEdAmt());
        edAmt = number.doubleValue();

        // rate 세팅
        map.put("saveDivi", "01");
        map.put("checkInDivi", "01");
        result = workLogMapper.selectWorkLogPlanningKeyResult(map);
        for (int i = result.size(); 0 < i; i--) {
            workLogPlanningKeyResultVO row = result.get(i-1);
            sum = sum + Double.parseDouble(row.getAmt());
            rate = (double) Math.round((sum * 100) / edAmt);
            row.setRate(rate);
        }
        return result;
    }

    public List<workLogPlanningKeyResultVO> selectWorkLogPlanKeyResult(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        workLogListVO subResult = null;
        double amt = 0;
        double applyTotAmt = 0;
        double rate = 0;
        List<workLogPlanningKeyResultVO> result = null;
        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));

        // rate 세팅
        map.put("saveDivi", "01");
        map.put("checkInDivi", "01");
        result = workLogMapper.selectWorkLogPlanKeyResult(map);

        // number 세팅
        NumberFormat format = NumberFormat.getInstance();

        for (int i = result.size(); 0 < i; i--) {
            workLogPlanningKeyResultVO row = result.get(i-1);

            Number number = format.parse(row.getAmt());
            amt = number.doubleValue();

            number = format.parse(row.getApplyTotAmt());
            applyTotAmt = number.doubleValue();

            rate = (double) Math.round((applyTotAmt * 100) / amt);
            row.setRate(rate);
        }
        return result;
    }

    public List<workLogPlanningKeyResultVO> getWorkLogPlanningKeyResultChart(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("saveDivi", "01");
        map.put("checkInDivi", "01");
        List<workLogPlanningKeyResultVO> result = workLogMapper.getWorkLogPlanningKeyResultChart(map);
        workLogListVO subResult = null;
        double edAmt = 0;
        double sum = 0;


        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = workLogMapper.selectWorkLogList(map).get(0);
        if(subResult.getEdAmt() == null || subResult.getEdAmt().isEmpty()){
            subResult.setEdAmt("0");
        }
        NumberFormat format = NumberFormat.getInstance();
        Number number = format.parse(subResult.getEdAmt());
        edAmt = number.doubleValue();

        // 누적 합계값 세팅
        for (int i = 0; i < result.size(); i++) {
            workLogPlanningKeyResultVO row = result.get(i);
            sum = sum + Double.parseDouble(row.getAmt());
            row.setAmt(String.valueOf(sum));
            row.setEdAmt(edAmt);
        }
        return result;
    }

    public List<workLogCheckInKeyResultVO> selectWorkLogCheckInKeyResult(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        workLogListVO subResult = null;
        double edAmt = 0;
        double sum = 0;
        double rate = 0;
        List<workLogCheckInKeyResultVO> result = null;
        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = workLogMapper.selectWorkLogList(map).get(0);
        NumberFormat format = NumberFormat.getInstance();
        Number number = format.parse(subResult.getEdAmt());
        edAmt = number.doubleValue();

        // rate 세팅
        map.put("saveDivi", "01");
        map.put("checkInDivi", "02");
        result = workLogMapper.selectWorkLogCheckInKeyResult(map);
        for (int i = result.size(); 0 < i; i--) {
            workLogCheckInKeyResultVO row = result.get(i-1);
            sum = sum + Double.parseDouble(row.getAmt());
            rate = (double) Math.round((sum * 100) / edAmt);
            row.setRate(rate);
        }
        return result;
    }

    public List<workLogCheckInKeyResultVO> getWorkLogCheckInKeyResultChart(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("saveDivi", "01");
        map.put("checkInDivi1", "01"); // 계획값
        map.put("checkInDivi2", "02"); // 목표값
        List<workLogCheckInKeyResultVO> result = workLogMapper.getWorkLogCheckInKeyResultChart(map);
        workLogListVO subResult = null;
        double edAmt = 0;
        double sum1 = 0;
        double sum2 = 0;


        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = workLogMapper.selectWorkLogList(map).get(0);
        if(subResult.getEdAmt() == null || subResult.getEdAmt().isEmpty()){
            subResult.setEdAmt("0");
        }
        NumberFormat format = NumberFormat.getInstance();
        Number number = format.parse(subResult.getEdAmt());
        edAmt = number.doubleValue();

        // 누적 합계값 세팅
        for (int i = 0; i < result.size(); i++) {
            workLogCheckInKeyResultVO row = result.get(i);
            sum1 = sum1 + Double.parseDouble(row.getPlanningAmt());
            sum2 = sum2 + Double.parseDouble(row.getCkeckInamt());
            row.setPlanningAmt(String.valueOf(sum1));
            row.setCkeckInamt(String.valueOf(sum2));
            row.setEdAmt(edAmt);
        }
        return result;
    }

    public List<workLogSchDetailProgressChartVO> getWorkLogSchDetailProgressChart(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("saveDivi1", "01");
        map.put("checkInDivi1", "01"); // 계획값
        map.put("saveDivi2", "01");
        map.put("checkInDivi2", "02"); // 실적값
        map.put("planCdsDivi", "01"); // planCd가 있을때
        if(((List) map.get("planCds")).isEmpty()){
            map.put("planCdsDivi", "02"); // planCd가 없을때
        }
        List<workLogSchDetailProgressChartVO> result = workLogMapper.getWorkLogSchDetailProgressChart(map);
        return result;
    }

    public List<workLogSchDetailProgressChartVO> getWorkLogSchDetailProgressChartPlanList(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("saveDivi1", "01");
        map.put("checkInDivi1", "01"); // 계획값
        map.put("saveDivi2", "01");
        map.put("checkInDivi2", "02"); // 실적값
        map.put("planCdsDivi", "01"); // planCd가 있을때
        System.out.println(map);
        if(((List) map.get("planCds")).isEmpty()){
            map.put("planCdsDivi", "02"); // planCd가 없을때
        }
        List<workLogSchDetailProgressChartVO> result = workLogMapper.getWorkLogSchDetailProgressChartPlanList(map);
        return result;
    }

    public List<workLogListVO> getLowKeyResults(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogListVO> result = workLogMapper.getLowKeyResults(map);
        for (int i = 0, length = result.size(); i < length; i++) { /*여기*/
            workLogListVO vo = result.get(i);
            String statusDivi = vo.getStatusDivi();
            Double rate = vo.getRate();
            if (statusDivi == null || statusDivi.isBlank()) vo.setStatusDivi("01");
            else if (statusDivi.contains("03")) vo.setStatusDivi("03");
            else if (statusDivi.contains("02")) vo.setStatusDivi("02");
            else if (statusDivi.contains("01")) vo.setStatusDivi("01");
            else {
                if(rate >= 100.0) vo.setStatusDivi("04");
                else vo.setStatusDivi("02");
            };
        }
        return result;
    }

    public List<workLogListVO> getLowKeyResultsForSch(Map<String, Object> map) throws Exception {
        long startTime = System.currentTimeMillis();
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogListVO> result = workLogMapper.getLowKeyResultsForSch(map);
        int resultLength = result.size();
        try {
            for (int i = 0; i < resultLength; i++) {
                // 상태 데이터 세팅
                workLogListVO vo = result.get(i);
                String statusDivi = vo.getStatusDivi();
                Double rate = vo.getRate();
                if (statusDivi == null || statusDivi.isBlank()) vo.setStatusDivi("01");
                else if (statusDivi.contains("03")) vo.setStatusDivi("03");
                else if (statusDivi.contains("02")) vo.setStatusDivi("02");
                else if (statusDivi.contains("01")) vo.setStatusDivi("01");
                else {
                    if(rate >= 100.0) vo.setStatusDivi("04");
                    else vo.setStatusDivi("02");
                };

                // 활동 데이터 추적
                Map<String, Object> planCd = new HashMap<>();
                planCd = map;
                planCd.put("planCd", vo.getPlanCd());
                planCd.put("OkrDiv", "02");
                Map<String, Object> cntMap = workLogMapper.selectWorkLogActivityCount(planCd);

                // 활동 수 세팅
                int cnt = 0;
                if(cntMap != null) cnt = Integer.parseInt(cntMap.get("cnt").toString());

                // 수 세팅에 따른 색상 세팅
                String cntColor = "#fff";
                if(cnt > 0) cntColor = "#efefef";
                vo.setCntColor(cntColor);
            }
            // result 리스트 정렬
            Collections.sort(result, new Comparator<workLogListVO>() {
                @Override
                public int compare(workLogListVO o1, workLogListVO o2) {
                    // getCntColor 값이 #efefef 인 경우 맨 위로 오도록 설정
                    return o1.getCntColor().compareTo(o2.getCntColor());
                }
            });
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        long endTime = System.currentTimeMillis();
        long elapsedTime = endTime - startTime;

        System.out.println("실행 시간: " + elapsedTime + " 밀리초");
        return result;
    }

    public Map<String,String> getPlanCdRoot(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        Map<String,String> result = workLogMapper.getPlanCdRoot(map);
        return result;
    }

    public List<workLogListVO> getPartCds(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());

        // 공동작업자 리스트 세팅
        List<workLogListVO> partCdArrResult = workLogMapper.getWorkCds(map);
        String partCds = "";
        for (int i = 0, length = partCdArrResult.size(); i < length; i++) {
            Map<String, Object> searchResult = (Map<String, Object>) partCdArrResult.get(i);
            if(i==0) partCds += searchResult.get("partCds");
            else partCds += ","+searchResult.get("partCds");
        }

        // 담당자 리스트 세팅
        List<workLogListVO> partCdArrResult2 = workLogMapper.getPartCds(map);
        for (int i = 0, resultLength = partCdArrResult2.size(); i < resultLength; i++) {
            Map<String, Object> rst = (Map<String, Object>) partCdArrResult2.get(i);
            if(partCds.equals("")) partCds += rst.get("empCd");
            else partCds += ","+rst.get("empCd");
        }

        // 담당자, 공동작업자 중복 삭제
        String[] partCdArr = partCds.split(",");
        Set<String> partCdsSet = new LinkedHashSet<>(Arrays.asList(partCdArr));
        partCdArr = partCdsSet.toArray(new String[0]);

        // 공동작업자 정보 세팅
        Map<String, Object> param = Map.of(
                "corpCd",SessionUtil.getUser().getCorpCd(),
                "partCdArr",partCdArr
        );

        List<workLogListVO> result = workLogMapper.getEmpCds(param);
        for (int i = 0, length = result.size(); i < length; i++) {
            Map<String, Object> searchResult = (Map<String, Object>) result.get(i);
            searchResult.put("partImg","/BASE_USER_MGT_LIST/selectUserFaceImageEdms/"+searchResult.get("corpCd")+":"+searchResult.get("empCd"));
        }

        return result;
    }

    public List<workLogListVO> getWorkCds(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());

        // 공동작업자 리스트 세팅
        List<workLogListVO> partCdArrResult = workLogMapper.getWorkCds(map);
        String partCds = "";
        for (int i = 0, length = partCdArrResult.size(); i < length; i++) {
            Map<String, Object> searchResult = (Map<String, Object>) partCdArrResult.get(i);
            if(i==0) partCds += searchResult.get("partCds");
            else partCds += ","+searchResult.get("partCds");
        }

        // 공동작업자 중복 삭제
        String[] partCdArr = partCds.split(",");
        Set<String> partCdsSet = new LinkedHashSet<>(Arrays.asList(partCdArr));
        partCdArr = partCdsSet.toArray(new String[0]);

        // 공동작업자 정보 세팅
        Map<String, Object> param = Map.of(
                "corpCd",SessionUtil.getUser().getCorpCd(),
                "partCdArr",partCdArr
        );
        List<workLogListVO> result = workLogMapper.getEmpCds(param);
        for (int i = 0, length = result.size(); i < length; i++) {
            Map<String, Object> searchResult = (Map<String, Object>) result.get(i);
            searchResult.put("partImg","/BASE_USER_MGT_LIST/selectUserFaceImageEdms/"+searchResult.get("corpCd")+":"+searchResult.get("empCd"));
        }

        return result;
    }

    @Transactional
    public Map<String, Object> cudWorkLogList(Map<String, Object> map) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            Map<String, Object> param = (Map<String, Object>) map.get("formData");
            // grid 처리: 삭제
            if(param.containsKey("rows")){
                List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("rows"); // rows to list
                for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                    String status = rows.get(i).get("status").toString();
                    if(status.equals("D")) {
                        workLogMapper.deleteWorkLogList(rows.get(i));
                        returnData.put("status","success");
                        returnData.put("note","성공적으로 삭제되었습니다.");
                    }
                }
            }
            // modal 처리: 신규
            else {
                // modalKeyName to DBColumns
                List<String> searchStrings = Arrays.asList(
                        "insertPlanModal", "detailPlanModal",
                        "insertKeyResultModal", "detailKeyResultModal"); // modalData List
                Map<String, Object> saveData = new HashMap<>(); // 저장 하기 위한 데이터 객체
                param.forEach((key, value) -> {
                    String newKey = key;
                    for (String searchString : searchStrings) { // 모든 검색 문자열에 대해 확인
                        if (newKey.contains(searchString)) { // 해당 문자열 제거
                            newKey = newKey.replace(searchString, "");
                            break; // 한 번 일치하는 경우가 발견되면 루프 종료
                        }
                    }
                    if (newKey.length() > 0) { // 새 키의 첫 글자를 소문자로 변환 (비어있지 않은 경우)
                        newKey = newKey.substring(0, 1).toLowerCase() + newKey.substring(1);
                    }
                    if(newKey.contains("stDt") || newKey.contains("edDt")) value = Util.removeMinusChar((String) value); // 날짜 "-" 삭제
                    saveData.put(newKey, value); // 변환된 키로 새로운 맵에 추가
                });
                saveData.put("userId", SessionUtil.getUser().getEmpCd());

                if(saveData.get("planCd").equals("")){ // 신규
                    saveData.put("edRate", "0");
                    // 팀원일 경우 "요청" 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) { saveData.put("saveDivi", "01");}
                    // 대표 이사, 이사, 팀장일 경우 "즉시 승인" 처리
                    else { saveData.put("saveDivi", "02");}
                    workLogMapper.insertWorkLogList(saveData);

                    returnData.put("status","success");
                    returnData.put("note","성공적으로 입력되었습니다.");
                }else { // 수정
                    saveData.put("userId", SessionUtil.getUser().getEmpCd());
                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        if(saveData.get("empCd").equals(SessionUtil.getUser().getEmpCd())){
                            returnData.put("status","success");
                            if(saveData.get("status").equals("U")) {
                                workLogMapper.updateWorkLogList(saveData);
                                returnData.put("note","성공적으로 변경되었습니다.");
                            }
                            if(saveData.get("status").equals("D")) {
                                workLogMapper.deleteWorkLogList(saveData);
                                returnData.put("note","성공적으로 삭제되었습니다.");
                            }

                        }
                        // 다른사람들 것은 삭제 비활성화
                        else{
                            returnData.put("status","fail");
                            returnData.put("note","변경 권한이 없습니다.");
                        }
                    }
                    // 대표 이사, 이사, 팀장일 경우 "즉시 수정" 처리
                    else {
                        returnData.put("status","success");
                        if(saveData.get("status").equals("U")) {
                            workLogMapper.updateWorkLogList(saveData);
                            returnData.put("note","성공적으로 변경되었습니다.");
                        }
                        if(saveData.get("status").equals("D")) {
                            workLogMapper.deleteWorkLogList(saveData);
                            returnData.put("note","성공적으로 삭제되었습니다.");
                        }
                    }
                }
            }
        } catch (Exception e) {
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }
        return returnData;
    }

    public Map<String, Object> cdWorkLogComment(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            map.put("userId", SessionUtil.getUser().getEmpCd());
            map.put("corpCd", SessionUtil.getUser().getCorpCd());
            map.put("busiCd", SessionUtil.getUser().getBusiCd());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());

            switch (status) {
                case "C" -> {
                    try {
                        map.put("saveDivi", "01");
                        workLogMapper.insertWorkLogContent(map);
                        returnData.put("note","");
                    }catch (Exception e){

                        String exc = e.toString();
                        returnData.put("status","fail");
                        returnData.put("exc",exc);
                        returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
                        e.printStackTrace();

                    }
                    // 알람 저장
                    Map<String, Object> alarmData = new HashMap<>();
                    alarmData.put("corpCd",map.get("corpCd").toString());
                    alarmData.put("empCd",SessionUtil.getUser().getEmpCd());
                    alarmData.put("empNm",SessionUtil.getUser().getEmpNm());
                    alarmData.put("navMessage","["+map.get("planNm").toString()+"]에 '"+map.get("content").toString()+ "' 코멘트가 등록되었습니다.");
                    alarmData.put("inpId",map.get("userId").toString());
                    alarmData.put("updId",map.get("userId").toString());
                    alarmData.put("submitCd",map.get("planCd").toString());
                    alarmData.put("submitNm","성과기획 - " + map.get("planNm").toString() + " 코멘트의 건");
                    alarmData.put("stateDivi","07");
                    alarmData.put("readDivi","00");
                    alarmData.put("saveDivi","00");

                    alarmData.put("target",map.get("empCd"));
                    List<String> partCds = (List<String>) map.get("partCds");
                    partCds.add(map.get("empCd").toString());
                    partCds = partCds.stream()
                            .distinct()
                            .collect(Collectors.toList());
                    int partCdsLength = partCds.size();
                    for (int i = 0; i < partCdsLength; i++) {
                        alarmData.put("id",partCds.get(i));
                        alarmData.put("target",partCds.get(i));
                        alarmService.insertAlarmList(alarmData);
                    }
                    break;
                }
                case "D" -> {

                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        if(map.get("inpId").toString().equals(SessionUtil.getUser().getEmpCd())){
                            map.put("saveDivi", "02");
                            workLogMapper.deleteWorkLogContent(map);
                            returnData.put("note","성공적으로 내역이 삭제되었습니다.");
                        }
                        // 다른사람들 것은 삭제 비활성화
                        else{
                            returnData.put("status","fail");
                            returnData.put("note","변경 권한이 없습니다.");
                        }
                    }
                    // 대표 이사, 이사, 팀장일 경우 "즉시 삭제" 처리
                    else {
                        map.put("saveDivi", "02");
                        workLogMapper.deleteWorkLogContent(map);
                        returnData.put("note","성공적으로 내역이 삭제되었습니다.");
                    }
                    break;
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

    public Map<String, Object> cdWorkLogActivity(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            map.put("userId", SessionUtil.getUser().getEmpCd());
            map.put("corpCd", SessionUtil.getUser().getCorpCd());
            map.put("busiCd", SessionUtil.getUser().getBusiCd());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());

            switch (status) {
                case "C" -> {
                    // 활동 저장
                    try {
                        map.put("saveDivi", "01");
                        map.put("activityDt", Util.removeMinusChar(map.get("activityDt").toString()));
                        workLogMapper.insertWorkLogActivity(map);
                        returnData.put("note","");
                    }catch (Exception e){

                        String exc = e.toString();
                        returnData.put("status","fail");
                        returnData.put("exc",exc);
                        returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
                        e.printStackTrace();

                    }
                    // 알람 저장
                    Map<String, Object> alarmData = new HashMap<>();
                    alarmData.put("corpCd",map.get("corpCd").toString());
                    alarmData.put("empCd",SessionUtil.getUser().getEmpCd());
                    alarmData.put("empNm",SessionUtil.getUser().getEmpNm());
                    alarmData.put("navMessage","["+map.get("planNm").toString()+"]에 '"+map.get("content").toString()+ "' 활동이 등록되었습니다.");
                    alarmData.put("inpId",map.get("userId").toString());
                    alarmData.put("updId",map.get("userId").toString());
                    alarmData.put("submitCd",map.get("planCd").toString());
                    alarmData.put("submitNm","성과기획 - " + map.get("planNm").toString() + " 활동의 건");
                    alarmData.put("stateDivi","05");
                    alarmData.put("readDivi","00");
                    alarmData.put("saveDivi","00");

                    alarmData.put("target",map.get("empCd"));
                    List<String> partCds = (List<String>) map.get("partCds");
                    partCds.add(map.get("empCd").toString());
                    partCds = partCds.stream()
                            .distinct()
                            .collect(Collectors.toList());
                    int partCdsLength = partCds.size();
                    for (int i = 0; i < partCdsLength; i++) {
                        alarmData.put("id",partCds.get(i));
                        alarmData.put("target",partCds.get(i));
                        alarmService.insertAlarmList(alarmData);
                    }
                    break;
                }
                case "D" -> {

                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        if(map.get("inpId").toString().equals(SessionUtil.getUser().getEmpCd())){
                            map.put("saveDivi", "02");
                            workLogMapper.deleteWorkLogActivity(map);
                            returnData.put("note","성공적으로 내역이 삭제되었습니다.");
                        }
                        // 다른사람들 것은 삭제 비활성화
                        else{
                            returnData.put("status","fail");
                            returnData.put("note","변경 권한이 없습니다.");
                        }
                    }
                    // 대표 이사, 이사, 팀장일 경우 "즉시 삭제" 처리
                    else {
                        map.put("saveDivi", "02");
                        workLogMapper.deleteWorkLogActivity(map);
                        returnData.put("note","성공적으로 내역이 삭제되었습니다.");
                    }
                    break;
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
    public Map<String, Object> cudWorkLogPlanningKeyResult(Map<String, Object> map) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            Map<String, Object> param = (Map<String, Object>) map.get("formData");
            // grid 처리: 삭제
            if(param.containsKey("rows")){
                List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("rows"); // rows to list
                for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                    String status = rows.get(i).get("status").toString();
                    if(status.equals("D")) {
                        workLogMapper.deleteWorkLogList(rows.get(i));
                        returnData.put("status","success");
                        returnData.put("note","성공적으로 삭제되었습니다.");
                    }
                }
            }
            // modal 처리: 신규
            else {
                // modalKeyName to DBColumns
                List<String> searchStrings = Arrays.asList(
                        "planningKeyResultModal", "insertPlanningKeyResultModal"); // modalData List
                Map<String, Object> saveData = new HashMap<>(); // 저장 하기 위한 데이터 객체
                param.forEach((key, value) -> {
                    String newKey = key;
                    for (String searchString : searchStrings) { // 모든 검색 문자열에 대해 확인
                        if (newKey.contains(searchString)) { // 해당 문자열 제거
                            newKey = newKey.replace(searchString, "");
                            break; // 한 번 일치하는 경우가 발견되면 루프 종료
                        }
                    }
                    if (newKey.length() > 0) { // 새 키의 첫 글자를 소문자로 변환 (비어있지 않은 경우)
                        newKey = newKey.substring(0, 1).toLowerCase() + newKey.substring(1);
                    }
                    if(newKey.contains("dt")) value = Util.removeMinusChar((String) value); // 날짜 "-" 삭제
                    saveData.put(newKey, value); // 변환된 키로 새로운 맵에 추가
                });
                saveData.put("userId", SessionUtil.getUser().getEmpCd());
                saveData.put("busiCd", SessionUtil.getUser().getBusiCd());
                saveData.put("depaCd", SessionUtil.getUser().getDepaCd());
                saveData.put("amt",Util.removeCommaChar(saveData.get("amt").toString()));

                if(saveData.get("seq").equals("")){ // 신규
                    saveData.put("saveDivi", "01");
                    workLogMapper.insertWorkLogPlanningKeyResult(saveData);

                    returnData.put("status","success");
                    returnData.put("note","성공적으로 입력되었습니다.");
                }else { // 수정
                    saveData.put("userId", SessionUtil.getUser().getEmpCd());
                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        if(saveData.get("inpId").equals(SessionUtil.getUser().getEmpCd())){
                            returnData.put("status","success");
                            if(saveData.get("status").equals("U")) {
                                workLogMapper.updateWorkLogPlanningKeyResult(saveData);
                                returnData.put("note","성공적으로 변경되었습니다.");
                            }
                            if(saveData.get("status").equals("D")) {
                                workLogMapper.deleteWorkLogPlanningKeyResult(saveData);
                                returnData.put("note","성공적으로 삭제되었습니다.");
                            }

                        }
                        // 다른사람들 것은 삭제 비활성화
                        else{
                            returnData.put("status","fail");
                            returnData.put("note","변경 권한이 없습니다.");
                        }
                    }
                    // 대표 이사, 이사, 팀장일 경우 "즉시 수정" 처리
                    else {
                        returnData.put("status","success");
                        if(saveData.get("status").equals("U")) {
                            workLogMapper.updateWorkLogPlanningKeyResult(saveData);
                            returnData.put("note","성공적으로 변경되었습니다.");
                        }
                        if(saveData.get("status").equals("D")) {
                            workLogMapper.deleteWorkLogPlanningKeyResult(saveData);
                            returnData.put("note","성공적으로 삭제되었습니다.");
                        }
                    }
                }
            }
        } catch (Exception e) {
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }
        return returnData;
    }

    @Transactional
    public Map<String, Object> cudWorkLogCheckInKeyResult(Map<String, Object> map) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            Map<String, Object> param = (Map<String, Object>) map.get("formData");
            // grid 처리: 삭제
            if(param.containsKey("rows")){
                List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("rows"); // rows to list
                for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                    String status = rows.get(i).get("status").toString();
                    if(status.equals("D")) {
                        workLogMapper.deleteWorkLogList(rows.get(i));
                        returnData.put("status","success");
                        returnData.put("note","성공적으로 삭제되었습니다.");
                    }
                }
            }
            // modal 처리: 신규
            else {
                // modalKeyName to DBColumns
                List<String> searchStrings = Arrays.asList(
                        "checkInKeyResultModal", "insertCheckInKeyResultModal"); // modalData List
                Map<String, Object> saveData = new HashMap<>(); // 저장 하기 위한 데이터 객체
                param.forEach((key, value) -> {
                    String newKey = key;
                    for (String searchString : searchStrings) { // 모든 검색 문자열에 대해 확인
                        if (newKey.contains(searchString)) { // 해당 문자열 제거
                            newKey = newKey.replace(searchString, "");
                            break; // 한 번 일치하는 경우가 발견되면 루프 종료
                        }
                    }
                    if (newKey.length() > 0) { // 새 키의 첫 글자를 소문자로 변환 (비어있지 않은 경우)
                        newKey = newKey.substring(0, 1).toLowerCase() + newKey.substring(1);
                    }
                    if(newKey.contains("dt")) value = Util.removeMinusChar((String) value); // 날짜 "-" 삭제
                    saveData.put(newKey, value); // 변환된 키로 새로운 맵에 추가
                });
                saveData.put("userId", SessionUtil.getUser().getEmpCd());
                saveData.put("busiCd", SessionUtil.getUser().getBusiCd());
                saveData.put("depaCd", SessionUtil.getUser().getDepaCd());
                saveData.put("amt",Util.removeCommaChar(saveData.get("amt").toString()));

                if(saveData.get("seq").equals("")){ // 신규
                    saveData.put("saveDivi", "01");
                    workLogMapper.insertWorkLogCheckInKeyResult(saveData);

                    returnData.put("status","success");
                    returnData.put("note","성공적으로 입력되었습니다.");
                }else { // 수정
                    saveData.put("userId", SessionUtil.getUser().getEmpCd());
                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        System.out.println("여기");
                        System.out.println(saveData);
                        if(saveData.get("inpId").equals(SessionUtil.getUser().getEmpCd())){
                            returnData.put("status","success");
                            if(saveData.get("status").equals("U")) {
                                workLogMapper.updateWorkLogCheckInKeyResult(saveData);
                                returnData.put("note","성공적으로 변경되었습니다.");
                            }
                            if(saveData.get("status").equals("D")) {
                                workLogMapper.deleteWorkLogCheckInKeyResult(saveData);
                                returnData.put("note","성공적으로 삭제되었습니다.");
                            }

                        }
                        // 다른사람들 것은 삭제 비활성화
                        else{
                            returnData.put("status","fail");
                            returnData.put("note","변경 권한이 없습니다.");
                        }
                    }
                    // 대표 이사, 이사, 팀장일 경우 "즉시 수정" 처리
                    else {
                        returnData.put("status","success");
                        if(saveData.get("status").equals("U")) {
                            workLogMapper.updateWorkLogCheckInKeyResult(saveData);
                            returnData.put("note","성공적으로 변경되었습니다.");
                        }
                        if(saveData.get("status").equals("D")) {
                            workLogMapper.deleteWorkLogCheckInKeyResult(saveData);
                            returnData.put("note","성공적으로 삭제되었습니다.");
                        }
                    }
                }
            }
        } catch (Exception e) {
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }
        return returnData;
    }

    @Transactional
    public Map<String, Object> cudWorkLogOrderPlanList(Map<String, Object> param) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            returnData.put("status","success");
            List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("param");
            DateTimeFormatter formatter = null;
            YearMonth yearMonth = null;
            LocalDate lastDay = null;
            String stDt = null;
            for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                Map<String, Object> row = rows.get(i);
                String status = row.get("status").toString();
                switch (status){
                    case "C" -> {
                        row.put("ordPlanCd",row.get("ordPlanCd"));
                        row.put("planDivi","02");
                        row.put("planNm","["+row.get("ordPlanYear").toString()+"."+row.get("ordPlanMonth").toString()+"]"+row.get("ordPlanCustCd"));
                        row.put("busiCd",row.get("ordPlanBusiCd"));
                        row.put("depaCd",row.get("ordPlanDepaCd"));
                        row.put("empCd",row.get("ordPlanEmpCd"));
                        row.put("unit","백만 원");
                        row.put("stAmt","0");
                        row.put("edAmt",row.get("ordPlanAmt"));

                        stDt = row.get("ordPlanYear").toString() + row.get("ordPlanMonth").toString();
                        row.put("stDt",stDt+"01");
                        formatter = DateTimeFormatter.ofPattern("yyyyMM");
                        yearMonth = YearMonth.parse(stDt, formatter);
                        lastDay = yearMonth.atEndOfMonth();
                        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
                        row.put("edDt",lastDay.format(outputFormatter));

                        row.put("note",row.get("ordPlanNote"));
                        row.put("edRate","0");
                        row.put("edDivi","");
                        row.put("saveDivi","02");
                        row.put("userId",SessionUtil.getUser().getEmpCd());
                        workLogMapper.insertWorkLogList(row);
                            returnData.put("note","성공적으로 입력되었습니다.");
                    }
                }
            }
        } catch (Exception e) {
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }
        return returnData;
    }

    @Transactional
    public Map<String, Object> cudWorkLogKeyResultPlanList(Map<String, Object> param) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            returnData.put("status","success");
            List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("param");
            DateTimeFormatter formatter = null;
            for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                Map<String, Object> row = rows.get(i);
                String status = row.get("status").toString();
                switch (status){
                    case "C" -> {
                        System.out.println("여기여기");
                        System.out.println(row);

                        // 현재 날짜를 가져오기
                        LocalDate currentDate = LocalDate.now();
                        // 한국 형식의 날짜 문자열로 포맷하기 (YYYYMMDD)
                        formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
                        String formattedDate = currentDate.format(formatter);

                        row.put("planSeq",row.get("seq").toString());
                        row.put("saveDivi","01");
                        row.put("checkInDivi","02");
                        row.put("dt", formattedDate);
                        row.put("amt", Util.removeCommaChar(row.get("applyAmt").toString()));
                        row.put("statusDivi","04");
                        row.put("userId",SessionUtil.getUser().getEmpCd());
                        workLogMapper.insertWorkLogPlanningKeyResult(row);
                        returnData.put("note","성공적으로 입력되었습니다.");
                    }
                }
            }
        } catch (Exception e) {
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }
        return returnData;
    }

    @Transactional
    public Map<String, Object> synchronizationWorkLogList(Map<String, Object> param) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            returnData.put("status","success");
            param.put("corpCd", SessionUtil.getUser().getCorpCd());
            param.put("userId", SessionUtil.getUser().getEmpCd());
            /* 수주계획 동기화*/
            workLogMapper.synchronizationOrderPlanToWorkLogList(param);

            /* 프로젝트 동기화*/
//            workLogMapper.synchronizationProjectToWorkLogList(param);
            returnData.put("note","");

        } catch (Exception e) {
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }
        return returnData;
    }
}