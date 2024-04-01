package com.springboot.myapp.eds.erp.vo.email;

import com.springboot.myapp.util.Util;
import lombok.Data;

@Data
public class emailListVO {
    private String corpCd;
    private String busiCd;
    private String estCd;
    private String projCd;
    private String projNm;
    private String ordCd;
    private String sendDivi;
    private String salCd;
    private String emailSeq;
    private String seq;
    private String divi;
    private String setForm;
    private String toAddr;
    private String ccAddr;
    private String bccAddr;
    private String setSubject;
    private String note;
    private String inpId;
    private String inpNm;
    private String inpDttm;
    private String updId;
    private String updNm;
    private String updDttm;
}