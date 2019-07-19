package com.edu.mapper;

import com.edu.pojo.Student;

import java.util.List;

public interface StudentMapper {
    //根据学生bean添加学生
    int addStudent(Student student);
    //根据学生bean删除学生
    int deleteStudent(Student student);
//    更新学生信息
    int updateStudent(Student student);
//根据账号密码查询 用于登录系统
    Student getStudent(String number,String password);
//    获得宿舍的全体成员
    List<Student> selectByRoom(String room);
//    得到所有学生
    List<Student> getAll();
}
