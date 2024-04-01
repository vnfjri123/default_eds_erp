package com.springboot.myapp.eds.groupware.vo.edms;
import lombok.Data;
import com.springboot.myapp.util.Util;

@Data
public class edmsExpenseItemListVO {
    private String corpCd;
    private String busiCd;
    private String submitCd;
    private String seq;
    private String projCd;
    private String projNm;
    private String accountCd;
    private String accountNm;
    private String supAmt;
    private String vatAmt;
    private String totAmt;
    private String costDt;
    private String custCd;
    private String custNm;
    private String depaCd;
    private String depaNm;
    private String credCd;
    private String credNm;
    private String expeDivi;
    private String payDivi;
    private String note;
    private String costPur;
    private String inpNm;
    private String updNm;
   
    public String getCostDt() {
        return Util.addMinusChar(costDt);
    }
}