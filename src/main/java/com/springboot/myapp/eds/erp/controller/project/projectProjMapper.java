package com.springboot.myapp.eds.erp.controller.project;

import com.springboot.myapp.eds.erp.vo.project.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface projectProjMapper {

    public List<projectProjListVO> selectProjMgtList(Map<String, Object> map) throws Exception;
    public List<projectProjSchListVO> selectProjSchList(Map<String, Object> map) throws Exception;
    public List<projectProjItemListVO> selectProjItemList(Map<String, Object> map) throws Exception;
    public List<projectProjPartListVO> selectProjPartList(Map<String, Object> map) throws Exception;
    public List<projectProjFileListVO> selectProjFileList(Map<String, Object> map) throws Exception;
    public List<projectProjCostListVO> selectProjCostList(Map<String, Object> map) throws Exception;
    public List<projectProjMemoListVO> selectProjMemoList(Map<String, Object> map) throws Exception;
    public List<projectProjCostListVO> selectProjCostTot(Map<String, Object> map) throws Exception;
    public List<projectProjCostListVO> selectProjCostDet(Map<String, Object> map) throws Exception;
    public List<projectProjCompListVO> selectProjCompMgtList(Map<String, Object> map) throws Exception;
    public List<projectProjCompPartListVO> selectProjCompPartList(Map<String, Object> map) throws Exception;
    public List<projectProjCompCostListVO> selectProjCompCostList(Map<String, Object> map) throws Exception;

    public int insertProjMgtList(Map<String, Object> map) throws Exception;
    public int insertProjItemList(Map<String, Object> map) throws Exception;
    public int insertProjPartList(Map<String, Object> map) throws Exception;
    public int insertProjFileList(Map<String, Object> map) throws Exception;
    public int insertProjCostList(Map<String, Object> map) throws Exception;
    public int insertProjMemoList(Map<String, Object> map) throws Exception;
    public int insertProjCompMgtList(Map<String, Object> map) throws Exception;
    public int insertProjCompPartList(Map<String, Object> map) throws Exception;
    public int insertProjCompCostList(Map<String, Object> map) throws Exception;

    public int updateProjMgtList(Map<String, Object> map) throws Exception;
    public int updateProjItemList(Map<String, Object> map) throws Exception;
    public int updateProjPartList(Map<String, Object> map) throws Exception;
    public int updateProjFileList(Map<String, Object> map) throws Exception;
    public int updateProjCostList(Map<String, Object> map) throws Exception;
    public int updateProjMemoList(Map<String, Object> map) throws Exception;
    public int updateProjCompMgtList(Map<String, Object> map) throws Exception;
    public int updateProjCompPartList(Map<String, Object> map) throws Exception;
    public int updateProjCompCostList(Map<String, Object> map) throws Exception;

    public int deleteProjMgtList(Map<String, Object> map) throws Exception;
    public int deleteProjItemList(Map<String, Object> map) throws Exception;
    public int deleteProjPartList(Map<String, Object> map) throws Exception;
    public int deleteProjFileList(Map<String, Object> map) throws Exception;
    public int deleteProjCostList(Map<String, Object> map) throws Exception;
    public int deleteProjMemoList(Map<String, Object> map) throws Exception;
    public int deleteProjEmailList(Map<String, Object> map) throws Exception;
    public int deleteProjCompMgtList(Map<String, Object> map) throws Exception;
    public int deleteProjCompPartList(Map<String, Object> map) throws Exception;
    public int deleteProjCompCostList(Map<String, Object> map) throws Exception;

    public int aEstMgtList(Map<String, Object> map) throws Exception;
    public int aEstItemList(Map<String, Object> map) throws Exception;
    public int deadLineProjMgtList(Map<String, Object> map) throws Exception;
}
