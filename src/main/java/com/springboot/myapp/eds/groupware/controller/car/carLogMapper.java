package com.springboot.myapp.eds.groupware.controller.car;

import com.springboot.myapp.eds.groupware.vo.car.carLogListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface carLogMapper {
    public List<carLogListVO> selectCarLogList(Map<String, Object> map) throws Exception;

    public void insertCarLogList(Map<String, Object> map) throws Exception;

    public void updateCarLogList(Map<String, Object> map) throws Exception;

    public void deleteCarLogList(Map<String, Object> map) throws Exception;
}
