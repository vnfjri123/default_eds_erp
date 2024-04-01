package com.springboot.myapp.eds.erp.vo.global;

import lombok.Data;

@Data
public class MENULISTVO {
    private String pgmId;
    private String pgmNm;
    private String menuId;
    private String pgmUrl;
    private String pgmIcon;
    private String readAuth;
    private String addAuth;
    private String updAuth;
    private String delAuth;
    private String excelDownAuth;
    private String printAuth;
    private String finishAuth;
    private String cancelAuth;
    private String emailPopupAuth;
    private String parent;
}