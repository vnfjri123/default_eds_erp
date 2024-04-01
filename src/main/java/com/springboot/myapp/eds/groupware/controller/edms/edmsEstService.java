package com.springboot.myapp.eds.groupware.controller.edms;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.groupware.vo.edms.edmsEstItemListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsEstListVO;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class edmsEstService {

    @Autowired
    private edmsEstMapper edmsEstMapper;


    @Autowired
    private edmsSubmitService edmsSubmitService;

    public List<edmsEstListVO> selectEstList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("cntDt", Util.removeMinusChar((String) map.get("cntDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<edmsEstListVO> result = edmsEstMapper.selectEstList(map);
        return result;
    }

    public List<edmsEstItemListVO> selectEstItemList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("cntDt", Util.removeMinusChar((String) map.get("cntDt")));
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<edmsEstItemListVO> result = edmsEstMapper.selectEstItemList(map);
        return result;
    }
    @Transactional
    public int insertEstList(List<MultipartFile> file,Map<String, Object> map) throws Exception {
        int result=0;
        //기안상신 내용
        Map<String, Object> submitData = (Map<String, Object>) map.get("parentData");
        submitData.put("corpCd", SessionUtil.getUser().getCorpCd());//회사내용추가
        submitData.put("submitNm", map.get("submitNm"));//문서명 추가
        result+=edmsSubmitService.insertSubmitList(submitData);
        //견적품의 form 내용
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("submitCd",submitData.get("submitCd"));
        map.put("estDt",Util.removeMinusChar((String) map.get("estDt")));
        map.put("initiateDt", Util.removeMinusChar((String) map.get("initiateDt")));
        map.put("cntDt", Util.removeMinusChar((String) map.get("cntDt")));
        result+=edmsEstMapper.insertEstList(map);
        result+=edmsSubmitService.insertEdmsFileList(file, map);
        result+= edmsEstMapper.deleteEstItemList(map);
        //견적품의 item 내용
        List saveItemData = (List) map.get("itemData");
		for (int i = 0; i < saveItemData.size(); i++) {
			Map<String, Object>  row = (Map<String, Object>) saveItemData.get(i);
            row.put("corpCd", SessionUtil.getUser().getCorpCd());//회사내용추가
            row.put("userId", SessionUtil.getUser().getEmpCd());
            row.put("submitCd",submitData.get("submitCd"));
            result+=edmsEstMapper.insertEstItemList(row);
		}

        return result;
    }

    public int insertEstItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsEstMapper.insertEstItemList(map);
    }

    public int updateEstList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsEstMapper.updateEstList(map);
    }

    public int updateEstItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsEstMapper.updateEstItemList(map);
    }

    public int deleteEstList(Map<String, Object> map) throws Exception {
        return edmsEstMapper.deleteEstList(map);
    }

    public int deleteEstItemList(Map<String, Object> map) throws Exception {
        return edmsEstMapper.deleteEstItemList(map);
    }
}
