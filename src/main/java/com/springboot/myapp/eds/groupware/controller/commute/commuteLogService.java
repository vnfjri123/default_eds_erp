package com.springboot.myapp.eds.groupware.controller.commute;

import com.springboot.myapp.eds.groupware.vo.commute.commuteLogListVO;
import com.springboot.myapp.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class commuteLogService {

    @Autowired
    private com.springboot.myapp.eds.groupware.controller.commute.commuteLogMapper commuteLogMapper;

    public List<commuteLogListVO> selectCommuteLogList(Map<String, Object> map) throws Exception {
        map.put("date", (String) map.get("date") + "%");

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        List<commuteLogListVO> result = commuteLogMapper.selectCommuteLogList(map);
        return result;
    }

    public Map<String, Object> cudCommuteLogList(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();
        try {
            String status = (String) map.get("status");

            map.put("userId", SessionUtil.getUser().getEmpCd());

            switch (status) {
                case "C" -> {
                    commuteLogMapper.insertCommuteLogList(map);
                    returnData.put("note","성공적으로 출근 처리가 되었습니다.");
                    break;
                }
                case "U" -> {
                    commuteLogMapper.updateCommuteLogList(map);
                    returnData.put("note","성공적으로 수정되었습니다.");
                    break;
                }
                case "U2" -> {
                    map.put("date", (String) map.get("date") + "%");
                    commuteLogMapper.updateCommuteLogList2(map);
                    returnData.put("note","성공적으로 수정되었습니다.");
                    break;
                }
                case "D" -> {
                    commuteLogMapper.deleteCommuteLogList(map);
                    returnData.put("note","성공적으로 삭제되었습니다.");
                    break;
                }
            }
            
            returnData.put("status","success");

        }catch (Exception e){

            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();

        }

        return returnData;
    }
}
