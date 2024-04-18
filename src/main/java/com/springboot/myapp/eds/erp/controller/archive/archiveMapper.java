package com.springboot.myapp.eds.erp.controller.archive;

import com.springboot.myapp.eds.erp.vo.archive.archiveFileVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveThumVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveVO;
import com.springboot.myapp.eds.erp.vo.archive.archiveVideoVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeVO;
import com.springboot.myapp.eds.ims.vo.site.siteImageVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface archiveMapper {
  List<archiveVO> selectArchive(Map<String, Object> map) throws Exception;
  int readArchive(Map<String, Object> map) throws Exception;
  List<archiveVideoVO> selectArchiveVideo(Map<String, Object> map) throws Exception;
  List<archiveThumVO> selectArchiveThum(Map<String, Object> map) throws Exception;
  List<archiveFileVO> selectArchiveFiles(Map<String, Object> map) throws Exception;
  int insertArchive(Map<String, Object> map) throws Exception;
  int insertArchiveVideo(Map<String, Object> map) throws Exception;
  int insertArchiveThumbnail(Map<String, Object> map) throws Exception;
  int insertArchiveFiles(Map<String, Object> map) throws Exception;
  int updateArchive(Map<String, Object> map) throws Exception;
  int updateArchiveThumbnail(Map<String, Object> map) throws Exception;
  int deleteVideo(Map<String, Object> map) throws Exception;
  int deleteThumbnail(Map<String, Object> map) throws Exception;
  int deleteFiles(Map<String, Object> map) throws Exception;
  int deleteArchive(Map<String, Object> map) throws Exception;
  int deleteArchiveImageList(Map<String, Object> map) throws Exception;
}
