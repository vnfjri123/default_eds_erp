package com.springboot.myapp.util;

import jakarta.servlet.http.HttpSession;

import com.springboot.myapp.eds.erp.vo.base.baseUserListVO;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SessionUtil {
    public static baseUserListVO getUser(){
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession httpSession = servletRequestAttributes.getRequest().getSession(true);

        return (baseUserListVO) httpSession.getAttribute("LoginInfo");
    }
}
