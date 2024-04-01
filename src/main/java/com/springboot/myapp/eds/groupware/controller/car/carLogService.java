package com.springboot.myapp.eds.groupware.controller.car;

import com.springboot.myapp.eds.groupware.vo.car.carLogListVO;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class carLogService {

    @Autowired
    private carLogMapper carLogMapper;

    public List<carLogListVO> selectCarLogList(Map<String, Object> map) throws Exception {
        map.put("stDt", (String) map.get("stDt") + " 00:00:00");
        map.put("edDt", (String) map.get("edDt") + " 23:29:55");

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        List<carLogListVO> result = carLogMapper.selectCarLogList(map);
        return result;
    }

    public Map<String, Object> cudCarLogList(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            map.put("userId", SessionUtil.getUser().getEmpCd());
            map.put("busiCd", SessionUtil.getUser().getBusiCd());

            map.put("stDist", Util.removeCommaChar((String) map.get("stDist")));
            map.put("mdDist", Util.removeCommaChar((String) map.get("mdDist")));
            map.put("edDist", Util.removeCommaChar((String) map.get("edDist")));

            switch (status) {
                case "C" -> {
                    carLogMapper.insertCarLogList(map);
                    returnData.put("note","성공적으로 내역이 예약되었습니다.");
                    break;
                }
                case "U" -> {
                    carLogMapper.updateCarLogList(map);
                    returnData.put("note","성공적으로 내역이 수정되었습니다.");
                    break;
                }
                case "D" -> {
                    carLogMapper.deleteCarLogList(map);
                    returnData.put("note","성공적으로 내역이 삭제되었습니다.");
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
