package com.springboot.myapp.eds.groupware.controller.edms;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.groupware.vo.edms.edmsExpenseItemListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsExpenseListVO;


@Repository
public interface edmsExpenseMapper {
    
    public List<edmsExpenseListVO> selectExpenseList(Map<String, Object> map) throws Exception;
    public List<edmsExpenseItemListVO> selectExpenseItemList(Map<String, Object> map) throws Exception;

    public int insertExpenseList(Map<String, Object> map) throws Exception;
    public int insertExpenseItemList(Map<String, Object> map) throws Exception;

    public int updateExpenseList(Map<String, Object> map) throws Exception;
    public int updateExpenseItemList(Map<String, Object> map) throws Exception;

    public int deleteExpenseList(Map<String, Object> map) throws Exception;
    public int deleteExpenseItemList(Map<String, Object> map) throws Exception;
}
