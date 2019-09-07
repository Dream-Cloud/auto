package com.edu.controller;

import com.edu.pojo.Brightness;
import com.edu.pojo.Humidity;
import com.edu.pojo.Temperature;
import com.edu.service.impl.SensorServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Controller("debug")
@RequestMapping("/debug")
public class DebugController {


    @Autowired
    SensorServiceImpl sensorService;



    @RequestMapping("/generateWeekTem")
    @ResponseBody
    public String test(String room){
        String msg = "上传失败";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR,-7);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Random rand = new Random();
        DecimalFormat df=new DecimalFormat("#.00");
        double t = 20;

        for (int i = 0;i<=3024;i++){

            Temperature temperature = new Temperature();
            temperature.setRoom(room);
            temperature.setData(df.format(t+rand.nextDouble()*10));
            temperature.setTime(sdf.format(calendar.getTime()));
            sensorService.putTemperature(temperature);
            calendar.add(Calendar.MINUTE,10);
        }
        return msg;
    }
    @RequestMapping("/generateWeekHum")
    @ResponseBody
    public String test2(String room){
        String msg = "上传失败";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR,-7);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Random rand = new Random();
        DecimalFormat df=new DecimalFormat("#.00");
        double t = 60;
        for (int i = 0;i<=3024;i++){
            Humidity humidity = new Humidity();
            humidity.setRoom(room);
            humidity.setData(df.format(t+rand.nextDouble()*10));
            humidity.setTime(sdf.format(calendar.getTime()));
            sensorService.putHumidity(humidity);
            calendar.add(Calendar.MINUTE,10);
        }
        return msg;
    }
    @RequestMapping("/generateWeekLight")
    @ResponseBody
    public String test3(String room){
        String msg = "上传失败";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR,-7);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Random rand = new Random();
        DecimalFormat df=new DecimalFormat("#.00");
        double t = 10;
        for (int i = 0;i<=3024;i++){
            Brightness brightness = new Brightness();
            brightness.setRoom(room);
            brightness.setData(df.format(t+rand.nextDouble()*10));
            brightness.setTime(sdf.format(calendar.getTime()));
            sensorService.putBright(brightness);
            calendar.add(Calendar.MINUTE,10);
        }
        return msg;
    }
}
