package com.springboot.myapp.eds.pda.salma;

import com.springboot.myapp.util.Util;

public class SALMA3500VO {
    private String corpCd;
    private String busiCd;
    private String exNo;
    private String exDt;
    private String saleCloseDivi;
    private String custCd;
    private String custNm;
    private String supAmt;
    private String tax;
    private String totAmt;
    private String suppCd;
    private String suppNm;
    private String picCd;
    private String picNm;
    private String depaCd;
    private String depaNm;
    private String empCd;
    private String empNm;
    private String remark;
    private String closeYn;

    public String getCorpCd() {
        return this.corpCd;
    }

    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
    }

    public String getBusiCd() {
        return this.busiCd;
    }

    public void setBusiCd(String busiCd) {
        this.busiCd = busiCd;
    }

    public String getExNo() {
        return this.exNo;
    }

    public void setExNo(String exNo) {
        this.exNo = exNo;
    }

    public String getExDt() {
        return Util.addMinusChar(this.exDt);
    }

    public void setExDt(String exDt) {
        this.exDt = exDt;
    }

    public String getSaleCloseDivi() {
        return this.saleCloseDivi;
    }

    public void setSaleCloseDivi(String saleCloseDivi) {
        this.saleCloseDivi = saleCloseDivi;
    }

    public String getCustCd() {
        return this.custCd;
    }

    public void setCustCd(String custCd) {
        this.custCd = custCd;
    }

    public String getCustNm() {
        return this.custNm;
    }

    public void setCustNm(String custNm) {
        this.custNm = custNm;
    }

    public String getSupAmt() {
        return this.supAmt;
    }

    public void setSupAmt(String supAmt) {
        this.supAmt = supAmt;
    }

    public String getTax() {
        return this.tax;
    }

    public void setTax(String tax) {
        this.tax = tax;
    }

    public String getTotAmt() {
        return this.totAmt;
    }

    public void setTotAmt(String totAmt) {
        this.totAmt = totAmt;
    }

    public String getSuppCd() {
        return this.suppCd;
    }

    public void setSuppCd(String suppCd) {
        this.suppCd = suppCd;
    }

    public String getSuppNm() {
        return this.suppNm;
    }

    public void setSuppNm(String suppNm) {
        this.suppNm = suppNm;
    }

    public String getPicCd() {
        return this.picCd;
    }

    public void setPicCd(String picCd) {
        this.picCd = picCd;
    }

    public String getPicNm() {
        return this.picNm;
    }

    public void setPicNm(String picNm) {
        this.picNm = picNm;
    }

    public String getDepaCd() {
        return this.depaCd;
    }

    public void setDepaCd(String depaCd) {
        this.depaCd = depaCd;
    }

    public String getDepaNm() {
        return this.depaNm;
    }

    public void setDepaNm(String depaNm) {
        this.depaNm = depaNm;
    }

    public String getEmpCd() {
        return this.empCd;
    }

    public void setEmpCd(String empCd) {
        this.empCd = empCd;
    }

    public String getEmpNm() {
        return this.empNm;
    }

    public void setEmpNm(String empNm) {
        this.empNm = empNm;
    }

    public String getRemark() {
        return this.remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getCloseYn() {
        return this.closeYn;
    }

    public void setCloseYn(String closeYn) {
        this.closeYn = closeYn;
    }

}