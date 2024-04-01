package com.springboot.myapp.eds.erp.controller.rule;

import com.springboot.myapp.eds.erp.vo.archive.archiveThumVO;
import com.springboot.myapp.eds.erp.vo.rule.RuleFileVO;
import com.springboot.myapp.eds.erp.vo.rule.RuleVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface RuleMapper {
  List<RuleVO> selectRule(Map<String, Object> map) throws Exception;
  List<RuleFileVO> selectRuleFile(Map<String, Object> map) throws Exception;
  List<RuleVO> selectUserInfo(Map<String, Object> map) throws Exception;
  int insertRule(Map<String, Object> map) throws Exception;
  int insertRuleFile(Map<String, Object> map) throws Exception;
  int updateRule(Map<String, Object> map) throws Exception;
  int updateRuleFile(Map<String, Object> map) throws Exception;
  int updateRead(Map<String, Object> map) throws Exception;
  int readRule(Map<String, Object> map) throws Exception;
  int deleteRule(Map<String, Object> map) throws Exception;

}
