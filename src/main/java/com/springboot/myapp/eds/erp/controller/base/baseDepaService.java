package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.erp.vo.base.baseDepaListVO;
import com.springboot.myapp.util.SessionUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class baseDepaService {

    @Autowired
    private baseDepaMapper baseDepaMapper;

    public List<baseDepaListVO> selectDepaList(Map<String, Object> map) throws Exception {
        List<baseDepaListVO> result = baseDepaMapper.selectDepaList(map);
        return result;
    }

    public List<baseDepaListVO> selectDepaPopList(Map<String, Object> map) throws Exception {
        List<baseDepaListVO> result = baseDepaMapper.selectDepaPopList(map);
        return result;
    }

    public int insertDepaList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseDepaMapper.insertDepaList(map);
    }

    public int updateDepaList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseDepaMapper.updateDepaList(map);
    }

    public int deleteDepaList(Map<String, Object> map) throws Exception {
        return baseDepaMapper.deleteDepaList(map);
    }
}
