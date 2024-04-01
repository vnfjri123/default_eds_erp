package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemPgmPopupVO;
import com.springboot.myapp.eds.erp.vo.system.systemPgmDetVO;
import com.springboot.myapp.eds.erp.vo.system.systemPgmListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface systemPgmMapper {

    public List<systemPgmListVO> selectPmgMgtList(Map<String, Object> map) throws Exception;
    public List<systemPgmPopupVO> selectPmgMgtListPopup(Map<String, Object> map) throws Exception;
    public List<systemPgmDetVO> checkedMenuList(Map<String, Object> map) throws Exception;
    public int insertPmgMgtList(Map<String, Object> map) throws Exception;
    public int updatePmgMgtList(Map<String, Object> map) throws Exception;
    public int deletePmgMgtList(Map<String, Object> map) throws Exception;
}
