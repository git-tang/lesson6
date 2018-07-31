package com.biz.lesson.business.student;

import com.biz.lesson.model.manage.Mark;
import com.biz.lesson.model.manage.Subject;
import com.biz.lesson.vo.student_tp.MarkVo;

import java.util.List;

public interface SubjectService {

    public void addCountAndAvg();
    List<MarkVo> findAllSubject();

    void deleteSubject(int id);

    List<MarkVo> updateSubject(int id, String name);

    void addSubject(String name);

    List<Subject> findAll();
}
