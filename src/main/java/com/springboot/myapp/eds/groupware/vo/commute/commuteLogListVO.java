package com.springboot.myapp.eds.groupware.vo.commute;

import lombok.Data;

@Data
public class commuteLogListVO {
    private String corpCd;
    private String corpNm;
    private String busiCd;
    private String busiNm;
    private String title;
    private String category;
    private String seq;
    private String id;
    private String stDt;
    private String startTime;
    private String start;
    private String edDt;
    private String endTime;
    private String end;
    private String backgroundColor;
    private String depaCd;
    private String calendarId;
    private String depaNm;
    private String empCd;
    private String empNm;
    private String note;
    private String inpId;
    private String inpNm;
    private String updId;
    private String updNm;

    public String getTitle() {
        title = "[" + this.depaNm + "]" + this.empNm + " " + startTime + "~" + endTime;
        return title;
    }
}
