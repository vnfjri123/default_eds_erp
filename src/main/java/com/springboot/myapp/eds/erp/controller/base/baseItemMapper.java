package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.base.baseItemListVO;

@Repository
public interface baseItemMapper {

    public List<baseItemListVO> selectItemList(Map<String, Object> map) throws Exception;

    public List<baseItemListVO> selectItemPopList(Map<String, Object> map) throws Exception;


    public int insertItemList(Map<String, Object> map) throws Exception;

    public int updateItemList(Map<String, Object> map) throws Exception;

    public int deleteItemList(Map<String, Object> map) throws Exception;
}
