package com.edu.service;

import org.springframework.web.socket.TextMessage;

import java.util.Set;

public interface WebSocketService {
    //连接的数量
    int usersSize();
    int roomsSize();
    //连接的内容
    Set<String> usersList();
    Set<String> roomsList();
//    发送消息给指定用户
    String sendMessageToUser(String clientId, TextMessage message);
//    发送消息给全部用户
    boolean sendMessageToAllUsers(TextMessage message);
    //    发送指令给指定宿舍
    String sendMessageToRoom(String roomId, TextMessage message);
    //    发送指令给全部宿舍
    boolean sendMessageToAllRooms(TextMessage message);

}
