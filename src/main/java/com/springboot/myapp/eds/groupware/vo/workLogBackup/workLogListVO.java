package com.springboot.myapp.eds.groupware.vo.workLogBackup.workLog;

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

    public String getStDt() {
        return Util.addMinusChar(stDt);
    }

    public String getEdDt() {
        return Util.addMinusChar(edDt);
    }

    public double getRate() {
        return (double) Math.round((rate * 100)/100);
    }
}