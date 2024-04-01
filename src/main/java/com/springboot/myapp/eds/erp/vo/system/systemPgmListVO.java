package com.springboot.myapp.eds.erp.vo.system;

public class systemPgmListVO {
    private String corpCd;
    private String pgmId;
    private String pgmNm;
    private String pgmUrl;
    private String pgmExp;
    private String useYn;

    public String getCorpCd() {
        return corpCd;
    }

    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
    }

    public String getPgmId() {
        return pgmId;
    }

    public void setPgmId(String pgmId) {
        this.pgmId = pgmId;
    }

    public String getPgmNm() {
        return pgmNm;
    }

    public void setPgmNm(String pgmNm) {
        this.pgmNm = pgmNm;
    }

    public String getPgmUrl() {
        return pgmUrl;
    }

    public void setPgmUrl(String pgmUrl) {
        this.pgmUrl = pgmUrl;
    }

    public String getPgmExp() {
        return pgmExp;
    }

    public void setPgmExp(String pgmExp) {
        this.pgmExp = pgmExp;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
}