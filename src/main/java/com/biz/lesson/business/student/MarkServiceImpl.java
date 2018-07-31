package com.biz.lesson.business.student;

import com.biz.lesson.dao.repository.MarkRepository;
import com.biz.lesson.model.manage.Mark;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service(value = "markService")
public class MarkServiceImpl implements MarkService {

    @Autowired
    MarkRepository markRepository;

    @Override
    public List<Mark> findAllByName(String name) {
        List<Mark> allByName = markRepository.findAllByName(name);
        return allByName;
    }
}
