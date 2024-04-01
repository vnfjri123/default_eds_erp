package com.springboot.myapp.eds.error.vo.error;

import lombok.Data;

@Data
public class errorLogListVO {
    private String corpCd;
    private String corpNm;
    private String seq;
    private String riskLevel;
    private String procStat;
    private String modulNm;
    private String mamuNm;
    private String busiCd;
    private String busiNm;
    private String depaCd;
    private String depaNm;
    private String empCd;
    private String empNm;
    private String reqCd;
    private String reqNm;
    private String note1;
    private String note2;
    private String inpDttm;
    private String procDttm;
    private String inpId;
    private String inpNm;
    private String updId;
    private String updNm;
}
