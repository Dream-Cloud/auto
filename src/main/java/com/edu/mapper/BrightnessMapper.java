package com.edu.mapper;

import com.edu.pojo.Brightness;

import java.util.List;

public interface BrightnessMapper {
    //获得对应宿舍的最新亮度
    Brightness getBright(String room);
    //得到对应宿舍的亮度记录
    List<Brightness> getAllBrightByRoom(String room);
    //添加亮度
    int addBright(Brightness brightness);
}
