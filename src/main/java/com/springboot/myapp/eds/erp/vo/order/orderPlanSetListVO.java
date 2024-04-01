package com.springboot.myapp.eds.erp.vo.order;

import lombok.Data;

@Data
public class orderPlanSetListVO {

    private String corpCd;
    private String ordPlanSetDt;
    private String ordInp02;
    private String ordInp03;
    private String ordInp04;
    private String salInp02;
    private String salInp03;
    private String salInp04;
    private String inpId;
    private String updId;
    private String inpNm;
    private String updNm;

    @Override
    public String toString() {
        return "orderPlanSetListVO{" +
                "corpCd='" + corpCd + '\'' +
                ", ordPlanSetDt='" + ordPlanSetDt + '\'' +
                ", ordInp02='" + ordInp02 + '\'' +
                ", ordInp03='" + ordInp03 + '\'' +
                ", ordInp04='" + ordInp04 + '\'' +
                ", salInp02='" + salInp02 + '\'' +
                ", salInp03='" + salInp03 + '\'' +
                ", salInp04='" + salInp04 + '\'' +
                ", inpId='" + inpId + '\'' +
                ", updId='" + updId + '\'' +
                ", inpNm='" + inpNm + '\'' +
                ", updNm='" + updNm + '\'' +
                '}';
    }
}
