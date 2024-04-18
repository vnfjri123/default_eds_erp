package com.springboot.myapp.eds.erp.controller.email;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.myapp.eds.erp.vo.email.emailFileVO;
import com.springboot.myapp.eds.erp.vo.email.emailListVO;
import com.springboot.myapp.eds.erp.controller.alarm.alarmService;
import com.springboot.myapp.util.AES256Util;
import com.springboot.myapp.util.SessionUtil;
import com.springboot.myapp.util.Util;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import net.sf.jasperreports.engine.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.*;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLOutput;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.DoubleStream;

@Service
public class emailService {

    @Value("${eds.front.file.path}")
    private String filePath;

    @Value("${eds.backs.file.path}")
    private String realPath;

    @Autowired
    private alarmService alarmService;

    @Autowired
    private emailMapper emailMapper;

    public List<emailListVO> selectSendEmailInfo(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());

        List<emailListVO> result = emailMapper.selectSendEmailInfo(map);

        return result;
    }

    public List<emailListVO> selectSendEmailInfo2(Map<String, Object> map) throws Exception {
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());

        List<emailListVO> result = emailMapper.selectSendEmailInfo2(map);

        return result;
    }

    public List<emailFileVO> selectSendEmailFileInfo(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());

        List<emailFileVO> result = emailMapper.selectSendEmailFileInfo(map);

        return result;
    }

    public List<emailFileVO> selectSendEmailJasperInfo(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());

        List<emailFileVO> result = emailMapper.selectSendEmailJasperInfo(map);

        return result;
    }

    public List<emailFileVO> selectSendEmailFileInfoAll(Map<String, Object> map) throws Exception {
        AES256Util aes256Util = new AES256Util();
        map.put("secretKey", aes256Util.getKey());
        map.put("authDivi", SessionUtil.getUser().getAuthDivi());
        map.put("depaCd", SessionUtil.getUser().getDepaCd());
        map.put("empCd", SessionUtil.getUser().getEmpCd());

        List<emailFileVO> result = emailMapper.selectSendEmailFileInfoAll(map);

        return result;
    }

    public String beforeUploadImageFile(MultipartHttpServletRequest mtfRequest) throws Exception {

        
        // 파일 세팅
        List<MultipartFile> fileList = mtfRequest.getFiles("file");
        MultipartFile mf= fileList.get(0);

        // 파라미터 세팅
        JSONObject jsonObject = new JSONObject();

        String corpCd = SessionUtil.getUser().getCorpCd();
        String empCd = SessionUtil.getUser().getEmpCd();
        String[] fileName = fileList.get(0).getOriginalFilename().split(".");

        int fileNameLength = fileName.length;

        String origNm = FilenameUtils.getBaseName(mf.getOriginalFilename());
        String ext = FilenameUtils.getExtension(mf.getOriginalFilename()); // 확장자
        String size = String.valueOf(fileList.get(0).getSize());
        String divi = mtfRequest.getParameter("divi");

        /* 경로 세팅 */
        String path = filePath;
        String returnPath = "\\file\\"+corpCd+"\\"+"email\\"+"image\\"+divi+"\\"+empCd+"\\";

        /* 시간 세팅 */
        SimpleDateFormat yyyMMFormat = new SimpleDateFormat("yyyyMM");
        String yyyyMM = yyyMMFormat.format(new Date());

        SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format

        /* 파일 경로 확인 및 생성*/
        path+="file\\";      final File fileDir = new File(path);
        path+=corpCd+"\\";   final File corpDir = new File(path);
        path+="email\\";      final File emailDir = new File(path);
        path+="image\\";      final File imageDir = new File(path);
        path+=divi+"\\";      final File diviDir = new File(path);
        path+=empCd+"\\";      final File empCdDir = new File(path);

        if(!fileDir.exists()){ fileDir.mkdir();}
        if(!corpDir.exists()){ corpDir.mkdir();}
        if(!emailDir.exists()){ emailDir.mkdir();}
        if(!imageDir.exists()){ imageDir.mkdir();}
        if(!diviDir.exists()){ diviDir.mkdir();}
        if(!empCdDir.exists()){ empCdDir.mkdir();}

        // 저장 파일 경로 적용
        String savePath = new File(path).getCanonicalPath()+File.separatorChar; // File path to be saved

        try {
            // 업로드된 파일의 InputStream 얻기
            InputStream fileStream = mtfRequest.getInputStream();

            // 저장명 적용 및 업로드된 파일을 지정된 경로에 저장
            String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
            mf.transferTo(new File(savePath + saveNm + "." + ext));

            // JSON 객체에 이미지 URL과 응답 코드 추가
            jsonObject.put("url", returnPath + saveNm + "." + ext);
            jsonObject.put("responseCode", "success");

        } catch (IOException e) {
            // 파일 저장 중 오류가 발생한 경우 해당 파일 삭제 및 에러 응답 코드 추가
            jsonObject.put("responseCode", "error");
            e.printStackTrace();
        }

        // JSON 객체를 문자열로 변환하여 반환
        return jsonObject.toString();
    }

    public Map<String, Object> sendEmail(MultipartHttpServletRequest mtfRequest) throws Exception {

        AES256Util aes256Util = new AES256Util();
        
        /**
         * 클라이언트 리턴 데이터
         * */
        Map<String, Object> returnData = new HashMap<String, Object>();

        /**
         * 이메일 서비스 제공자의 자격 증명 확인
         * */
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.mailplug.co.kr");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.mailplug.co.kr");
        /**
         * 대표 사용자 이름 및 비밀번호로 세션 생성
         */
        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("vnfjri123@edscorp.kr", "Qwe123!@#");
            }
        });
