package com.springboot.myapp.eds.erp.vo.yeongEob;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class yeongEobEstListVO {
    private String corpCd;
    private String busiCd;
    private String busiNm;
    private String estCd;
    private String deadDivi;
    private String sccDivi;
    private String projNm;
    private String estDt;
    private String validDt;
    private String custCd;
    private String custNm;
    private String manCd;
    private String manNm;
    private String manNote;
    private String depaCd;
    private String depaNm;
    private double supAmt;
    private double vatAmt;
    private double totAmt;
    private double supAmt2;
    private double vatAmt2;
    private double totAmt2;
    private String profit;
    private String margin;
    private String clas;
    private String item;
    private String payTm;
    private String note1;
    private String note2;
    private String note3;
    private String inpNm;
    private String updNm;
    private String submitCd;
    private String keyCd;

    public String getEstDt() {
        return Util.addMinusChar(estDt);
    }

    public String getValidDt() {
        return Util.addMinusChar(validDt);
    }
}