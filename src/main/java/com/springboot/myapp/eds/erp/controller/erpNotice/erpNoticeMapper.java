package com.springboot.myapp.eds.erp.controller.erpNotice;

import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeFileVO;
import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeImageVO;
import com.springboot.myapp.eds.erp.vo.erpNotice.erpNoticeVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeFileVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface erpNoticeMapper {
  List<erpNoticeVO> selectERPNotice(Map<String, Object> map) throws Exception;
  List<erpNoticeImageVO> selectERPNoticeImageList(Map<String, Object> map) throws Exception;
  List<erpNoticeFileVO> selectERPNoticeFiles(Map<String, Object> map) throws Exception;
  List<erpNoticeVO> selectERPNoticeByIndex(Map<String, Object> map) throws Exception;
  int insertERPNotice(Map<String, Object> map) throws Exception;
  int insertERPNoticeImage(Map<String, Object> map) throws Exception;
  int insertERPNoticeFile(Map<String, Object> map) throws Exception;
  int updateERPNotice(Map<String, Object> map) throws Exception;
  int readERPNotice(Map<String, Object> map) throws Exception;
  int deleteERPNotice(Map<String, Object> map) throws Exception;
  int deleteERPNoticeImageList(Map<String, Object> map) throws Exception;
  int deleteERPNoticeFile(Map<String, Object> map) throws Exception;
  int deleteERPNoticeFilesAll(Map<String, Object> map) throws Exception;
}
