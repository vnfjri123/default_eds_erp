package com.springboot.myapp.eds.ims.controller.error;

import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeImageVO;
import com.springboot.myapp.eds.ims.vo.error.errorImageVO;
import com.springboot.myapp.eds.ims.vo.error.errorVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ErrorMapper {
  List<errorVO> selectError(Map<String, Object> map) throws Exception;
  List<errorVO> selectErrorByIndex(Map<String, Object> map) throws Exception;
  List<errorImageVO> selectErrorImageList(Map<String, Object> map) throws Exception;
  int insertError(Map<String, Object> map) throws Exception;
  int insertErrorImage(Map<String, Object> map) throws Exception;
  int updateError(Map<String, Object> map) throws Exception;
  int deleteError(Map<String, Object> map) throws Exception;
  int deleteErrorImageList(Map<String, Object> map) throws Exception;
}
