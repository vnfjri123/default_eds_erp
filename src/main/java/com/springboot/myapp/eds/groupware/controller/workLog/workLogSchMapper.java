package com.springboot.myapp.eds.groupware.controller.workLog;

import com.springboot.myapp.eds.groupware.vo.workLog.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface workLogSchMapper {
    public List<workLogSchListVO> selectWorkLogSchList(Map<String, Object> map) throws Exception;
    public List<workLogCommentVO> selectWorkLogSchComment(Map<String, Object> map) throws Exception;
    public List<workLogActivityVO> selectWorkLogSchActivity(Map<String, Object> map) throws Exception;
    public List<workLogPlanningKeyResultVO> selectWorkLogSchPlanningKeyResult(Map<String, Object> map) throws Exception;
    public List<workLogPlanningKeyResultVO> getWorkLogSchPlanningKeyResultChart(Map<String, Object> map) throws Exception;
    public List<workLogCheckInKeyResultVO> selectWorkLogSchCheckInKeyResult(Map<String, Object> map) throws Exception;
    public List<workLogCheckInKeyResultVO> getWorkLogSchCheckInKeyResultChart(Map<String, Object> map) throws Exception;
    public List<workLogSchListVO> getLowKeyResults(Map<String, Object> map) throws Exception;
    public Map<String,String> getPlanCdRoot(Map<String, Object> map) throws Exception;
    public List<workLogSchListVO> getPartCds(Map<String, Object> map) throws Exception;
    public List<workLogSchListVO> getWorkCds(Map<String, Object> map) throws Exception;
    public List<workLogSchListVO> getEmpCds(Map<String, Object> map) throws Exception;

    public int insertWorkLogSchList(Map<String, Object> map) throws Exception;
    public int insertWorkLogSchContent(Map<String, Object> map) throws Exception;
    public int insertWorkLogSchActivity(Map<String, Object> map) throws Exception;
    public int insertWorkLogSchPlanningKeyResult(Map<String, Object> map) throws Exception;
    public int insertWorkLogSchCheckInKeyResult(Map<String, Object> map) throws Exception;

    public int updateWorkLogSchList(Map<String, Object> map) throws Exception;
    public int updateWorkLogSchPlanningKeyResult(Map<String, Object> map) throws Exception;
    public int updateWorkLogSchCheckInKeyResult(Map<String, Object> map) throws Exception;

    public int deleteWorkLogSchList(Map<String, Object> map) throws Exception;
    public int deleteWorkLogSchContent(Map<String, Object> map) throws Exception;
    public int deleteWorkLogSchActivity(Map<String, Object> map) throws Exception;
    public int deleteWorkLogSchPlanningKeyResult(Map<String, Object> map) throws Exception;
    public int deleteWorkLogSchCheckInKeyResult(Map<String, Object> map) throws Exception;
}
