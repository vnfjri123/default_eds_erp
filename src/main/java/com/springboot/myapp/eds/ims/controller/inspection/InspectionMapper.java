package com.springboot.myapp.eds.ims.controller.inspection;

import com.springboot.myapp.eds.erp.vo.global.MAINCONTENTVO;
import com.springboot.myapp.eds.erp.vo.system.systemMenuListVO;
import com.springboot.myapp.eds.ims.vo.inspection.inspectionVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface InspectionMapper {
  List<inspectionVO> selectInspectionList(Map<String, Object> map) throws Exception;
  List<inspectionVO> selectInspectionUserList(Map<String, Object> map) throws Exception;
  List<inspectionVO> selectThisMonthPercent(Map<String, Object> map) throws Exception;
  List<inspectionVO> selectInfo(Map<String, Object> map) throws Exception;

  int resetInspectionList(Map<String, Object> map) throws Exception;

  int updateInspectionList(Map<String, Object> map) throws Exception;
  int deleteInspectionList(Map<String, Object> map) throws Exception;

  int insertInspectionList(Map<String, Object> map) throws Exception;

  List<inspectionVO> selectInspectionProgress(Map<String, Object> map) throws Exception;
}
