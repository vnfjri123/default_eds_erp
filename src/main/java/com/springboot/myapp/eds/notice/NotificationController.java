package com.springboot.myapp.eds.notice;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.springboot.myapp.eds.erp.controller.login.LOGINController;



import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@RestController
public class NotificationController {

    private final static Map<String, SseEmitter> emitters = new ConcurrentHashMap<>();
    private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60;
    @GetMapping("/notifications/{clientId}")
    public SseEmitter notifications(@PathVariable String clientId,HttpServletRequest request) throws Exception {
        SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
        try {
			// 세션정보가 없을경우  false
			if(request.getSession().getAttribute("LoginInfo") == null){
                throw new Exception("no session");
			}
			// 세션정보가 있고 root 접속시
			else{
                emitter.onCompletion(() -> {emitters.remove(clientId);System.out.println("onCompletion");});
                emitter.onTimeout(() -> {emitter.complete();});  

                System.out.println("===이미터확인===");
                System.out.println(emitters);
                emitters.put(request.getSession().getId(), emitter);
                System.out.println(request.getSession().getMaxInactiveInterval());
                    // 처음 연결시 더미 데이터 전송
                try {
                    emitter.send(SseEmitter.event()
                    .name("connect")
                    .data("connected!"));
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
			}
		} catch (Exception e) {
			e.printStackTrace();
           if(e.getMessage()=="no session")//세션없을시 보냄
           {
                try {  
                emitter.send(SseEmitter.event()  
                            .name("reset")  
                            .data("/LOGIN_VIEW"));  
                } catch (IOException ex) {  
                    throw new RuntimeException(ex);  
                }
           }
           emitter.complete();
           emitters.remove(clientId);   
		}
        return emitter;

    }

    public void sendNotification(String clientId, String message) {
        //ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        //HttpSession httpSession = servletRequestAttributes.getRequest().getSession(true);
        //접속되어 있는 아이디중 권한에 따라 SEND 분류하여 보내
        System.out.println("---------알림보내기-------");
        for( String key :  LOGINController.loginUsers.keySet() ){
            System.out.println(LOGINController.loginUsers);
            String loginId= LOGINController.loginUsers.get(key).toString();
            System.out.println("---------이미터정보-------");
            System.out.println( String.format("접속유저정보 키 : %s, 값 : %s", key,  loginId) );
            SseEmitter emitter = emitters.get(key);
            System.out.println(emitter);
             if (emitter != null&&loginId.equals(clientId)) {//로그인된 사용자에게만 알람전달
                try {
                    emitter.send(SseEmitter.event()
                            .name("notification")
                            .data(message));
                             System.out.println("Check세션 id:"+key+"----알람전송성공-------");
                } catch (IOException e) {
                    System.out.println("Check세션 id:"+key+"----알람전송실패-------");
                    System.out.println("사유:"+e);
                    emitter.complete();
                    emitters.remove(key);   
                }
            }
        }
    }
    
     public void closeEmitters(String key) {    
        System.out.println(emitters);
        SseEmitter emitter = emitters.get(key);
        System.out.println("Check세션 id:"+key+"----이미터삭제-------");
         if (emitter != null)
        {
            System.out.println("Check세션 id:"+key+"----삭제성공-------");
            emitter.complete();
            emitters.remove(key);
             System.out.println("Check세션 id:"+key+"----이미터삭제성공-------");
        }
        System.out.println(emitters);
    }
}