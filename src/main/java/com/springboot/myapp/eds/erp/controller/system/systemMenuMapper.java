package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemMenuListVO;
import com.springboot.myapp.eds.erp.vo.system.systemMenuDetVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface systemMenuMapper {

    public List<systemMenuListVO> selectManuMgtList(Map<String, Object> map) throws Exception;
    public List<systemMenuDetVO> selectManuMgtDet(Map<String, Object> map) throws Exception;

    public int insertManuMgtList(Map<String, Object> map) throws Exception;
    public int insertManuMgtDet(Map<String, Object> map) throws Exception;

    public int updateManuMgtList(Map<String, Object> map) throws Exception;
    public int updateManuMgtDet(Map<String, Object> map) throws Exception;

    public int deleteManuMgtList(Map<String, Object> map) throws Exception;
    public int deleteManuMgtDet(Map<String, Object> map) throws Exception;
    public int deleteManuGpAuth(Map<String, Object> map) throws Exception;
}
