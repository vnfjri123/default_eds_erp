package com.springboot.myapp.eds.erp.controller.global;

import com.springboot.myapp.eds.erp.vo.global.MENULISTVO;
import com.springboot.myapp.eds.erp.vo.global.MENUVO;
import com.springboot.myapp.eds.erp.vo.global.MAINCONTENTVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface GLOBALMapper {

    public List<MENUVO> selectMENU(Map<String, Object> map) throws Exception;

    public List<MENULISTVO> selectMENUList(Map<String, Object> map) throws Exception;
    public List<MAINCONTENTVO> selectMainSearch(Map<String, Object> map) throws Exception;
    public List<MAINCONTENTVO> recentTaxInvoiceIssuanceStatus(Map<String, Object> map) throws Exception;
    public List<MAINCONTENTVO> recentProjectContractStatus(Map<String, Object> map) throws Exception;
    public List<MAINCONTENTVO> overdueDeliveryAndNonIssuanceOfTaxInvoice(Map<String, Object> map) throws Exception;
    public List<MAINCONTENTVO> deliveryTermProjectStatus(Map<String, Object> map) throws Exception;
    public List<MAINCONTENTVO> collectionProjectStatus(Map<String, Object> map) throws Exception;
    public List<MAINCONTENTVO> longTermAttemptedBondStatus(Map<String, Object> map) throws Exception;

}