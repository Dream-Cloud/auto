package com.edu.service;

import com.edu.pojo.Brightness;
import com.edu.pojo.Humidity;
import com.edu.pojo.Temperature;

import java.util.List;

public interface SensorService {
//======================================================================
//                       对温度信息的操作

//    添加一条温度信息
    int putTemperature(Temperature temperature);
//    得到该宿舍一周内的温度信息
    List<Temperature> getTemDataWeek(String room);




//======================================================================
//                      对湿度信息的操作
    int putHumidity(Humidity humidity);
    List<Humidity> getHumDataWeek(String room);


//======================================================================
//                      对亮度信息的操作
    int putBright(Brightness brightness);
    List<Brightness> getLightDataWeek(String room);
}
