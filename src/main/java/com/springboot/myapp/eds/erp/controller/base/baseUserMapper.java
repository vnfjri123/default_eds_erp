package com.springboot.myapp.eds.erp.controller.base;

import com.springboot.myapp.eds.erp.vo.base.baseUserListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface baseUserMapper {
    
    public List<baseUserListVO> selectUserMgtList(Map<String, Object> map) throws Exception;
    public List<baseUserListVO> selectUserEmailList(Map<String, Object> map) throws Exception;
    public List<baseUserListVO> checkUserFaceImage(Map<String, Object> map) throws Exception;

    public int insertUserMgtList(Map<String, Object> map) throws Exception;

    public int updateUserMgtList(Map<String, Object> map) throws Exception;

    public int deleteUserMgtList(Map<String, Object> map) throws Exception;

    public String selectEmpCdCheck(Map<String, Object> map) throws Exception;

    public String selectEmpIdCheck(Map<String, Object> map) throws Exception;

    public List<baseUserListVO> userCheckByGroup(Map<String, Object> map) throws Exception;

    public String duplicateUserCheck(Map<String, Object> map) throws Exception;

    public int uploadUserFaceImage(Map<String, Object> map) throws Exception;
    public int deleteUserFaceImage(Map<String, Object> map) throws Exception;
}