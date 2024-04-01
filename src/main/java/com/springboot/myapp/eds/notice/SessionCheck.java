package com.springboot.myapp.eds.notice;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springboot.myapp.eds.erp.controller.login.LOGINController;

import jakarta.servlet.annotation.WebListener;

import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class SessionCheck implements HttpSessionListener{
    private int userCount;

    private NotificationController notificationController=new NotificationController();

    public void sessionCreated(HttpSessionEvent se)  {
        System.out.printf("생성된 SESSIONID %s \n",  se.getSession().getId());
    }

	@ResponseBody
    public void sessionDestroyed(HttpSessionEvent se)  {

        System.out.println("Check세션 id:"+se.getSession().getId()+"----세션삭제-------");

        System.out.println("Check세션 id:"+se.getSession().getId()+"----세션삭제성공-------");
        System.out.printf("제거된 SESSIONID %s \n",  se.getSession().getId());
        notificationController.closeEmitters(se.getSession().getId());

    }



}
