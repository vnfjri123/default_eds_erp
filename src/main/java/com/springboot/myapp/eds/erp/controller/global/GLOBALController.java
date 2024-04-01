package com.springboot.myapp.eds.erp.controller.global;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class GLOBALController {

    @Autowired
    GLOBALService globalService;

    @RequestMapping("/eds/erp/global/selectCONTENTView")
    public String selectCONTENTView(Model model) throws Exception{

        return "/eds/erp/global/content";
    }
    
    @RequestMapping("/eds/erp/global/selectMAINCONTENTView")
    public String selectMAINCONTENTView(Model model) throws Exception{

        return "/eds/erp/global/MainContent";
    }
    @RequestMapping("/MANUAL_VIEW")
    public String manualiew(Model model) throws Exception{

        return "/eds/erp/global/manual";
    }
    

    @PostMapping("/eds/erp/global/selectMENU")
    @ResponseBody
    public Map<String, Object> selectMENU(@RequestParam Map<String, Object> map) throws Exception{
        Map<String, Object> hashMap = new HashMap<String, Object>();
        try {
            hashMap.put("data", globalService.selectMENU(map));
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        return hashMap;
    }

    @PostMapping("/eds/erp/global/selectMENUList")
    @ResponseBody
    public Map<String, Object> selectMENUList(@RequestParam Map<String, Object> map) throws Exception{
        Map<String, Object> hashMap = new HashMap<String, Object>();
        try {
            hashMap.put("data", globalService.selectMENUList(map));
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        return hashMap;
    }

    @PostMapping("/eds/erp/global/selectMainSearch")
    @ResponseBody
    public Map<String, Object> selectMainSearch(@RequestParam Map<String, Object> map) throws Exception{
        Map<String, Object> hashMap = new HashMap<String, Object>();
        try {
            hashMap.put("data", globalService.selectMainSearch(map));
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        return hashMap;
    }

    @RequestMapping("/eds/erp/global/recentTaxInvoiceIssuanceStatus")
    @ResponseBody
    public Map recentTaxInvoiceIssuanceStatus(@RequestBody HashMap<String, Object> map) throws Exception {
        Map mp = new HashMap();
        try {
            List li = globalService.recentTaxInvoiceIssuanceStatus(map);
            mp.put("data", li);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mp;
    }

    @RequestMapping("/eds/erp/global/recentProjectContractStatus")
    @ResponseBody
    public Map recentProjectContractStatus(@RequestBody HashMap<String, Object> map) throws Exception {
        Map mp = new HashMap();
        try {
            List li = globalService.recentProjectContractStatus(map);
            mp.put("data", li);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mp;
    }

    @RequestMapping("/eds/erp/global/overdueDeliveryAndNonIssuanceOfTaxInvoice")
    @ResponseBody
    public Map overdueDeliveryAndNonIssuanceOfTaxInvoice(@RequestBody HashMap<String, Object> map) throws Exception {
        Map mp = new HashMap();
        try {
            List li = globalService.overdueDeliveryAndNonIssuanceOfTaxInvoice(map);
            mp.put("data", li);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mp;
    }

    @RequestMapping("/eds/erp/global/deliveryTermProjectStatus")
    @ResponseBody
    public Map deliveryTermProjectStatus(@RequestBody HashMap<String, Object> map) throws Exception {
        Map mp = new HashMap();
        try {
            List li = globalService.deliveryTermProjectStatus(map);
            mp.put("data", li);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mp;
    }

    @RequestMapping("/eds/erp/global/collectionProjectStatus")
    @ResponseBody
    public Map collectionProjectStatus(@RequestBody HashMap<String, Object> map) throws Exception {
        Map mp = new HashMap();
        try {
            List li = globalService.collectionProjectStatus(map);
            mp.put("data", li);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mp;
    }

    @RequestMapping("/eds/erp/global/longTermAttemptedBondStatus")
    @ResponseBody
    public Map longTermAttemptedBondStatus(@RequestBody HashMap<String, Object> map) throws Exception {
        Map mp = new HashMap();
        try {
            List li = globalService.longTermAttemptedBondStatus(map);
            mp.put("data", li);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return mp;
    }
}
