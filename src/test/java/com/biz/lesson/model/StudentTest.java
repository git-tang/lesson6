package com.biz.lesson.model;

import com.biz.lesson.dao.repository.StudentRepository;
import com.biz.lesson.model.manage.Student;
import com.biz.lesson.util.OSSUtil;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.net.URL;
import java.util.Date;
import java.util.List;

public class StudentTest {

    private ApplicationContext ctx = null;
    StudentRepository studentRepository = null;
    @Before
    public void setup() {
        ctx = new ClassPathXmlApplicationContext("application-content.xml");
        studentRepository = ctx.getBean(StudentRepository.class);
        System.out.println("setup");
    }

    @After
    public void tearDown() {
        ctx = null;
        System.out.println("tearDown");
    }

    @Test
    public void Test(){
        List<Student> all = studentRepository.findAll();
        System.out.println(all);
    }

    @Test
    public void Test2(){
        Pageable pageable = new PageRequest(1,2);
        /*Specification<Student> studentSpecification = new Specification<Student>() {
            @Override
            public Predicate toPredicate(Root<Student> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Path path = root.get("studentid");
                Predicate gt = criteriaBuilder.gt(path, 50);

                return gt;
            }
        };*/
        Page<Student> all = studentRepository.findAll(pageable);
        System.out.println(all.getContent());
        System.out.println(all.getNumber());
        System.out.println(all.getTotalPages());
        System.out.println(all.getTotalElements());
    }

    @Test
    public void Test3(){
        Date date1 = new Date();
        Date date2 = new Date();
        List<Student> sousuo = studentRepository.sousuo("1", "1");
        System.out.println(sousuo);
    }

    @Test
    public void Test4(){

        List<Student> allByStudentid = studentRepository.findAllByStudentid("1");
        System.out.println(allByStudentid);

    }
    @Test
    public void Test5(){

        studentRepository.delete(1);
        System.out.println("ok");

    }
    @Test
    public void Test6(){

        Student student = new Student();
        student.setId(2);
        student.setName("2号");
        studentRepository.save(student);
        System.out.println("ok");

    }
    @Test
    public void Test7() throws FileNotFoundException {

        OSSUtil ossUtil = new OSSUtil();
        String url = "F:\\4.png";
        ossUtil.upload(url);

    }
    @Test
    public void Test8() throws FileNotFoundException {

        OSSUtil ossUtil = new OSSUtil();
        String url = "F:\\4.png";
        System.out.println("https://file-img.oss-cn-beijing.aliyuncs.com/"+new File(url).getName());
        //ossUtil.upload(url);


    }

    @Test
    public void Test9() throws FileNotFoundException {

        List<Student> byGradeId = studentRepository.findByGradeId(1);
        System.out.println(byGradeId);


    }


}
