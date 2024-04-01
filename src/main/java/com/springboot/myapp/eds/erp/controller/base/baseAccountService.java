package com.springboot.myapp.eds.erp.controller.base;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.erp.vo.base.baseAccountListVO;
import com.springboot.myapp.util.SessionUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class baseAccountService {

    @Autowired
    private baseAccountMapper baseAccountMapper;

    public List<baseAccountListVO> selectAccountList(Map<String, Object> map) throws Exception {
        List<baseAccountListVO> result = baseAccountMapper.selectAccountList(map);
        return result;
    }

    public List<baseAccountListVO> selectAccountPopList(Map<String, Object> map) throws Exception {
        List<baseAccountListVO> result = baseAccountMapper.selectAccountPopList(map);
        return result;
    }

    public int insertAccountList(Map<String, Object> map) throws Exception,SQLException {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseAccountMapper.insertAccountList(map);
    }

    public int updateAccountList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseAccountMapper.updateAccountList(map);
    }

    public int deleteAccountList(Map<String, Object> map) throws Exception {
        return baseAccountMapper.deleteAccountList(map);
    }

}
