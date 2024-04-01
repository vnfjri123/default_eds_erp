package com.springboot.myapp.eds.groupware.controller.workLog;

import com.springboot.myapp.eds.groupware.vo.workLog.workLogCommentVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogActivityVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogListVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogPlanningKeyResultVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogCheckInKeyResultVO;
import com.springboot.myapp.eds.groupware.vo.workLog.workLogSchDetailProgressChartVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface workLogMapper {
    public List<workLogListVO> selectWorkLogList(Map<String, Object> map) throws Exception;
    public List<workLogListVO> selectWorkLogObjectiveList(Map<String, Object> map) throws Exception;
    public List<workLogListVO> selectWorkLogKeyResultList(Map<String, Object> map) throws Exception;
    public List<workLogCommentVO> selectWorkLogComment(Map<String, Object> map) throws Exception;
    public List<workLogActivityVO> selectWorkLogActivity(Map<String, Object> map) throws Exception;
    public Map<String, Object> selectWorkLogActivityCount(Map<String, Object> map) throws Exception;
    public List<workLogActivityVO> selectWorkLogActiveList(Map<String, Object> map) throws Exception;
    public List<workLogActivityVO> getLowKeyResultsActivitys(Map<String, Object> map) throws Exception;
    public List<workLogPlanningKeyResultVO> selectWorkLogPlanningKeyResult(Map<String, Object> map) throws Exception;
    public List<workLogPlanningKeyResultVO> selectWorkLogPlanKeyResult(Map<String, Object> map) throws Exception;
    public List<workLogPlanningKeyResultVO> getWorkLogPlanningKeyResultChart(Map<String, Object> map) throws Exception;
    public List<workLogCheckInKeyResultVO> selectWorkLogCheckInKeyResult(Map<String, Object> map) throws Exception;
    public List<workLogCheckInKeyResultVO> getWorkLogCheckInKeyResultChart(Map<String, Object> map) throws Exception;
    public List<workLogSchDetailProgressChartVO> getWorkLogSchDetailProgressChart(Map<String, Object> map) throws Exception;
    public List<workLogSchDetailProgressChartVO> getWorkLogSchDetailProgressChartPlanList(Map<String, Object> map) throws Exception;
    public List<workLogListVO> getLowKeyResults(Map<String, Object> map) throws Exception;
    public List<workLogListVO> getLowKeyResultsForSch(Map<String, Object> map) throws Exception;
    public Map<String,String> getPlanCdRoot(Map<String, Object> map) throws Exception;
    public List<workLogListVO> getPartCds(Map<String, Object> map) throws Exception;
    public List<workLogListVO> getWorkCds(Map<String, Object> map) throws Exception;
    public List<workLogListVO> getEmpCds(Map<String, Object> map) throws Exception;

    public int insertWorkLogList(Map<String, Object> map) throws Exception;
    public int insertWorkLogContent(Map<String, Object> map) throws Exception;
    public int insertWorkLogActivity(Map<String, Object> map) throws Exception;
    public int insertWorkLogPlanningKeyResult(Map<String, Object> map) throws Exception;
    public int insertWorkLogCheckInKeyResult(Map<String, Object> map) throws Exception;

    public int updateWorkLogList(Map<String, Object> map) throws Exception;
    public int updateWorkLogPlanningKeyResult(Map<String, Object> map) throws Exception;
    public int updateWorkLogCheckInKeyResult(Map<String, Object> map) throws Exception;

    public int deleteWorkLogList(Map<String, Object> map) throws Exception;
    public int deleteWorkLogContent(Map<String, Object> map) throws Exception;
    public int deleteWorkLogActivity(Map<String, Object> map) throws Exception;
    public int deleteWorkLogPlanningKeyResult(Map<String, Object> map) throws Exception;
    public int deleteWorkLogCheckInKeyResult(Map<String, Object> map) throws Exception;
    public int deleteWorkLogOrderPlanList(Map<String, Object> map) throws Exception;
    public int synchronizationOrderPlanToWorkLogList(Map<String, Object> map) throws Exception;
    public int synchronizationProjectToWorkLogList(Map<String, Object> map) throws Exception;
}
