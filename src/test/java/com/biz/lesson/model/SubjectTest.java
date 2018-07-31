package com.biz.lesson.model;

import com.biz.lesson.dao.repository.MarkRepository;
import com.biz.lesson.dao.repository.SubjectRepository;
import com.biz.lesson.model.manage.Subject;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;

import java.util.Iterator;
import java.util.List;

@Transactional
public class SubjectTest {

    private ApplicationContext ctx = null;
    SubjectRepository subjectRepository = null;
    MarkRepository markRepository =null;
    @Before
    public void setup() {
        ctx = new ClassPathXmlApplicationContext("application-content.xml");
        subjectRepository = ctx.getBean(SubjectRepository.class);
        markRepository = ctx.getBean(MarkRepository.class);
        System.out.println("setup");
    }

    @After
    public void tearDown() {
        ctx = null;
        System.out.println("tearDown");
    }

    @Test
    public void Test1(){
        List<Subject> all = subjectRepository.findAll();
        System.out.println(all);
    }

    @Test
    public void Test2(){

        List<Subject> all = subjectRepository.findAll();
        Iterator<Subject> itall = all.iterator();
        while (itall.hasNext()){
            Subject subject = itall.next();

            Integer sum = markRepository.getGradeCount(subject.getName());
            System.out.println(sum +" "+subject.getName());
            subjectRepository.updateCount(sum,subject.getName());

            System.out.println(sum);
            /*Integer avg = subjectRepository.getAvg(subject.getName());
            subjectRepository.updateAvg(avg,subject.getName());*/
        }

    }
}
