package com.biz.lesson.web.controller.student;

import com.biz.lesson.business.student.SubjectService;
import com.biz.lesson.model.manage.Mark;
import com.biz.lesson.model.manage.Subject;
import com.biz.lesson.vo.student_tp.MarkVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping(value = "student")
public class SubjectController {


    @Autowired
    SubjectService subjectService;

    @RequestMapping("/selectsubject")
    public ModelAndView selectSuject(){
        ModelAndView modelAndView = new ModelAndView("student/selectSubject");
        subjectService.addCountAndAvg();

        List<MarkVo> allSubject = subjectService.findAllSubject();
        modelAndView.addObject("subjects",allSubject);

        return  modelAndView;
    }

    @RequestMapping("/deletesubject")
    public ModelAndView deleteSubject(int id){

        subjectService.deleteSubject(id);

        ModelAndView modelAndView = new ModelAndView("student/selectSubject");


        List<MarkVo> allSubject = subjectService.findAllSubject();
        modelAndView.addObject("subjects",allSubject);
        return modelAndView;
    }

    @RequestMapping("/updatesubject")
    public ModelAndView updateSubject(int id,String name){

        List<MarkVo> allSubject =  subjectService.updateSubject(id,name);
        ModelAndView modelAndView = new ModelAndView("student/selectSubject");
        modelAndView.addObject("subjects",allSubject);
        return modelAndView;
    }

    @RequestMapping("/addsubject")
    public ModelAndView addSubject(String name){

        subjectService.addSubject(name);

        ModelAndView modelAndView = new ModelAndView("student/selectSubject");

        List<MarkVo> allSubject = subjectService.findAllSubject();
        modelAndView.addObject("subjects",allSubject);
        return modelAndView;
    }


}
