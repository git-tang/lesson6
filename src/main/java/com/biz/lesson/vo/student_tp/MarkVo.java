package com.biz.lesson.vo.student_tp;

import com.biz.lesson.model.manage.Mark;

import java.util.ArrayList;
import java.util.List;

public class MarkVo {

    private Integer id;

    private String  name;

    private Integer sum;

    private Integer avgscore;

    private List<Mark> marks = new ArrayList<>();

    @Override
    public String toString() {
        return "MarkVo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", sum=" + sum +
                ", avgscore=" + avgscore +
                ", marks=" + marks +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSum() {
        return sum;
    }

    public void setSum(Integer sum) {
        this.sum = sum;
    }

    public Integer getAvgscore() {
        return avgscore;
    }

    public void setAvgscore(Integer avgscore) {
        this.avgscore = avgscore;
    }

    public List<Mark> getMarks() {
        return marks;
    }

    public void setMarks(List<Mark> marks) {
        this.marks = marks;
    }
}
