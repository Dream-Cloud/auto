package com.edu.controller;

import com.edu.service.impl.WebSocketServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import javax.servlet.http.HttpSession;
import java.util.Set;

@Controller("/webSocket")
public class SocketController {

    @Autowired
    private WebSocketServiceImpl webSocketService;


    @RequestMapping("/login")
    public String login(HttpSession session, String username, String password ) {
        session.setAttribute("username", username);
        Set<String> usersList  = webSocketService.usersList();
        session.setAttribute("usersList", usersList);
        Set<String> roomsList  = webSocketService.roomsList();
        session.setAttribute("usersList", roomsList);
        if (username.equals("admin")  && password.equals("123456")){
            return "index";
        }
        //System.out.println("登录接口,username="+username);

        return "success";
    }

    @RequestMapping("/messageAll")
    public @ResponseBody int sendMessageAll(String text) {
        boolean flag = webSocketService.sendMessageToAllUsers(new TextMessage(text));
        System.out.println(flag);
        if (flag){
            //成功
            return 1001;
        }else {
            //失败
            return 1002;
        }
    }

    @RequestMapping("/messageToUser")
    public @ResponseBody String sendMessageToUser(String clientId,String text) {
        boolean flag = webSocketService.sendMessageToUser(clientId,new TextMessage(text));
        System.out.println(flag);
        if (flag){
            return "";
        }else {
            return "发送";
        }
    }

}
