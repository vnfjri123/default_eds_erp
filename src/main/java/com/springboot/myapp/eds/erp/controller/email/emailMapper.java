package com.springboot.myapp.eds.erp.controller.email;

import com.springboot.myapp.eds.erp.vo.email.emailFileVO;
import com.springboot.myapp.eds.erp.vo.email.emailListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface emailMapper {

    public List<emailListVO> selectSendEmailInfo(Map<String, Object> map) throws Exception;
    public List<emailListVO> selectSendEmailInfo2(Map<String, Object> map) throws Exception;
    public List<emailFileVO> selectSendEmailFileInfo(Map<String, Object> map) throws Exception;
    public List<emailFileVO> selectSendEmailJasperInfo(Map<String, Object> map) throws Exception;
    public List<emailFileVO> selectSendEmailFileInfoAll(Map<String, Object> map) throws Exception;

    public int applySendEmail(Map<String, Object> map) throws Exception;
    public void insertSendEmailInfo(Map<String, Object> map) throws Exception;
    public void insertSendEmailAtchInfo(Map<String, Object> map) throws Exception;
    public void insertSendEmailJasperInfo(Map<String, Object> map) throws Exception;
}
