package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.erp.vo.base.baseBusiListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class baseBusiService {

    @Autowired
    private baseBusiMapper baseBusiMapper;

    public List<baseBusiListVO> selectBusiList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseBusiListVO> result = baseBusiMapper.selectBusiList(map);
        return result;
    }

    public List<baseBusiListVO> selectBusiPopList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<baseBusiListVO> result = baseBusiMapper.selectBusiListPop(map);
        return result;
    }

    public int insertBusiList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseBusiMapper.insertBusiList(map);
    }

    public int updateBusiList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseBusiMapper.updateBusiList(map);
    }

    public int deleteBusiList(Map<String, Object> map) throws Exception {
        return baseBusiMapper.deleteBusiList(map);
    }
}
