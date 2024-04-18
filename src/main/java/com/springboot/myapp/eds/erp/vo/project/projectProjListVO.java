package com.springboot.myapp.eds.erp.vo.project;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class projectProjListVO {
    private String corpCd;
    private String busiCd;
    private String busiNm;
    private String projCd;
    private String estCd;
    private String projDivi;
    private String deadDivi;
    private String sccDivi;
    private String projNm;
    private String estDt;
    private String validDt;
    private String cntDt;
    private String initiateDt;
    private String dueDt;
    private String endDt;
    private String custCd;
    private String custNm;
    private String manCd;
    private String manNm;
    private String depaCd;
    private String depaNm;
    private String partPopup;
    private Double supAmt;
    private Double vatAmt;
    private Double totAmt;
    private Double supAmt2;
    private Double vatAmt2;
    private Double totAmt2;
    private Double supAmt3;
    private Double vatAmt3;
    private Double totAmt3;
    private Double supAmt4;
    private Double vatAmt4;
    private Double totAmt4;
    private Double supAmt5;
    private Double vatAmt5;
    private Double totAmt5;
    private Double costTotAmt;
    private String clas;
    private String item;
    private String payTm;
    private String note;
    private String note1;
    private String note2;
    private String inpNm;
    private String updNm;
    private String submitCd;
    private String margin;
    private String profit;
    private String margin2;
    private String profit2;
    private String margin3;
    private String profit3;
    private String manager;
    private String projPur;

    public String getEstDt() {
        return Util.addMinusChar(estDt);
    }

    public String getValidDt() {
        return Util.addMinusChar(validDt);
    }

    public String getCntDt() {
        return Util.addMinusChar(cntDt);
    }

    public String getInitiateDt() {
        return Util.addMinusChar(initiateDt);
    }

    public String getDueDt() {
        return Util.addMinusChar(dueDt);
    }

    public String getEndDt() {
        return Util.addMinusChar(endDt);
    }

    public String getProfit() {
        return Util.addCommaChar(Util.removeCommaChar(profit));
    }

    public String getProfit2() {
        return Util.addCommaChar(Util.removeCommaChar(profit2));
    }

    public String getProfit3() {
        return Util.addCommaChar(Util.removeCommaChar(profit3));
    }
}