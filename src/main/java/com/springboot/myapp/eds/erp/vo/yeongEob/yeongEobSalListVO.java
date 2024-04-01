package com.springboot.myapp.eds.erp.vo.yeongEob;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class yeongEobSalListVO {

    private String corpCd;
    private String busiCd;
    private String busiNm;
    private String estCd;
    private String projCd;
    private String salCd;
    private String projDivi;
    private String deadDivi;
    private String sccDivi;
    private String salDivi;
    private String projNm;
    private String estDt;
    private String validDt;
    private String cntDt;
    private String dueDt;
    private String endDt;
    private String salDt;
    private String custCd;
    private String custNm;
    private String manCd;
    private String manNm;
    private String depaCd;
    private String depaNm;
    private String partPopup;
    private int supAmt;
    private int vatAmt;
    private int totAmt;
    private int supAmt2;
    private int vatAmt2;
    private int totAmt2;
    private int supAmt3;
    private int vatAmt3;
    private int totAmt3;
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
    public String getSalDt() {
        return Util.addMinusChar(salDt);
    }
}