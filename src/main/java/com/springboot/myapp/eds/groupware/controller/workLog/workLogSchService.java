package com.springboot.myapp.eds.groupware.controller.workLog;

import com.springboot.myapp.eds.groupware.vo.workLog.*;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class workLogSchService {

    @Autowired
    private workLogSchMapper WorkLogSchMapper;

    public List<workLogSchListVO> selectWorkLogSchList(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        String searchDivi = (String) map.get("searchDivi");
        List<workLogSchListVO> result = null;
        List<workLogSchListVO> subResult = null;
        if(searchDivi.equals("03")){ // 전사적 목표
            result = WorkLogSchMapper.selectWorkLogSchList(map);
        }else{ // 내목표, 부서별 최상위 부모 연동
            // planCdRoot 조회
            subResult = WorkLogSchMapper.selectWorkLogSchList(map);
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
            result = WorkLogSchMapper.selectWorkLogSchList(map);
        }

        for (int i = 0, length = result.size(); i < length; i++) {
            workLogSchListVO vo = result.get(i);
            String statusDivi = vo.getStatusDivi();
            if (statusDivi == null || statusDivi.isBlank()) vo.setStatusDivi("01");
            else if (statusDivi.contains("03")) vo.setStatusDivi("03");
            else if (statusDivi.contains("02")) vo.setStatusDivi("02");
            else if (statusDivi.contains("01")) vo.setStatusDivi("01");
            else vo.setStatusDivi("04");
        }

        return result;
    }

    public List<workLogCommentVO> selectWorkLogSchComment(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogCommentVO> result = WorkLogSchMapper.selectWorkLogSchComment(map);
        return result;
    }

    public List<workLogActivityVO> selectWorkLogSchActivity(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogActivityVO> result = WorkLogSchMapper.selectWorkLogSchActivity(map);
        return result;
    }

    public List<workLogPlanningKeyResultVO> selectWorkLogSchPlanningKeyResult(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        workLogSchListVO subResult = null;
        double edAmt = 0;
        double sum = 0;
        double rate = 0;
        List<workLogPlanningKeyResultVO> result = null;
        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = WorkLogSchMapper.selectWorkLogSchList(map).get(0);
        edAmt = Double.parseDouble(subResult.getEdAmt());

        // rate 세팅
        map.put("saveDivi", "01");
        map.put("checkInDivi", "01");
        result = WorkLogSchMapper.selectWorkLogSchPlanningKeyResult(map);
        for (int i = result.size(); 0 < i; i--) {
            workLogPlanningKeyResultVO row = result.get(i-1);
            sum = sum + Double.parseDouble(row.getAmt());
            rate = (double) Math.round((sum * 100) / edAmt);
            row.setRate(rate);
        }
        return result;
    }

    public List<workLogPlanningKeyResultVO> getWorkLogSchPlanningKeyResultChart(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("saveDivi", "01");
        map.put("checkInDivi", "01");
        List<workLogPlanningKeyResultVO> result = WorkLogSchMapper.getWorkLogSchPlanningKeyResultChart(map);
        workLogSchListVO subResult = null;
        double edAmt = 0;
        double sum = 0;


        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = WorkLogSchMapper.selectWorkLogSchList(map).get(0);
        if(subResult.getEdAmt() == null || subResult.getEdAmt().isEmpty()){
            subResult.setEdAmt("0");
        }
        edAmt = Double.parseDouble(subResult.getEdAmt());

        // 누적 합계값 세팅
        for (int i = 0; i < result.size(); i++) {
            workLogPlanningKeyResultVO row = result.get(i);
            sum = sum + Double.parseDouble(row.getAmt());
            row.setAmt(String.valueOf(sum));
            row.setEdAmt(edAmt);
        }
        return result;
    }

    public List<workLogCheckInKeyResultVO> selectWorkLogSchCheckInKeyResult(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        workLogSchListVO subResult = null;
        double edAmt = 0;
        double sum = 0;
        double rate = 0;
        List<workLogCheckInKeyResultVO> result = null;
        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = WorkLogSchMapper.selectWorkLogSchList(map).get(0);
        edAmt = Double.parseDouble(subResult.getEdAmt());

        // rate 세팅
        map.put("saveDivi", "01");
        map.put("checkInDivi", "02");
        result = WorkLogSchMapper.selectWorkLogSchCheckInKeyResult(map);
        for (int i = result.size(); 0 < i; i--) {
            workLogCheckInKeyResultVO row = result.get(i-1);
            sum = sum + Double.parseDouble(row.getAmt());
            rate = (double) Math.round((sum * 100) / edAmt);
            row.setRate(rate);
        }
        return result;
    }

    public List<workLogCheckInKeyResultVO> getWorkLogSchCheckInKeyResultChart(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        extracted(map);
        map.put("checkInDivi1", "01"); // 계획값
        map.put("checkInDivi2", "02"); // 목표값
        List<workLogCheckInKeyResultVO> result = WorkLogSchMapper.getWorkLogSchCheckInKeyResultChart(map);
        workLogSchListVO subResult = null;
        double edAmt = 0;
        double sum1 = 0;
        double sum2 = 0;


        // 목표값 조회
        map.put("searchDivi","");
        map.put("planCdSearch",map.get("planCd"));
        subResult = WorkLogSchMapper.selectWorkLogSchList(map).get(0);
        if(subResult.getEdAmt() == null || subResult.getEdAmt().isEmpty()){
            subResult.setEdAmt("0");
        }
        edAmt = Double.parseDouble(subResult.getEdAmt());

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

    private static void extracted(Map<String, Object> map) {
        map.put("saveDivi", "01");
    }

    public List<workLogSchListVO> getLowKeyResults(Map<String, Object> map) throws Exception {
        List<workLogSchListVO> result = WorkLogSchMapper.getLowKeyResults(map);
        for (int i = 0, length = result.size(); i < length; i++) {
            workLogSchListVO vo = result.get(i);
            String statusDivi = vo.getStatusDivi();
            if (statusDivi == null || statusDivi.isBlank()) vo.setStatusDivi("01");
            else if (statusDivi.contains("03")) vo.setStatusDivi("03");
            else if (statusDivi.contains("02")) vo.setStatusDivi("02");
            else if (statusDivi.contains("01")) vo.setStatusDivi("01");
            else vo.setStatusDivi("04");
        }
        return result;
    }

    public Map<String,String> getPlanCdRoot(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        Map<String,String> result = WorkLogSchMapper.getPlanCdRoot(map);
        return result;
    }

    public List<workLogSchListVO> getPartCds(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<workLogSchListVO> result = WorkLogSchMapper.getPartCds(map);
        for (int i = 0, resultLength = result.size(); i < resultLength; i++) {
            Map<String, Object> rst = (Map<String, Object>) result.get(i);
            rst.put("partImg","/BASE_USER_MGT_LIST/selectUserFaceImageEdms/"+rst.get("corpCd")+":"+rst.get("empCd"));
        }
        return result;
    }

    public List<workLogSchListVO> getWorkCds(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());

        // 담당자 리스트 세팅
        List<workLogSchListVO> partCdArrResult = WorkLogSchMapper.getWorkCds(map);
        String partCds = "";
        for (int i = 0, length = partCdArrResult.size(); i < length; i++) {
            Map<String, Object> searchResult = (Map<String, Object>) partCdArrResult.get(i);
            if(i==0) partCds += searchResult.get("partCds");
            else partCds += ","+searchResult.get("partCds");
        }

        String[] partCdArr = partCds.split(",");
        Set<String> partCdsSet = new LinkedHashSet<>(Arrays.asList(partCdArr));
        partCdArr = partCdsSet.toArray(new String[0]);

        // 담당자 정보 세팅
        Map<String, Object> param = Map.of(
                "corpCd",SessionUtil.getUser().getCorpCd(),
                "partCdArr",partCdArr
        );
        List<workLogSchListVO> result = WorkLogSchMapper.getEmpCds(param);
        for (int i = 0, length = result.size(); i < length; i++) {
            Map<String, Object> searchResult = (Map<String, Object>) result.get(i);
            searchResult.put("partImg","/BASE_USER_MGT_LIST/selectUserFaceImageEdms/"+searchResult.get("corpCd")+":"+searchResult.get("empCd"));
        }

        return result;
    }

    @Transactional
    public Map<String, Object> cudWorkLogSchList(Map<String, Object> map) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            Map<String, Object> param = (Map<String, Object>) map.get("formData");
            // grid 처리: 삭제
            if(param.containsKey("rows")){
                List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("rows"); // rows to list
                for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                    String status = rows.get(i).get("status").toString();
                    if(status.equals("D")) {
                        WorkLogSchMapper.deleteWorkLogSchList(rows.get(i));
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
                    WorkLogSchMapper.insertWorkLogSchList(saveData);

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
                                WorkLogSchMapper.updateWorkLogSchList(saveData);
                                returnData.put("note","성공적으로 변경되었습니다.");
                            }
                            if(saveData.get("status").equals("D")) {
                                WorkLogSchMapper.deleteWorkLogSchList(saveData);
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
                            WorkLogSchMapper.updateWorkLogSchList(saveData);
                            returnData.put("note","성공적으로 변경되었습니다.");
                        }
                        if(saveData.get("status").equals("D")) {
                            WorkLogSchMapper.deleteWorkLogSchList(saveData);
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

    public Map<String, Object> cdWorkLogSchComment(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            map.put("userId", SessionUtil.getUser().getEmpCd());
            map.put("corpCd", SessionUtil.getUser().getCorpCd());
            map.put("busiCd", SessionUtil.getUser().getBusiCd());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());

            switch (status) {
                case "C" -> {
                    map.put("saveDivi", "01");
                    WorkLogSchMapper.insertWorkLogSchContent(map);
                    returnData.put("note","");
                    break;
                }
                case "D" -> {

                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        if(map.get("inpId").toString().equals(SessionUtil.getUser().getEmpCd())){
                            map.put("saveDivi", "02");
                            WorkLogSchMapper.deleteWorkLogSchContent(map);
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
                        WorkLogSchMapper.deleteWorkLogSchContent(map);
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

    public Map<String, Object> cdWorkLogSchActivity(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            map.put("userId", SessionUtil.getUser().getEmpCd());
            map.put("corpCd", SessionUtil.getUser().getCorpCd());
            map.put("busiCd", SessionUtil.getUser().getBusiCd());
            map.put("depaCd", SessionUtil.getUser().getDepaCd());

            switch (status) {
                case "C" -> {
                    map.put("saveDivi", "01");
                    WorkLogSchMapper.insertWorkLogSchActivity(map);
                    returnData.put("note","");
                    break;
                }
                case "D" -> {

                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        if(map.get("inpId").toString().equals(SessionUtil.getUser().getEmpCd())){
                            map.put("saveDivi", "02");
                            WorkLogSchMapper.deleteWorkLogSchActivity(map);
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
                        WorkLogSchMapper.deleteWorkLogSchActivity(map);
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
    public Map<String, Object> cudWorkLogSchPlanningKeyResult(Map<String, Object> map) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            Map<String, Object> param = (Map<String, Object>) map.get("formData");
            // grid 처리: 삭제
            if(param.containsKey("rows")){
                List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("rows"); // rows to list
                for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                    String status = rows.get(i).get("status").toString();
                    if(status.equals("D")) {
                        WorkLogSchMapper.deleteWorkLogSchList(rows.get(i));
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

                if(saveData.get("seq").equals("")){ // 신규
                    saveData.put("saveDivi", "01");
                    WorkLogSchMapper.insertWorkLogSchPlanningKeyResult(saveData);

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
                                WorkLogSchMapper.updateWorkLogSchPlanningKeyResult(saveData);
                                returnData.put("note","성공적으로 변경되었습니다.");
                            }
                            if(saveData.get("status").equals("D")) {
                                WorkLogSchMapper.deleteWorkLogSchPlanningKeyResult(saveData);
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
                            WorkLogSchMapper.updateWorkLogSchPlanningKeyResult(saveData);
                            returnData.put("note","성공적으로 변경되었습니다.");
                        }
                        if(saveData.get("status").equals("D")) {
                            WorkLogSchMapper.deleteWorkLogSchPlanningKeyResult(saveData);
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
    public Map<String, Object> cudWorkLogSchCheckInKeyResult(Map<String, Object> map) throws Exception {
        Map<String, Object> returnData = new HashMap<>();
        try {
            Map<String, Object> param = (Map<String, Object>) map.get("formData");
            // grid 처리: 삭제
            if(param.containsKey("rows")){
                List<Map<String, Object>> rows = (List<Map<String, Object>>) param.get("rows"); // rows to list
                for (int i = 0, rowsLength = rows.size(); i < rowsLength; i++) {
                    String status = rows.get(i).get("status").toString();
                    if(status.equals("D")) {
                        WorkLogSchMapper.deleteWorkLogSchList(rows.get(i));
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

                if(saveData.get("seq").equals("")){ // 신규
                    saveData.put("saveDivi", "01");
                    WorkLogSchMapper.insertWorkLogSchCheckInKeyResult(saveData);

                    returnData.put("status","success");
                    returnData.put("note","성공적으로 입력되었습니다.");
                }else { // 수정
                    saveData.put("userId", SessionUtil.getUser().getEmpCd());
                    // "팀원"일 경우 자기 자신 것만 처리
                    if(SessionUtil.getUser().getRespDivi().equals("04")) {
                        // 자기 자신 것 처리
                        System.out.println(saveData);
                        if(saveData.get("inpId").equals(SessionUtil.getUser().getEmpCd())){
                            returnData.put("status","success");
                            if(saveData.get("status").equals("U")) {
                                WorkLogSchMapper.updateWorkLogSchCheckInKeyResult(saveData);
                                returnData.put("note","성공적으로 변경되었습니다.");
                            }
                            if(saveData.get("status").equals("D")) {
                                WorkLogSchMapper.deleteWorkLogSchCheckInKeyResult(saveData);
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
                            WorkLogSchMapper.updateWorkLogSchCheckInKeyResult(saveData);
                            returnData.put("note","성공적으로 변경되었습니다.");
                        }
                        if(saveData.get("status").equals("D")) {
                            WorkLogSchMapper.deleteWorkLogSchCheckInKeyResult(saveData);
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
}