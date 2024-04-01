package com.springboot.myapp.eds.pda.salma;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SALMA4500Mapper {

    public List<SALMA4500VO> selectSALMA4500(Map<String, Object> map) throws Exception;
    public List<SALMA4501VO> selectSALMA4501(Map<String, Object> map) throws Exception;
    public List<SALMA4502VO> selectSALMA4502(Map<String, Object> map) throws Exception;
    public List<SALMA4503VO> selectSALMA4503(Map<String, Object> map) throws Exception;
    public List<SALMA4504VO> selectSALMA4504(Map<String, Object> map) throws Exception;
    public List<SALMA4505VO> selectSALMA4505(Map<String, Object> map) throws Exception;
    public List<SALMA4501VO> selectSALMA4506(Map<String, Object> map) throws Exception;
    public List<SALMA4501VO> selectSALMA4507(Map<String, Object> map) throws Exception;
    public List<SALMA4501VO> selectSALMA4508(Map<String, Object> map) throws Exception;
    public List<SALMA4501VO> selectSALMA4509(Map<String, Object> map) throws Exception;

    public int insertSALMA4500(Map<String, Object> map) throws Exception;
    public int insertSALMA4501(Map<String, Object> map) throws Exception;

    public int updateSALMA4500(Map<String, Object> map) throws Exception;
    public int updateSALMA4501(Map<String, Object> map) throws Exception;
    public int updateSALMA4502(Map<String, Object> map) throws Exception;
    public int updateSALMA4503(Map<String, Object> map) throws Exception;
    public int updateSALMA4506(Map<String, Object> map) throws Exception;

    public int resetSALMA4503(Map<String, Object> map) throws Exception;
    public int updateSALMA4505(Map<String, Object> map) throws Exception;
    public int resetSALMA4505(Map<String, Object> map) throws Exception;
    public int closeYnSALMA4500(Map<String, Object> map) throws Exception;

    public int deleteSALMA4500(Map<String, Object> map) throws Exception;
    public int deleteSALMA4501(Map<String, Object> map) throws Exception;
//    public int deleteSALMA4502(Map<String, Object> map) throws Exception;
    public int deleteSALMA4503(Map<String, Object> map) throws Exception;

    public int applySALMA4503(Map<String, Object> map) throws Exception;
    public int applySALMA4505(Map<String, Object> map) throws Exception;
    public int applySALMADcAtmTax(Map<String, Object> map) throws Exception;

    public int saleCloseSALMA4500(Map<String, Object> map) throws Exception;
    public int saleCloseSALMA4501(Map<String, Object> map) throws Exception;

    public List<SALMA4506VO> applyBarcode2Item(Map<String, Object> map) throws Exception;
    public List<SALMA4501VO> countSALMA4506(Map<String, Object> map) throws Exception;
    public int applySALMA4506(Map<String, Object> map) throws Exception;
    public int resetSALMA4506(Map<String, Object> map) throws Exception;
    public int resetSALMA4507(Map<String, Object> map) throws Exception;
}
