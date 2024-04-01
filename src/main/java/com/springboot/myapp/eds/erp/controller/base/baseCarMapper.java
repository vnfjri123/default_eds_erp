package com.springboot.myapp.eds.erp.controller.base;

import com.springboot.myapp.eds.erp.vo.base.baseCarExpeFileListVO;
import com.springboot.myapp.eds.erp.vo.base.baseCarExpeListVO;
import com.springboot.myapp.eds.erp.vo.base.baseCarListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface baseCarMapper {
    
    public List<baseCarListVO> selectCarMgtList(Map<String, Object> map) throws Exception;
    public List<baseCarListVO> selectCarMgtUseList(Map<String, Object> map) throws Exception;
    public List<baseCarExpeListVO> selectCarExpeList(Map<String, Object> map) throws Exception;
    public List<baseCarExpeFileListVO> selectCarExpeFileList(Map<String, Object> map) throws Exception;

    public int insertCarMgtList(Map<String, Object> map) throws Exception;
    public int insertCarExpeList(Map<String, Object> map) throws Exception;
    public int insertCarExpeFileList(Map<String, Object> map) throws Exception;

    public int updateCarMgtList(Map<String, Object> map) throws Exception;
    public int updateCarExpeList(Map<String, Object> map) throws Exception;
    public int updateCarExpeFileList(Map<String, Object> map) throws Exception;

    public int deleteCarMgtList(Map<String, Object> map) throws Exception;
    public int deleteCarExpeList(Map<String, Object> map) throws Exception;
    public int deleteCarExpeFileList(Map<String, Object> map) throws Exception;

    public String selectEmpCdCheck(Map<String, Object> map) throws Exception;

    public String selectEmpIdCheck(Map<String, Object> map) throws Exception;

    public List<baseCarListVO> carCheckByGroup(Map<String, Object> map) throws Exception;

    public String duplicateCarCheck(Map<String, Object> map) throws Exception;

    public int uploadCarFaceImage(Map<String, Object> map) throws Exception;
    public int deleteCarFaceImage(Map<String, Object> map) throws Exception;
}