package com.edu.controller;

import com.edu.pojo.Brightness;
import com.edu.pojo.Humidity;
import com.edu.pojo.Temperature;
import com.edu.service.impl.SensorServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/sensor")
public class SensorController {

    @Autowired
    private SensorServiceImpl sensorService;



    @RequestMapping("/putTemData")
    @ResponseBody
    public String putTemData(Temperature temperature){
        String msg = "上传失败";
        if(sensorService.putTemperature(temperature) == 1){
            msg = "上传成功";
        }
        return msg;
    }
    @RequestMapping("/putHumData")
    @ResponseBody
    public String putHumData(Humidity humidity){
        String msg = "上传失败";
        if(sensorService.putHumidity(humidity) == 1){
            msg = "上传成功";
        }
        return msg;
    }
    @RequestMapping("/putLightData")
    @ResponseBody
    public String putLightData(Brightness brightness){
        String msg = "上传失败";
        if(sensorService.putBright(brightness) == 1){
            msg = "上传成功";
        }
        return msg;
    }


    @RequestMapping("/getTemDataWeek")
    @ResponseBody
    public Map<String,Object> getTemDataWeek(@RequestParam("room") String room){
        Map<String,Object> map = new HashMap<>();
        List<String> times = new ArrayList<>();
        List<String> datas = new ArrayList<>();
        String msg = "";
        List<Temperature> temperatures = sensorService.getTemDataWeek(room);
        for(Temperature t:temperatures){
            times.add(t.getTime());
            datas.add(t.getData());
        }
        map.put("msg",msg);
        map.put("times",times);
        map.put("datas",datas);
        return map;
    }
    @RequestMapping("/getHumDataWeek")
    @ResponseBody
    public Map<String,Object> getHumDataWeek(@RequestParam("room") String room){
        Map<String,Object> map = new HashMap<>();
        List<String> times = new ArrayList<>();
        List<String> datas = new ArrayList<>();
        String msg = "";
        List<Humidity> humidities = sensorService.getHumDataWeek(room);
        for(Humidity t:humidities){
            times.add(t.getTime());
            datas.add(t.getData());
        }
        map.put("msg",msg);
        map.put("times",times);
        map.put("datas",datas);
        return map;
    }
    @RequestMapping("/getLightDataWeek")
    @ResponseBody
    public Map<String,Object> getLightDataWeek(@RequestParam("room") String room){
        Map<String,Object> map = new HashMap<>();
        List<String> times = new ArrayList<>();
        List<String> datas = new ArrayList<>();
        String msg = "";
        List<Brightness> brightnesses = sensorService.getLightDataWeek(room);
        for(Brightness t:brightnesses){
            times.add(t.getTime());
            datas.add(t.getData());
        }
        map.put("msg",msg);
        map.put("times",times);
        map.put("datas",datas);
        return map;
    }
}
