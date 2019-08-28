package com.edu.controller;

import com.edu.pojo.Room;
import com.edu.service.impl.RoomServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomServiceImpl roomService;


    @RequestMapping("/getRoomList")
    @ResponseBody
    public List<String> getRoomList(){
        List<String> rooms = roomService.getRoomList();
        return rooms;
    }

    @RequestMapping("/roomStatue")
    @ResponseBody
    public Map<String,Object> roomStatue(){
        Map<String,Object> result = new HashMap<>();
        List<Room> rooms = roomService.getRooms();

        result.put("code",0);
        result.put("msg",null);
        result.put("count",rooms.size());
        result.put("data",rooms);

        return result;
    }


}
