package com.biz.lesson.business.student;

import com.biz.lesson.dao.repository.MarkRepository;
import com.biz.lesson.dao.repository.SubjectRepository;
import com.biz.lesson.model.manage.Mark;
import com.biz.lesson.model.manage.Subject;
import com.biz.lesson.vo.student_tp.MarkVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Transactional
@Service(value = "subjectService")
public class SubjectServiceImpl implements  SubjectService{

    @Autowired
    SubjectRepository subjectRepository;

    @Autowired
    MarkRepository markRepository;

    @Override
    public void addCountAndAvg() {
        List<Subject> all = subjectRepository.findAll();
        Iterator<Subject> itall = all.iterator();
        while (itall.hasNext()){
            Subject subject = itall.next();

            Integer sum = markRepository.getGradeCount(subject.getName());
            subjectRepository.updateCount(sum,subject.getName());

            Integer avg = markRepository.getAvg(subject.getName());
            subjectRepository.updateAvg(avg,subject.getName());
        }
    }

    public List<MarkVo> findAllSubject(){

        List<Subject> all = subjectRepository.findAll();

        List<MarkVo> markVoList = new ArrayList<>();

        Iterator<Subject> iterator = all.iterator();
        while (iterator.hasNext()){
            Subject subject = iterator.next();
            MarkVo markVo = new MarkVo();
            markVo.setId(subject.getId());
            markVo.setName(subject.getName());
            markVo.setSum(subject.getSum());
            markVo.setAvgscore(subject.getAvgscore());
            List<Mark> allByName = markRepository.findAllByName(subject.getName());
            markVo.setMarks(allByName);
            markVoList.add(markVo);
        }

        return markVoList;
    }

    @Override
    public void deleteSubject(int id) {

        Subject one = subjectRepository.findOne(id);

        System.out.println(one);
        subjectRepository.delete(id);

        markRepository.deleteByName(one.getName());
    }

    @Override
    public List<MarkVo>   updateSubject(int id, String name) {
        Subject subject = subjectRepository.findAllById(id);

        markRepository.updateByName(subject.getName(),name);

        subjectRepository.updateById(id,name);

        List<MarkVo> allSubject = findAllSubject();

        return allSubject;

    }

    @Override
    public void addSubject(String name) {

        Subject subject = new Subject();
        subject.setName(name);
        subject.setAvgscore(0);
        subject.setSum(0);

        subjectRepository.save(subject);
    }

    @Override
    public List<Subject> findAll() {
        List<Subject> all = subjectRepository.findAll();
        return all;
    }
}
