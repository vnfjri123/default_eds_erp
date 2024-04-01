package com.springboot.myapp.eds.ims.controller.site;

import com.springboot.myapp.eds.erp.vo.project.projectProjFileListVO;
import com.springboot.myapp.eds.erp.vo.project.projectProjListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsFileListVO;
import com.springboot.myapp.eds.ims.vo.site.siteFileVO;
import com.springboot.myapp.eds.ims.vo.site.siteImageVO;
import com.springboot.myapp.eds.ims.vo.site.siteMemoVO;
import com.springboot.myapp.eds.ims.vo.site.siteVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SiteMapper {
  List<siteVO> selectSite(Map<String, Object> map) throws Exception;
  List<siteVO> selectSitePop(Map<String, Object> map) throws Exception;
  List<siteVO> selectSiteByIndex(Map<String, Object> map) throws Exception;
  List<siteMemoVO> selectSiteMemoList(Map<String, Object> map) throws Exception;
  List<siteFileVO> selectSiteFileList(Map<String, Object> map) throws Exception;
  List<siteFileVO> selectSiteFileListForDelete(Map<String, Object> map) throws Exception;
  List<siteFileVO> selectSiteFileListForDeleteALL(Map<String, Object> map) throws Exception;
  List<siteImageVO> selectSiteImageList(Map<String, Object> map) throws Exception;
  List<projectProjListVO> selectProjMgtListInIms(Map<String, Object> map) throws Exception;
  int insertSite(Map<String, Object> map) throws Exception;
  int updateSite(Map<String, Object> map) throws Exception;
  int deleteSite(Map<String, Object> map) throws Exception;
  int insertCarryOverDivi(Map<String, Object> map) throws Exception;
  int updateCarryOverDivi(Map<String, Object> map) throws Exception;

  int insertSiteImage(Map<String, Object> map) throws Exception;
  int deleteSiteImageList(Map<String, Object> map) throws Exception;
  int deleteAllSiteImage(Map<String, Object> map) throws Exception;

  int insertSiteFileList(Map<String, Object> map) throws Exception;
  int updateSiteFileList(Map<String, Object> map) throws Exception;
  int deleteSiteFileList(Map<String, Object> map) throws Exception;

  int insertSiteMemoList(Map<String, Object> map) throws Exception;
  int updateSiteMemoList(Map<String, Object> map) throws Exception;
  int deleteSiteMemoList(Map<String, Object> map) throws Exception;



}
