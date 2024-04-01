package com.springboot.myapp.eds.groupware.controller.edms;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.groupware.vo.edms.edmsEstItemListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsEstListVO;


@Repository
public interface edmsEstMapper {
    
    public List<edmsEstListVO> selectEstList(Map<String, Object> map) throws Exception;
    public List<edmsEstItemListVO> selectEstItemList(Map<String, Object> map) throws Exception;

    public int insertEstList(Map<String, Object> map) throws Exception;
    public int insertEstItemList(Map<String, Object> map) throws Exception;

    public int updateEstList(Map<String, Object> map) throws Exception;
    public int updateEstItemList(Map<String, Object> map) throws Exception;

    public int deleteEstList(Map<String, Object> map) throws Exception;
    public int deleteEstItemList(Map<String, Object> map) throws Exception;
}
