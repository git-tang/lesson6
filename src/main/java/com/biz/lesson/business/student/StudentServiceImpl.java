package com.biz.lesson.business.student;

import com.biz.lesson.dao.repository.MarkRepository;
import com.biz.lesson.dao.repository.StudentRepository;
import com.biz.lesson.model.manage.Mark;
import com.biz.lesson.model.manage.Student;
import com.biz.lesson.util.OSSUtil;
import javafx.beans.binding.BooleanExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.*;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
@Transactional
@Service(value = "studentService")
public class StudentServiceImpl implements StudentService{
    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private MarkRepository markRepository;

    OSSUtil ossUtil = new OSSUtil();

    public void addavg(){
        List<Student> all = studentRepository.findAll();
        Iterator<Student> iterator = all.iterator();
        while (iterator.hasNext()){
            Student next = iterator.next();
            List<Mark> marks = next.getMarks();
            int length = marks.size();
            if(length == 0){
                length = 1;
            }
            int sum = 0;
            System.out.println(marks.size() + " ");
            Iterator<Mark> iterator1 = marks.iterator();
            while (iterator1.hasNext()){
                Mark next1 = iterator1.next();
                sum = sum + next1.getScore();
            }
            next.setAvgscore(sum/length);

            Integer x1 = next.getId();
            Integer x2 = next.getAvgscore();

            studentRepository.updateAvgById(x1,x2);
        }
    }

    public  Page<Student> findAllStudent(int page){
        addavg();

        List<Student> list = new ArrayList<>();
        Pageable pageable = new PageRequest(page,5);


        Page<Student> all = studentRepository.findAll(pageable);

        return all;
    }

    @Override
    public Page<Student> sousuo(int page,String studentid1, String name1,Date date1,Date date2) {

        Pageable pageable = new PageRequest(page,5);
        Specification specification = new Specification() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {

                Path studentid = root.get("studentid");
                Predicate like = criteriaBuilder.like(studentid, studentid1 + "%");

                Path name = root.get("name");
                Predicate like1 = criteriaBuilder.like(name, "%" + name1 + "%");

                Path birthday = root.get("birthday");
                Predicate predicate = criteriaBuilder.lessThan(birthday, date2);

                Predicate predicate1 = criteriaBuilder.greaterThan(birthday, date1);

                Predicate and = criteriaBuilder.and(like, like1,predicate1, predicate);

                return and;
            }
        };

        Page all = studentRepository.findAll(specification, pageable);

        return all;
    }

    public void deleteStudent(Integer id){

        studentRepository.delete(id);
    }

    public void addStudent(Student student,File filepath){
        ossUtil.upload(filepath.getPath());

        studentRepository.save(student);


    }

    public Student findStudentById(int id){
        Student byId = studentRepository.findById(id);
        return byId;
    }

    @Override
    public void updateStudent(Student student, File file) {

        System.out.println("-----------------------------------------");
        System.out.println(student);
        System.out.println(file.getPath());
        ossUtil.upload(file.getPath());
        studentRepository.save(student);
    }

    @Override
    public Student findAllById(int id) {
        Student byId = studentRepository.findById(id);
        return byId;
    }

    @Override
    public void xuanke(String[] subs, int id) {

        Student student = studentRepository.findById(id);

        for (String name: subs) {
            Mark mark = new Mark();
            mark.setName(name);
            mark.setScore(0);
            mark.setStudent(student);
            student.getMarks().add(mark);
        }

        studentRepository.save(student);
    }

    @Override
    public void updateMark(int sid, int mid, int score) {
        markRepository.updateById(mid,score);
    }
}
