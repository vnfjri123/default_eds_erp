package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemMenuListVO;
import com.springboot.myapp.eds.erp.vo.system.systemMenuDetVO;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class systemMenuService {

    @Autowired
    private systemMenuMapper systemMenuMapper;

    public List<systemMenuListVO> selectManuMgtList(Map<String, Object> map) throws Exception {
        List<systemMenuListVO> result = systemMenuMapper.selectManuMgtList(map);
        return result;
    }

    public List<systemMenuDetVO> selectManuMgtDet(Map<String, Object> map) throws Exception {
        List<systemMenuDetVO> result = systemMenuMapper.selectManuMgtDet(map);
        return result;
    }

    public int insertManuMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemMenuMapper.insertManuMgtList(map);
    }

    public int insertManuMgtDet(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemMenuMapper.insertManuMgtDet(map);
    }

    public int updateManuMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemMenuMapper.updateManuMgtList(map);
    }

    public int updateManuMgtDet(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemMenuMapper.updateManuMgtDet(map);
    }

    public int deleteManuMgtList(Map<String, Object> map) throws Exception {
        return systemMenuMapper.deleteManuMgtList(map);
    }

    public int deleteManuMgtDet(Map<String, Object> map) throws Exception {
        return systemMenuMapper.deleteManuMgtDet(map);
    }

    public int deleteManuGpAuth(Map<String, Object> map) throws Exception {
        return systemMenuMapper.deleteManuGpAuth(map);
    }
}
