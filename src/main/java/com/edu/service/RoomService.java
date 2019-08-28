package com.edu.service;

import com.edu.pojo.Room;

import java.util.List;

public interface RoomService {
    //得到数据库中都有那些宿舍
    List<String> getRoomList();
//    得到一个宿舍的基本信息
    Room getRoom(String room);
//    得到所有宿舍的基本信息
    List<Room> getRooms();
}
