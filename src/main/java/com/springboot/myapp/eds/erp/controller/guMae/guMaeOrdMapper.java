package com.springboot.myapp.eds.erp.controller.guMae;

import com.springboot.myapp.eds.erp.vo.guMae.guMaeOrdItemListVO;
import com.springboot.myapp.eds.erp.vo.guMae.guMaeOrdListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface guMaeOrdMapper {

    public List<guMaeOrdListVO> selectOrdMgtList(Map<String, Object> map) throws Exception;
    public List<guMaeOrdItemListVO> selectOrdItemList(Map<String, Object> map) throws Exception;

    public int insertOrdMgtList(Map<String, Object> map) throws Exception;
    public int insertOrdItemList(Map<String, Object> map) throws Exception;

    public int updateOrdMgtList(Map<String, Object> map) throws Exception;
    public int updateOrdItemList(Map<String, Object> map) throws Exception;

    public int deleteOrdMgtList(Map<String, Object> map) throws Exception;
    public int deleteOrdItemList(Map<String, Object> map) throws Exception;
    public int deleteOrdEmailList(Map<String, Object> map) throws Exception;

    public int aProjMgtList(Map<String, Object> map) throws Exception;
    public int aProjItemList(Map<String, Object> map) throws Exception;
    public int deadLineOrdMgtList(Map<String, Object> map) throws Exception;
}
