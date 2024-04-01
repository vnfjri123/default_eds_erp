package com.springboot.myapp.eds.groupware.vo.car;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class carBookListVO {
    private String corpCd;
    private String corpNm;
    private String busiCd;
    private String busiNm;
    private String carBookCd;
    private String carCd;
    private String title;
    private String id;
    private String carNm;
    private String stDt;
    private String start;
    private String edDt;
    private String end;
    private String backgroundColor;
    private String useTime;
    private String empCd;
    private String empNm;
    private String depaCd;
    private String calendarId;
    private String depaNm;
    private String purpCd;
    private String note;
    private String inpId;
    private String inpNm;
    private String updId;
    private String updNm;

    public String getTitle() {
        title = "[" + this.depaNm + "]" + this.empNm + " " + this.carNm;
        return title;
    }

    public String getStDt() {
        return stDt.substring(0,stDt.length()-3);
    }

    public String getStart() {
        return start.substring(0,start.length()-3);
    }

    public String getEdDt() {
        return edDt.substring(0,edDt.length()-3);
    }

    public String getEnd() {
        return end.substring(0,end.length()-3);
    }
}
