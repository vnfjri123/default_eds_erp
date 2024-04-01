package com.springboot.myapp.eds.erp.controller.yeongEob;

import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobRecListVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobSalListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface yeongEobRecMapper {
    public List<yeongEobRecListVO> selectRecMgtList(Map<String, Object> map) throws Exception;

}
