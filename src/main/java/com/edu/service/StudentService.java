package com.edu.service;


import com.edu.pojo.Student;

import java.util.List;

public interface StudentService {
//  通过账号密码得到用户基本信息 用于验证登录
    Student getStudent(String number,String password);
//  得到这个宿舍里的所有学生的基本信息
    List<Student> getStudentByRoom(String room);
//  得到所有学生的基本信息
    List<Student> getAll();
//  添加一名学生的基本信息
    boolean addStudent(Student student);
//  删除一名学生的基本信息
    boolean deleteStudent(Student student);
//  修改一名学生的基本信息
    boolean updateStudent(Student student);
}
