package com.springboot.myapp.eds.erp.vo.file;

import lombok.Data;

@Data
public class fileDownloadHistoryListVO {
    private String corpCd;
    private String busiCd;
    private String seq;
    private String origNm;
    private String saveRoot;
    private String menuPath;
    private String inpId;
    private String inpNm;
    private String inpDttm;
}