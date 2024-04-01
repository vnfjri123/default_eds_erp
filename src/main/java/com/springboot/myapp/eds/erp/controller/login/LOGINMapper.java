package com.springboot.myapp.eds.erp.controller.login;

import com.springboot.myapp.eds.erp.vo.base.baseUserListVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobEstListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface LOGINMapper {

	public int selectLOGINCnt(Map<String, Object> map) throws Exception;

	public List<baseUserListVO> selectLOGINInfo(Map<String, Object> map) throws Exception;

	public void insertLOGINLOG(Map<String, Object> map) throws Exception;

	public int updatePASSWORD(Map<String, Object> map) throws Exception;

	public int updatePASSWORDNext(Map<String, Object> map) throws Exception;
	public int selectCommute(Map<String, Object> map) throws Exception;

	public List<baseUserListVO> checkPASSWORD(Map<String, Object> map) throws Exception;
}
