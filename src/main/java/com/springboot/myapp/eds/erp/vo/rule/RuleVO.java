package com.springboot.myapp.eds.erp.vo.rule;

import lombok.Data;

import java.util.Date;


@Data
public class RuleVO {
  private int index;
  private String corpCd;
  private String depaCd;
  private String depaNm;
  private String inpId;
  private Date inpDttm;
  private String updId;
  private Date updDttm;
  private String title;
  private int hit;
  private String saveNm;
  private String origNm;
  private String ext;
  private String read;
}
