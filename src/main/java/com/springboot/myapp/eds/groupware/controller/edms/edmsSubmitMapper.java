package com.springboot.myapp.eds.groupware.controller.edms;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.springboot.myapp.eds.groupware.vo.edms.edmsFileListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsHomeListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsSubmitListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsApproveUserListVO;

@Repository
public interface edmsSubmitMapper {
    public List<edmsHomeListVO> selectHomeList(Map<String, Object> map) throws Exception;
    public List<edmsSubmitListVO> selectSubmitList(Map<String, Object> map) throws Exception;
    public List<edmsSubmitListVO> selectSubmitTempList(Map<String, Object> map) throws Exception;
    public List<edmsSubmitListVO> selectSubmitReqList(Map<String, Object> map) throws Exception;
    public List<edmsSubmitListVO> selectSubmitComList(Map<String, Object> map) throws Exception;
    public List<edmsApproveUserListVO> selectEdmsMessageList(Map<String, Object> map) throws Exception;
    
    public List<edmsFileListVO> selectEdmsFileList(Map<String, Object> map) throws Exception;
    public List<edmsApproveUserListVO> selectApproveUserList(Map<String, Object> map) throws Exception;
    public List<edmsApproveUserListVO> selectCcUserList(Map<String, Object> map) throws Exception;

    public int insertSubmitList(Map<String, Object> map) throws Exception;
    public int insertEdmsFileList(Map<String, Object> map) throws Exception;
    public int insertApproveList(Map<String, Object> map) throws Exception;
    public int insertApproveUserList(Map<String, Object> map) throws Exception;
    public int insertCcConfirmList(Map<String, Object> map) throws Exception;
    public int insertApproveConfirmList(Map<String, Object> map) throws Exception;
    public int insertDeclineList(Map<String, Object> map) throws Exception;
    public int insertCancelList(Map<String, Object> map) throws Exception;
    public int insertMessageList(Map<String, Object> map) throws Exception;

    public int deleteSubmitList(Map<String, Object> map) throws Exception;
    public int deleteSubmitUserList(Map<String, Object> map) throws Exception;
    public int deleteEdmsFileList(Map<String, Object> map) throws Exception;
    public int deleteMessageList(Map<String, Object> map) throws Exception;
    


}
