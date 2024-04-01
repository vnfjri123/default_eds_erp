package com.springboot.myapp.eds.ims.vo.error;

import lombok.Data;

import java.util.Date;

@Data
public class errorImageVO {
  private int index;
  private int errorIndex;
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
