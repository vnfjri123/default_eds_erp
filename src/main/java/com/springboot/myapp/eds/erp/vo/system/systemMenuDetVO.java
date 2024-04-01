package com.springboot.myapp.eds.erp.vo.system;

public class systemMenuDetVO {
    private String corpCd;
    private String menuId;
    private String pgmId;
    private String pgmIdDb;
    private String pgmNm;
    private String seq;
    private String pgmOrder;
    private String pgmIcon;
    private String useYn;
    private String parent;

    public String getCorpCd() {
        return corpCd;
    }

    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
    }

    public String getMenuId() {
        return this.menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public String getPgmId() {
        return this.pgmId;
    }

    public void setPgmId(String pgmId) {
        this.pgmId = pgmId;
    }

    public String getPgmIdDb() {
        return pgmIdDb;
    }

    public void setPgmIdDb(String pgmIdDb) {
        this.pgmIdDb = pgmIdDb;
    }

    public String getPgmNm() {
        return this.pgmNm;
    }

    public void setPgmNm(String pgmNm) {
        this.pgmNm = pgmNm;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getPgmOrder() {
        return this.pgmOrder;
    }

    public void setPgmOrder(String pgmOrder) {
        this.pgmOrder = pgmOrder;
    }

    public String getPgmIcon() {
        return this.pgmIcon;
    }

    public void setPgmIcon(String pgmIcon) {
        this.pgmIcon = pgmIcon;
    }

    public String getUseYn() {
        return this.useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

}