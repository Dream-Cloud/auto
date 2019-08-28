package com.edu.mapper;

import com.edu.pojo.Brightness;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BrightnessMapper {
    //获得对应宿舍的最新亮度
    String getNewBri(@Param(value="room")String room);
    //得到对应宿舍的亮度记录
    List<Brightness> getAllBrightByRoom(@Param(value="room") String room);
    //添加亮度
    int addBright(Brightness brightness);

    List<Brightness> getDataByRoom(@Param(value="room") String room, @Param(value="start")String start, @Param(value="end")String end);
}
