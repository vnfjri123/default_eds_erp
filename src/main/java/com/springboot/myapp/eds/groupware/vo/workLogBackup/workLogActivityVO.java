package com.springboot.myapp.eds.groupware.vo.workLogBackup.workLog;

import lombok.Data;

@Data
public class workLogActivityVO {
    private String corpCd;
    private String corpNm;
    private String planCd;
    private String seq;
    private String saveDivi;
    private String busiCd;
    private String busiNm;
    private String depaCd;
    private String depaNm;
    private String content;
    private String inpId;
    private String inpNm;
    private String inpDttm;
    private String updId;
    private String updNm;
    private String updDttm;
}
