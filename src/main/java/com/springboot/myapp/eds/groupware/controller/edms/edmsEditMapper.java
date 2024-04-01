package com.springboot.myapp.eds.groupware.controller.edms;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.groupware.vo.edms.edmsEditFileListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsEditListVO;


@Repository
public interface edmsEditMapper {
    
    public List<edmsEditListVO> selectEditList(Map<String, Object> map) throws Exception;
    public List<edmsEditFileListVO> selectEditFileList(Map<String, Object> map) throws Exception;


    public int insertEditList(Map<String, Object> map) throws Exception;
    public int insertEditFileList(Map<String, Object> map) throws Exception;

    public int updateEditList(Map<String, Object> map) throws Exception;
    public int updateEditItemList(Map<String, Object> map) throws Exception;

    public int deleteEditList(Map<String, Object> map) throws Exception;
    public int deleteEditFileList(Map<String, Object> map) throws Exception;
}
