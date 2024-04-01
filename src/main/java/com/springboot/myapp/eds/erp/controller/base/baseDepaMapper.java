package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.base.baseDepaListVO;

@Repository
public interface baseDepaMapper {
    
    public List<baseDepaListVO> selectDepaList(Map<String, Object> map) throws Exception;

    public List<baseDepaListVO> selectDepaPopList(Map<String, Object> map) throws Exception;

    public int insertDepaList(Map<String, Object> map) throws Exception;

    public int updateDepaList(Map<String, Object> map) throws Exception;

    public int deleteDepaList(Map<String, Object> map) throws Exception;
}
