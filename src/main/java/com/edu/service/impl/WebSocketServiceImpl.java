package com.edu.service.impl;


import com.edu.service.WebSocketService;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Service("webSocket")
public class WebSocketServiceImpl extends TextWebSocketHandler implements WebSocketService{
    //在线用户列表
    private static final Map<String, WebSocketSession> users;
    private static final Map<String, WebSocketSession> rooms;
    //用户标识
    private static final String CLIENT_ID = "username";
    private static final String ROOM_ID = "room";

    static {
        users = new HashMap<>();
        rooms = new HashMap<>();
    }

    @Override
    public int usersSize(){
        return users.size();
    }
    @Override
    public int roomsSize(){
        return rooms.size();
    }
    @Override
    public Set<String> usersList(){

        return users.keySet();
    }
    @Override
    public Set<String> roomsList(){

        return rooms.keySet();
    }
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("===========================================");
        String username = getClientId(session);
        String room = getRoomId(session);
        if (username != null) {
            users.put(username, session);
            session.sendMessage(new TextMessage("用户成功建立socket连接"));
            System.out.println("当前连接用户:"+username+"连接成功");
            System.out.println("     "+session);
        }else if (room != null){
            rooms.put(room,session);
            session.sendMessage(new TextMessage("宿舍成功建立socket连接"));
            System.out.println("当前连接用户:"+room+"连接成功");
            System.out.println("     "+session);
        }
        System.out.println("用户webSocket连接列表:"+ usersList());
        System.out.println("用户webSocket连接数量:"+ users.size());
        System.out.println("宿舍webSocket连接列表:"+ roomsList());
        System.out.println("宿舍webSocket连接数量:"+ rooms.size());
        System.out.println("===========================================");
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        System.out.println("===========================================");
        String username = getClientId(session);
        String room = getRoomId(session);
        if (username != null) {
            System.out.print("收到用户:"+username+"的消息: ");
        }else if (room != null){
            System.out.print("收到用户:"+room+"的消息: ");
        }

        System.out.println(message.getPayload());
        System.out.println("===========================================");

    }

    /**
     * 发送信息给指定用户
     * @param clientId
     * @param message
     * @return
     */
    @Override
    public String sendMessageToUser(String clientId, TextMessage message) {
        if (users.get(clientId) == null) {
            System.out.println(clientId+"该用户未连接");
            return "该用户未连接";
        }
        WebSocketSession session = users.get(clientId);
        System.out.println("sendMessage:" + session);
        if (!session.isOpen()) {
            System.out.println("会话已关闭");
            return "会话已关闭";
        }
        try {
            session.sendMessage(message);
        } catch (IOException e) {
            System.out.println(e);
            return "未知错误,发送失败";
        }
        return "发送成功";
    }

    /**
     * 广播信息
     * @param message
     * @return
     */
    @Override
    public boolean sendMessageToAllUsers(TextMessage message) {
        boolean allSendSuccess = true;
        Set<String> clientIds = users.keySet();
        WebSocketSession session = null;
        for (String clientId : clientIds) {
            try {
                session = users.get(clientId);
                if (session.isOpen()) {
                    session.sendMessage(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
                allSendSuccess = false;
            }
        }

        return  allSendSuccess;
    }

    @Override
    public String sendMessageToRoom(String roomId, TextMessage message) {
        if (rooms.get(roomId) == null) {
            System.out.println(roomId+"该宿舍未连接");
            return "该宿舍未连接";
        }
        WebSocketSession session = rooms.get(roomId);
        System.out.println("sendMessage:" + session);
        if (!session.isOpen()) {
            System.out.println("会话已关闭");
            return "会话已关闭";
        }
        try {
            session.sendMessage(message);
        } catch (IOException e) {
            System.out.println(e);
            return "未知错误,发送失败";
        }
        return "发送成功";
    }

    @Override
    public boolean sendMessageToAllRooms(TextMessage message) {
        Set<String> roomIds = rooms.keySet();
        boolean sendSuccess = true;
        WebSocketSession session = null;
        for (String roomId : roomIds) {
            try {
                session = rooms.get(roomId);
                if (session.isOpen()) {
                    session.sendMessage(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
                sendSuccess = false;
            }
        }

        return  sendSuccess;
    }


    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            session.close();
        }
        System.out.println("连接出错");
        users.remove(getClientId(session));
        rooms.remove(getRoomId(session));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        System.out.println("===========================================");
        String username = getClientId(session);
        String room = getRoomId(session);
        if (username != null) {
            System.out.println("用户:" + username + "连接关闭");
            System.out.println(status);
            users.remove(getClientId(session));
        }
        if (room != null) {
            System.out.println("宿舍:" + room + "连接关闭");
            System.out.println(status);
            rooms.remove(getRoomId(session));
        }
        System.out.println("===========================================");
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 获取用户标识
     * @param session
     * @return
     */
    private String getClientId(WebSocketSession session) {
        try {
            String clientId = (String) session.getAttributes().get(CLIENT_ID);
            return clientId;
        } catch (Exception e) {
            return null;
        }
    }
    private String getRoomId(WebSocketSession session) {
        try {
            String roomId = (String) session.getAttributes().get(ROOM_ID);
            return roomId;
        } catch (Exception e) {
            return null;
        }
    }

}



