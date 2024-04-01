package com.springboot.myapp.eds.erp.vo.global;
import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class MAINCONTENTVO {
    private String corpCd;
    private String busiCd;
    private String mon;
    private String conTotAmt;
    private String salTotAmt;
    private String costTotAmt;
    private String colTotAmt;

    /* main 화면 조회 현황*/
    private String dt;
    private String custNm;
    private String projNm;
    private String note;
    private String amt;

    public String getDt() {
        return Util.addMinusChar(dt);
    }

}