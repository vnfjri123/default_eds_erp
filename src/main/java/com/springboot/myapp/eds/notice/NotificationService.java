package com.springboot.myapp.eds.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {

    @Autowired
    private NotificationController notificationController;

    public void sendNotification(String clientId,String message) {
        
        notificationController.sendNotification(clientId,message);
    }

}