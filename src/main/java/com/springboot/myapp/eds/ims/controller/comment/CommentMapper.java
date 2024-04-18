package com.springboot.myapp.eds.ims.controller.comment;

import com.springboot.myapp.eds.ims.vo.error.errorCommentVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface CommentMapper {
  List<errorCommentVO> selectComment(Map<String, Object> map) throws Exception;
  int insertComment(Map<String, Object> map) throws Exception;
  int updateComment(Map<String, Object> map) throws Exception;
  int deleteComment(Map<String, Object> map) throws Exception;
}
