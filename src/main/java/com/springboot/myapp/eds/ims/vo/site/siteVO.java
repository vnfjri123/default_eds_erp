package com.springboot.myapp.eds.ims.vo.site;

import lombok.Data;

import java.util.Date;

@Data
public class siteVO {
  private int index;
  private String corpCd;
  private String depaCd;
  private String depaNm;
  private String empNm;
  private String projNm;
  private String projCd;
  private Date inpDttm;
  private Date updDttm;
  private String updId;
  private String ad;
  private String address;
  private String siteNm;
  private String dualSt;
  private String installDt;
  private String clasifyDivi;
  private String modelDivi;
  private String speakerSt;
  private String installDivi;
  private int SpeakerDx;
  private String satelliteDivi;
  private String satelliteId;
  private String commDivi;
  private String comm9k;
  private String commTD;
  private String telNo;
  private String ipAdr;
  private String mcuV;
  private String batteryDt;
  private String latitude;
  private String longitude;
  private String serviceDivi;
  private String checkCycle;
  private String remark;
  private String districtDivi;
  private String modelNm;
  private String maker;
  private String networkDivi;
  private String chargeDivi;
  private String examDt;
  private String sensor;
  private String measureUnit;
  private String sensorInstallDt;
  private String sensorExamNo;
  private String year;
  private int carryOverIndex;
  private String carryOverDivi;
}
