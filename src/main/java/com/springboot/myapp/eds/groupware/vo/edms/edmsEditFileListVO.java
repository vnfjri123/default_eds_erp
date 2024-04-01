package com.springboot.myapp.eds.groupware.vo.edms;
import lombok.Data;

@Data
public class edmsEditFileListVO {
    private String corpCd;
    private String seq;
    private String saveRoot;
    private String ext;
    private String size;
    private String inpNm;
    private String inpDttm;
    private String updNm;
    private String updDttm;
}
