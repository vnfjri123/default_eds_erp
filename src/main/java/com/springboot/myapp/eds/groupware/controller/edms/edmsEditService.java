package com.springboot.myapp.eds.groupware.controller.edms;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.springboot.myapp.eds.erp.vo.base.baseUserListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsEditFileListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsEditListVO;
import com.springboot.myapp.eds.groupware.vo.edms.edmsFileListVO;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

@Service
public class edmsEditService {
	@Value("${eds.front.file.path}")
    private String frontPath;
	
    @Value("${eds.backs.file.path}")
    private String realPath;
    
    @Autowired
    private edmsEditMapper edmsEditMapper;


    @Autowired
    private edmsSubmitService edmsSubmitService;

    
    public List<edmsEditListVO> selectEditList(Map<String, Object> map) throws Exception {
        map.put("stDt", Util.removeMinusChar((String) map.get("stDt")));
        map.put("edDt", Util.removeMinusChar((String) map.get("edDt")));
        map.put("cntDt", Util.removeMinusChar((String) map.get("cntDt")));
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        
        List<edmsEditListVO> result = edmsEditMapper.selectEditList(map);
        return result;
    }
    public List<edmsEditFileListVO> selectEditFileList(Map<String, Object> map) throws Exception {
        map.put("corpCd", SessionUtil.getUser().getCorpCd());
        List<edmsEditFileListVO> result = edmsEditMapper.selectEditFileList(map);
        return result;
    }


