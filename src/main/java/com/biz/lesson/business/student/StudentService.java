package com.biz.lesson.business.student;


import com.biz.lesson.dao.repository.StudentRepository;
import com.biz.lesson.model.manage.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public interface StudentService {

    public Page<Student> findAllStudent(int page);
    public void addavg();
    public Page<Student> sousuo(int page,String studentid,String name, Date date1,Date date2);
    public void deleteStudent(Integer id);
    public void addStudent(Student student, File filepath);
    public Student findStudentById(int id);
    public void updateStudent(Student student,File file);

    Student findAllById(int id);

    void xuanke(String[] subs, int id);

    void updateMark(int sid, int mid, int score);
}
