package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.base.baseCustListVO;

@Repository
public interface baseCustMapper {

    public List<baseCustListVO> selectCustList(Map<String, Object> map) throws Exception;

    public List<baseCustListVO> selectCustPopList(Map<String, Object> map) throws Exception;

    public int insertCustList(Map<String, Object> map) throws Exception;

    public int updateCustList(Map<String, Object> map) throws Exception;

    public int deleteCustList(Map<String, Object> map) throws Exception;

    public String selectCorpNoCheck(Map<String, Object> map) throws Exception;

}
