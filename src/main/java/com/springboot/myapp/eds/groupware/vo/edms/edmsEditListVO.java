package com.springboot.myapp.eds.groupware.vo.edms;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class edmsEditListVO {
    private String corpCd;
    private String busiCd;
    private String submitCd;
    private String deadDivi;
    private String sccDivi;
    private String projNm;
    private String projPur;
    private String estDt;
    private String stDt;
    private String edDt;
    private String validDt;
    private String custCd;
    private String custNm;
    private String manCd;
    private String empCd;
    private String depaCd;
    private String manNm;
    private int supAmt;
    private int vatAmt;
    private int totAmt;
    private String supAmt2;
    private String vatAmt2;
    private String totAmt2;
    private String clas;
    private String item;
    private String payTm;
    private String note1;
    private String note2;
    private String inpNm;
    private String updNm;
    private String supAmt3;
    private String vatAmt3;
    private String totAmt3;
    private String supAmt4;
    private String vatAmt4;
    private String totAmt4;
    private String supAmt5;
    private String vatAmt5;
    private String totAmt5;
    private String margin;
    private String manager;
    private String profit;
    private String cntDt;
    private String inpId;
    private String keyCd;
    private String projDivi;
    private String editerArea;
    


    public String getEstiDt() {
        return Util.addMinusChar(estDt);
    }

    public String getValidDt() {
        return Util.addMinusChar(validDt);
    }
}
