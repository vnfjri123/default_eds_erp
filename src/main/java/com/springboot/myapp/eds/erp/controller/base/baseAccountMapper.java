package com.springboot.myapp.eds.erp.controller.base;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.erp.vo.base.baseAccountListVO;

@Repository
public interface baseAccountMapper {

    public List<baseAccountListVO> selectAccountList(Map<String, Object> map) throws Exception;

    public List<baseAccountListVO> selectAccountPopList(Map<String, Object> map) throws Exception;


    public int insertAccountList(Map<String, Object> map) throws Exception;

    public int updateAccountList(Map<String, Object> map) throws Exception;

    public int deleteAccountList(Map<String, Object> map) throws Exception;
}
