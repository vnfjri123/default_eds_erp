package com.springboot.myapp.eds.groupware.vo.edms;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class edmsEstListVO {
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
    private String initiateDt;
    private String validDt;
    private String custCd;
    private String custNm;
    private String manCd;
    private String empCd;
    private String depaCd;
    private String manNm;
    private Double supAmt;
    private Double vatAmt;
    private Double totAmt;
    private Double supAmt2;
    private Double vatAmt2;
    private Double totAmt2;
    private String clas;
    private String item;
    private String payTm;
    private String note1;
    private String note2;
    private String inpNm;
    private String updNm;
    private Double supAmt3;
    private Double vatAmt3;
    private Double totAmt3;
    private Double supAmt4;
    private Double vatAmt4;
    private Double totAmt4;
    private Double supAmt5;
    private Double vatAmt5;
    private Double totAmt5;
    private String margin;
    private String profit;
    private String margin2;
    private String profit2;
    private String margin3;
    private String profit3;
    private String manager;
    private String cntDt;
    private String inpId;
    private String keyCd;
    private String projDivi;
    


    public String getEstiDt() {
        return Util.addMinusChar(estDt);
    }

    public String getValidDt() {
        return Util.addMinusChar(validDt);
    }
    public String getInitiateDt() {
        return Util.addMinusChar(initiateDt);
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
