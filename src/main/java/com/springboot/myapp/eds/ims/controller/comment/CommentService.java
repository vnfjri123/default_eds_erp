package com.springboot.myapp.eds.ims.controller.comment;

import com.springboot.myapp.eds.erp.controller.alarm.alarmService;
import com.springboot.myapp.eds.groupware.vo.edms.edmsApproveUserListVO;
import com.springboot.myapp.eds.messages.controller.send.sendController;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.springboot.myapp.eds.ims.vo.error.errorCommentVO;
import java.util.List;
import java.util.Map;

@Service
public class CommentService {

  @Autowired
  private CommentMapper commentMapper;

  @Autowired
  private sendController sendController;

  @Autowired
  private alarmService alarmService;

  public List<errorCommentVO> selectComment(Map<String, Object> map) throws Exception {

    map.put("authDivi", SessionUtil.getUser().getAuthDivi());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    AES256Util aes256Util = new AES256Util();
    map.put("secretKey", aes256Util.getKey());
    List<errorCommentVO> result = commentMapper.selectComment(map);
    return result;
  }

  @Transactional
  public int insertComment(Map<String, Object> map) throws Exception {
    map.put("corpCd", SessionUtil.getUser().getCorpCd());
    map.put("busiCd", SessionUtil.getUser().getBusiCd());
    map.put("userId", SessionUtil.getUser().getEmpCd());
    map.put("empNm", SessionUtil.getUser().getEmpNm());
    map.put("empCd", SessionUtil.getUser().getEmpCd());

    //nav 메시지입력
//    String submitNm=(String)map.get("submitNm");
//    String Massge=(String) map.get("content");
//    String navMessage =submitNm+" 문서에 '"+Massge+"' 코멘트가 등록 되었습니다.";
//    map.put("stateDivi", "01");
//    map.put("id", map.get("inpId").toString());
//    map.put("navMessage", navMessage);
//    map.put("target", map.get("inpId").toString());
//    if(!map.get("inpId").toString().equals(SessionUtil.getUser().getEmpCd().toString())){alarmService.insertAlarmList(map);}
//    alarmService.insertAlarmChat(map);
    sendController.noticeComment(map);
    return commentMapper.insertComment(map);
  }

  @Transactional
  public int updateComment(Map<String, Object> map) throws Exception {
    map.put("corpCd", SessionUtil.getUser().getCorpCd());
    map.put("busiCd", SessionUtil.getUser().getBusiCd());

    return commentMapper.updateComment(map);
  }

  public int deleteComment(Map<String, Object> map) throws Exception {
    System.out.println("서비스 확인");
    System.out.println(map);
    String inpId= (String) map.get("inpId");
    if(!inpId.equals(SessionUtil.getUser().getEmpCd())) throw  new Exception("본인이 작성한 코멘트가 아닙니다.");
    return commentMapper.deleteComment(map);
  }
}
