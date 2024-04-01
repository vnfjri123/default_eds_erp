package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.erp.vo.base.baseCorpListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class baseCorpService {

    @Autowired
    private baseCorpMapper baseCorpMapper;

    public List<baseCorpListVO> selectCorpList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseCorpListVO> result = baseCorpMapper.selectCorpList(map);
        return result;
    }

    public int insertCorpList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCorpMapper.insertCorpList(map);
    }

    public int updateCorpList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseCorpMapper.updateCorpList(map);
    }

    public int deleteCorpList(Map<String, Object> map) throws Exception {
        return baseCorpMapper.deleteCorpList(map);
    }
}
