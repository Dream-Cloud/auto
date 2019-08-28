package com.edu.controller;


import com.edu.pojo.Student;
import com.edu.service.impl.StudentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        return "index";
    }

    @RequestMapping("/getByRoom")
    @ResponseBody
    public Map<String, Object> getByRoom(String room){
        System.out.println(room);
        Map<String, Object> result = new HashMap();
        List<Student> students= studentService.getStudentByRoom(room);
        result.put("code",0);
        result.put("msg",null);
        result.put("count",students.size());
        result.put("data",students);
        return result;

    }
    @RequestMapping("/getAll")
    @ResponseBody
    public Map<String, Object> getAll(){
        Map<String, Object> result = new HashMap();
        List<Student> students= studentService.getAll();
        result.put("code",0);
        result.put("msg",null);
        result.put("count",students.size());
        result.put("data",students);
        return result;
    }

    @RequestMapping("/add")
    @ResponseBody
    public Map<String, Object> addStudent(Student student){
        Map<String, Object> result = new HashMap();
        if(studentService.addStudent(student)){
            result.put("msg","添加成功");
        }else {
            result.put("msg","添加失败");
        }
        result.put("code",null);
        result.put("count",null);
        result.put("data",null);
        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, Object> deleteStudent(Student student){
        Map<String, Object> result = new HashMap();
        if(studentService.deleteStudent(student)){
            result.put("msg","删除成功");
        }else {
            result.put("msg","删除失败");
        }
        result.put("code",null);
        result.put("count",null);
        result.put("data",null);
        return result;
    }

    @RequestMapping("/update")
    @ResponseBody
    public Map<String, Object> updateStudent(Student student){
        Map<String, Object> result = new HashMap();
        if(studentService.updateStudent(student)){
            result.put("msg","更新成功");
        }else {
            result.put("msg","更新失败");
        }
        result.put("code",null);
        result.put("count",null);
        result.put("data",null);
        return result;
    }
}
