package com.springboot.myapp.eds.erp.vo.erpNotice;

import lombok.Data;

import java.util.Date;

@Data
public class erpNoticeFileVO {
  private int index;
  private int noticeIndex;
  private String corpCd;
  private String saveNm;
  private String origNm;
  private String saveRoot;
  private String ext;
  private int size;
  private String inpId;
  private Date inpDttm;
  private String empNm;
  private String busiCd;
}