//        session.setDebug(true); // for debug

        try {
            /**
             * 세션 기준 메세지 객체 생성
             */
            Message message = new MimeMessage(session); // session creat

            String divi = mtfRequest.getParameter("divi");
            String sendDivi = mtfRequest.getParameter("sendDivi");
            String estCd = mtfRequest.getParameter("estCd");
            String projCd = mtfRequest.getParameter("projCd");
            String ordCd = mtfRequest.getParameter("ordCd");
            String salCd = mtfRequest.getParameter("salCd");
            String colCd = mtfRequest.getParameter("colCd");
            String setFrom = mtfRequest.getParameter("setFrom");
            String toAddr = mtfRequest.getParameter("toAddr");
            String ccAddr = mtfRequest.getParameter("ccAddr");
            String bccAddr = mtfRequest.getParameter("bccAddr");
            String setSubject = mtfRequest.getParameter("setSubject");
            String htmlToEmail = mtfRequest.getParameter("html");
            String note = mtfRequest.getParameter("html");
            String beforeEmailSeq = mtfRequest.getParameter("beforeEmailSeq");

            /**
             * 이메일 기본 정보 db 객체 생성 및 저장
             */
            Map<String, Object> saveToDatabase = new HashMap<String, Object>();
            saveToDatabase.put("corpCd",SessionUtil.getUser().getCorpCd());
            saveToDatabase.put("busiCd",SessionUtil.getUser().getBusiCd());
            saveToDatabase.put("estCd",estCd);
            saveToDatabase.put("projCd",projCd);
            saveToDatabase.put("ordCd",ordCd);
            saveToDatabase.put("salCd",salCd);
            saveToDatabase.put("colCd",colCd);
            saveToDatabase.put("divi",divi);
            saveToDatabase.put("setForm",setFrom);
            saveToDatabase.put("toAddr",toAddr);
            saveToDatabase.put("ccAddr",ccAddr);
            saveToDatabase.put("bccAddr",bccAddr);
            saveToDatabase.put("setSubject",setSubject);
            saveToDatabase.put("note",note);
            saveToDatabase.put("userId",SessionUtil.getUser().getEmpCd());

            emailMapper.insertSendEmailInfo(saveToDatabase);
            String emailSeq = (String) saveToDatabase.get("emailSeq");

            Pattern emailPattern = Pattern.compile("([\\w\\-]([\\.\\w])+[\\w]+@([\\w\\-]+\\.)+[A-Za-z]{2,4})"); // 정규표현식 문자열로 패턴 객체 생성

            /**
             * 보내는 사람 세팅
             * toAddr: 받는 이
             */
            message.setFrom(new InternetAddress(setFrom));

            /**
             * 받는 사람 세팅
             * toAddr: 받는 이
             * ccAddr: 참조
             * bccAddr: 숨은 참조
             */
            String[] toAddrArr = toAddr.split(",");
            String[] ccAddrArr = ccAddr.split(",");
            String[] bccAddrArr = bccAddr.split(",");

            int toAddrArrLength = toAddrArr.length;
            int ccAddrArrLength = ccAddrArr.length;
            int bccAddrArrLength = bccAddrArr.length;

            if(toAddrArrLength > 0 && !toAddrArr[0].equals("")){
                InternetAddress[] interToAddrArr = new InternetAddress[toAddrArrLength];
                for(int i=0; i<toAddrArrLength; i++){Matcher m = emailPattern.matcher(toAddrArr[i]);m.find();interToAddrArr[i] = new InternetAddress(m.group(1));}
                message.setRecipients(Message.RecipientType.TO, interToAddrArr);
            }

            if(ccAddrArrLength > 0 && !ccAddrArr[0].equals("")){
                InternetAddress[] interCcAddrArr = new InternetAddress[ccAddrArrLength];
                for(int i=0; i<ccAddrArrLength; i++){Matcher m = emailPattern.matcher(ccAddrArr[i]);m.find();interCcAddrArr[i] = new InternetAddress(m.group(1));}
                message.setRecipients(Message.RecipientType.CC, interCcAddrArr);
            }

            if(bccAddrArrLength > 0 && !bccAddrArr[0].equals("")){
                InternetAddress[] interBccAddrArr = new InternetAddress[bccAddrArrLength];
                for(int i=0; i<bccAddrArrLength; i++){Matcher m = emailPattern.matcher(bccAddrArr[i]);m.find();interBccAddrArr[i] = new InternetAddress(m.group(1));}
                message.setRecipients(Message.RecipientType.BCC, interBccAddrArr);
            }
            /**
             * 제목 세팅
             */
            message.setSubject(setSubject);

            /**
             * 전체 내용 세팅
             */
            Multipart mainParts = new MimeMultipart();
            /**
             * 상세 내용 세팅
             * 1. 임시 저장된 이미지를 서버 resource에 저장
             * 2. temp 파일 비우기
             */

            // file Root
            String corpCd = SessionUtil.getUser().getCorpCd();
            String empCd = SessionUtil.getUser().getEmpCd();
            String tempRoot = filePath + "file\\"+corpCd+"\\"+"email\\"+"image\\"+divi+"\\"+empCd+"\\";
            String realRoot = realPath + "file\\"+corpCd+"\\"+"email\\"+"image\\"+divi+"\\"+empCd+"\\";

            // 이미지 태그를 추출하기 위한 정규식.
            Pattern imgSrcPattern  =  Pattern.compile("(<img[^>]*src\s*=\s*[\"']?([^>\"\']+)[\"']?[^>]*>)");
            Matcher matcher = imgSrcPattern.matcher(htmlToEmail);

            String pathToImg = realPath;

            /* 파일 경로 확인 및 생성*/
            pathToImg+="file\\";     final File fileDirToImg = new File(pathToImg);
            pathToImg+=corpCd+"\\";  final File corpDirToImg = new File(pathToImg);
            pathToImg+="email\\";    final File emailDirToImg = new File(pathToImg);
            pathToImg+="image\\";    final File imageDirToImg = new File(pathToImg);
            pathToImg+=divi+"\\";    final File diviDirToImg = new File(pathToImg);
            pathToImg+=empCd+"\\";   final File empCdDirToImg = new File(pathToImg);

            if(!fileDirToImg.exists()){ fileDirToImg.mkdir();}
            if(!corpDirToImg.exists()){ corpDirToImg.mkdir();}
            if(!emailDirToImg.exists()){ emailDirToImg.mkdir();}
            if(!imageDirToImg.exists()){ imageDirToImg.mkdir();}
            if(!diviDirToImg.exists()){ diviDirToImg.mkdir();}
            if(!empCdDirToImg.exists()){ empCdDirToImg.mkdir();}

            while (matcher.find()){

                // 1. 임시 저장된 이미지를 서버 resource에 저장
                String imgSrc = matcher.group(2).trim();
                String[] imgSrcArr = imgSrc.split("\\\\");

                File tempFile = new File(tempRoot+imgSrcArr[imgSrcArr.length-1]);
                File realFile = new File(realRoot+imgSrcArr[imgSrcArr.length-1]);
                if(!tempFile.exists()) tempFile = realFile;

                Files.copy(
                        tempFile.toPath(),
                        realFile.toPath(),
                        StandardCopyOption.REPLACE_EXISTING); // REPLACE_EXISTING 이미 있으면 덮어쓰기 기능

                byte[] fileContent = FileUtils.readFileToByteArray(realFile);
                String encodedString = Base64.getEncoder().encodeToString(fileContent);
                htmlToEmail = htmlToEmail.replace(matcher.group(2).trim(),"data:image/"+realFile.getName().substring(realFile.getName().lastIndexOf(".") + 1)+";base64,"+encodedString);
            }

            // 2. temp 파일 비우기
            File tempFiles = new File(tempRoot);
            FileUtils.deleteDirectory(tempFiles);

            MimeBodyPart notePart = new MimeBodyPart();
            notePart.setContent(htmlToEmail, "text/html; charset=utf-8");
            mainParts.addBodyPart(notePart);

            /**
             * 첨부 파일 세팅
             */
            // 파일 읽기: 클라이언트 input[type='file']의 name이랑 getFiles의 명과 동일해야함
            List<MultipartFile> fileList = mtfRequest.getFiles("emailFile");
            int fileListSize = fileList.size();

            /* 이메일 첨부파일 기본명 세팅 마친 후 삭제 작업*/
            File[] tempFile = new File[fileListSize];

            /* 첨부파일 db 저장을 위한 파라미터 */
            Map<String, Object>[] atchFile = new HashMap[fileListSize];

            /* 첨부파일 파일 객체 생성 */
            String pathToAtch = realPath;

            /* 파일 경로 확인 및 생성*/
            pathToAtch+="file\\";     final File fileDirToAtch = new File(pathToAtch);
            pathToAtch+=corpCd+"\\";  final File corpDirToAtch = new File(pathToAtch);
            pathToAtch+="email\\";    final File emailDirToAtch = new File(pathToAtch);
            pathToAtch+="atch\\";     final File atchDirToAtch = new File(pathToAtch);
            pathToAtch+=divi+"\\";    final File diviDirToAtch = new File(pathToAtch);
            pathToAtch+=empCd+"\\";   final File empCdDirToAtch = new File(pathToAtch);
            
            /* 이메일 첨부파일 이 존재할 시 실행 */
            if(fileListSize > 0 && fileList.get(0).getSize() != 0){

                if(!fileDirToAtch.exists()){ fileDirToAtch.mkdir();}
                if(!corpDirToAtch.exists()){ corpDirToAtch.mkdir();}
                if(!emailDirToAtch.exists()){ emailDirToAtch.mkdir();}
                if(!atchDirToAtch.exists()){ atchDirToAtch.mkdir();}
                if(!diviDirToAtch.exists()){ diviDirToAtch.mkdir();}
                if(!empCdDirToAtch.exists()){ empCdDirToAtch.mkdir();}
                
                /* 이메일 첨부파일 세팅*/
                for (int i = 0; i < fileListSize; i++) {

                    /* 랜덤 저장 명 파라미터 생성*/
                    SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
                    
                    /* 첨부파일 생성 */
                    File realFile = null;
                    String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
                    String origNm = FilenameUtils.getBaseName(fileList.get(i).getOriginalFilename()); // 원본명
                    String ext = FilenameUtils.getExtension(fileList.get(i).getOriginalFilename()); // 확장자

                    realFile = new File(pathToAtch+saveNm+"."+ext);
                    realFile.createNewFile();

                    /* 첨부파일 콘텐츠 생성 */
                    MimeBodyPart filePart = new MimeBodyPart();
                    FileOutputStream fos = new FileOutputStream(realFile);
                    fos.write(fileList.get(i).getBytes());
                    fos.close();

                    /* 이메일 보낼 시, 첨부파일 기본명 세팅을 위한 복사 작업*/
                    tempFile[i] = new File(pathToAtch+origNm+"."+ext);

                    Files.copy(
                            realFile.toPath(),
                            tempFile[i].toPath(),
                            StandardCopyOption.REPLACE_EXISTING); // REPLACE_EXISTING 이미 있으면 덮어쓰기 기능

                    /* 첨부파일 콘텐츠 추가 */
                    filePart.attachFile(tempFile[i]);
                    mainParts.addBodyPart(filePart);

                    /* 첨부파일 db 저장을 위한 파라미터 세팅*/
                    atchFile[i] = new HashMap<>();
                    atchFile[i].put("corpCd",SessionUtil.getUser().getCorpCd());
                    atchFile[i].put("busiCd",SessionUtil.getUser().getBusiCd());
                    atchFile[i].put("estCd",estCd);
                    atchFile[i].put("projCd",projCd);
                    atchFile[i].put("ordCd",ordCd);
                    atchFile[i].put("salCd",salCd);
                    atchFile[i].put("colCd",colCd);
                    atchFile[i].put("divi",divi);
                    atchFile[i].put("saveNm",saveNm);
                    atchFile[i].put("origNm",origNm);
                    atchFile[i].put("saveRoot",pathToAtch+saveNm+"."+ext);
                    atchFile[i].put("ext",ext);
                    atchFile[i].put("size",realFile.length());
                    atchFile[i].put("userId",empCd);
                    atchFile[i].put("secretKey", aes256Util.getKey());
                }
            }
            /* 이메일 첨부파일이 존재하지 않을 시*/
            else {
                Map<String, Object> map = new HashMap<>();
                map.put("secretKey", aes256Util.getKey());
                map.put("corpCd",corpCd);
                map.put("busiCd",SessionUtil.getUser().getBusiCd());
                map.put("estCd",estCd);
                map.put("projCd",projCd);
                map.put("ordCd",ordCd);
                map.put("salCd",salCd);
                map.put("colCd",colCd);
                map.put("divi",divi);
                map.put("emailSeq",beforeEmailSeq);
                map.put("authDivi", SessionUtil.getUser().getAuthDivi());
                List<emailFileVO> result = emailMapper.selectSendEmailFileInfo(map);
                /* 1. 재전송이며 보낼 첨부파일이 있을 경우 */
                if(!result.isEmpty()  && fileList.get(0).getSize() == 0){
                    fileListSize = result.size();
                    tempFile = new File[fileListSize];
                    atchFile = new HashMap[fileListSize];
                    for (int i = 0; i < fileListSize; i++) {

                        /* 랜덤 저장 명 파라미터 생성*/
                        SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format

                        /* 첨부파일 생성 */
                        File realFile = null;
                        File copyFile = null;

                        String saveNm = result.get(i).getSaveNm(); // 변경 파일 명
                        String copyNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명

                        String origNm = result.get(i).getOrigNm(); // 원본명
                        String ext = result.get(i).getExt(); // 확장자

                        realFile = new File(pathToAtch+saveNm+"."+ext);

                        /* 재전송에 대한 새 파일 복사*/
                        copyFile = new File(pathToAtch+copyNm+"."+ext);
                        copyFile.createNewFile();

                        Files.copy(
                                realFile.toPath(),
                                copyFile.toPath(),
                                StandardCopyOption.REPLACE_EXISTING); // REPLACE_EXISTING 이미 있으면 덮어쓰기 기능


                        /* 이메일 보낼 시, 첨부파일 기본명 세팅을 위한 복사 작업*/
                        tempFile[i] = new File(pathToAtch+origNm+"."+ext);

                        Files.copy(
                                realFile.toPath(),
                                tempFile[i].toPath(),
                                StandardCopyOption.REPLACE_EXISTING); // REPLACE_EXISTING 이미 있으면 덮어쓰기 기능

                        /* 첨부파일 콘텐츠 추가 */
                        MimeBodyPart filePart = new MimeBodyPart();
                        filePart.attachFile(tempFile[i]);
                        mainParts.addBodyPart(filePart);

                        /* 첨부파일 db 저장을 위한 파라미터 세팅*/
                        atchFile[i] = new HashMap<>();
                        atchFile[i].put("corpCd",corpCd);
                        atchFile[i].put("busiCd",SessionUtil.getUser().getBusiCd());
                        atchFile[i].put("estCd",estCd);
                        atchFile[i].put("projCd",projCd);
                        atchFile[i].put("ordCd",ordCd);
                        atchFile[i].put("salCd",salCd);
                        atchFile[i].put("colCd",colCd);
                        atchFile[i].put("divi",divi);
                        atchFile[i].put("saveNm",copyNm);
                        atchFile[i].put("saveRoot",pathToAtch+copyNm+"."+ext);
                        atchFile[i].put("origNm",origNm);
                        atchFile[i].put("ext",ext);
                        atchFile[i].put("size",realFile.length());
                        atchFile[i].put("userId",empCd);
                        atchFile[i].put("secretKey", aes256Util.getKey());

                    }
                }
                /* 2. 첨부파일이 없는 경우 */
                else {

                }

            }

            /**
             * 견적서 파일 세팅
             */
            /* 견적서 파일 콘텐츠 생성 */
            String busiCd = mtfRequest.getParameter("busiCd");
            String num = mtfRequest.getParameter("num");
            String num2han = mtfRequest.getParameter("num2han");
            String printKind = mtfRequest.getParameter("printKind");
            String nameFormat = mtfRequest.getParameter("nameFormat");
            String id = mtfRequest.getParameter("id");

            Map<String, Object> printParam = new HashMap<>();
            printParam.put("corpCd",corpCd);
            printParam.put("busiCd",busiCd);
            printParam.put("estCd",estCd);
            printParam.put("projCd",projCd);
            printParam.put("ordCd",ordCd);
            printParam.put("salCd",salCd);
            printParam.put("colCd",colCd);
            printParam.put("num",num);
            printParam.put("num2han",num2han);
            printParam.put("printKind",printKind);
            printParam.put("nameFormat",nameFormat);
            printParam.put("emailSeq",emailSeq);
            printParam.put("id",id);
            printParam.put("divi",divi);

            File printFile = null;
            if(    !divi.equals("sales")
                && !divi.equals("collect")){
                printFile = printFile(printParam);
                MimeBodyPart filePart = new MimeBodyPart();
                filePart.attachFile(printFile);
                mainParts.addBodyPart(filePart);
            }

            /**
             * 이메일 보내기
             */
            message.setContent(mainParts);

            if(sendDivi.equals("save")){
                
                returnData.put("status","success");
                returnData.put("note","성공적으로 이메일을 요청하였습니다.");
                
            }else{
                Transport.send(message);

                returnData.put("status","success");
                returnData.put("note","성공적으로 이메일을 발송하였습니다.");
            }

            /* 이메일 첨부파일 기본명 세팅 마친 후 삭제 작업*/
            if(fileListSize > 0){
                for (int i = 0; i < fileListSize; i++) {
                    if(atchFile[i] == null) continue;
                    atchFile[i].put("emailSeq",emailSeq);
                    emailMapper.insertSendEmailAtchInfo(atchFile[i]);

                    tempFile[i].delete();
                }
            }
            if(    !divi.equals("sales")
                    && !divi.equals("collect")){
                printFile.delete();
            }

            // 알람 저장
            if(divi.equals("estimate")){// 알람 저장
                Map<String, Object> alarmDataParam = new HashMap<>();
                alarmDataParam.put("corpCd",SessionUtil.getUser().getCorpCd());
                alarmDataParam.put("estCd",estCd);
                alarmDataParam.put("divi","estimate");
                alarmDataParam.put("seq","");
                alarmDataParam.put("authDivi","");
                List<emailListVO> result = emailMapper.selectSendEmailInfo2(alarmDataParam);

                emailListVO vo = result.get(0);
                Map<String, Object> alarmData = new HashMap<>();

                alarmData.put("corpCd",vo.getCorpCd());
                alarmData.put("empCd",vo.getInpId());
                alarmData.put("empNm",vo.getInpNm());
                alarmData.put("navMessage","[" + vo.getProjNm().toString() + "] 프로젝트의 견적요청이 도착하였습니다.");
                alarmData.put("inpId",vo.getInpId());
                alarmData.put("updId",vo.getInpId());
                alarmData.put("submitCd",vo.getEstCd().toString() + "-" + vo.getSeq());
                alarmData.put("submitNm","견적서발송 - " + vo.getProjNm().toString() + " 견적요청의 건");
                alarmData.put("stateDivi","11"); // 견적서발송 코드
                alarmData.put("readDivi","00");
                alarmData.put("saveDivi","00");

                alarmData.put("target",vo.getInpId());
                List<String> partCds = new ArrayList<>();
                partCds.add("0004"); // 발주서요청 알림 받아야할 사원코드 넣어야함(사장님)
//                partCds.add("0000"); // 발주서요청 알림 받아야할 사원코드 넣어야함
                partCds = partCds.stream()
                        .distinct()
                        .collect(Collectors.toList());
                int partCdsLength = partCds.size();
                for (int i = 0; i < partCdsLength; i++) {
                    alarmData.put("id",partCds.get(i));
                    alarmData.put("target",partCds.get(i));
                    alarmService.insertAlarmList(alarmData);
                }
            }else if(divi.equals("order")){// 알람 저장
                Map<String, Object> alarmDataParam = new HashMap<>();
                alarmDataParam.put("corpCd",SessionUtil.getUser().getCorpCd());
                alarmDataParam.put("ordCd",ordCd);
                alarmDataParam.put("divi","order");
                alarmDataParam.put("seq","");
                alarmDataParam.put("authDivi","");
                List<emailListVO> result = emailMapper.selectSendEmailInfo2(alarmDataParam);

                emailListVO vo = result.get(0);
                Map<String, Object> alarmData = new HashMap<>();

                alarmData.put("corpCd",vo.getCorpCd());
                alarmData.put("empCd",vo.getInpId());
                alarmData.put("empNm",vo.getInpNm());
                alarmData.put("navMessage","[" + vo.getProjNm().toString() + "] 프로젝트의 발주요청이 도착하였습니다.");
                alarmData.put("inpId",vo.getInpId());
                alarmData.put("updId",vo.getInpId());
                alarmData.put("submitCd",vo.getOrdCd().toString() + "-" + vo.getSeq());
                alarmData.put("submitNm","발주서발송 - " + vo.getProjNm().toString() + " 발주요청의 건");
                alarmData.put("stateDivi","08"); // 발주서발송 코드
                alarmData.put("readDivi","00");
                alarmData.put("saveDivi","00");

                alarmData.put("target",vo.getInpId());
                List<String> partCds = new ArrayList<>();
                partCds.add("0004"); // 발주서요청 알림 받아야할 사원코드 넣어야함(사장님)
//                partCds.add("0000"); // 발주서요청 알림 받아야할 사원코드 넣어야함
                partCds = partCds.stream()
                        .distinct()
                        .collect(Collectors.toList());
                int partCdsLength = partCds.size();
                for (int i = 0; i < partCdsLength; i++) {
                    alarmData.put("id",partCds.get(i));
                    alarmData.put("target",partCds.get(i));
                    alarmService.insertAlarmList(alarmData);
                }
            }
        }catch (MessagingException e){
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);

            if(exc.contains("Invalid Addresses")){
                returnData.put("note","보내는 사람이 회사 이메일에 등록되지 않은 사용자입니다.\n보내는 사람을 다시 확인해 주시길 바랍니다.");
            }else if(exc.contains("No recipient addresses")){
                returnData.put("note","받는 사람 이메일이 유효하지 않습니다.\n다시 확인해 주시길 바랍니다.");
            }else {
                returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            }

            e.printStackTrace();
        }catch (Exception e){
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }

        return returnData;
    }

    public Map<String, Object> onlySendEmail(MultipartHttpServletRequest mtfRequest) throws Exception {

        AES256Util aes256Util = new AES256Util();

        /**
         * 클라이언트 리턴 데이터
         * */
        Map<String, Object> returnData = new HashMap<String, Object>();

        /**
         * 이메일 서비스 제공자의 자격 증명 확인
         * */
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.mailplug.co.kr");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.mailplug.co.kr");
        /**
         * 대표 사용자 이름 및 비밀번호로 세션 생성
         */
        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("vnfjri123@edscorp.kr", "Qwe123!@#");
            }
        });
