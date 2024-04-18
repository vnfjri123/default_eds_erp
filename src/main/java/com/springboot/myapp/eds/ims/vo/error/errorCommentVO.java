package com.springboot.myapp.eds.ims.vo.error;

import lombok.Data;

import java.util.Date;

@Data
public class errorCommentVO {
  private String corpCd;
  private String submitCd;
  private String busiCd;
  private String seq;
  private String content;
  private String inpId;
  private String inpDttm;
  private String updDttm;
  private String depaCd;

  private String empNm;
  private String depaNm;
}
