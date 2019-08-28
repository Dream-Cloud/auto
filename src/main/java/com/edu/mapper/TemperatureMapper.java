package com.edu.mapper;

import com.edu.pojo.Temperature;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TemperatureMapper {
    //获得对应宿舍的最新温度
    String getNewTem(@Param(value="room") String room);
    //得到对应宿舍的温度记录
    List<Temperature> getAllByRoom(@Param(value="room") String room);
    //添加温度
    int addTem(Temperature temperature);

//    原符号       <        <=      >       >=       &        '        "
//    替换符号    &lt;    &lt;=   &gt;    &gt;=   &amp;   &apos;  &quot;
//    得到一个礼拜内的数据
    List<Temperature> getDataByRoom(@Param(value="room")String room, @Param(value="start")String start, @Param(value="end")String end);
}
