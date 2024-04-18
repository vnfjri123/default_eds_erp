package com.springboot.myapp.eds.erp.vo.archive;

import lombok.Data;

import java.util.Date;

@Data
public class archiveVideoVO {
  private int index;
  private int archiveIndex;
  private String corpCd;
  private String inpId;
  private Date inpDttm;
  private String saveNm;
  private String origNm;
  private String saveRoot;
  private String ext;
  private int size;
  private String empNm;
  private String busiCd;
  private Date updDttm;
  private String updId;
}
