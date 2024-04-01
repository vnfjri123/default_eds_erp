package com.springboot.myapp.eds.erp.vo.project;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class projectProjCompCostListVO {
    private String corpCd;
    private String busiCd;
    private String estCd;
    private String projCd;
    private String projCompCd;
    private String seq;
    private String accountDivi;
    private String accountCd;
    private String custCd;
    private String depaCd;
    private String depaNm;
    private String credCd;
    private String costDt;
    private String expeDivi;
    private String accountNm;
    private String custNm;
    private String note;
    private String supAmt;
    private String vatAmt;
    private String totAmt;
    private String inpNm;
    private String updNm;

    public String getCostDt() {
        return Util.addMinusChar(costDt);
    }
}