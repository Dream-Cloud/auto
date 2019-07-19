package com.edu.service.impl;

import com.edu.mapper.StudentMapper;
import com.edu.pojo.Student;
import com.edu.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
