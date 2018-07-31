package com.biz.lesson.web.controller.student;

import ch.qos.logback.core.util.FileUtil;
import com.biz.lesson.business.student.GradeService;
import com.biz.lesson.business.student.StudentService;
import com.biz.lesson.business.student.SubjectService;
import com.biz.lesson.model.manage.Grade;
import com.biz.lesson.model.manage.Mark;
import com.biz.lesson.model.manage.Student;
import com.biz.lesson.model.manage.Subject;
import com.biz.lesson.vo.student_tp.MarkVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("student")
public class StudentController {

    @Autowired
    StudentService studentService;

    @Autowired
    GradeService gradeService;
    @Autowired
    SubjectService subjectService;

    @RequestMapping("/daoadd")
    public ModelAndView daoStudent(){
        ModelAndView modelAndView = new ModelAndView("student/addStudent");

        List<Grade> all = gradeService.findAll();
        modelAndView.addObject("grades",all);
        return modelAndView;
    }

    @RequestMapping("/addstudent")
    public ModelAndView addStudent(String studentid, String name, String sex, String birthday, MultipartFile img, int grade,HttpSession session,HttpServletRequest request) throws IOException, ParseException {
        ModelAndView modelAndView = new ModelAndView("student/addStudent");


        String path = request.getServletContext().getRealPath("/images/");
        String filename = img.getOriginalFilename();
        File filepath = new File(path,filename);
        if (!filepath.getParentFile().exists()) {
            filepath.getParentFile().mkdirs();
        }
        img.transferTo(filepath);

        Student student = new Student();
        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
        student.setBirthday(format.parse(birthday));
        student.setStudentid(studentid);
        student.setName(name);
        student.setImg(filename);
        student.setSex(sex);
        Grade byId = gradeService.findById(grade);
        student.setGrade(byId);

        studentService.addStudent(student,filepath);

        return modelAndView;
    }

    @RequestMapping("/selectstudent")
    public ModelAndView selectStudent(int page){
        ModelAndView modelAndView = new ModelAndView("student/selectStudent");

        if(page <= 0){
            page = 0;
        }else {
            page --;
        }


        Page<Student> allStudent = studentService.findAllStudent(page);


        modelAndView.addObject("students",allStudent.getContent());
        modelAndView.addObject("allStudent",allStudent);
        modelAndView.addObject("page",allStudent.getNumber()+1);
        modelAndView.addObject("pages",allStudent.getTotalPages());
        System.out.println(allStudent.getNumber());
        return modelAndView;
    }


    //搜索
    @RequestMapping("/sousuo")
    public ModelAndView sousuo(int page ,String studentid,String name, String  startdate, String  enddate) throws ParseException {
        ModelAndView modelAndView = new ModelAndView("student/selectStudent2");


        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = simpleDateFormat.parse(startdate);
        Date date2 = simpleDateFormat.parse(enddate);
        System.out.println(page);
        //System.out.println(student);
        System.out.println(startdate);
        System.out.println(enddate);
        Page<Student> sousuo = studentService.sousuo(page, studentid,name, date1, date2);

        System.out.println("sousuode daima "+sousuo.getContent());

        modelAndView.addObject("students",sousuo.getContent());
        modelAndView.addObject("allStudent",sousuo);
        modelAndView.addObject("page",sousuo.getNumber()+1);
        modelAndView.addObject("pages",sousuo.getTotalPages());
        return modelAndView;
    }

    @RequestMapping("/daoupdate")
    public ModelAndView daoUpdate(Integer id){

        ModelAndView modelAndView = new ModelAndView("student/updateStudent");
        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
        Student studentById = studentService.findStudentById(id);
        List<Grade> all = gradeService.findAll();
        modelAndView.addObject("grades",all);
        modelAndView.addObject("student",studentById);
        modelAndView.addObject("date",format.format(studentById.getBirthday()));
        return  modelAndView;

    }


    @RequestMapping("/updatestudent")
    public ModelAndView updateStudent(int id,String studentid, String name, String sex, String birthday, MultipartFile img, int grade,HttpSession session,HttpServletRequest request) throws IOException, ParseException {
        ModelAndView modelAndView = new ModelAndView("student/selectStudent");


        String path = request.getServletContext().getRealPath("/images-update/");
        String filename = img.getOriginalFilename();
        File filepath = new File(path,filename);
        if (!filepath.getParentFile().exists()) {
            filepath.getParentFile().mkdirs();
        }
        img.transferTo(filepath);

        Student student = new Student();
        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
        student.setBirthday(format.parse(birthday));
        student.setStudentid(studentid);
        student.setName(name);
        student.setImg(filename);
        student.setSex(sex);
        student.setId(id);
        Grade byId = gradeService.findById(grade);
        student.setGrade(byId);

        studentService.updateStudent(student,filepath);

        ModelAndView modelAndView1 = selectStudent(0);

        return modelAndView1;

    }



    @RequestMapping("/deletestudent")
    public ModelAndView deleteStudent(Integer id,int page){

        ModelAndView modelAndView = new ModelAndView("student/selectStudent");

        studentService.deleteStudent(id);

        if(page <= 0){
            page = 0;
        }else {
            page --;
        }


        Page<Student> allStudent = studentService.findAllStudent(page);


        modelAndView.addObject("students",allStudent.getContent());
        modelAndView.addObject("allStudent",allStudent);
        modelAndView.addObject("page",allStudent.getNumber()+1);
        modelAndView.addObject("pages",allStudent.getTotalPages());
        System.out.println(allStudent.getNumber());
        return modelAndView;

    }

    @RequestMapping("/daoxuanke")
    public ModelAndView daoXuanKe(int id){

        ModelAndView modelAndView = new ModelAndView("student/xuanke");
        Student student = studentService.findAllById(id);

        List<Subject> all = subjectService.findAll();
        List<Subject> noSubjects = new ArrayList<>();
        List<Mark> marks = student.getMarks();
        Iterator<Subject> iterator = all.iterator();
        while (iterator.hasNext()){
            Subject subject = iterator.next();
            String name = subject.getName();

            Iterator<Mark> markIterator = marks.iterator();
            int a = 0;

            while (markIterator.hasNext()){
                Mark mark = markIterator.next();
                String markName = mark.getName();
                if(markName.equals(name) ){
                    a=1;
                    break;
                }
            }
            if (a!=1){
                noSubjects.add(subject);
            }
        }

        modelAndView.addObject("student",student);
        modelAndView.addObject("subjects",noSubjects);
        return modelAndView;
    }

    @RequestMapping("/xuanke")
    public ModelAndView xuanke(String[] subs,int id){

        studentService.xuanke(subs,id);


        ModelAndView modelAndView = daoXuanKe(id);
        return modelAndView;
    }

    @RequestMapping("/daoaddmark")
    public ModelAndView daoAddMark(int id){

        Student student = studentService.findAllById(id);
        ModelAndView modelAndView = new ModelAndView("/student/addMark");
        modelAndView.addObject("student",student);
        return modelAndView;
    }

    @RequestMapping("/updatemark")
    public ModelAndView updateMark(int sid,int mid,int score){

        studentService.updateMark(sid,mid,score);

        ModelAndView modelAndView = daoAddMark(sid);
        return modelAndView;
    }

}
