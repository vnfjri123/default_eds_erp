package com.springboot.myapp.eds.erp.controller.guMae;

import com.springboot.myapp.eds.erp.vo.guMae.guMaeColListVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobSalListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface guMaeColMapper {

    public List<guMaeColListVO> selectColMgtList(Map<String, Object> map) throws Exception;

    public int insertColMgtList(Map<String, Object> map) throws Exception;

    public int updateColMgtList(Map<String, Object> map) throws Exception;

    public int deleteColMgtList(Map<String, Object> map) throws Exception;
    public int deleteColEmailList(Map<String, Object> map) throws Exception;
    public int aRecMgtList(Map<String, Object> map) throws Exception;
    public int deadLineColMgtList(Map<String, Object> map) throws Exception;
}
