package com.edu.service.impl;

import com.edu.mapper.BrightnessMapper;
import com.edu.mapper.HumidityMapper;
import com.edu.mapper.StudentMapper;
import com.edu.mapper.TemperatureMapper;
import com.edu.pojo.Room;
import com.edu.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("room")
public class RoomServiceImpl implements RoomService {

    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private TemperatureMapper temperatureMapper;
    @Autowired
    private BrightnessMapper brightnessMapper;
    @Autowired
    private HumidityMapper humidityMapper;

    @Override
    public List<String> getRoomList() {
        return studentMapper.getRoomList();
    }

    @Override
    public Room getRoom(String room) {
        Room room1 = new Room();
        room1.setRoom(room);
        room1.setTemperature(temperatureMapper.getNewTem(room));
        room1.setBrightness(brightnessMapper.getNewBri(room));
        room1.setHumidity(humidityMapper.getNewHum(room));
        return room1;
    }

    @Override
    public List<Room> getRooms() {
        List<String> roomList = getRoomList();
        List<Room> rooms = new ArrayList<>();
        for(String room:roomList){
            rooms.add(getRoom(room)) ;
        }
        return rooms;
    }
}
