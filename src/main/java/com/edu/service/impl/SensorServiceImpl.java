package com.edu.service.impl;

import com.edu.mapper.BrightnessMapper;
import com.edu.mapper.HumidityMapper;
import com.edu.mapper.TemperatureMapper;
import com.edu.pojo.Brightness;
import com.edu.pojo.Humidity;
import com.edu.pojo.Temperature;
import com.edu.service.SensorService;
import com.edu.utils.MyDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("Sensor")
public class SensorServiceImpl implements SensorService {
    @Autowired
    private TemperatureMapper temperatureMapper;
    @Autowired
    private BrightnessMapper brightnessMapper;
    @Autowired
    private HumidityMapper humidityMapper;




    @Override
    public int putHumidity(Humidity humidity) {
        return humidityMapper.addHumidity(humidity);
    }

    @Override
    public List<Humidity> getHumDataWeek(String room) {
        String start = MyDate.now();//现在的时间
        String end = MyDate.weekAgo();//一个礼拜前

        List<Humidity> humidities = humidityMapper.getDataByRoom(room,start,end);
        return humidities;
    }

    @Override
    public int putBright(Brightness brightness) {
        return brightnessMapper.addBright(brightness);
    }

    @Override
    public List<Brightness> getLightDataWeek(String room) {
        String start = MyDate.now();//现在的时间
        String end = MyDate.weekAgo();//一个礼拜前

        List<Brightness> brightnesses = brightnessMapper.getDataByRoom(room,start,end);
        return brightnesses;
    }

    @Override
    public int putTemperature(Temperature temperature) {
        return temperatureMapper.addTem(temperature);
    }
    @Override
    public List<Temperature> getTemDataWeek(String room) {
        String start = MyDate.now();//现在的时间
        String end = MyDate.weekAgo();//一个礼拜前

        List<Temperature> temperatures = temperatureMapper.getDataByRoom(room,start,end);
        return temperatures;
    }
}
