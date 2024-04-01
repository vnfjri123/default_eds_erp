package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.erp.vo.base.baseItemListVO;
import com.springboot.myapp.util.SessionUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class baseItemService {

    @Autowired
    private baseItemMapper baseItemMapper;

    public List<baseItemListVO> selectItemList(Map<String, Object> map) throws Exception {
        List<baseItemListVO> result = baseItemMapper.selectItemList(map);
        return result;
    }

    public List<baseItemListVO> selectItemPopList(Map<String, Object> map) throws Exception {
        List<baseItemListVO> result = baseItemMapper.selectItemPopList(map);
        return result;
    }

    public int insertItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseItemMapper.insertItemList(map);
    }

    public int updateItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return baseItemMapper.updateItemList(map);
    }

    public int deleteItemList(Map<String, Object> map) throws Exception {
        return baseItemMapper.deleteItemList(map);
    }

}
