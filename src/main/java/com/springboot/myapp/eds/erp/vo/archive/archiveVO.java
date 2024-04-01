package com.springboot.myapp.eds.erp.vo.archive;

import lombok.Data;

import java.util.Date;

@Data
public class archiveVO {
  private int index;
  private String corpCd;
  private String depaCd;
  private String depaNm;
  private String inpId;
  private Date inpDttm;
  private Date updDttm;
  private String updId;
  private String title;
  private int hit;
  private String saveNm;
  private String videoSaveNm;
  private String origNm;
  private String videoOrigNm;
  private String saveRoot;
  private String ext;
  private String videoExt;
  private int size;
  private String content;
}
