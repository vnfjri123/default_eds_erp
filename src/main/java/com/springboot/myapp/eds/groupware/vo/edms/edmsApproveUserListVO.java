package com.springboot.myapp.eds.groupware.vo.edms;

import com.springboot.myapp.util.Util;

import lombok.Data;

@Data
public class edmsApproveUserListVO {
    private String corpCd;
    private String busiCd;
    private String submitCd;
    private String approverCd;
    private String empNm;
    private String seq;
    private String message;
    private String inpDttm;
    private String inpId;
}