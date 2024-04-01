package com.springboot.myapp.eds.groupware.controller.commute;

import com.springboot.myapp.eds.groupware.vo.commute.commuteLogListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface commuteLogMapper {
    public List<commuteLogListVO> selectCommuteLogList(Map<String, Object> map) throws Exception;

    public void insertCommuteLogList(Map<String, Object> map) throws Exception;

    public void updateCommuteLogList(Map<String, Object> map) throws Exception;
    public void updateCommuteLogList2(Map<String, Object> map) throws Exception;

    public void deleteCommuteLogList(Map<String, Object> map) throws Exception;
}
