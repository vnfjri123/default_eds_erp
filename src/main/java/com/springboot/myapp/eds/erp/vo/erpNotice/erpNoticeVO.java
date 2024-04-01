package com.springboot.myapp.eds.erp.vo.erpNotice;

import lombok.Data;

import java.util.Date;

@Data
public class erpNoticeVO {
  private int index;
  private String corpCd;
  private String depaCd;
  private String depaNm;
  private String inpId;
  private Date inpDttm;
  private Date updDttm;
  private String updId;
  private String title;
  private String content;
  private int hit;
  private String endDt;
}
