package com.springboot.myapp.eds.messages.controller.send;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpRequest.BodyPublishers;
import java.net.http.HttpResponse.BodyHandlers;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller
public class sendController {

    public void sendKakaoworkMessage(Map<String, Object> map) throws Exception {
        System.out.println(map);
        String accessToken = "a3a88143.836ea5cf068c4e5895c651477a890c80";
        String url = "https://api.kakaowork.com/v1/messages.send_by_email"; // 실제 엔드포인트 URL로 변경해야 합니다.
        String miribogi = ""; // 미리보기
        String header = ""; // 문서제목
        /*
        * stateDivi -> 01: 메세지, 03: 결제요청, 04: 수신참조,
        *              05: 활동내역, 07: 코멘트내역,
        *              08: 발주요청, 09: 발주승인, 10: 발주반려,
        *              11: 견적요청, 12: 견적승인, 13: 견적반려,
        * */
        // stateDivi -> 01: 메세지, 03: 결제요청, 04: 수신참조, 05: 활동내역, 07: 코멘트내역, 08: 발주요청, 09: 발주승인, 10: 발주반려
        switch (map.get("stateDivi").toString()){
            case "01" -> {
                map.put("stateDivi","메세지");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "가 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "03" -> {
                map.put("stateDivi","결재요청");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "04" -> {
                map.put("stateDivi","수신참조");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "가 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "05" -> {
                map.put("stateDivi","활동내역");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "06" -> {
                map.put("stateDivi","결재반려");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "가 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "07" -> {
                map.put("stateDivi","코멘트내역");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "08" -> {
                map.put("stateDivi","발주요청");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "09" -> {
                map.put("stateDivi","발주승인");
                miribogi = "요청한 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "10" -> {
                map.put("stateDivi","발주반려");
                miribogi = "요청한 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "11" -> {
                map.put("stateDivi","견적요청");
                miribogi = "새로운 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "12" -> {
                map.put("stateDivi","견적승인");
                miribogi = "요청한 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
            case "13" -> {
                map.put("stateDivi","견적반려");
                miribogi = "요청한 " + map.get("stateDivi").toString() + "이 도착했습니다."; // 미리보기
                header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
                break;
            }
        }
        // stateDivi -> ??: 결재완료 처리
        if(map.get("navMessage").toString().contains("결재완료")){
            map.put("stateDivi","결재완료");
            miribogi = "새로운 " + map.get("stateDivi").toString() + "가 도착했습니다."; // 미리보기
            header = map.get("stateDivi").toString() + " 도착!"; // 문서제목
        }
//        String miribogi = "EPR에 새로운 메세지가 도착했습니다."; // 미리보기
        String email = map.get("balsinEmail").toString();
//        String header = "EPR 메세지 도착!"; // 문서제목
        String content = map.get("navMessage").toString(); // 내용
        // 한국 시간대 설정
        ZoneId seoulZoneId = ZoneId.of("Asia/Seoul");

        // 현재 시간을 한국 시간대로 가져오기
        ZonedDateTime nowInSeoul = ZonedDateTime.now(seoulZoneId);

        // 원하는 형식으로 시간 포맷 설정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // 형식에 맞게 시간을 문자열로 변환
        String formattedString = nowInSeoul.format(formatter);

        String dt = formattedString; // 일시
        String susin = "["+map.get("susinEmpNm").toString()+"]"+map.get("susinDepaNm").toString(); // 수신
        String balsin = "["+map.get("balsinEmpNm").toString()+"]"+map.get("balsinDepaNm").toString(); // 발신
        System.out.println("여기니");
        System.out.println(map.get("stateDivi").toString());
        System.out.println(miribogi);
        System.out.println(header);
        System.out.println(dt);
        System.out.println(susin);
        System.out.println(balsin);
        System.out.println(content);
        String jsonPayload =
                "{\"email\": \""+email+"\"," +
                        " \"text\": \""+miribogi+"\","+
                        " \"blocks\": ["+
                        "{"+
                        "    \"type\": \"header\","+
                        "    \"text\": \""+header+"\","+
                        "    \"style\": \"white\""+
                        "},"+
                        "{"+
                        "    \"type\": \"description\","+
                        "    \"term\": \"일시\","+
                        "    \"content\": {"+
                        "                \"type\": \"text\","+
                        "                \"text\": \""+dt+"\""+
                        "    },"+
                        "    \"accent\": true"+
                        "},"+
                        "{"+
                        "    \"type\": \"description\","+
                        "    \"term\": \"수신\","+
                        "    \"content\": {"+
                        "                \"type\": \"text\","+
                        "                \"text\": \""+susin+"\""+
                        "    },"+
                        "    \"accent\": true"+
                        "},"+
                        "{"+
                        "    \"type\": \"description\","+
                        "    \"term\": \"발신\","+
                        "    \"content\": {"+
                        "                \"type\": \"text\","+
                        "                \"text\": \""+balsin+"\""+
                        "    },"+
                        "    \"accent\": true"+
                        "},"+
                        "{"+
                        "    \"type\": \"description\","+
                        "    \"term\": \"내용\","+
                        "    \"content\": {"+
                        "                \"type\": \"text\","+
                        "                \"text\": \""+content+"\""+
                        "    },"+
                        "    \"accent\": true"+
                        "}"+
                        "]}";

        System.out.println(jsonPayload);
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("Authorization", "Bearer " + accessToken)
                .header("Content-Type", "application/json")
                .POST(BodyPublishers.ofString(jsonPayload))
                .build();

        HttpResponse<String> response = client.send(request, BodyHandlers.ofString());

        System.out.println(response.statusCode());
        System.out.println(response.body());
    }

    // 전직원 공지사항 알림
    @RequestMapping("/sendController/noticeAllEmployee")
    @ResponseBody
    public void noticeAllEmployee(@RequestBody Map<String, Object> map) throws Exception {
        // 카카오워크 액세스 토큰
        String accessToken = "445c8fb1.7962b3737a9f4f1f95820e1caac2c49f";

        // 카카오워크 API 엔드포인트 URL
        String url = "https://api.kakaowork.com/v1/messages.send_by_email";

        String divi = (String) map.get("divi");
        String preview = "[" + divi + "]" + "새로운 공지사항이 등록 되었습니다.";
        String writer = (String) map.get("writer");
        String date = (String) map.get("date");
        String title = (String) map.get("title");
        String postNum = (String) map.get("postNum");
        List<String> userEmailList = (List<String>) map.get("userEmail");

        if (userEmailList != null && !userEmailList.isEmpty()) {
            for (String email : userEmailList) {
                String text =
                        "{\"email\": \""+email+"\"," +
                                "  \"text\": \""+preview+"\",\n" +
                                "    \"blocks\": [\n" +
                                "    {\n" +
                                "      \"type\": \"text\",\n" +
                                "      \"text\": \""+preview+"\",\n" +
                                "      \"inlines\": [\n" +
                                "        {\n" +
                                "          \"type\": \"styled\",\n" +
                                "          \"text\": \""+preview+"\",\n" +
                                "          \"bold\": true\n" +
                                "        }\n" +
                                "      ]\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"divider\"\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"분류\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+divi+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"일시\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+date+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"발신\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+writer+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"제목\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+title+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"글번호\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+postNum+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    }\n" +
                                "  ]\n" +
                                "}";

                // 헤더 설정
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.APPLICATION_JSON);
                headers.set("Authorization", "Bearer " + accessToken);

                // 요청 바디 설정
                String requestBody = text;

                // HTTP 요청 보내기
                RestTemplate restTemplate = new RestTemplate();
                try {
                    ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.POST, new HttpEntity<>(requestBody, headers), String.class);
                    System.out.println("responseEntity: " + responseEntity);
                    // 응답 처리
                    if (responseEntity.getStatusCode() == HttpStatus.OK) {
                        System.out.println("메시지 전송 성공");
                    } else {
                        System.out.println("메시지 전송 실패");
                    }
                } catch (HttpClientErrorException e) {
                    System.out.println("HTTP 요청 실패: " + e.getRawStatusCode() + " - " + e.getResponseBodyAsString());
                } catch (Exception e) {
                    System.out.println("예외 발생: " + e.getMessage());
                }
            }
        }
    }

    @ResponseBody
    public void noticeComment(@RequestBody Map<String, Object> map) throws Exception {
        // 카카오워크 액세스 토큰
        String accessToken = "445c8fb1.7962b3737a9f4f1f95820e1caac2c49f";

        // 카카오워크 API 엔드포인트 URL
        String url = "https://api.kakaowork.com/v1/messages.send_by_email";

        String preview = "새로운 코멘트가 등록 되었습니다.";
        String postNum = (String) map.get("postNum");
        String writer = (String) map.get("writer");
        String date = (String) map.get("date");
        String title = (String) map.get("title");
        String content = map.get("content").toString();
        List<String> userEmailList = (List<String>) map.get("userEmail");

        if (userEmailList != null && !userEmailList.isEmpty()) {
            for (String email : userEmailList) {
                String text =
                        "{\"email\": \""+email+"\"," +
                                "  \"text\": \""+preview+"\",\n" +
                                "    \"blocks\": [\n" +
                                "    {\n" +
                                "      \"type\": \"text\",\n" +
                                "      \"text\": \""+preview+"\",\n" +
                                "      \"inlines\": [\n" +
                                "        {\n" +
                                "          \"type\": \"styled\",\n" +
                                "          \"text\": \""+preview+"\",\n" +
                                "          \"bold\": true\n" +
                                "        }\n" +
                                "      ]\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"divider\"\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"일시\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+date+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"발신\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+writer+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"제목\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+title+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"글번호\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+postNum+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    },\n" +
                                "    {\n" +
                                "      \"type\": \"description\",\n" +
                                "      \"term\": \"내용\",\n" +
                                "      \"content\": {\n" +
                                "        \"type\": \"text\",\n" +
                                "        \"text\": \""+content+"\"\n" +
                                "      },\n" +
                                "      \"accent\": true\n" +
                                "    }\n" +
                                "  ]\n" +
                                "}";

                // 헤더 설정
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.APPLICATION_JSON);
                headers.set("Authorization", "Bearer " + accessToken);

                // 요청 바디 설정
                String requestBody = text;

                // HTTP 요청 보내기
                RestTemplate restTemplate = new RestTemplate();
                try {
                    ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.POST, new HttpEntity<>(requestBody, headers), String.class);
                    System.out.println("responseEntity: " + responseEntity);
                    // 응답 처리
                    if (responseEntity.getStatusCode() == HttpStatus.OK) {
                        System.out.println("메시지 전송 성공");
                    } else {
                        System.out.println("메시지 전송 실패");
                    }
                } catch (HttpClientErrorException e) {
                    System.out.println("HTTP 요청 실패: " + e.getRawStatusCode() + " - " + e.getResponseBodyAsString());
                } catch (Exception e) {
                    System.out.println("예외 발생: " + e.getMessage());
                }
            }
        }
    }


}
