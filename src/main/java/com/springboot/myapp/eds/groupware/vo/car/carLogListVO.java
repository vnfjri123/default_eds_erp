package com.springboot.myapp.eds.groupware.vo.car;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class carLogListVO {
    private String corpCd;
    private String corpNm;
    private String busiCd;
    private String busiNm;
    private String carLogCd;
    private String carCd;
    private String carNm;
    private String stDt;
    private String edDt;
    private String stLoca;
    private String edLoca;
    private String purpCd;
    private String useTime;
    private String empCd;
    private String empNm;
    private String depaCd;
    private String depaNm;
    private String stDist;
    private String mdDist;
    private String edDist;
    private String note;
    private String inpId;
    private String inpNm;
    private String updId;
    private String updNm;

    public String getStDist() {
        return Util.addCommaChar(stDist);
    }

    public String getMdDist() {
        return Util.addCommaChar(mdDist);
    }

    public String getEdDist() {
        return Util.addCommaChar(edDist);
    }
}
