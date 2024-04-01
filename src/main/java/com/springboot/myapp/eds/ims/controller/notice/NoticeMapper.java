package com.springboot.myapp.eds.ims.controller.notice;

import com.springboot.myapp.eds.ims.vo.error.errorVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeFileVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeImageVO;
import com.springboot.myapp.eds.ims.vo.notice.noticeVO;
import com.springboot.myapp.eds.ims.vo.site.siteImageVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface NoticeMapper {
  List<noticeVO> selectNotice(Map<String, Object> map) throws Exception;
  List<noticeImageVO> selectNoticeImageList(Map<String, Object> map) throws Exception;
  List<noticeFileVO> selectNoticeFiles(Map<String, Object> map) throws Exception;
  List<noticeVO> selectNoticeByIndex(Map<String, Object> map) throws Exception;
  int insertNotice(Map<String, Object> map) throws Exception;
  int insertNoticeImage(Map<String, Object> map) throws Exception;
  int insertNoticeFile(Map<String, Object> map) throws Exception;
  int updateNotice(Map<String, Object> map) throws Exception;
  int readNotice(Map<String, Object> map) throws Exception;
  int deleteNotice(Map<String, Object> map) throws Exception;
  int deleteNoticeImageList(Map<String, Object> map) throws Exception;
  int deleteNoticeImageListAll(Map<String, Object> map) throws Exception;
  int deleteNoticeFile(Map<String, Object> map) throws Exception;
  int deleteNoticeFilesAll(Map<String, Object> map) throws Exception;
}
