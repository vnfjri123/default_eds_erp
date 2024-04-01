package com.springboot.myapp.eds.erp.vo.guMae;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class guMaeOrdListVO {
    private String corpCd;
    private String busiCd;
    private String busiNm;
    private String estCd;
    private String projCd;
    private String ordCd;
    private String deadDivi;
    private String sccDivi;
    private String projNm;
    private String estDt;
    private String ordDt;
    private String validDt;
    private String ordDueDt;
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
    private double supAmt3;
    private double vatAmt3;
    private double totAmt3;
    private String clas;
    private String item;
    private String payTm;
    private String note1;
    private String note2;
    private String inpNm;
    private String updNm;

    public String getEstDt() {
        return Util.addMinusChar(estDt);
    }
    public String getOrdDt() {
        return Util.addMinusChar(ordDt);
    }

    public String getValidDt() {
        return Util.addMinusChar(validDt);
    }

    public String getOrdDueDt() {
        return Util.addMinusChar(ordDueDt);
    }
}