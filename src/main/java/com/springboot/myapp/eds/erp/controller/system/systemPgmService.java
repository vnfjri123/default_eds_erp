package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemPgmPopupVO;
import com.springboot.myapp.eds.erp.vo.system.systemPgmDetVO;
import com.springboot.myapp.eds.erp.vo.system.systemPgmListVO;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class systemPgmService {

    @Autowired
    private systemPgmMapper systemPgmMapper;

    public List<systemPgmListVO> selectPmgMgtList(Map<String, Object> map) throws Exception {
        List<systemPgmListVO> result = systemPgmMapper.selectPmgMgtList(map);
        return result;
    }

    public List<systemPgmDetVO> checkedMenuList(Map<String, Object> map) throws Exception {
        List<systemPgmDetVO> result = systemPgmMapper.checkedMenuList(map);
        return result;
    }

    public List<systemPgmPopupVO> selectPmgMgtListPopup(Map<String, Object> map) throws Exception {
        List<systemPgmPopupVO> result = systemPgmMapper.selectPmgMgtListPopup(map);
        return result;
    }

    public int insertPmgMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemPgmMapper.insertPmgMgtList(map);
    }

    public int updatePmgMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemPgmMapper.updatePmgMgtList(map);
    }

    public int deletePmgMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemPgmMapper.deletePmgMgtList(map);
    }
}
