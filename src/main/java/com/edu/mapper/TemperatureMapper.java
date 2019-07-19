package com.edu.mapper;

import com.edu.pojo.Temperature;

import java.util.List;

public interface TemperatureMapper {
    //获得对应宿舍的最新温度
    Temperature getTem(String room);
    //得到对应宿舍的温度记录
    List<Temperature> getAllByRoom(String room);
    //添加温度
    int addTem(Temperature temperature);
}
