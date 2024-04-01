package com.springboot.myapp.eds.erp.controller.login;

import com.springboot.myapp.eds.erp.vo.base.baseUserListVO;
import com.springboot.myapp.eds.erp.vo.yeongEob.yeongEobEstListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class LOGINService {

	@Autowired
	private LOGINMapper loginMapper;

	public int selectLOGINCnt(Map<String, Object> map) throws Exception
	{
		return loginMapper.selectLOGINCnt(map);
	}

	public List<baseUserListVO> selectLOGINInfo(Map<String, Object> map) throws Exception
	{
		AES256Util aes256Util = new AES256Util();
		map.put("secretKey", aes256Util.getKey());
		return loginMapper.selectLOGINInfo(map);
	}

	public void insertLOGINLOG(Map<String, Object> map) throws Exception
	{
		loginMapper.insertLOGINLOG(map);
	}

	public int updatePASSWORD(Map<String, Object> map) throws Exception
	{
		return loginMapper.updatePASSWORD(map);
	}

	public int updatePASSWORDNext(Map<String, Object> map) throws Exception
	{
		return loginMapper.updatePASSWORDNext(map);
	}

	public int selectCommute(Map<String, Object> map) throws Exception
	{
//		map.put("stDt", (String) map.get("date") + "%");
		return loginMapper.selectCommute(map);
	}

	public List<baseUserListVO> checkPASSWORD(Map<String, Object> map) throws Exception {
		List<baseUserListVO> result = loginMapper.checkPASSWORD(map);
		return result;
	}
}
