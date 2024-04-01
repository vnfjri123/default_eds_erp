package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.base.baseBusiListVO;

@Repository
public interface baseBusiMapper {    

    public List<baseBusiListVO> selectBusiList(Map<String, Object> map) throws Exception;

    public List<baseBusiListVO> selectBusiListPop(Map<String, Object> map) throws Exception;

    public int insertBusiList(Map<String, Object> map) throws Exception;

    public int updateBusiList(Map<String, Object> map) throws Exception;

    public int deleteBusiList(Map<String, Object> map) throws Exception;
}
