package com.biz.lesson.business.student;

import com.biz.lesson.model.manage.Grade;
import com.biz.lesson.vo.student_tp.GradeVo;

import java.util.List;

public interface GradeService {
    public List<Grade> findAll();

    public Grade findById(int id);
    public List<GradeVo> findAllToGradeVo();
    public void deleteGrade(int id);

    void updateGrade(int id, String name);

    void addGrade(String name);
    //public Grade findById(int id)
}
