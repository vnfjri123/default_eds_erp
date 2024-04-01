package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemGpListVO;
import com.springboot.myapp.eds.erp.vo.system.systemGpUserListVO;
import com.springboot.myapp.eds.erp.vo.system.systemGpAuthVO;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class systemGpService {

    @Autowired
    private systemGpMapper systemGpMapper;

    public List<systemGpListVO> selectGpMenuMgtList(Map<String, Object> map) throws Exception {
        List<systemGpListVO> result = systemGpMapper.selectGpMenuMgtList(map);
        return result;
    }

    public List<systemGpAuthVO> selectGpMenuAuthList(Map<String, Object> map) throws Exception {
        systemGpMapper.deleteGpMenuAuth(map);
        systemGpMapper.insertGpMenuAuth(map);
        List<systemGpAuthVO> result = systemGpMapper.selectGpMenuAuthList(map);
        return result;
    }

    public List<systemGpUserListVO> selectGpUserMgtList(Map<String, Object> map) throws Exception {
        List<systemGpUserListVO> result = systemGpMapper.selectGpUserMgtList(map);
        return result;
    }

    public int insertGpMenuMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemGpMapper.insertGpMenuMgtList(map);
    }

    public int insertGpUserMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemGpMapper.insertGpUserMgtList(map);
    }

    public int updateGpMenuMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemGpMapper.updateGpMenuMgtList(map);
    }

    public int updateGpMenuAuthList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemGpMapper.updateGpMenuAuthList(map);
    }

    public int updateGpUserMgtList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemGpMapper.updateGpUserMgtList(map);
    }

    public int deleteGpMenuMgtList(Map<String, Object> map) throws Exception {
        return systemGpMapper.deleteGpMenuMgtList(map);
    }

    public int deleteGpMenuAuthList(Map<String, Object> map) throws Exception {
        return systemGpMapper.deleteGpMenuAuthList(map);
    }

    public int deleteGpUserMgtList(Map<String, Object> map) throws Exception {
        return systemGpMapper.deleteGpUserMgtList(map);
    }
}
