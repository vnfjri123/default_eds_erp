package com.springboot.myapp.eds.erp.controller.file;

import com.springboot.myapp.eds.erp.vo.file.fileDownloadHistoryListVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface fileMapper {

    public List<fileDownloadHistoryListVO> selectFileDownloadHistory(Map<String, Object> map) throws Exception;

    public void insertFileDownloadHistory(Map<String, Object> map) throws Exception;
}
