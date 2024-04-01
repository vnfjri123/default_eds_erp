package com.springboot.myapp.eds.erp.controller.system;

import com.springboot.myapp.eds.erp.vo.system.systemShaListVO;
import com.springboot.myapp.eds.erp.vo.system.systemShaDetVO;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class systemShaService {

    @Autowired
    private systemShaMapper systemShaMapper;

    public List<systemShaListVO> selectShaList(Map<String, Object> map) throws Exception {
        List<systemShaListVO> result = systemShaMapper.selectShaList(map);
        return result;
    }

    public List<systemShaDetVO> selectShaDet(Map<String, Object> map) throws Exception {
        List<systemShaDetVO> result = systemShaMapper.selectShaDet(map);
        return result;
    }

    public int insertShaList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemShaMapper.insertShaList(map);
    }

    public int insertShaDet(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemShaMapper.insertShaDet(map);
    }

    public int updateShaList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemShaMapper.updateShaList(map);
    }

    public int updateShaDet(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return systemShaMapper.updateShaDet(map);
    }

    public int deleteShaList(Map<String, Object> map) throws Exception {
        return systemShaMapper.deleteShaList(map);
    }

    public int deleteShaDet(Map<String, Object> map) throws Exception {
        return systemShaMapper.deleteShaDet(map);
    }
}
