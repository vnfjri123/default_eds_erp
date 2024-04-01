package com.springboot.myapp.eds.erp.controller.yeongEob;

import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobEstListVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobEstItemListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface yeongEobEstMapper {

    public List<yeongEobEstListVO> selectEstMgtList(Map<String, Object> map) throws Exception;
    public List<yeongEobEstItemListVO> selectEstItemList(Map<String, Object> map) throws Exception;

    public int insertEstMgtList(Map<String, Object> map) throws Exception;
    public int insertEstItemList(Map<String, Object> map) throws Exception;

    public int updateEstMgtList(Map<String, Object> map) throws Exception;
    public int updateEstItemList(Map<String, Object> map) throws Exception;

    public int deleteEstMgtList(Map<String, Object> map) throws Exception;
    public int deleteEstItemList(Map<String, Object> map) throws Exception;
    public int deleteEstEmailList(Map<String, Object> map) throws Exception;
    public int deadLineEstMgtList(Map<String, Object> map) throws Exception;
}
