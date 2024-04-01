package com.springboot.myapp.eds.erp.vo.system;

import lombok.Data;

@Data
public class systemGpAuthVO {
    private String corpCd;
    private String groupId;
    private String menuId;
    private String pgmId;
    private String pgmNm;
    private String pgmUrl;
    private String readAuth;
    private String addAuth;
    private String updAuth;
    private String delAuth;
    private String excelDownAuth;
    private String printAuth;
    private String finishAuth;
    private String cancelAuth;
    private String emailPopupAuth;
}