//        session.setDebug(true); // for debug

        try {
            /**
             * 세션 기준 메세지 객체 생성
             */
            Message message = new MimeMessage(session); // session creat

            String divi = mtfRequest.getParameter("divi");
            String estCd = mtfRequest.getParameter("estCd");
            String projCd = mtfRequest.getParameter("projCd");
            String ordCd = mtfRequest.getParameter("ordCd");
            String salCd = mtfRequest.getParameter("salCd");
            String colCd = mtfRequest.getParameter("colCd");
            String setFrom = mtfRequest.getParameter("setFrom");
            String toAddr = mtfRequest.getParameter("toAddr");
            String ccAddr = mtfRequest.getParameter("ccAddr");
            String bccAddr = mtfRequest.getParameter("bccAddr");
            String setSubject = mtfRequest.getParameter("setSubject");
            String htmlToEmail = mtfRequest.getParameter("html");
            String note = mtfRequest.getParameter("html");
            String emailSeq = mtfRequest.getParameter("emailSeq");
            String beforeEmailSeq = mtfRequest.getParameter("beforeEmailSeq");

            Pattern emailPattern = Pattern.compile("([\\w\\-]([\\.\\w])+[\\w]+@([\\w\\-]+\\.)+[A-Za-z]{2,4})"); // 정규표현식 문자열로 패턴 객체 생성

            /**
             * 보내는 사람 세팅
             * toAddr: 받는 이
             */
            message.setFrom(new InternetAddress(setFrom));

            /**
             * 받는 사람 세팅
             * toAddr: 받는 이
             * ccAddr: 참조
             * bccAddr: 숨은 참조
             */
            String[] toAddrArr = toAddr.split(",");
            String[] ccAddrArr = ccAddr.split(",");
            String[] bccAddrArr = bccAddr.split(",");

            int toAddrArrLength = toAddrArr.length;
            int ccAddrArrLength = ccAddrArr.length;
            int bccAddrArrLength = bccAddrArr.length;

            if(toAddrArrLength > 0 && !toAddrArr[0].equals("")){
                InternetAddress[] interToAddrArr = new InternetAddress[toAddrArrLength];
                for(int i=0; i<toAddrArrLength; i++){Matcher m = emailPattern.matcher(toAddrArr[i]);m.find();interToAddrArr[i] = new InternetAddress(m.group(1));}
                message.setRecipients(Message.RecipientType.TO, interToAddrArr);
            }

            if(ccAddrArrLength > 0 && !ccAddrArr[0].equals("")){
                InternetAddress[] interCcAddrArr = new InternetAddress[ccAddrArrLength];
                for(int i=0; i<ccAddrArrLength; i++){Matcher m = emailPattern.matcher(ccAddrArr[i]);m.find();interCcAddrArr[i] = new InternetAddress(m.group(1));}
                message.setRecipients(Message.RecipientType.CC, interCcAddrArr);
            }

            if(bccAddrArrLength > 0 && !bccAddrArr[0].equals("")){
                InternetAddress[] interBccAddrArr = new InternetAddress[bccAddrArrLength];
                for(int i=0; i<bccAddrArrLength; i++){Matcher m = emailPattern.matcher(bccAddrArr[i]);m.find();interBccAddrArr[i] = new InternetAddress(m.group(1));}
                message.setRecipients(Message.RecipientType.BCC, interBccAddrArr);
            }
            /**
             * 제목 세팅
             */
            message.setSubject(setSubject);

            /**
             * 전체 내용 세팅
             */
            Multipart mainParts = new MimeMultipart();
            // file Root
            String corpCd = SessionUtil.getUser().getCorpCd();
            String empCd = SessionUtil.getUser().getEmpCd();

            // 이미지 태그를 추출하기 위한 정규식.
            Pattern imgSrcPattern  =  Pattern.compile("(<img[^>]*src\s*=\s*[\"']?([^>\"\']+)[\"']?[^>]*>)");
            Matcher matcher = imgSrcPattern.matcher(htmlToEmail);

            /* 파일 경로 확인 및 생성*/

            while (matcher.find()){

                // 1. 임시 저장된 이미지를 서버 resource에 저장
                String imgSrc = matcher.group(2).trim();
                String[] imgSrcArr = imgSrc.split("\\\\");

                File realFile = new File(realPath+imgSrc);

                byte[] fileContent = FileUtils.readFileToByteArray(realFile);
                String encodedString = Base64.getEncoder().encodeToString(fileContent);
                htmlToEmail = htmlToEmail.replace(matcher.group(2).trim(),"data:image/"+realFile.getName().substring(realFile.getName().lastIndexOf(".") + 1)+";base64,"+encodedString);
            }

            MimeBodyPart notePart = new MimeBodyPart();
            notePart.setContent(htmlToEmail, "text/html; charset=utf-8");
            mainParts.addBodyPart(notePart);

            /**
             * 첨부 파일 세팅
             */
            String fileLists =  mtfRequest.getParameter("emailFile");
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> returnMap = mapper.readValue(fileLists, Map.class);
            
            /* 첨부파일 리스트화*/
            List fileDatas = (List) returnMap.get("data");
            int fileListSize = fileDatas.size();


            /* 이메일 첨부파일 기본명 세팅 마친 후 삭제 작업하기 위한 File 리스트*/
            File[] tempFile = new File[fileListSize];
            
            /* 첨부파일 저장명에서 기존 명 변경 세팅 시작*/
            for (int i = 0; i < fileListSize; i++) {
                Map<String, String> fileData = (Map<String, String>) fileDatas.get(i);
                String saveRoot = fileData.get("saveRoot");
                String origNm = fileData.get("origNm");

                File realFile = new File(saveRoot);
                tempFile[i] = new File(realPath + "file\\"+corpCd+"\\"+"email\\"+origNm);

                Files.copy(
                        realFile.toPath(),
                        tempFile[i].toPath(),
                        StandardCopyOption.REPLACE_EXISTING); // REPLACE_EXISTING 이미 있으면 덮어쓰기 기능

                /* 첨부파일 콘텐츠 추가 */
                MimeBodyPart filePart = new MimeBodyPart();
                filePart.attachFile(tempFile[i]);
                mainParts.addBodyPart(filePart);
            }

            /**
             * 이메일 보내기
             */
            message.setContent(mainParts);

            Transport.send(message);

            returnData.put("status","success");
            returnData.put("note","성공적으로 이메일을 발송하였습니다.");

            /* 이메일 첨부파일 기본명 세팅 마친 후 삭제 작업*/
            for (int i = 0; i < fileListSize; i++) {
                tempFile[i].delete();
            }

        }catch (MessagingException e){
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);

            if(exc.contains("Invalid Addresses")){
                returnData.put("note","보내는 사람이 회사 이메일에 등록되지 않은 사용자입니다.\n보내는 사람을 다시 확인해 주시길 바랍니다.");
            }else if(exc.contains("No recipient addresses")){
                returnData.put("note","받는 사람 이메일이 유효하지 않습니다.\n다시 확인해 주시길 바랍니다.");
            }else {
                returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            }

            e.printStackTrace();
        }catch (Exception e){
            String exc = e.toString();
            returnData.put("status","fail");
            returnData.put("exc",exc);
            returnData.put("note","알 수 없는 오류입니다.\n053-951-4500에 개발팀으로 연락 바랍니다.");
            e.printStackTrace();
        }

        return returnData;
    }

    AES256Util aes256Util;

    {
        try {
            aes256Util = new AES256Util();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    public File printFile(Map<String, Object> map) throws Exception {

        byte[] data = null;
        Connection conn = null;
        String os = System.getProperty("os.name").toLowerCase();

        String id = (String) map.get("id");
        String[] paths = id.split("_");
        String path = paths[0];
        String jasperPath = "";
        File file = null;

        try {

            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            if (os.contains("linux")) {
                URL res = getClass().getClassLoader().getResource(Paths.get(File.separatorChar + "jrxml/eds/erp/"+path, File.separatorChar + paths[1]+".jrxml").toString());
                jasperPath = res.getPath().substring(0, res.getPath().lastIndexOf("/"))+File.separatorChar;
                file = Paths.get(res.toURI()).toFile();
            } else {
                jasperPath =  new File(realPath+"jrxml/eds/erp/").getCanonicalPath()+File.separatorChar+path+File.separatorChar;
                file = new File(jasperPath+paths[1]+".jrxml");
            }

            JasperReport jasperReport = JasperCompileManager.compileReport(new FileInputStream(file.getAbsolutePath()));

            //리포트 페이지 생성
            JasperPrint jasperPrint = new JasperPrint();
            Map<String, Object> rptData = map;
            rptData.put("SUBREPORT_DIR", jasperPath);
            rptData.put("secretKey", aes256Util.getKey());

            if(rptData.containsKey("printKind")){
                String printKind = (String) rptData.get("printKind");
                switch (printKind){
                    case "prints1":
                        rptData.put("logo", "eds_logo.png");
                        rptData.put("stamp", "eds_stamp_company.png");
                        rptData.put("param1", "등 록 번 호 : 504-86-09846");
                        rptData.put("param2", "상         호 : 이디에스 주식회사  대표 : 이종필");
                        rptData.put("param3", "사업장주소 : 경상북도 김천시 혁신8로5 216호");
                        rptData.put("param4", "전 화 번 호 : 054.436.4501(代),팩스 : 054.434.4501");
                        rptData.put("param5", "업         태 : 건설/제조/서비스, 종    목 : 통신공사업 외");
                        rptData.put("param6", "");
                        break;
                    case "prints8":
                        rptData.put("logo", "eds_logo.png");
                        rptData.put("stamp", "eds_stamp_individual.png");
                        rptData.put("param1", "등 록 번 호 : 504-86-09846");
                        rptData.put("param2", "상         호 : 이디에스 주식회사  대표 : 이종필");
                        rptData.put("param3", "사업장주소 : 경상북도 김천시 혁신8로5 216호");
                        rptData.put("param4", "전 화 번 호 : 054.436.4501(代),팩스 : 054.434.4501");
                        rptData.put("param5", "업         태 : 건설/제조/서비스, 종    목 : 통신공사업 외");
                        rptData.put("param6", "");
                        break;
                    case "prints2":
                        rptData.put("logo", "tomato_logo.png");
                        rptData.put("stamp", "tomato_stamp_company.png");
                        rptData.put("param1", "대구광역시 북구 동변로 13길 20-1(동변동)");
                        rptData.put("param2", "대표전화 : 053.951.4500 F : 053.951.4501");
                        rptData.put("param3", "사업자등록번호 : 107-88-42726");
                        rptData.put("param4", "대 표 이 사 : 권     양     익     (인)  ");
                        rptData.put("param5", "업 태 : 제조/서비스, 종  목:통신공사업 외");
                        rptData.put("param6", "");
                        break;
                    case "prints3":
                        rptData.put("logo", "tomato_logo.png");
                        rptData.put("stamp", "tomato_stamp_individual.png");
                        rptData.put("param1", "대구광역시 북구 동변로 13길 20-1(동변동)");
                        rptData.put("param2", "대표전화 : 053.951.4500 F : 053.951.4501");
                        rptData.put("param3", "사업자등록번호 : 107-88-42726");
                        rptData.put("param4", "대 표 이 사 : 권     양     익     (인)  ");
                        rptData.put("param5", "업 태 : 제조/서비스, 종  목:통신공사업 외");
                        rptData.put("param6", "");
                        break;
                    case "prints4":
                        rptData.put("logo", "tmt_logo.png");
                        rptData.put("stamp", "tmt_stamp_company.png");
                        rptData.put("param1", "등 록 번 호 : 111-81-93899");
                        rptData.put("param2", "상         호 : 이디에스 주식회사  대표 : 서지윤");
                        rptData.put("param3", "사업장주소 : 충북 청주시 흥덕구 직지대로436 76,833호");
                        rptData.put("param4", "전 화 번 호 : 043.264.4500(代),팩스 : 264.4501");
                        rptData.put("param5", "업         태 : 건설/제조/서비스, 종    목 : 통신공사업 외");
                        rptData.put("param6", "");
                        break;
                    case "prints5":
                        rptData.put("logo", "tmt_logo.png");
                        rptData.put("stamp", "tmt_stamp_individual.png");
                        rptData.put("param1", "등 록 번 호 : 111-81-93899");
                        rptData.put("param2", "상         호 : 이디에스 주식회사  대표 : 서지윤");
                        rptData.put("param3", "사업장주소 : 충북 청주시 흥덕구 직지대로436 76,833호");
                        rptData.put("param4", "전 화 번 호 : 043.264.4500(代),팩스 : 264.4501");
                        rptData.put("param5", "업         태 : 건설/제조/서비스, 종    목 : 통신공사업 외");
                        rptData.put("param6", "");
                        break;
                    case "prints6"://충북
                        rptData.put("logo", "edsone_logo.png");
                        rptData.put("stamp", "edsone_stamp_company.png");
                        rptData.put("param1", "등 록 번 호 : 210111-0197246");
                        rptData.put("param2", "상         호 : 주식회사 이디에스원  대표 : 김 병 우");
                        rptData.put("param3", "사업장주소 : 전북 전주시 덕진구 만성북로 51-25,4층 4048호");
                        rptData.put("param4", "전 화 번 호 : 063.213.4500(代),팩스 : 213.4501");
                        rptData.put("param5", "업         태 : 건설/제조, 종    목 : 통신공사업 외");
                        rptData.put("param6", "");
                        break;
                    case "prints7"://충북
                        rptData.put("logo", "edsone_logo.png");
                        rptData.put("stamp", "edsone_stamp_individual.png");
                        rptData.put("param1", "등 록 번 호 : 210111-0197246");
                        rptData.put("param2", "상         호 : 주식회사 이디에스원  대표 : 김 병 우");
                        rptData.put("param3", "사업장주소 : 전북 전주시 덕진구 만성북로 51-25,4층 4048호");
                        rptData.put("param4", "전 화 번 호 : 063.213.4500(代),팩스 : 213.4501");
                        rptData.put("param5", "업         태 : 건설/제조, 종    목 : 통신공사업 외");
                        rptData.put("param6", "");
                        break;
                }
            }

            jasperPrint = JasperFillManager.fillReport(jasperReport, rptData, conn);
            // 오른쪽 상단에 eds 식별 qrcode 의무화: 회사코드+사업장코드+사업장등록번호+각 테이블에대한 유니크넘버

            data = JasperExportManager.exportReportToPdf(jasperPrint);
        } catch (Exception e){
            System.out.print(e);
        } finally {
            conn.close();
        }


        /* 랜덤 저장 명 파라미터 생성*/
        String divi = (String) map.get("divi");
        String corpCd = SessionUtil.getUser().getCorpCd();
        String estCd = (String) map.get("estCd");
        String projCd = (String) map.get("projCd");
        String ordCd = (String) map.get("ordCd");
        String salCd = (String) map.get("salCd");
        String colCd = (String) map.get("colCd");
        String emailSeq = (String) map.get("emailSeq");
        String empCd = SessionUtil.getUser().getEmpCd();

        SimpleDateFormat seventeenFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); // yyyyMMddHHmmssSSS format
        String saveNm = seventeenFormat.format(new Date())+ Util.removeMinusChar(UUID.randomUUID().toString()); // 변경 파일 명
        String origNm = (String) map.get("nameFormat") + SessionUtil.getUser().getEmpNm() + "(" + seventeenFormat.format(new Date()) + ")";

        String pathToPrintFile = realPath;

        /* 파일 경로 확인 및 생성*/
        pathToPrintFile+="file\\";     final File fileDirToPrintFile = new File(pathToPrintFile);
        pathToPrintFile+=corpCd+"\\";  final File corpDirToPrintFile = new File(pathToPrintFile);
        pathToPrintFile+="email\\";    final File emailDirToPrintFile = new File(pathToPrintFile);
        pathToPrintFile+="printFile\\";final File printFileDirToPrintFile = new File(pathToPrintFile);
        pathToPrintFile+=divi+"\\";    final File diviDirToPrintFile = new File(pathToPrintFile);
        pathToPrintFile+=empCd+"\\";   final File empCdDirToPrintFile = new File(pathToPrintFile);

        if(!fileDirToPrintFile.exists()){ fileDirToPrintFile.mkdir();}
        if(!corpDirToPrintFile.exists()){ corpDirToPrintFile.mkdir();}
        if(!emailDirToPrintFile.exists()){ emailDirToPrintFile.mkdir();}
        if(!printFileDirToPrintFile.exists()){ printFileDirToPrintFile.mkdir();}
        if(!diviDirToPrintFile.exists()){ diviDirToPrintFile.mkdir();}
        if(!empCdDirToPrintFile.exists()){ empCdDirToPrintFile.mkdir();}

        /* 파일 저장*/
        File printFile = new File(pathToPrintFile+saveNm+".pdf");
        if(!printFile.exists()) printFile.createNewFile();

        FileOutputStream applyData = new FileOutputStream(printFile);
        applyData.write(data);
        applyData.close();

        /* 첨부파일 db 저장을 위한 파라미터 */
        Map<String, Object> jasperFile = new HashMap<>();
        jasperFile.put("corpCd",corpCd);
        jasperFile.put("busiCd",SessionUtil.getUser().getBusiCd());
        jasperFile.put("estCd",estCd);
        jasperFile.put("projCd",projCd);
        jasperFile.put("ordCd",ordCd);
        jasperFile.put("salCd",salCd);
        jasperFile.put("colCd",colCd);
        jasperFile.put("emailSeq",emailSeq);
        jasperFile.put("divi",divi);
        jasperFile.put("saveNm",saveNm);
        jasperFile.put("saveRoot",pathToPrintFile+saveNm+".pdf");
        jasperFile.put("origNm",origNm);
        jasperFile.put("ext","pdf");
        jasperFile.put("size",printFile.length());
        jasperFile.put("userId",empCd);
        jasperFile.put("secretKey", aes256Util.getKey());
        emailMapper.insertSendEmailJasperInfo(jasperFile);

        /* 변경된 이름 리턴*/
        File renewFile = new File(pathToPrintFile+origNm+".pdf");
        if(!renewFile.exists()) renewFile.createNewFile();

        FileOutputStream applyRenewData = new FileOutputStream(renewFile);
        applyRenewData.write(data);
        applyRenewData.close();

        return renewFile;
    }

    public int applySendEmail(Map<String, Object> map) throws Exception {
        int returnData = 0;

        try{

            String sendDiv = map.get("sendDivi").toString();
            sendDiv = (sendDiv.equals("02"))?"승인":(sendDiv.equals("03")?"반려":"");
            /* 발주 이메일 발송 적용*/
            map.put("userId", SessionUtil.getUser().getEmpCd());
            map.put("authDivi", "");
            returnData = emailMapper.applySendEmail(map);

            // 알람 저장
            List<emailListVO> result = emailMapper.selectSendEmailInfo2(map);

            emailListVO vo = result.get(0);

            Map<String, Object> alarmData = new HashMap<>();
            alarmData.put("corpCd",vo.getCorpCd());
            alarmData.put("empCd",SessionUtil.getUser().getEmpCd());
            alarmData.put("empNm",SessionUtil.getUser().getEmpNm());
            alarmData.put("inpId",SessionUtil.getUser().getEmpCd());
            alarmData.put("updId",SessionUtil.getUser().getEmpCd());
            alarmData.put("readDivi","00");
            alarmData.put("saveDivi","00");

            if(map.get("divi").toString().equals("estimate")){
                String stateDivi = map.get("sendDivi").toString();
                stateDivi = (stateDivi.equals("02"))?"12":(stateDivi.equals("03")?"13":"");
                alarmData.put("submitCd",vo.getEstCd().toString() + "-" + vo.getSeq());
                alarmData.put("navMessage","[" + vo.getProjNm().toString() + "] 프로젝트의 견적요청이 "+sendDiv+"되었습니다.");
                alarmData.put("submitNm","견적서조회 - " + vo.getProjNm().toString() + " 견적"+sendDiv+"의 건");
                alarmData.put("stateDivi",stateDivi); // 발주서발송 코드
            }else if(map.get("divi").toString().equals("order")){
                String stateDivi = map.get("sendDivi").toString();
                stateDivi = (stateDivi.equals("02"))?"09":(stateDivi.equals("03")?"10":"");
                alarmData.put("submitCd",vo.getOrdCd().toString() + "-" + vo.getSeq());
                alarmData.put("navMessage","[" + vo.getProjNm().toString() + "] 프로젝트의 발주요청이 "+sendDiv+"되었습니다.");
                alarmData.put("submitNm","발주서조회 - " + vo.getProjNm().toString() + " 발주"+sendDiv+"의 건");
                alarmData.put("stateDivi",stateDivi); // 발주서발송 코드
            }

            alarmData.put("target",vo.getInpId());
            List<String> partCds = new ArrayList<>();
            partCds.add(vo.getInpId()); // 발주서요청 알림 받아야할 사원코드 넣어야함
            partCds = partCds.stream()
                    .distinct()
                    .collect(Collectors.toList());
            int partCdsLength = partCds.size();
            for (int i = 0; i < partCdsLength; i++) {
                alarmData.put("id",partCds.get(i));
                alarmData.put("target",partCds.get(i));
                alarmService.insertAlarmList(alarmData);
            }
            returnData = 1;
        }catch (Exception e){

            String exc = e.toString();
            System.out.println(exc);
            e.printStackTrace();
            returnData = 0;

        }
        return returnData;
    }
}
