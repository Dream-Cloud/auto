package com.edu.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;


public class MyDate {


    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    static public String now(){
        Calendar calendar = Calendar.getInstance();
        return sdf.format(calendar.getTime());
    }

    public static String weekAgo() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_YEAR,-1);
        return sdf.format(calendar.getTime());
    }
}
