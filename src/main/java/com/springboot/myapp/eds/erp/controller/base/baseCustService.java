package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springboot.myapp.eds.erp.vo.base.baseCustListVO;
@Service
public class baseCustService {

    @Autowired
    private baseCustMapper baseCustMapper;

    public List<baseCustListVO> selectCustList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseCustListVO> result = baseCustMapper.selectCustList(map);
        return result;
    }

    public List<baseCustListVO> selectCustPopList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseCustListVO> result = baseCustMapper.selectCustPopList(map);
        return result;
    }

    public int insertCustList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCustMapper.insertCustList(map);
    }

    public int updateCustList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCustMapper.updateCustList(map);
    }

    public int deleteCustList(Map<String, Object> map) throws Exception {
        return baseCustMapper.deleteCustList(map);
    }

    public String selectCorpNoCheck(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        return baseCustMapper.selectCorpNoCheck(map);
    }
}
