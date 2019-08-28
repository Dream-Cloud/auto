package com.edu.mapper;

import com.edu.pojo.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentMapper {
    //根据学生bean添加学生
    int addStudent(Student student);
    //根据学生bean删除学生
    int deleteStudent(Student student);
//    更新学生信息
    int updateStudent(Student student);
//根据账号密码查询 用于登录系统
    Student getStudent(@Param(value="number")String number,@Param(value="password")String password);
//    获得宿舍的全体成员
    List<Student> selectByRoom(@Param(value="room") String room);
//    得到所有学生
    List<Student> getAll();

    List<String> getRoomList();
}
