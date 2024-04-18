package com.springboot.myapp.eds.ims.controller.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CommentController {

  @Autowired
  private CommentService commentService;

  @RequestMapping("/comment/cudComment")
  @ResponseBody
  public Map cudComment(@RequestBody Map param) throws Exception{
    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      List saveData = (List)param.get("data");
      int updatedCnt = 0;
      for(int i=0;i<saveData.size();i++) {
        Map row = (Map)saveData.get(i);
        switch (row.get("status").toString()){
          case "C": updatedCnt += commentService.insertComment(row); break;
          case "U": updatedCnt += commentService.updateComment(row); break;
          case "D": updatedCnt += commentService.deleteComment(row); break;
        }
      }
      if(updatedCnt>0) { //정상 저장
        rtn.put("Result",0);
        rtn.put("Message","저장 되었습니다.");
      }else { //저장 실패
        rtn.put("Result", -100); //음수값은 모두 실패
        rtn.put("Message", "저장에 실패하였습니다.");
      }
    }catch(Exception ex) {
      ex.printStackTrace();
      rtn.put("Result", -100); //음수값은 모두 실패
      rtn.put("Message",ex.getMessage());
    }
    mp.put("IO", rtn);
    return mp;
  }

  @RequestMapping("/comment/selectComment")
  @ResponseBody
  public Map selectComment(@RequestBody HashMap<String, Object> map) throws Exception{
    Map mp = new HashMap();

    try {
      List li = commentService.selectComment(map);
      mp.put("data", li);
    }catch(Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

}
