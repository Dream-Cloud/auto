package com.edu.controller;


import com.edu.pojo.Student;
import com.edu.service.impl.StudentServiceImpl;
import com.edu.service.impl.WebSocketServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/student")
public class StudentController {


    @Autowired
    private StudentServiceImpl studentService;
    @Autowired
    private WebSocketServiceImpl webSocketService;


    @RequestMapping("/login")
    public String login(HttpSession session, String username, String password ) {
        session.setAttribute("username", username);
        if (username != null && password != null) {
            if (username.equals("admin") && password.equals("123456")) {
                return "index";
            } else if (studentService.getStudent(username, password) != null) {
                    return "success";
                }

        }
        return "forward:/login";
    }

    @RequestMapping("/getByRoom")
    @ResponseBody
    public Map<String, Object> getByRoom(String room){
        Map<String, Object> result = new HashMap();
        List<Student> students= studentService.getStudentByRoom(room);
        result.put("code", 0);
        result.put("msg", null);
        result.put("count", students.size());
        result.put("data", students);
        return result;

    }
    @RequestMapping("/getAll")
    @ResponseBody
    public Map<String, Object> getAll(){
        Map<String, Object> result = new HashMap();
        List<Student> students= studentService.getAll();

        result.put("code", 0);
        result.put("msg", null);
        result.put("count", students.size());
        result.put("data", students);
        return result;
    }

    @RequestMapping("/add")
    @ResponseBody
    public Map<String, Object> addStudent(Student student){
        Map<String, Object> result = new HashMap();
        int code;
        String msg;
        if(studentService.addStudent(student)){
            code = 0;
            msg = "添加成功";
        }else {
            code = 1;
            msg = "添加失败";
        }
        result.put("code", code);
        result.put("count", msg);
        result.put("data", null);
        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, Object> deleteStudent(Student student){
        Map<String, Object> result = new HashMap();
        String msg;
        int code;
        if(studentService.deleteStudent(student)){
            code = 211;
            msg = "删除成功";
        }else {
            code = 210;
            msg = "删除失败";
        }
        result.put("code", code);
        result.put("msg", msg);
        result.put("count", null);
        result.put("data", null);
        return result;
    }

    @RequestMapping("/update")
    @ResponseBody
    public Map<String, Object> updateStudent(Student student){
        Map<String, Object> result = new HashMap();
        int code;
        String msg;
        if(studentService.updateStudent(student)){
            code = 311;
            msg = "更新成功";
        }else {
            code = 310;
            msg = "更新失败";
        }
        result.put("msg", msg);
        result.put("code", code);
        result.put("count", null);
        result.put("data", null);
        return result;
    }
}
