package com.springboot.myapp.eds.ims.controller.inspection;

import com.springboot.myapp.eds.erp.vo.global.MAINCONTENTVO;
import com.springboot.myapp.eds.ims.vo.inspection.inspectionVO;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InspectionService {

  @Autowired
  private InspectionMapper inspectionMapper;

  @Autowired
  SqlSession sqlSession;

  public List<inspectionVO> selectInspectionList(Map<String, Object> map) throws Exception {
    String depaCd =map.get("depaCd").toString();
    if(!("1012").equals(depaCd) && !("1008").equals(depaCd) && !("1009").equals(depaCd))
    {map.put("depaCd", null);}
    List<inspectionVO> result = inspectionMapper.selectInspectionList(map);
    return result;
  }

  public List<inspectionVO> selectInspectionUserList(Map<String, Object> map) throws Exception {
    String depaCd =map.get("depaCd").toString();
    if(!("1012").equals(depaCd) && !("1008").equals(depaCd) && !("1009").equals(depaCd))
    {map.put("depaCd", null);}
    List<inspectionVO> result = inspectionMapper.selectInspectionUserList(map);
    return result;
  }

  public List<inspectionVO> selectThisMonthPercent(Map<String, Object> map) throws Exception {
    List<inspectionVO> result = inspectionMapper.selectThisMonthPercent(map);
    return result;
  }

  public List<inspectionVO> selectInfo(Map<String, Object> map) throws Exception {
    List<inspectionVO> result = inspectionMapper.selectInfo(map);
    return result;
  }

  public int resetInspectionList(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return inspectionMapper.resetInspectionList(map);
  }

  public int updateInspectionList(Map<String, Object> map) throws Exception {
    map.put("userId", SessionUtil.getUser().getEmpCd());
    return inspectionMapper.updateInspectionList(map);
  }

  public int deleteInspectionList(Map<String, Object> map) throws Exception {
    return inspectionMapper.deleteInspectionList(map);
  }

  public int insertInspectionList(Map<String, Object> map) throws Exception {
      map.put("userId", SessionUtil.getUser().getEmpCd());
      if (map.get("checkCycle").equals("월")) {
        for (int i = 1; i <= 12; i++) {
          map.put("month", i);
          inspectionMapper.insertInspectionList(map);
        }
      } else if (map.get("checkCycle").equals("분기")) {
        for (int i = 41; i <= 44; i++) {
          map.put("month", i);
          inspectionMapper.insertInspectionList(map);
        }
      }
      return 1;
  }

  public List<inspectionVO> selectInspectionProgress(Map<String, Object> map) throws Exception
  {
    map.put("empCd", SessionUtil.getUser().getEmpCd());
    map.put("corpCd", SessionUtil.getUser().getCorpCd());
    List<inspectionVO> result = inspectionMapper.selectInspectionProgress(map);
    return result;
  }

}
