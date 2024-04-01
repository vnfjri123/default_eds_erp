package com.springboot.myapp.eds.groupware.vo.edms;

import com.springboot.myapp.util.Util;

import lombok.Data;

@Data
public class edmsSubmitListVO {
    private String corpCd;
    private String busiCd;
    private String busiNm;
    private String submitCd;
    private String deadDivi;
    private String docDivi;
    private String ownerNm;
    private String submitDt;
    private String submitNm;
    private String inpDttm;
    private String useYn;
    private String submitApprover;
    private String submitCcUser;
    private String submitDivi;
    private String currApproverCd;
    private String corpNm;
    private String inpBusi;
    private String inpBusiNm;
    private String inpId;
    private String inpNm;
    private String updDttm;
    private String respDivi;
    private String posiDivi;
    private String depaNm;
    private String appUsers;
    private String appUsersName;
    private String ccUsers;
    private String ccUsersName;
    private String saveNm;
    private String inpCorpCd;
    private String inpCorpNm;
    private String completeDt;
    private String ext;
    
    public String getCorpCd() {
        return corpCd;
    }
    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
    }
    public String getBusiCd() {
        return busiCd;
    }
    public void setBusiCd(String busiCd) {
        this.busiCd = busiCd;
    }
    public String getSubmitCd() {
        return submitCd;
    }
    public void setSubmitCd(String submitCd) {
        this.submitCd = submitCd;
    }
    public String getDeadDivi() {
        return deadDivi;
    }
    public void setDeadDivi(String deadDivi) {
        this.deadDivi = deadDivi;
    }
    public String getDocDivi() {
        return docDivi;
    }
    public void setDocDivi(String docDivi) {
        this.docDivi = docDivi;
    }
    public String getOwnerNm() {
        return ownerNm;
    }
    public void setOwnerNm(String ownerNm) {
        this.ownerNm = ownerNm;
    }
    public String getSubmitDt() {
        return Util.addMinusChar(submitDt);
    }
    public void setSubmitDt(String submitDt) {
        this.submitDt = submitDt;
    }
    public String getSubmitNm() {
        return submitNm;
    }
    public void setSubmitNm(String submitNm) {
        this.submitNm = submitNm;
    }
    public String getInpNm() {
        return inpNm;
    }
    public void setInpNm(String inpNm) {
        this.inpNm = inpNm;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }


}