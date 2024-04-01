package com.springboot.myapp.eds.groupware.controller.car;

import com.springboot.myapp.eds.groupware.vo.car.carBookListVO;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class carBookService {

    @Autowired
    private carBookMapper carBookMapper;

    public List<carBookListVO> selectCarBookList(Map<String, Object> map) throws Exception {
        map.put("date", Util.removeMinusChar((String) map.get("date")) + "%");

        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        List<carBookListVO> result = carBookMapper.selectCarBookList(map);
        return result;
    }

    public Map<String, Object> cudCarBookList(Map<String, Object> map) throws Exception {

        Map<String, Object> returnData = new HashMap<>();

        try {
            String status = (String) map.get("status");

            map.put("userId", SessionUtil.getUser().getEmpCd());

            switch (status) {
                case "C" -> {
                    carBookMapper.insertCarBookList(map);
                    returnData.put("note","성공적으로 차량이 예약되었습니다.");
                    break;
                }
                case "U" -> {
                    carBookMapper.updateCarBookList(map);
                    returnData.put("note","성공적으로 차량이 수정되었습니다.");
                    break;
                }
                case "D" -> {
                    carBookMapper.deleteCarBookList(map);
                    returnData.put("note","성공적으로 차량이 삭제되었습니다.");
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
