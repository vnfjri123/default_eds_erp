package com.springboot.myapp.eds.groupware.vo.workLog;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class workLogListVO {
    private String corpCd;
    private String corpNm;
    private String planCd;
    private String planDivi;
    private String parePlanCd;
    private String planCdRoot;
    private String pareSeq;
    private String depth;
    private String planNm;
    private String subPlanNm;
    private String busiCd;
    private String busiNm;
    private String depaCd;
    private String depaNm;
    private String depaColorCd;
    private String empCd;
    private String empNm;
    private String partCds;
    private String inpId;
    private String inpNm;
    private String updId;
    private String updNm;
    private String saveDivi;
    private String stDt;
    private String edDt;
    private String unit;
    private String stAmt;
    private String edAmt;
    private String note;
    private String edRate;
    private double rate;
    private String status;
    private String partImg;
    private String statusDivi;
    private String statusDivis;
    private String cntColor;

    public String getStDt() {
        return Util.addMinusChar(stDt);
    }

    public String getEdDt() {
        return Util.addMinusChar(edDt);
    }

    public double getRate() {
        return (double) Math.round((rate * 100)/100);
    }

    @Override
    public String toString() {
        return "workLogListVO{" +
                "corpCd='" + corpCd + '\'' +
                ", corpNm='" + corpNm + '\'' +
                ", planCd='" + planCd + '\'' +
                ", planDivi='" + planDivi + '\'' +
                ", parePlanCd='" + parePlanCd + '\'' +
                ", planCdRoot='" + planCdRoot + '\'' +
                ", pareSeq='" + pareSeq + '\'' +
                ", depth='" + depth + '\'' +
                ", planNm='" + planNm + '\'' +
                ", subPlanNm='" + subPlanNm + '\'' +
                ", busiCd='" + busiCd + '\'' +
                ", busiNm='" + busiNm + '\'' +
                ", depaCd='" + depaCd + '\'' +
                ", depaNm='" + depaNm + '\'' +
                ", depaColorCd='" + depaColorCd + '\'' +
                ", empCd='" + empCd + '\'' +
                ", empNm='" + empNm + '\'' +
                ", partCds='" + partCds + '\'' +
                ", inpId='" + inpId + '\'' +
                ", inpNm='" + inpNm + '\'' +
                ", updId='" + updId + '\'' +
                ", updNm='" + updNm + '\'' +
                ", saveDivi='" + saveDivi + '\'' +
                ", stDt='" + stDt + '\'' +
                ", edDt='" + edDt + '\'' +
                ", unit='" + unit + '\'' +
                ", stAmt='" + stAmt + '\'' +
                ", edAmt='" + edAmt + '\'' +
                ", note='" + note + '\'' +
                ", edRate='" + edRate + '\'' +
                ", rate=" + rate +
                ", status='" + status + '\'' +
                ", partImg='" + partImg + '\'' +
                ", statusDivi='" + statusDivi + '\'' +
                ", statusDivis='" + statusDivis + '\'' +
                ", cntColor='" + cntColor + '\'' +
                '}';
    }
}