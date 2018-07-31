package com.biz.lesson.business.student;

import com.biz.lesson.model.manage.Mark;
import org.springframework.stereotype.Service;

import java.util.List;


public interface MarkService {

    public List<Mark> findAllByName(String name);

}
