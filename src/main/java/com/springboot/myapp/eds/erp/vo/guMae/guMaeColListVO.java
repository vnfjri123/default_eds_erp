package com.springboot.myapp.eds.erp.vo.guMae;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class guMaeColListVO {
    private String corpCd;
    private String busiCd;
    private String busiNm;
    private String estCd;
    private String projCd;
    private String colCd;
    private String projDivi;
    private String deadDivi;
    private String sccDivi;
    private String colDivi;
    private String projNm;
    private String estDt;
    private String validDt;
    private String cntDt;
    private String dueDt;
    private String endDt;
    private String colDt;
    private String custCd;
    private String custNm;
    private String manCd;
    private String manNm;
    private String depaCd;
    private String depaNm;
    private String partPopup;
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

    public String getValidDt() {
        return Util.addMinusChar(validDt);
    }

    public String getCntDt() {
        return Util.addMinusChar(cntDt);
    }

    public String getDueDt() {
        return Util.addMinusChar(dueDt);
    }

    public String getEndDt() {
        return Util.addMinusChar(endDt);
    }
    public String getColDt() {
        return Util.addMinusChar(colDt);
    }
}