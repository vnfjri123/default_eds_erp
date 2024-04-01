package com.springboot.myapp.eds.groupware.controller.edms;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

import com.springboot.myapp.eds.erp.controller.alarm.alarmService;
import com.springboot.myapp.eds.erp.controller.project.projectProjMapper;
import com.springboot.myapp.eds.erp.controller.yeongEob.yeongEobEstMapper;  
import com.springboot.myapp.eds.groupware.vo.edms.edmsApproveUserListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsEditFileListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsEstListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsExpenseListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsFileListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsHomeListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsSubmitListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class edmsSubmitService {

    @Autowired
    private edmsSubmitMapper edmsSubmitMapper;

    @Autowired
    private edmsEditMapper edmsEditMapper;

    @Autowired
    private edmsEstMapper edmsEstMapper;
    
    @Autowired
    private edmsExpenseMapper edmsExpenseMapper;

    @Autowired
    private yeongEobEstMapper yeongEobEstMapper;
    
    @Autowired
    private projectProjMapper projectProjMapper;

    @Autowired
    private alarmService alarmService;
    
	@Value("${eds.front.file.path}")
    private String frontPath;
	
    @Value("${eds.backs.file.path}")
    private String realPath;
    

    public List<edmsHomeListVO> selectHomeList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());        
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        List<edmsHomeListVO> result = edmsSubmitMapper.selectHomeList(map);
        return result;
    }

    public List<edmsSubmitListVO> selectSubmitList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        if(("01").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());map.put("submitDivi", "01");}///결재진행내역
        else if(("02").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());map.put("submitDivi", "02");}//임시보관내역
        else if(("03").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());map.put("submitDivi", "03");}//승인
        else if(("04").equals(map.get("edmsDivi"))){map.put("approverDivi", "01");map.put("submitDivi", "01");}//결재요청내역
        else if(("05").equals(map.get("edmsDivi"))){map.put("approverDivi", "02");map.put("submitDivi", null);}//결재참조
        else if(("06").equals(map.get("edmsDivi"))){map.put("approverDivi", "01");map.put("submitDivi", "03");}//결재내역
        else if(("07").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());map.put("submitDivi", "04");}//반려
        else if(("08").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());map.put("submitDivi", "03");}//전체
        
        
        map.put("secretKey", aes256Util.getKey());       
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<edmsSubmitListVO> result = edmsSubmitMapper.selectSubmitList(map);
        return result;
    }
    public List<edmsSubmitListVO> selectSubmitTempList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());       
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<edmsSubmitListVO> result = edmsSubmitMapper.selectSubmitTempList(map);
        return result;
    }
    public List<edmsSubmitListVO> selectSubmitReqList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        if(("01").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());map.put("submitDivi", "01");}///결재진행내역
        else if(("02").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());}//임시보관내역
        else if(("03").equals(map.get("edmsDivi"))){map.put("submitUser", SessionUtil.getUser().getEmpCd());map.put("submitDivi", "03");}//결재완료
        else if(("04").equals(map.get("edmsDivi"))){map.put("approverDivi", "01");map.put("submitDivi", "01");}//결재수신함
        else if(("05").equals(map.get("edmsDivi"))){map.put("approverDivi", "02");map.put("submitDivi", null);}//결재참조
        else if(("06").equals(map.get("edmsDivi"))){map.put("approverDivi", "01");map.put("submitDivi", "03");}
        else if(("07").equals(map.get("edmsDivi"))){map.put("approverDivi", "01");map.put("submitDivi", "04");}//반려
        else if(("08").equals(map.get("edmsDivi"))){map.put("approverDivi", "01");map.put("submitDivi", "03");}//전체
        else if(("09").equals(map.get("edmsDivi"))){map.put("depaCd",SessionUtil.getUser().getDepaCd() );map.put("submitDivi", "03");}//전체
        map.put("secretKey", aes256Util.getKey());       
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<edmsSubmitListVO> result = edmsSubmitMapper.selectSubmitReqList(map);
        return result;
    }
    public List<edmsSubmitListVO> selectSubmitComList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());       
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        List<edmsSubmitListVO> result = edmsSubmitMapper.selectSubmitComList(map);
        return result;
    }


    public List<edmsFileListVO> selectEdmsFileList(Map<String, Object> map) throws Exception {
        
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<edmsFileListVO> result = edmsSubmitMapper.selectEdmsFileList(map);
        return result;
    }

    public List<edmsApproveUserListVO> selectEdmsMessageList(Map<String, Object> map) throws Exception {
        
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        List<edmsApproveUserListVO> result = edmsSubmitMapper.selectEdmsMessageList(map);
        return result;
    }


    public int insertSubmitList(Map<String, Object> map) throws Exception {
        map.put("submitDt", Util.removeMinusChar((String) map.get("submitDt")));
        map.put("userId", SessionUtil.getUser().getEmpCd());
        List saveData = (List)map.get("submitApprover");
        if(saveData.size()>0){map.put("currApproverCd", saveData.get(0));}//승인목록이 있을시 첫번째 승인자 저장
        int result= edmsSubmitMapper.insertSubmitList(map);
        edmsSubmitMapper.deleteSubmitUserList(map);//기존 유저삭제
        for(int i=0;i<saveData.size();i++) {
            Map row = new HashMap();  
            row.put("corpCd", map.get("corpCd"));
            row.put("busiCd", map.get("busiCd"));
            row.put("submitCd", map.get("submitCd"));
            row.put("seq",i);
            row.put("endDivi","00");
            row.put("approverDivi","01");
            row.put("approverCd",saveData.get(i));
            row.put("userId", SessionUtil.getUser().getEmpCd());
            edmsSubmitMapper.insertApproveUserList(row);
            if(("01").equals(map.get("submitDivi")) && (i==0))
            {
                //nav 메시지입력
                String submitNm=(String)map.get("submitNm");
                String navMessage =submitNm+ " 문서를 결재요청하였습니다.";
                map.put("stateDivi", "03");
                map.put("id", saveData.get(i));
                map.put("navMessage", navMessage);
                map.put("target", saveData.get(i));
                map.put("userId", SessionUtil.getUser().getEmpCd());
                map.put("empCd", SessionUtil.getUser().getEmpCd());
                map.put("empNm", SessionUtil.getUser().getEmpNm());
                alarmService.insertAlarmList(map);
            }
        }
        List ccData = (List)map.get("submitCcUser");
        for(int i=0;i<ccData.size();i++) {
            Map row = new HashMap();  
            row.put("corpCd", map.get("corpCd"));
            row.put("busiCd", map.get("busiCd"));
            row.put("submitCd", map.get("submitCd"));
            row.put("seq",i);
            row.put("endDivi","00");
            row.put("approverDivi","02");
            row.put("approverCd",ccData.get(i));
            row.put("userId", SessionUtil.getUser().getEmpCd());
            edmsSubmitMapper.insertApproveUserList(row);
        }
        return result;
    }

    public int insertCcConfirmList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsSubmitMapper.insertCcConfirmList(map);
    }
    public int insertApproveConfirmList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsSubmitMapper.insertApproveConfirmList(map);
    }
    public int insertDeclineList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        String approver=map.get("currApproverCd").toString();
        if(!approver.equals(SessionUtil.getUser().getEmpCd())) throw  new Exception("<"+(String)map.get("submitNm")+"> 문서는 " + "반려를 할 수 없는 단계 입니다.");
        //반려메세지 전송
        //nav 메시지입력
        String submitNm=(String)map.get("submitNm");
        String navMessage =submitNm+ " 문서가 반려되었습니다.";
        map.put("stateDivi", "06");
        map.put("id", map.get("inpId"));
        map.put("navMessage", navMessage);
        map.put("target", map.get("inpId"));
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("empNm", SessionUtil.getUser().getEmpNm());
        alarmService.insertAlarmList(map);
        return edmsSubmitMapper.insertDeclineList(map);
    }
    public int insertCancelList(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsSubmitMapper.insertCancelList(map);
    }
    @Transactional
     public int insertMessageList(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        map.put("busiCd", SessionUtil.getUser().getBusiCd());
        map.put("approverCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("empNm", SessionUtil.getUser().getEmpNm());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        //nav 메시지입력
        String submitNm=(String)map.get("submitNm");
        String Massge=(String) map.get("message");
        String navMessage =submitNm+" 문서에 '"+Massge+"' 결재의견을 남겼습니다.";
        map.put("stateDivi", "01");
        map.put("id", map.get("inpId").toString());
        map.put("navMessage", navMessage);
        map.put("target", map.get("inpId").toString());
        if(!map.get("inpId").toString().equals(SessionUtil.getUser().getEmpCd().toString())){alarmService.insertAlarmList(map);}
        alarmService.insertAlarmChat(map);
        return edmsSubmitMapper.insertMessageList(map);
    }
    
   
    @Transactional
    public int insertApproveList(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("submitDt", Util.removeMinusChar((String) map.get("submitDt")));
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("corpCd",SessionUtil.getUser().getCorpCd());
        map.put("estDt",Util.removeMinusChar((String) map.get("submitDt")));
        map.put("manCd", map.get("empCd"));
        String approver=map.get("currApproverCd").toString();

        if(!approver.equals(SessionUtil.getUser().getEmpCd())) throw  new Exception("<"+(String)map.get("submitNm")+"> 문서는 " + "승인할 수 없는 단계 입니다.");
        List sa = edmsSubmitMapper.selectApproveUserList(map);
        for(int i=0;i<sa.size();i++) {
            edmsApproveUserListVO data=(edmsApproveUserListVO)sa.get(i);
            if(data.getApproverCd().equals(approver))
            {
                if(i+1==sa.size())
                {
                    map.put("submitDivi","03"); 
                    if(("01").equals(map.get("docDivi").toString())) //견저서등록
                    {
                        List dataList = edmsEstMapper.selectEstList(map);
                        edmsEstListVO estData=(edmsEstListVO)dataList.get(0);
                        Map<String, Object> convertMap = convertToMap(estData);

                        List saveData = edmsEstMapper.selectEstItemList(map);
                        convertMap.put("userId", convertMap.get("inpId"));//입력자추가
                        yeongEobEstMapper.insertEstMgtList(convertMap);

                        for(int z=0;z<saveData.size();z++) {
                            Map<String, Object>  row = convertToMap(saveData.get(z));
                            row.put("estCd", convertMap.get("estCd"));
                            row.put("userId", convertMap.get("inpId"));
                            yeongEobEstMapper.insertEstItemList(row);
                        }
                    }
                    else if(("02").equals(map.get("docDivi").toString()))//프로젝트등록
                    {
                        List dataList = edmsEstMapper.selectEstList(map);
                        edmsEstListVO estData=(edmsEstListVO)dataList.get(0);
                        Map<String, Object> convertMap = convertToMap(estData);
                        List saveData = edmsEstMapper.selectEstItemList(map);
                        convertMap.put("estCd", convertMap.get("keyCd"));
                        convertMap.put("userId", convertMap.get("inpId"));//입력자추가
                        convertMap.put("dueDt", convertMap.get("stDt"));//납기일자변환
                        
                        projectProjMapper.insertProjMgtList(convertMap);
                        for(int z=0;z<saveData.size();z++) {
                            Map<String, Object>  row = convertToMap(saveData.get(z));
                            row.put("estCd", convertMap.get("keyCd"));
                            row.put("projCd", convertMap.get("projCd"));
                            row.put("userId", convertMap.get("inpId"));
                            projectProjMapper.insertProjItemList(row);
                            
                        }
                        List fileData =selectEdmsFileList(map);//파일 검색
                        System.out.println(fileData);
                        for(int z=0;z<fileData.size();z++) {
                            Map<String, Object>  row = convertToMap(fileData.get(z));
                            row.put("estCd", convertMap.get("keyCd"));
                            row.put("projCd", convertMap.get("projCd"));
                            row.put("userId", convertMap.get("inpId"));
                            row.put("secretKey", aes256Util.getKey());
                            projectProjMapper.insertProjFileList(row);
                        }
                    }
                    else if(("03").equals(map.get("docDivi").toString()))//지출품의등록
                    {
                        List dataList = edmsExpenseMapper.selectExpenseList(map);
                        edmsExpenseListVO expenseData=(edmsExpenseListVO)dataList.get(0);
                        Map<String, Object> convertMap = convertToMap(expenseData);
                        List saveData = edmsExpenseMapper.selectExpenseItemList(map);
                        convertMap.put("estCd", convertMap.get("keyCd"));
                        convertMap.put("userId", convertMap.get("inpId"));//입력자추가
                        
                        for(int z=0;z<saveData.size();z++) {
                            Map<String, Object>  row = convertToMap(saveData.get(z));
                            row.put("estCd", convertMap.get("keyCd"));
                            row.put("userId", convertMap.get("inpId"));
                            projectProjMapper.insertProjCostList(row);
                        }
                        
                        // List fileData = edmsSubmitMapper.selectEdmsFileList(map);//파일 검샘
                        // for(int z=0;z<fileData.size();z++) {
                        //     Map<String, Object>  row = convertToMap(fileData.get(z));
                        //     row.put("estCd", convertMap.get("keyCd"));
                        //     row.put("projCd", convertMap.get("projCd"));
                        //     row.put("userId", convertMap.get("inpId"));
                        //     projectProjMapper.insertProjFileList(row);
                        // }
                    }
                    else if(("05").equals(map.get("docDivi").toString()))//프로젝트준공
                    {
                        List dataList = edmsEstMapper.selectEstList(map);
                        edmsEstListVO estData=(edmsEstListVO)dataList.get(0);
                        Map<String, Object> convertMap = convertToMap(estData);
                        List saveData = edmsEstMapper.selectEstItemList(map);
                        convertMap.put("projCd", convertMap.get("keyCd"));
                        convertMap.put("userId", convertMap.get("inpId"));//입력자추가
                        convertMap.put("sccDivi","01");
                        convertMap.put("dueDt", convertMap.get("stDt"));//납기일자변환
                        //convertMap.put("dueDt", convertMap.get("stDt"));//납기일자변환
                        
                        projectProjMapper.updateProjMgtList(convertMap);
                        projectProjMapper.deleteProjItemList(convertMap);
                        for(int z=0;z<saveData.size();z++) {
                            Map<String, Object>  row = convertToMap(saveData.get(z));
                            
                            row.put("projCd", convertMap.get("keyCd"));
                            row.put("userId", convertMap.get("inpId"));
                            projectProjMapper.insertProjItemList(row);
                        }
                        List fileData =selectEdmsFileList(map);//파일 검색
                        for(int z=0;z<fileData.size();z++) {
                            Map<String, Object>  row = convertToMap(fileData.get(z));
                           
                            row.put("projCd", convertMap.get("keyCd"));
                            row.put("userId", convertMap.get("inpId"));
                            row.put("secretKey", aes256Util.getKey());
                            projectProjMapper.insertProjFileList(row);
                        }
                    }
                    else if(("11").equals(map.get("docDivi").toString()))//프로젝트변경
                    {
                        List dataList = edmsEstMapper.selectEstList(map);
                        edmsEstListVO estData=(edmsEstListVO)dataList.get(0);
                        Map<String, Object> convertMap = convertToMap(estData);
                        List saveData = edmsEstMapper.selectEstItemList(map);
                        convertMap.put("projCd", convertMap.get("keyCd"));
                        convertMap.put("userId", convertMap.get("inpId"));//입력자추가
                        convertMap.put("dueDt", convertMap.get("stDt"));//납기일자변환
                        
                        projectProjMapper.updateProjMgtList(convertMap);
                        projectProjMapper.deleteProjItemList(convertMap);
                        for(int z=0;z<saveData.size();z++) {
                            Map<String, Object>  row = convertToMap(saveData.get(z));
                            
                            row.put("projCd", convertMap.get("keyCd"));
                            row.put("userId", convertMap.get("inpId"));
                            projectProjMapper.insertProjItemList(row);
                        }
                        List fileData =selectEdmsFileList(map);//파일 검색
                        for(int z=0;z<fileData.size();z++) {
                            Map<String, Object>  row = convertToMap(fileData.get(z));
                            row.put("projCd", convertMap.get("keyCd"));
                            row.put("userId", convertMap.get("inpId"));
                            row.put("secretKey", aes256Util.getKey());
                            projectProjMapper.insertProjFileList(row);
                        }
                    }
                    //완료시 수신참조
                    List cc = edmsSubmitMapper.selectCcUserList(map);
                    for(int z=0;z<cc.size();z++)
                    {
                        edmsApproveUserListVO ccData=(edmsApproveUserListVO)cc.get(z);
                        //nav 메시지입력
                        String submitNm=(String)map.get("submitNm");
                        String navMessage =submitNm+ "문서에 수신참조되었습니다.";
                        map.put("stateDivi", "04");
                        map.put("id", ccData.getApproverCd());
                        map.put("navMessage", navMessage);
                        map.put("target", ccData.getApproverCd());
                        map.put("userId", ccData.getInpId());
                        map.put("empCd", ccData.getInpId());
                        map.put("empNm", ccData.getEmpNm());
                        alarmService.insertAlarmList(map);
                    }
                    //완료시 결재요청자에게 알람방송
                    //nav 메시지입력
                    String submitNm=(String)map.get("submitNm");
                    String navMessage =submitNm+ " 문서가 결재완료되었습니다.";
                    map.put("stateDivi", "03");
                    map.put("id", map.get("inpId"));
                    map.put("navMessage", navMessage);
                    map.put("target", map.get("inpId"));
                    map.put("userId", SessionUtil.getUser().getEmpCd());
                    map.put("empCd", SessionUtil.getUser().getEmpCd());
                    map.put("empNm", SessionUtil.getUser().getEmpNm());
                    alarmService.insertAlarmList(map);
                    break;//승인 끝
                }
                else
                {
                   map.put("submitDivi","01");
                }
                edmsApproveUserListVO datas=(edmsApproveUserListVO)sa.get(i+1);
                map.put("currApproverCd",datas.getApproverCd());//마지막 승인이 아닐시 유저시퀀스 한단계 추가
                //다음 결재자에게 메세지 발송
                String submitNm=(String)map.get("submitNm");
                String navMessage =submitNm+" 문서를 결재요청하였습니다.";
                map.put("stateDivi", "03");
                map.put("id", datas.getApproverCd());
                map.put("navMessage", navMessage);
                map.put("target", datas.getApproverCd());
                map.put("userId", data.getInpId());
                map.put("empCd", data.getInpId());
                map.put("empNm", data.getEmpNm());
                alarmService.insertAlarmList(map);
                break;  
            }
        }
        return edmsSubmitMapper.insertApproveList(map);
    }
   
    @Transactional
    public int deleteSubmitList(Map<String, Object> map) throws Exception {
        int result=0;
        AES256Util aes256Util = new AES256Util();
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("secretKey", aes256Util.getKey());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<edmsFileListVO> fileData = edmsSubmitMapper.selectEdmsFileList(map);   
        try {
            result+=edmsSubmitMapper.deleteEdmsFileList(map);
            for( Object key :fileData){//빈값 null 변경
                edmsFileListVO row= (edmsFileListVO) key;
                String path = row.getSaveRoot().toString();
                System.out.println(path);
                Files.delete(Paths.get(path));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<edmsEditFileListVO> editFileData = edmsEditMapper.selectEditFileList(map);   
        try {
            for( Object key :editFileData){//빈값 null 변경
                edmsEditFileListVO row= (edmsEditFileListVO) key;
                String path = row.getSaveRoot().toString();
                System.out.println(path);
                Files.delete(Paths.get(path));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    
        result+=edmsSubmitMapper.deleteSubmitList(map);
        return result;
    }
    @Transactional
    public int insertEdmsFileList(List<MultipartFile> files,Map<String, Object> map) throws Exception {
        StringBuilder response = new StringBuilder();
        int result=0;
        AES256Util aes256Util = new AES256Util();
        String corpCd = SessionUtil.getUser().getCorpCd();
        String empCd = SessionUtil.getUser().getEmpCd();
        try {
            String path = realPath;
            /* 파일 경로 확인 및 생성*/
            path+="file\\";     final File fileDir = new File(path);
            path+=corpCd+"\\";  final File corpDir = new File(path);
            path+="edms\\";    final File projectDir = new File(path);
            path+=empCd+"\\";   final File empCdDir = new File(path);
            if(!fileDir.exists()){ fileDir.mkdir();}
            if(!corpDir.exists()){ corpDir.mkdir();}
            if(!projectDir.exists()){ projectDir.mkdir();}
            if(!empCdDir.exists()){ empCdDir.mkdir();}
            for (MultipartFile file : files) {
			    System.out.println(file.getOriginalFilename());
			    if (file.isEmpty()) {
    		    	response.append("Failed to upload ")
        	                .append(file.getOriginalFilename());
        	    } 
			    else {                          
                    try 
			        {	
                        /* 랜덤 저장 명 파라미터 생성*/
                        SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
                        /* 첨부파일 생성 */

                        String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
                        String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
                        String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
			    		byte[] bytes = file.getBytes();
                        
                        Path filePath = Paths.get(path + saveNm+"."+ext);
			    		System.out.println(filePath);
                        Files.write(filePath, bytes);
                        /* 첨부파일 db 저장을 위한 파라미터 세팅*/
                        Map<String, Object> test = new HashMap<String, Object>();
                        test.put("corpCd",map.get("corpCd"));
                        test.put("busiCd",map.get("busiCd"));
                        System.out.println("::::submitCd:::::");
                        System.out.println(map.get("submitCd"));
                        test.put("submitCd",map.get("submitCd"));
                        test.put("saveNm",saveNm);
                        test.put("origNm",origNm);
                        test.put("saveRoot",path+saveNm+"."+ext);
                        test.put("ext",ext);
                        test.put("size",file.getSize());
                        test.put("userId",empCd);
                        test.put("secretKey", aes256Util.getKey());
                        result+=edmsSubmitMapper.insertEdmsFileList(test);
                        response.append("Successfully uploaded ")
                                .append(file.getOriginalFilename())
                                .append(". ");
			    	}
			    	catch (IOException e) {
                        response.append("Failed to upload ")
                                .append(file.getOriginalFilename())
                                .append(" due to an error: ")
                                .append(e.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
    
        return result;
    }
    
    
    @Transactional
    public int deleteEdmsFileList(ArrayList<Object> map) throws Exception {
        int result=0;
        try {
            for( Object key :map){//빈값 null 변경
                Map<String, Object> row= (Map<String, Object>) key;
                result+=edmsSubmitMapper.deleteEdmsFileList(row);
                String path = row.get("saveRoot").toString();
                Files.delete(Paths.get(path));
            }
        } catch (Exception e) {
            
        }
        return result;
    }
    public int deleteMessageList(Map<String, Object> map) throws Exception {
        String approver=map.get("approverCd").toString();
        if(!approver.equals(SessionUtil.getUser().getEmpCd())) throw  new Exception("<본인이 작성한 메시지가 아닙니다.>");
        return edmsSubmitMapper.deleteMessageList(map);
    }
        // VO -> Map
    public static Map<String, Object> convertToMap(Object obj) {
        try {
            if (Objects.isNull(obj)) {
                return Collections.emptyMap();
            }
            Map<String, Object> convertMap = new HashMap<>();
 
            Field[] fields = obj.getClass().getDeclaredFields();
 
            for (Field field : fields) {
                field.setAccessible(true);
                convertMap.put(field.getName(), field.get(obj));
            }
            return convertMap;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
