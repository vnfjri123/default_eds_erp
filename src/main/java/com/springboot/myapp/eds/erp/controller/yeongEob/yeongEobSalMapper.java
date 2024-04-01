package com.springboot.myapp.eds.erp.controller.yeongEob;

import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobSalListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface yeongEobSalMapper {

    public List<yeongEobSalListVO> selectSalMgtList(Map<String, Object> map) throws Exception;

    public int insertSalMgtList(Map<String, Object> map) throws Exception;

    public int updateSalMgtList(Map<String, Object> map) throws Exception;

    public int deleteSalMgtList(Map<String, Object> map) throws Exception;
    public int deleteSalEmailList(Map<String, Object> map) throws Exception;

    public int aProjMgtList(Map<String, Object> map) throws Exception;
    public int deadLineSalMgtList(Map<String, Object> map) throws Exception;
}
