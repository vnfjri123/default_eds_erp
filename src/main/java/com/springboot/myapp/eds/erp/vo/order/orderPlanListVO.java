package com.springboot.myapp.eds.erp.vo.order;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class orderPlanListVO {

    private String corpCd;
    private String ordPlanCd;
    private String ordPlanYear;
    private String ordPlanMonth;
    private String ordPlanDivi;
    private String ordPlanItem;
    private String ordPlanBusiCd;
    private String ordPlanDepaCd;
    private String ordPlanEmpCd;
    private String ordPlanBusiDivi;
    private String ordPlanCustCd;
    private String ordPlanAmt;
    private String ordPlanGr;
    private String ordPlanNote;

    @Override
    public String toString() {
        return "orderPlanListVO{" +
                "corpCd='" + corpCd + '\'' +
                ", ordPlanCd='" + ordPlanCd + '\'' +
                ", ordPlanYear='" + ordPlanYear + '\'' +
                ", ordPlanMonth='" + ordPlanMonth + '\'' +
                ", ordPlanDivi='" + ordPlanDivi + '\'' +
                ", ordPlanItem='" + ordPlanItem + '\'' +
                ", ordPlanBusiCd='" + ordPlanBusiCd + '\'' +
                ", ordPlanDepaCd='" + ordPlanDepaCd + '\'' +
                ", ordPlanEmpCd='" + ordPlanEmpCd + '\'' +
                ", ordPlanBusiDivi='" + ordPlanBusiDivi + '\'' +
                ", ordPlanCustCd='" + ordPlanCustCd + '\'' +
                ", ordPlanAmt='" + ordPlanAmt + '\'' +
                ", ordPlanGr='" + ordPlanGr + '\'' +
                ", ordPlanNote='" + ordPlanNote + '\'' +
                '}';
    }
}
