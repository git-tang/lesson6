package com.biz.lesson.business.student;

import com.biz.lesson.dao.repository.GradeRepository;
import com.biz.lesson.dao.repository.StudentRepository;
import com.biz.lesson.model.manage.Grade;
import com.biz.lesson.model.manage.Mark;
import com.biz.lesson.model.manage.Student;
import com.biz.lesson.vo.student_tp.GradeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Transactional
@Service(value = "gradeService")
public class GradeServiceImpl implements  GradeService {

    @Autowired
    GradeRepository gradeRepository;

    @Autowired
    StudentRepository studentRepository;
    @Override
    public List<Grade> findAll() {

        List<Grade> all = gradeRepository.findAll();
        return all;
    }

    @Override
    public Grade findById(int id) {

        Grade byId = gradeRepository.findById(id);
        return byId;
    }

    @Override
    public void deleteGrade(int id) {
        gradeRepository.delete(id);
    }

    @Override
    public void updateGrade(int id, String name) {
        gradeRepository.updateGrade(id,name);
    }

    @Override
    public void addGrade(String name) {
        Grade grade = new Grade();
        List<Student> list = new ArrayList<>();
        grade.setName(name);
        grade.setStudents(list);
        gradeRepository.save(grade);
    }

    @Override
    public List<GradeVo> findAllToGradeVo() {

        List<Grade> all = gradeRepository.findAll();
        List<GradeVo> gradeVos = new ArrayList<>();
        Iterator<Grade> iterator = all.iterator();

        while (iterator.hasNext()){
            Integer avgGrade = 0;

            Grade grade = iterator.next();
            List<Student> students = studentRepository.findByGradeId(grade.getId());
            Iterator<Student> studentIterator = students.iterator();
            while (studentIterator.hasNext()){

                Student student = studentIterator.next();
                Integer avgscore = student.getAvgscore();
                avgGrade = avgGrade+avgscore;
            }
            GradeVo gradeVo = new GradeVo();
            int a = students.size();
            if(a == 0){
                a = 1;
            }
            gradeVo.setAvgscore(avgGrade/a);
            gradeVo.setName(grade.getName());
            gradeVo.setId(grade.getId());
            gradeVo.setStudents(students);

            gradeVos.add(gradeVo);

        }




        return gradeVos;
    }
}
