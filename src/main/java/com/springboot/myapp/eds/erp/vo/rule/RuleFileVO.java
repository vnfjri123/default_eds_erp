package com.springboot.myapp.eds.erp.vo.rule;

import lombok.Data;

import java.util.Date;

@Data
public class RuleFileVO {
  private int index;
  private int ruleIndex;
  private String corpCd;
  private String saveNm;
  private String origNm;
  private String saveRoot;
  private String ext;
  private int size;
  private String inpId;
  private Date inpDttm;
  private String busiCd;
}
