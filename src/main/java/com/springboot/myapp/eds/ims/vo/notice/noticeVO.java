package com.springboot.myapp.eds.ims.vo.notice;

import lombok.Data;

import java.util.Date;

@Data
public class noticeVO {
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
