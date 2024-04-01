package com.springboot.myapp.eds.groupware.controller.edms;

import java.util.List;
import java.util.Map;

import com.springboot.myapp.eds.groupware.vo.edms.edmsExpenseItemListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsExpenseListVO;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class edmsExpenseService {

    @Autowired
    private edmsExpenseMapper edmsExpenseMapper;


    @Autowired
    private edmsSubmitService edmsSubmitService;

    public List<edmsExpenseListVO> selectExpenseList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("cntDt", Util.removeMinusChar((String) map.get("cntDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<edmsExpenseListVO> result = edmsExpenseMapper.selectExpenseList(map);
        return result;
    }

    public List<edmsExpenseItemListVO> selectExpenseItemList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("cntDt", Util.removeMinusChar((String) map.get("cntDt")));
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<edmsExpenseItemListVO> result = edmsExpenseMapper.selectExpenseItemList(map);
        return result;
    }
    @Transactional
    public int insertExpenseList(List<MultipartFile> file,Map<String, Object> map) throws Exception {
        int result=0;
        //기안상신 내용
        Map<String, Object> submitData = (Map<String, Object>) map.get("parentData");
        submitData.put("corpCd", SessionUtil.getUser().getCorpCd());//회사내용추가
        submitData.put("submitNm", map.get("submitNm"));//문서명 추가
        result+=edmsSubmitService.insertSubmitList(submitData);
        //견적품의 form 내용
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("submitCd",submitData.get("submitCd"));
        map.put("expenseDt",submitData.get("submitDt"));
        map.put("cntDt", Util.removeMinusChar((String) map.get("cntDt")));
        result+=edmsExpenseMapper.insertExpenseList(map);
        result+=edmsSubmitService.insertEdmsFileList(file, map);
        result+= edmsExpenseMapper.deleteExpenseItemList(map);
        //견적품의 item 내용
        List saveItemData = (List) map.get("itemData");
		for (int i = 0; i < saveItemData.size(); i++) {
			Map<String, Object>  row = (Map<String, Object>) saveItemData.get(i);
            System.out.println(row);
            row.put("corpCd", SessionUtil.getUser().getCorpCd());//회사내용추가
            row.put("userId", SessionUtil.getUser().getEmpCd());
            row.put("submitCd",submitData.get("submitCd"));
            row.put("costDt", Util.removeMinusChar((String) row.get("costDt")));
            result+=edmsExpenseMapper.insertExpenseItemList(row);
		}

        return result;
    }

    public int insertExpenseItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsExpenseMapper.insertExpenseItemList(map);
    }

    public int updateExpenseList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsExpenseMapper.updateExpenseList(map);
    }

    public int updateExpenseItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsExpenseMapper.updateExpenseItemList(map);
    }

    public int deleteExpenseList(Map<String, Object> map) throws Exception {
        return edmsExpenseMapper.deleteExpenseList(map);
    }

    public int deleteExpenseItemList(Map<String, Object> map) throws Exception {
        return edmsExpenseMapper.deleteExpenseItemList(map);
    }
}
