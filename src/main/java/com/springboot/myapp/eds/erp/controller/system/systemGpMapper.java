package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemGpListVO;
import com.springboot.myapp.eds.erp.vo.system.systemGpAuthVO;
import com.springboot.myapp.eds.erp.vo.system.systemGpUserListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface systemGpMapper {
    
    public List<systemGpListVO> selectGpMenuMgtList(Map<String, Object> map) throws Exception;
    public List<systemGpAuthVO> selectGpMenuAuthList(Map<String, Object> map) throws Exception;
    public List<systemGpUserListVO> selectGpUserMgtList(Map<String, Object> map) throws Exception;

    public int insertGpMenuMgtList(Map<String, Object> map) throws Exception;
    public int insertGpUserMgtList(Map<String, Object> map) throws Exception;
    public int insertGpMenuAuth(Map<String, Object> map) throws Exception;

    public int updateGpMenuMgtList(Map<String, Object> map) throws Exception;
    public int updateGpMenuAuthList(Map<String, Object> map) throws Exception;
    public int updateGpUserMgtList(Map<String, Object> map) throws Exception;

    public int deleteGpMenuMgtList(Map<String, Object> map) throws Exception;
    public int deleteGpMenuAuthList(Map<String, Object> map) throws Exception;
    public int deleteGpUserMgtList(Map<String, Object> map) throws Exception;
    public int deleteGpMenuAuth(Map<String, Object> map) throws Exception;
}
