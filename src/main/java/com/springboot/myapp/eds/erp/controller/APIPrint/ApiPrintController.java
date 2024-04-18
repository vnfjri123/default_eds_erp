package com.springboot.myapp.eds.erp.controller.APIPrint;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.myapp.util.AES256Util;
import jakarta.servlet.http.HttpServletRequest;
import net.sf.jasperreports.engine.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ApiPrintController {

    @Value("${eds.backs.file.path}")
    private String filePath;

    AES256Util aes256Util = new AES256Util();

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    public ApiPrintController() throws UnsupportedEncodingException {
    }

    @RequestMapping("/eds/erp/api/print/{id}")
    public ResponseEntity<byte[]> print(HttpServletRequest request,
                                        @RequestParam String param,
                                        @PathVariable("id") String id) throws Exception {

        byte[] data = null;
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<String, Object>();
        Connection conn = null;
        String os = System.getProperty("os.name").toLowerCase();

        try {
            params = mapper.readValue(param, Map.class);
        } catch (JsonProcessingException e){
            e.printStackTrace();
        }

        try {

            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            String[] paths = id.split("_");
            String path = paths[0];
            String jasperPath = "";
            File file = null;

            if (os.contains("linux")) {
                URL res = getClass().getClassLoader().getResource(Paths.get(File.separatorChar + "jrxml/eds/erp/"+path, File.separatorChar + id+".jrxml").toString());
                jasperPath = res.getPath().substring(0, res.getPath().lastIndexOf("/"))+File.separatorChar;
                file = Paths.get(res.toURI()).toFile();
            } else {
//                jasperPath =  new File(filePath+"jrxml/eds/erp").getCanonicalPath()+File.separatorChar+path+File.separatorChar;
                jasperPath =  new File(filePath+"jrxml/eds/erp/").getCanonicalPath()+File.separatorChar+path+File.separatorChar;
                file = new File(jasperPath+paths[1]+".jrxml");
                System.out.println(jasperPath+paths[1]+".jrxml");
            }

            JasperReport jasperReport = JasperCompileManager.compileReport(new FileInputStream(file.getAbsolutePath()));

            // Tui Grid에서 넘어온 데이터
            List reportData = (List) params.get("data");

            int size = reportData.size();

            Map existence = (Map) reportData.get(0);// 바코드 프린트 판단
            if(existence.containsKey("cnt")) { // 바코드 프린트
                JasperPrint jasperPrints = JasperFillManager.fillReport(jasperReport, null, conn); // 부모 리포트 생성
                // 부모 리포트 데이터 생성 루프
                for(int i=0; i<size; i++){
                    Map barcodeData = (Map) reportData.get(i); // 자식 데이터 생성
                    int barcodeCnt = Integer.parseInt((String) barcodeData.get("cnt")); // 자식 데이터 인쇄 수 저장
                    if(barcodeCnt > 0) { // 인쇄 수 > 0
                        //자식 리포트를 인쇄 수만큼 생성 루프
                        JasperPrint[] jasperPrint = new JasperPrint[barcodeCnt];
                        for (int j = 0; j < barcodeCnt; j++) {
                            jasperPrint[j] = JasperFillManager.fillReport(jasperReport, barcodeData, conn); // 자식 리포트 생성
                        }
                        //부모 리포트에 자식 리포트 추가 루프
                        for (int j = 0; j < barcodeCnt; j++) {
                            List pages = jasperPrint[j].getPages(); // 인쇄 수만큼 생성된 자식 리포트를 페이지로 가공
                            for (int k = 0; k < pages.size(); k++) {
                                JRPrintPage object = (JRPrintPage) pages.get(k);
                                jasperPrints.addPage(object); // 부모 리포트에 가공된 페이지 추가
                            }
                        }
                    }
                }
                data = JasperExportManager.exportReportToPdf(jasperPrints);
            }else {
                //리포트 페이지 생성
                JasperPrint[] jasperPrint = new JasperPrint[size];
                for (int i = 0; i < size; i++) {
                    Map rptData = (Map) reportData.get(i);
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
                    jasperPrint[i] = JasperFillManager.fillReport(jasperReport, rptData, conn);
                    // 오른쪽 상단에 eds 식별 qrcode 의무화: 회사코드+사업장코드+사업장등록번호+각 테이블에대한 유니크넘버
                }
                //리포트 페이지 병합2
                for (int i = 1; i < size; i++) {
                    List pages = jasperPrint[i].getPages();
                    for (int j = 0; j < pages.size(); j++) {
                        JRPrintPage object = (JRPrintPage) pages.get(j);
                        jasperPrint[0].addPage(object);
                    }
                }
                data = JasperExportManager.exportReportToPdf(jasperPrint[0]);
            }
        } catch (Exception e){
            System.out.print(e);
        } finally {
            conn.close();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=invoice.pdf");

        return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF).body(data);
    }

    @RequestMapping("/eds/erp/api/multiPrint")
    public ResponseEntity<byte[]> multiPrint(HttpServletRequest request,
                                             @RequestParam String param) throws Exception {
        byte[] data = null;
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> params = new HashMap<String, Object>();

        Connection conn = null;
        String os = System.getProperty("os.name").toLowerCase();

        try {
            params = mapper.readValue(param, Map.class);
        } catch (JsonProcessingException e){
            e.printStackTrace();
        }

        try {

            // 1. DB 접속 정보
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // 2. 단위 행 데이터 묶음
            List bundleRows = (List) params.get("datas");
            int bundleRowsLen= bundleRows.size();

            // 3. 리포트 페이지 생성 루프
            JasperPrint[][] jasperPrint = new JasperPrint[bundleRowsLen][100];
            for(int i=0; i<bundleRowsLen; i++){
                // 3-1. 단위 행 데이터
                Map<String, Object> rows = (HashMap<String, Object>) bundleRows.get(i);
                List rowsData = (List) rows.get("data");
                int rowsLen= rowsData.size();

                for(int j=0; j<rowsLen; j++){

                    // 3-1-1. 단위 행이 담고 있는 파라미터 데이터
                    Map<String, Object> paramData = (HashMap<String, Object>) rowsData.get(j);

                    // 3-1-2. file 경로 + id
                    String id = (String) paramData.get("jrl");
                    String path = id.contains("SALMA") ? "salma" : id.contains("MATMA") ? "matma" : id.contains("BUYMA") ? "buyma" : id.contains("BASMA") ? "basma" : id.contains("BARCODE") ? "barcode" : id.contains("CARMA") ? "carma" : id.contains("PROMA") ? "proma" : "";
                    String jasperPath = "";
                    File file = null;

                    if (os.contains("linux")) {
                        URL res = getClass().getClassLoader().getResource(Paths.get(File.separatorChar + "jrxml/eds/erp/"+path, File.separatorChar + id+".jrxml").toString());
                        jasperPath = res.getPath().substring(0, res.getPath().lastIndexOf("/"))+File.separatorChar;
                        file = Paths.get(res.toURI()).toFile();
                    } else {
//                        jasperPath =  new File(filePath+"jrxml/eds/erp").getCanonicalPath()+File.separatorChar+path+File.separatorChar;
                        jasperPath =  new File(filePath+"jrxml/eds/erp/").getCanonicalPath()+File.separatorChar+path+File.separatorChar;
                        file = new File(jasperPath+id+".jrxml");
                    }

                    // 3-1-3. Jasper 리포트 엔진 활성화
                    JasperReport jasperReport = JasperCompileManager.compileReport(new FileInputStream(file.getAbsolutePath()));

                    //// 3-1-4. 리포트 페이지 생성
                    Map rptData = (Map) rowsData.get(j);
                    rptData.put("SUBREPORT_DIR", jasperPath);
                    rptData.put("secretKey", aes256Util.getKey());
                    jasperPrint[i][j] = JasperFillManager.fillReport(jasperReport, rptData, conn);
                }
            }

            // 4. 리포트 페이지 병합
            for(int i=0; i<bundleRowsLen; i++){
                Map<String, Object> rows = (HashMap<String, Object>) bundleRows.get(i);
                List rowsData = (List) rows.get("data");
                int rowsLen= rowsData.size();
                for(int j=0; j<rowsLen; j++){
                    List pages = jasperPrint[i][j].getPages();
                    int pagesLen = pages.size();
                    for(int k=0;k<pagesLen;k++){
                        if(i == 0 && j == 0 ){

                        }else{
                            JRPrintPage object = (JRPrintPage) pages.get(k);
                            jasperPrint[0][0].addPage(object);
                        }
                    }
                }
            }

            data = JasperExportManager.exportReportToPdf(jasperPrint[0][0]);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=invoice.pdf");

        return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF).body(data);
    }
}
