package com.springboot.myapp.eds.erp.controller.global;

import com.springboot.myapp.eds.erp.vo.global.MAINCONTENTVO;
import com.springboot.myapp.eds.erp.vo.global.MENULISTVO;
import com.springboot.myapp.eds.erp.vo.global.MENUVO;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class GLOBALService {
    
    @Autowired
    private GLOBALMapper globalMapper;


    public List<MENUVO> selectMENU(Map<String, Object> map) throws Exception
    {
        map.put("groupId", SessionUtil.getUser().getGroupId());
        List<MENUVO> result = globalMapper.selectMENU(map);
        return result;
    }

    public List<MENULISTVO> selectMENUList(Map<String, Object> map) throws Exception
    {
        map.put("groupId", SessionUtil.getUser().getGroupId());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<MENULISTVO> result = globalMapper.selectMENUList(map);
        return result;
    }
    public List<MAINCONTENTVO> selectMainSearch(Map<String, Object> map) throws Exception
    {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<MAINCONTENTVO> result = globalMapper.selectMainSearch(map);
        return result;
    }
    public List<MAINCONTENTVO> recentTaxInvoiceIssuanceStatus(Map<String, Object> map) throws Exception
    {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<MAINCONTENTVO> result = globalMapper.recentTaxInvoiceIssuanceStatus(map);
        return result;
    }
    public List<MAINCONTENTVO> recentProjectContractStatus(Map<String, Object> map) throws Exception
    {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<MAINCONTENTVO> result = globalMapper.recentProjectContractStatus(map);
        return result;
    }
    public List<MAINCONTENTVO> overdueDeliveryAndNonIssuanceOfTaxInvoice(Map<String, Object> map) throws Exception
    {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<MAINCONTENTVO> result = globalMapper.overdueDeliveryAndNonIssuanceOfTaxInvoice(map);
        return result;
    }
    public List<MAINCONTENTVO> deliveryTermProjectStatus(Map<String, Object> map) throws Exception
    {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<MAINCONTENTVO> result = globalMapper.deliveryTermProjectStatus(map);
        return result;
    }
    public List<MAINCONTENTVO> collectionProjectStatus(Map<String, Object> map) throws Exception
    {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<MAINCONTENTVO> result = globalMapper.collectionProjectStatus(map);
        return result;
    }
    public List<MAINCONTENTVO> longTermAttemptedBondStatus(Map<String, Object> map) throws Exception
    {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<MAINCONTENTVO> result = globalMapper.longTermAttemptedBondStatus(map);
        return result;
    }
}
