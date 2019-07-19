package com.edu.mapper;

import com.edu.pojo.Humidity;

import java.util.List;

public interface HumidityMapper {
    //获得对应宿舍的最新湿度
    Humidity getHumidity(String room);
    //得到对应宿舍的湿度记录
    List<Humidity> getAllHumidityByRoom(String room);
    //添加湿度
    int addHumidity(Humidity humidity);
}
