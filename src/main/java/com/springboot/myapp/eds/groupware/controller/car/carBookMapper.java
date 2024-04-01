package com.springboot.myapp.eds.groupware.controller.car;

import com.springboot.myapp.eds.groupware.vo.car.carBookListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface carBookMapper {
    public List<carBookListVO> selectCarBookList(Map<String, Object> map) throws Exception;

    public void insertCarBookList(Map<String, Object> map) throws Exception;

    public void updateCarBookList(Map<String, Object> map) throws Exception;

    public void deleteCarBookList(Map<String, Object> map) throws Exception;
}
