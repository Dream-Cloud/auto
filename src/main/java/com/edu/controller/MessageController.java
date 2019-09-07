package com.edu.controller;

import com.edu.service.impl.WebSocketServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Controller("/webSocket")
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private WebSocketServiceImpl webSocketService;

    @RequestMapping("/getUsersList")
    public  @ResponseBody Set<String> getUsersList(){
        Set<String> usersList  = webSocketService.usersList();
        return usersList;
    }

    @RequestMapping("/getRoomsList")
    public  @ResponseBody Set<String> getRoomsList(){
        Set<String> roomsList  = webSocketService.roomsList();
        return roomsList;
    }


    @RequestMapping("/messageAllUser")
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
    public @ResponseBody
    Map<String, Object> sendMessageToUser(String number, String text) {
        Map<String, Object> result = new HashMap();
        String flag = webSocketService.sendMessageToUser(number,new TextMessage(text));

        result.put("flag", flag);
        return result;
    }

}
