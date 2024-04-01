package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.base.baseCorpListVO;

@Repository
public interface baseCorpMapper {
    
    public List<baseCorpListVO> selectCorpList(Map<String, Object> map) throws Exception;

    public int insertCorpList(Map<String, Object> map) throws Exception;

    public int updateCorpList(Map<String, Object> map) throws Exception;

    public int deleteCorpList(Map<String, Object> map) throws Exception;

}
