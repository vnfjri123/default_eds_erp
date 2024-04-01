package com.springboot.myapp.eds.ims.controller.inspection;

import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.sound.midi.Soundbank;
import java.net.SocketTimeoutException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class InspectionController {

  @Autowired
  private InspectionService inspectionService;

  @RequestMapping("/INSPECTION_VIEW")
  public String inspectionView() {

    return "/eds/ims/inspection/inspectionView";
  }

  @RequestMapping("/inspection/selectInspectionList")
  @ResponseBody
  public Map selectInspectionList(@RequestBody HashMap<String, Object> map) throws Exception{
    Map mp = new HashMap();
    try {
      List li = inspectionService.selectInspectionList(map);
      mp.put("data", li);
    }catch(Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }
  @RequestMapping("/inspection/selectInspectionUserList")
  @ResponseBody
  public Map selectInspectionUserList(@RequestBody HashMap<String, Object> map) throws Exception{
    Map mp = new HashMap();
    try {
      List li = inspectionService.selectInspectionUserList(map);
      mp.put("data", li);
    }catch(Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }
  @RequestMapping("/inspection/selectThisMonthPercent")
  @ResponseBody
  public Map selectThisMonthPercent(@RequestBody HashMap<String, Object> map) throws Exception{
    Map mp = new HashMap();
    try {
      List li = inspectionService.selectThisMonthPercent(map);
      mp.put("data", li);
    }catch(Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/inspection/selectInfo")
  @ResponseBody
  public Map selectInfo(@RequestBody HashMap<String, Object> map) throws Exception{
    Map mp = new HashMap();
    try {
      List li = inspectionService.selectInfo(map);
      mp.put("data", li);
    }catch(Exception ex) {
      ex.printStackTrace();
    }
    return mp;
  }

  @RequestMapping("/inspection/cudInspectionList")
  @ResponseBody
  public Map cudInspectionList(@RequestBody Map param) throws Exception{

    Map mp = new HashMap();
    Map rtn = new HashMap();
    try {
      //ibsheet에서 넘어온 내용
      List saveData = (List)param.get("data");
      int updatedCnt = 0;
      for(int i=0;i<saveData.size();i++) {
        Map row = (Map)saveData.get(i);

        if (row.get("inspectDt") != null) {
          switch (row.get("status").toString()) {
            case "U":
              updatedCnt += inspectionService.updateInspectionList(row);
              break;
          }
        }
        switch (row.get("status").toString()){
            case "D":
              updatedCnt += inspectionService.deleteInspectionList(row);
              break;
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
      rtn.put("Result", -100); //음수값은 모두 실패
      rtn.put("Message", "오류입니다.");
    }
    mp.put("IO", rtn);

    return mp;
  }

  @PostMapping("/inspection/selectInspectionProgress")
  @ResponseBody
  public Map<String, Object> selectInspectionProgress(@RequestBody Map<String, Object> map) throws Exception{
    Map<String, Object> hashMap = new HashMap<String, Object>();
    try {
      hashMap.put("data", inspectionService.selectInspectionProgress(map));
    }catch(Exception ex) {
      ex.printStackTrace();
    }
    return hashMap;
  }

}
