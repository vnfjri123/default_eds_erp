package com.springboot.myapp.eds.ims.vo.site;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Data
public class siteFileVO {
  private int index;
  private int siteIndex;
  private String corpCd;
  private String saveNm;
  private String origNm;
  private String saveRoot;
  private String ext;
  private int size;
  private String remark;
  private String inpId;
  private Date inpDttm;
  private String updId;
  private Date updDttm;
  private String empNm;
  private String updNm;
}
