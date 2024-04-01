package com.springboot.myapp.eds.erp.controller.alarm;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.erp.vo.alarm.alarmListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsSubmitListVO;
import com.springboot.myapp.eds.notice.NotificationService;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.eds.messages.controller.send.sendController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class alarmService {

    @Autowired
    private alarmMapper alarmMapper;

    @Autowired
    private sendController sendController;

    @Autowired
    private NotificationService notificationService;

    public List<alarmListVO> selectAlarmList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        List<alarmListVO> result = alarmMapper.selectAlarmList(map);
        return result;
    }
    public List<edmsSubmitListVO> selectAlarmSubmit(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        List<edmsSubmitListVO> result = alarmMapper.selectAlarmSubmit(map);
        return result;
    }

    public int insertAlarmList(Map<String, Object> map) throws Exception {

        String stateDivi = map.get("stateDivi").toString();

        try{
            // id: target(받을 사람 empCd)
            notificationService.sendNotification(map.get("id").toString(), map.get("navMessage").toString());
            // 수신인, 발신인 데이터 복호화 데이터 세팅
            AES256Util aes256Util = new AES256Util();
            map.put("secretKey", aes256Util.getKey());

            // 수신인 데이터 세팅
            map.put("schEmpCd",map.get("empCd"));
            Map<String, Object> susinData = alarmMapper.selectAlarmTargetInfo(map);
            map.put("susinEmpNm", susinData.get("empNm"));
            map.put("susinDepaNm", susinData.get("depaNm"));
            map.put("susinEmail", susinData.get("email"));

            // 발신인 데이터 세팅
            map.put("schEmpCd",map.get("target"));
            Map<String, Object> balsinData = alarmMapper.selectAlarmTargetInfo(map);
            map.put("balsinEmpNm", balsinData.get("empNm"));
            map.put("balsinDepaNm", balsinData.get("depaNm"));
            map.put("balsinEmail", balsinData.get("email"));

            sendController.sendKakaoworkMessage(map);
        }catch (Exception ex){
            ex.printStackTrace();
        }

        // stateDivi inserAlarmList 값 초기화
        map.put("stateDivi",stateDivi);
        return alarmMapper.insertAlarmList(map);
        
    }
    public int insertAlarmChat(Map<String, Object> map) throws Exception {
        
        //notificationService.sendNotification(map.get("id").toString(), map.get("navMessage").toString());
        return alarmMapper.insertAlarmChat(map);
        
    }

    public int updateAlarmList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("target", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        return alarmMapper.updateAlarmList(map);
    }

    public int deleteAlarmList(Map<String, Object> map) throws Exception {
        map.put("deleteTarget", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        String subNm=(String)map.get("submitNm");
        // if(map.get("stateDivi").equals("01"))
        // {
        //     map.put("stateDivi", "02");
        //     map.put("navMessage", subNm+"문서의 알림이 확인 되었습니다.");
        //     insertAlarmList(map);
        // }
        return alarmMapper.deleteAlarmList(map);
    }

}
