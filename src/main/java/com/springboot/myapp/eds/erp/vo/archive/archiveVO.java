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
  private String content;

  private String thumbOrigNm;
  private String thumbExt;
  private String thumbSaveRoot;
  private String thumbSaveNm;
  private String thumbSize;

  private String videoSaveNm;
  private String videoExt;
  private String videoOrigNm;
  private String videoSaveRoot;
}
