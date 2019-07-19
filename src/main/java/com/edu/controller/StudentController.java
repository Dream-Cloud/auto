package com.edu.controller;


import com.edu.service.impl.StudentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/student")
public class StudentController {
    @Autowired
    private StudentServiceImpl studentService;


    @RequestMapping("/login")
    public String login(String number,String password){
        if(number != null && password != null){
            if(studentService.getStudent(number,password) != null){
                return "success";
            }
        }
        return "success";
    }
}
