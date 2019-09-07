package com.edu.controller;

import com.edu.pojo.Room;
import com.edu.service.impl.RoomServiceImpl;
import com.edu.utils.Control;
import com.edu.utils.GetJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    @RequestMapping("/controlOn")
    @ResponseBody
    public String controlOn(@RequestParam int control,@RequestParam int s){
        int result = control+s;
        return Control.on(result);
    }

    @RequestMapping("/controlOff")
    @ResponseBody
    public String controlOff(@RequestParam int control,@RequestParam int s){
        int result = s - control;
        return Control.off(result);
    }

    @RequestMapping("/gets")
    @ResponseBody
    public Map<String,Object> gets(){
        Map result = new HashMap();
        GetJson getJson = new GetJson();

        String s = (String) getJson.getControl().getData();
        System.out.println(s);
        String ts = "关闭";
        String hs = "关闭";
        String ls = "关闭";
        switch (s){
            case "01":
                ts = "开启";
                hs = "关闭";
                ls = "关闭";
                break;
            case "02":
                ts = "关闭";
                hs = "开启";
                ls = "关闭";
                break;
            case "03":
                ts = "开启";
                hs = "开启";
                ls = "关闭";
                break;
            case "04":
                ts = "关闭";
                hs = "关闭";
                ls = "开启";
                break;
            case "05":
                ts = "开启";
                hs = "关闭";
                ls = "开启";
                break;
            case "06":
                ts = "关闭";
                hs = "开启";
                ls = "开启";
                break;
            case "07":
                ts = "开启";
                hs = "开启";
                ls = "开启";
                break;
        }
        result.put("ts",ts);
        result.put("hs",hs);
        result.put("ls",ls);
        return result;
    }
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
