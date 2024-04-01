package com.springboot.myapp.eds.ims.vo.calendar;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class calendarVO {
  private int index;
  private String corpCd;
  private String depaCd;
  private String title;
  private String content;
  private Date startCalDt;
  private Date endCalDt;
  private String empNm;
  private Date inpDttm;
  private Date updDttm;
  private String remark;
  private String updId;
}