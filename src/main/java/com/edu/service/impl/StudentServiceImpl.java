package com.edu.service.impl;

import com.edu.mapper.StudentMapper;
import com.edu.pojo.Student;
import com.edu.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;


    @Override
    public Student getStudent(String number, String password) {
        if (!number.equals("") && !password.equals("")){
            return studentMapper.getStudent(number,password);
        }
        return null;
    }

    @Override
    public List<Student> getStudentByRoom(String room) {
        return studentMapper.selectByRoom(room);
    }

    @Override
    public List<Student> getAll() {
        return studentMapper.getAll();
    }

    @Override
    public boolean addStudent(Student student) {
        int row = studentMapper.addStudent(student);
        return row == 1 ? true:false;
    }

    @Override
    public boolean deleteStudent(Student student) {
        return studentMapper.deleteStudent(student) == 1 ? true:false;
    }

    @Override
    public boolean updateStudent(Student student) {
        return studentMapper.updateStudent(student) == 1 ? true:false;
    }
}
