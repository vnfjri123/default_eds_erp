package com.springboot.myapp.eds.main.controller.home;

import com.springboot.myapp.eds.main.vo.home.homeListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface homeMapper {
    public List<homeListVO> selectHomeList(Map<String, Object> map) throws Exception;

    public void insertHomeList(Map<String, Object> map) throws Exception;

    public void updateHomeList(Map<String, Object> map) throws Exception;

    public void deleteHomeList(Map<String, Object> map) throws Exception;
}
