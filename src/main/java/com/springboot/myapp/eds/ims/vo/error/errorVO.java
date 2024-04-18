package com.springboot.myapp.eds.ims.vo.error;


import lombok.Data;

import java.util.Date;

@Data
public class errorVO {
  private int index;
  private int siteIndex;
  private String busiCd;
  private String corpCd;
  private String depaCd;
  private String depaNm;
  private String inpId;
  private Date inpDttm;
  private String updId;
  private Date updDttm;
  private String title;
  private String content;
  private String receiptDt;
  private String completionDt;
  private String progressDivi;
  private String handler;

  private String userId;
  private String siteNm;
  private String ad;
  private String clasifyDivi;
  private String installDt;
  private String modelDivi;
  private String batteryDt;
  private String modelNm;
  private String projNm;
  private String projCd;
}
