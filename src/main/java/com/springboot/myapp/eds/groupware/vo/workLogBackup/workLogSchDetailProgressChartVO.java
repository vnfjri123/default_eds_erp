package com.springboot.myapp.eds.groupware.vo.workLogBackup.workLog;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class workLogSchDetailProgressChartVO {
    private String corpCd;
    private String planCd;
    private String planNm;
    private String stAmt;
    private String edAmt;
    private String unit;
    private String seq;
    private String planDt;
    private String planNote;
    private String planPer;
    private String planAmt;
    private String checkInDt;
    private String checkInNote;
    private String checkInPer;
    private String checkInAmt;

    public String getPlanDt() {
        return Util.addMinusChar(planDt);
    }

    public String getCheckInDt() {
        return Util.addMinusChar(checkInDt);
    }
}
