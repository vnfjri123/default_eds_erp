package com.springboot.myapp.eds.pda.salma;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SALMA3500Mapper {

    public List<SALMA3500VO> selectSALMA3500(Map<String, Object> map) throws Exception;
    public List<SALMA3501VO> selectSALMA3501(Map<String, Object> map) throws Exception;
    public List<SALMA3502VO> selectSALMA3502(Map<String, Object> map) throws Exception;
    public List<SALMA3503VO> selectSALMA3503(Map<String, Object> map) throws Exception;
    public List<SALMA3504VO> selectSALMA3504(Map<String, Object> map) throws Exception;
    public List<SALMA3505VO> selectSALMA3505(Map<String, Object> map) throws Exception;
    public List<SALMA3501VO> selectSALMA3506(Map<String, Object> map) throws Exception;
    public List<SALMA3501VO> selectSALMA3507(Map<String, Object> map) throws Exception;
    public List<SALMA3501VO> selectSALMA3508(Map<String, Object> map) throws Exception;
    public List<SALMA3501VO> selectSALMA3509(Map<String, Object> map) throws Exception;

    public int insertSALMA3500(Map<String, Object> map) throws Exception;
    public int insertSALMA3501(Map<String, Object> map) throws Exception;

    public int updateSALMA3500(Map<String, Object> map) throws Exception;
    public int updateSALMA3501(Map<String, Object> map) throws Exception;
    public int updateSALMA3502(Map<String, Object> map) throws Exception;
    public int updateSALMA3503(Map<String, Object> map) throws Exception;
    public int updateSALMA3506(Map<String, Object> map) throws Exception;

    public int resetSALMA3503(Map<String, Object> map) throws Exception;
    public int updateSALMA3505(Map<String, Object> map) throws Exception;
    public int resetSALMA3505(Map<String, Object> map) throws Exception;
    public int closeYnSALMA3500(Map<String, Object> map) throws Exception;

    public int deleteSALMA3500(Map<String, Object> map) throws Exception;
    public int deleteSALMA3501(Map<String, Object> map) throws Exception;
    public int deleteSALMA3502(Map<String, Object> map) throws Exception;
    public int deleteSALMA3503(Map<String, Object> map) throws Exception;

    public int applySALMA3503(Map<String, Object> map) throws Exception;
    public int applySALMA3505(Map<String, Object> map) throws Exception;
    public int applySALMADcAtmTax(Map<String, Object> map) throws Exception;

    public int saleCloseSALMA3500(Map<String, Object> map) throws Exception;
    public int saleCloseSALMA3501(Map<String, Object> map) throws Exception;

    public List<SALMA3506VO> applyBarcode2Item(Map<String, Object> map) throws Exception;
    public List<SALMA3501VO> countSALMA3506(Map<String, Object> map) throws Exception;
    public int applySALMA3506(Map<String, Object> map) throws Exception;
    public int resetSALMA3506(Map<String, Object> map) throws Exception;
    public int resetSALMA3507(Map<String, Object> map) throws Exception;
}
