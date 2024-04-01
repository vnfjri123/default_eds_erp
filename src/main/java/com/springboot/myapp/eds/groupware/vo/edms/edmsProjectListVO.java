package com.springboot.myapp.eds.groupware.vo.edms;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class edmsProjectListVO {
    private String corpCd;
    private String busiCd;
    private String submitCd;
    private String deadDivi;
    private String sccDivi;
    private String projNm;
    private String projPur;
    private String ProjectDt;
    private String stDt;
    private String edDt;
    private String validDt;
    private String custCd;
    private String custNm;
    private String manCd;
    private String empCd;
    private String depaCd;
    private String manNm;
    private int supAmt;
    private int vatAmt;
    private int totAmt;
    private String supAmt2;
    private String vatAmt2;
    private String totAmt2;
    private String clas;
    private String item;
    private String payTm;
    private String note1;
    private String note2;
    private String inpNm;
    private String updNm;

    public String getProjectiDt() {
        return Util.addMinusChar(ProjectDt);
    }

    public String getValidDt() {
        return Util.addMinusChar(validDt);
    }
}
