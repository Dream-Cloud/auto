package com.edu.mapper;

import com.edu.pojo.Humidity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface HumidityMapper {
    //获得对应宿舍的最新湿度
    String getNewHum(@Param(value="room")String room);
    //得到对应宿舍的湿度记录
    List<Humidity> getAllHumidityByRoom(@Param(value="room")String room);
    //添加湿度
    int addHumidity(Humidity humidity);

    List<Humidity> getDataByRoom(@Param(value="room") String room, @Param(value="start")String start, @Param(value="end")String end);
}
