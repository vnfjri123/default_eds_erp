package com.springboot.myapp.eds.erp.vo.system;

public class systemMenuListVO {
    private String corpCd;
    private String menuId;
    private String menuNm;
    private String seq;
    private String menuOrder;
    private String menuIcon;
    private String useYn;

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

    public String getMenuNm() {
        return this.menuNm;
    }

    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    public String getSeq() {
        return this.seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getMenuOrder() {
        return this.menuOrder;
    }

    public void setMenuOrder(String menuOrder) {
        this.menuOrder = menuOrder;
    }

    public String getMenuIcon() {
        return this.menuIcon;
    }

    public void setMenuIcon(String menuIcon) {
        this.menuIcon = menuIcon;
    }

    public String getUseYn() {
        return this.useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

}