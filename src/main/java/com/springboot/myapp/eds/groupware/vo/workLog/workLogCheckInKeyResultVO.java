package com.springboot.myapp.eds.groupware.vo.workLog;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class workLogCheckInKeyResultVO {
    private String corpCd;
    private String corpNm;
    private String planCd;
    private String seq;
    private String saveDivi;
    private String checkInDivi;
    private String dt;
    private String amt;
    private String planningAmt;
    private String ckeckInamt;
    private double edAmt;
    private double rate;
    private String statusDivi;
    private String busiCd;
    private String busiNm;
    private String depaCd;
    private String depaNm;
    private String depaColorCd;
    private String note;
    private String inpId;
    private String inpNm;
    private String updId;
    private String updNm;

    public String getDt() {
        return Util.addMinusChar(dt);
    }
}
