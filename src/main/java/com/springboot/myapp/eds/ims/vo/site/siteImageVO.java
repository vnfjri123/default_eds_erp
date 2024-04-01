package com.springboot.myapp.eds.ims.vo.site;

import lombok.Data;

import java.util.Date;

@Data
public class siteImageVO {
  private int index;
  private int siteIndex;
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
