package com.springboot.myapp.eds.ims.vo.inspection;

import lombok.Data;

import java.util.Date;

@Data
public class inspectionVO {
  private String index;

  private String insCount;
  private String corpCd;
  private String depaCd;
  private String depaNm;
  private String month;
  private String empCd;
  private String inspectDt;
  private String siteNm;
  private String projNm;
  private String projCd;
  private String content;
  private String inpId;
  private Date inpDttm;
  private String updId;
  private Date updDttm;
  private String inspectDivi;
  private int totNum;
  private int completionNum;
  private int incompletionNum;

  private String year;
  private String ad;
  private String clasifyDivi;
  private String CheckCycle;
  private int rate;
}
