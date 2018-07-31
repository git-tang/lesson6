package com.biz.lesson.web.controller.student;

import com.biz.lesson.business.student.GradeService;
import com.biz.lesson.model.manage.Grade;
import com.biz.lesson.vo.student_tp.GradeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

@Controller
@RequestMapping("/student")
public class GradeController {

    @Autowired
    GradeService gradeService;

    @RequestMapping("/selectgrade")
    public ModelAndView selectAllGrade(){

        List<GradeVo> allToGradeVo = gradeService.findAllToGradeVo();
        ModelAndView  modelAndView = new ModelAndView("student/selectGrade");
        modelAndView.addObject("grades",allToGradeVo);
        return modelAndView;
    }

    @RequestMapping("/deletegrade")
    public ModelAndView deleteGrade(int id){
        gradeService.deleteGrade(id);

        ModelAndView modelAndView = selectAllGrade();
        return modelAndView;
    }

    @RequestMapping("/daoupdategrade")
    public ModelAndView daoUpdateGrade(int id){
        Grade byId = gradeService.findById(id);
        ModelAndView modelAndView = new ModelAndView("/student/updateGrade");
        modelAndView.addObject("grade",byId);
        return modelAndView;
    }

    @RequestMapping("/updategrade")
    public ModelAndView updateGrade(int id,String name){

        System.out.println(name);
        gradeService.updateGrade(id,name);
        ModelAndView modelAndView = selectAllGrade();
        return modelAndView;
    }
    @RequestMapping("/addgrade")
    public ModelAndView addGrade(String name){

        gradeService.addGrade(name);
        ModelAndView modelAndView = selectAllGrade();
        return modelAndView;
    }
}
