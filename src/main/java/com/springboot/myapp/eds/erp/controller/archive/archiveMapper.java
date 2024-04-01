package com.springboot.myapp.eds.erp.controller.archive;

import com.springboot.myapp.eds.erp.vo.archive.archiveThumVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeVO;
import com.springboot.myapp.eds.ims.vo.site.siteImageVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface archiveMapper {
  List<archiveVO> selectArchive(Map<String, Object> map) throws Exception;
  List<archiveThumVO> selectArchiveThum(Map<String, Object> map) throws Exception;
  int insertArchive(Map<String, Object> map) throws Exception;
  int insertArchiveFile(Map<String, Object> map) throws Exception;
  int updateArchive(Map<String, Object> map) throws Exception;
  int updateArchiveFile(Map<String, Object> map) throws Exception;
  int deleteArchive(Map<String, Object> map) throws Exception;
  int deleteArchiveImageList(Map<String, Object> map) throws Exception;
}
