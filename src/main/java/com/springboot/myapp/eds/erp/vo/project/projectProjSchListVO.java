package com.springboot.myapp.eds.erp.vo.project;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class projectProjSchListVO {
    private String corpCd;
    private String busiCd;
    private String busiNm;
    private String estCd;
    private String projCd;
    private String projDivi;
    private String sccDivi;
    private String projNm;
    private String estDt;
    private String validDt;
    private String cntDt;
    private String initiateDt;
    private String dueDt;
    private String endDivi;
    private String endDt;
    private String custNm;
    private Double conTotAmt;
    private Double salTotAmt;
    private Double costTotAmt;
    private Double profitAmt;
    private Double profitRate;
    private Double colTotAmt;
    private Double reColTotAmt;
    private Double colTotRate;
    private String note1;
    private String inpNm;
    private String updNm;
    private String manNm;
    private String depaNm;
    private String clas; 
    private String item;
    private String edmsMargin;

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

    public Double getProfitAmt() {
        profitAmt = salTotAmt - costTotAmt;
        return profitAmt;
    }

    public Double getProfitRate() {
        profitRate = (double) (Math.round(( profitAmt / salTotAmt) * 1000) /10);
        if(profitRate<0) {profitRate = (double) 0;}
        else {}
        return profitRate;
    }

    public Double getColTotAmt() {
        colTotAmt = salTotAmt - colTotAmt;
        return colTotAmt;
    }

    public Double getReColTotAmt() {
        reColTotAmt = salTotAmt - colTotAmt;
        return reColTotAmt;
    }

    public Double getColTotRate() {
        colTotRate = 100.0 - Math.round((colTotAmt / salTotAmt) * 1000) /10;
        if(colTotRate == 100.0){
            colTotRate = 0.0;
        }
        return colTotRate;
    }

    public String getEdmsMargin() {
        edmsMargin = edmsMargin.replaceAll("%","");
        if (edmsMargin == null || edmsMargin.isEmpty()) {
            edmsMargin = "0";
        }
        return edmsMargin;
    }
}