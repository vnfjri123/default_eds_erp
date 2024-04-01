package com.springboot.myapp.eds.erp.controller.alarm;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.alarm.alarmListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsSubmitListVO;

@Repository
public interface alarmMapper {

    public List<alarmListVO> selectAlarmList(Map<String, Object> map) throws Exception;

    public List<alarmListVO> selectAlarmPopList(Map<String, Object> map) throws Exception;
    public Map<String, Object> selectAlarmTargetInfo(Map<String, Object> map) throws Exception;
    public List<edmsSubmitListVO> selectAlarmSubmit(Map<String, Object> map) throws Exception;
    
    
    public int insertAlarmList(Map<String, Object> map) throws Exception;
    public int insertAlarmChat(Map<String, Object> map) throws Exception;

    public int updateAlarmList(Map<String, Object> map) throws Exception;

    public int deleteAlarmList(Map<String, Object> map) throws Exception;
}
