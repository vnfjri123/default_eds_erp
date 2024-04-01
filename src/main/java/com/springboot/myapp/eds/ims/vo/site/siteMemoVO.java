package com.springboot.myapp.eds.ims.vo.site;

import lombok.Data;

import java.util.Date;

@Data
public class siteMemoVO {
  private int index;
  private int siteIndex;
  private String corpCd;
  private String memo;
  private String inpId;
  private Date inpDttm;
  private String updId;
  private Date updDttm;
}
