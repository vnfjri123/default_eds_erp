package com.springboot.myapp.eds.error.controller.error;

import com.springboot.myapp.eds.error.vo.error.errorLogListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface errorLogMapper {
    public List<errorLogListVO> selectErrorLogList(Map<String, Object> map) throws Exception;

    public void insertErrorLogList(Map<String, Object> map) throws Exception;

    public void updateErrorLogList(Map<String, Object> map) throws Exception;

    public void deleteErrorLogList(Map<String, Object> map) throws Exception;
}
