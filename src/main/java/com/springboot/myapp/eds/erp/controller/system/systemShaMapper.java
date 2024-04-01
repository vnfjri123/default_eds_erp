package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemShaListVO;
import com.springboot.myapp.eds.erp.vo.system.systemShaDetVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface systemShaMapper {
    
    public List<systemShaListVO> selectShaList(Map<String, Object> map) throws Exception;
    public List<systemShaDetVO> selectShaDet(Map<String, Object> map) throws Exception;

    public int insertShaList(Map<String, Object> map) throws Exception;
    public int insertShaDet(Map<String, Object> map) throws Exception;

    public int updateShaList(Map<String, Object> map) throws Exception;
    public int updateShaDet(Map<String, Object> map) throws Exception;

    public int deleteShaList(Map<String, Object> map) throws Exception;
    public int deleteShaDet(Map<String, Object> map) throws Exception;
}