    @Transactional
    public int insertEditList(List<MultipartFile> file,Map<String, Object> map,List<MultipartFile> imgFiles) throws Exception {
        int result=0;
        AES256Util aes256Util = new AES256Util();
        //기안상신 내용
        Map<String, Object> submitData = (Map<String, Object>) map.get("parentData");
        submitData.put("corpCd", SessionUtil.getUser().getCorpCd());//회사내용추가
        submitData.put("submitNm", map.get("submitNm"));//문서명 추가
        result+=edmsSubmitService.insertSubmitList(submitData);
        String editData=map.get("editerArea").toString();
        //견적품의 form 내용
        map.put("userId", SessionUtil.getUser().getEmpCd());
        map.put("submitCd",submitData.get("submitCd"));
        map.put("secretKey", aes256Util.getKey());
        removeEditImgFile(map);
        List<String> strings=insertEditImageFileList(imgFiles, map);//후에 파일이 마지막으로 저장될 수 있도록 수정
        String editAreaData=changeEditImgData(strings,editData);
        map.put("editerArea",editAreaData);
        result+=edmsEditMapper.insertEditList(map);
        result+=edmsSubmitService.insertEdmsFileList(file, map);
        
        return result;
    }
    @Transactional
    public List<String> insertEditImageFileList(List<MultipartFile> files,Map<String, Object> map) throws Exception {
        StringBuilder response = new StringBuilder();
        List<String> result = new ArrayList<>();
        AES256Util aes256Util = new AES256Util();
        String corpCd = SessionUtil.getUser().getCorpCd();
        String empCd = SessionUtil.getUser().getEmpCd();
        try {
            String path =realPath;
            /* 파일 경로 확인 및 생성*/
            path+="file\\";     final File fileDir = new File(path);
            path+=corpCd+"\\";  final File corpDir = new File(path);
            path+="edit\\";    final File projectDir = new File(path);
            path+=empCd+"\\";   final File empCdDir = new File(path);
            if(!fileDir.exists()){ fileDir.mkdir();}
            if(!corpDir.exists()){ corpDir.mkdir();}
            if(!projectDir.exists()){ projectDir.mkdir();}
            if(!empCdDir.exists()){ empCdDir.mkdir();}
            for (MultipartFile file : files) {
			    if (file.isEmpty()) {
    		    	response.append("Failed to upload ")
        	                .append(file.getOriginalFilename());
        	    } 
			    else {                          
                    try 
			        {	
                        /* 랜덤 저장 명 파라미터 생성*/
                        SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
                        /* 첨부파일 생성 */

                        String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
                        String origNm = FilenameUtils.getBaseName(file.getOriginalFilename()); // 원본명
                        String ext = FilenameUtils.getExtension(file.getOriginalFilename()); // 확장자
			    		byte[] bytes = file.getBytes();
                        
                        Path filePath = Paths.get(realPath+path + saveNm+"."+ext);
                        Files.write(filePath, bytes);
                        Map<String, Object> test = new HashMap<String, Object>();
                        test.put("corpCd",map.get("corpCd"));
                        test.put("busiCd",map.get("busiCd"));
                        test.put("submitCd",map.get("submitCd"));
                        test.put("saveRoot",realPath+path + saveNm+"."+ext);
                        test.put("ext",ext);
                        test.put("size",file.getSize());
                        test.put("userId",empCd);
                        test.put("secretKey", aes256Util.getKey());
                        insertEditFileList(test);
                        String pathenc = corpCd+":"+empCd+":"+saveNm+"."+ext;
                        result.add(pathenc);
                        response.append("Successfully uploaded ")
                                .append(file.getOriginalFilename())
                                .append(". ");
			    	}
			    	catch (IOException e) {
                        response.append("Failed to upload ")
                                .append(file.getOriginalFilename())
                                .append(" due to an error: ")
                                .append(e.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
    
        return result;
    }
     @Transactional
    public String changeEditImgData(List<String> roots,String editerArea) throws Exception {
        String result="";
        Pattern imgSrcPattern = Pattern.compile("<img[^>]*src=[\\”‘]?([^>\\”‘]+)[\\”‘]?[^>]*>");
        Matcher matcher = imgSrcPattern.matcher(editerArea);
        String regex = "(<img\\s+[^>]*src\\s*=\\s*['\"])(data:image[^'\"]+)(['\"][^>]*>)";//new image
        String regex2 = "(<img\\s+[^>]*src\\s*=\\s*['\"])([^'\"]*EDMS_EDIT_REPORT[^'\"]*)(['\"][^>]*>)";//기존이미지
        //String regex = "(<img\\s+[^>]*src\\s*=\\s*['\"])([^'\"]+)(['\"][^>]*>)";
        int i=0;//data:image 만 새로 집어넣고 저장 EDMS_EDIT_REPORT데이터는 삭

        
        while (matcher.find()) {
            String imgSrc = matcher.group(1);
            String newUrl = "/EDMS_EDIT_REPORT/"+roots.get(i);
            //editerArea = editerArea.replaceFirst(regex2,"$1"+newUrl+"$3");
            editerArea = editerArea.replaceFirst(regex,"$1"+newUrl+"$3");
            i++;
            
        }
        i=0;
        Pattern imgSrcPattern2 = Pattern.compile("<img[^>]*src=[\\”‘]?([^>\\”‘]+)[\\”‘]?[^>]*>");
        Matcher matcher2 = imgSrcPattern2.matcher(editerArea);
        while (matcher2.find()) {//기존데이터 변경
            String imgSrc = matcher2.group(1);
            String newUrl = "\"/EDMS_EDIT_REPORT/"+roots.get(i)+"\"";
            editerArea = editerArea.replace(imgSrc, newUrl);
            i++;
            
        }
        result=editerArea;
        return result;
    }
    @Transactional
    public void removeEditImgFile(Map<String, Object> map) throws Exception {
        String result="";
        List<edmsEditFileListVO> fileData = edmsEditMapper.selectEditFileList(map);
        deleteEditFileList(map);
        for(int i=0;i<fileData.size();i++)
        {//빈값 null 변경
            edmsEditFileListVO row= (edmsEditFileListVO) fileData.get(i);
            String path = row.getSaveRoot().toString();
            //String paths = new File(realPath).getCanonicalPath()+path;
            File file = new File(path);
            if(file.exists())
            {
                file.delete();
            }
            //Files.delete(Paths.get(path));
        }
    }
    public ResponseEntity<byte[]> selectEditImage(@PathVariable("params") String params) throws Exception {
        String[] param = params.split(":"); // params
        Map map = new HashMap();
        String path = new File(realPath).getCanonicalPath()
        +File.separatorChar +"file"
        +File.separatorChar +param[0]
        +File.separatorChar +"edit"
        +File.separatorChar +param[1]
        +File.separatorChar +param[2];
        InputStream imageStream = null;
        byte[] imageByteArray = null;
        File file = new File(path);
        if(file.exists()){
            imageStream = new FileInputStream(path);
            imageByteArray = IOUtils.toByteArray(imageStream);
            imageStream.close();
        }else{

        }
        return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
    }


    public int insertEditFileList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsEditMapper.insertEditFileList(map);
    }

    public int updateEditList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsEditMapper.updateEditList(map);
    }

    public int updateEditItemList(Map<String, Object> map) throws Exception {
        map.put("userId", SessionUtil.getUser().getEmpCd());
        return edmsEditMapper.updateEditItemList(map);
    }

    public int deleteEditList(Map<String, Object> map) throws Exception {
        return edmsEditMapper.deleteEditList(map);
    }

    public int deleteEditFileList(Map<String, Object> map) throws Exception {
        return edmsEditMapper.deleteEditFileList(map);
    }
    
}
