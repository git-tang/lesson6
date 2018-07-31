package com.biz.lesson.vo.student_tp;

import com.biz.lesson.model.manage.Student;

import java.util.List;

public class GradeVo {
    private Integer id;

    private String name;

    private Integer avgscore;

    private List<Student> students;

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

    public Integer getAvgscore() {
        return avgscore;
    }

    public void setAvgscore(Integer avgscore) {
        this.avgscore = avgscore;
    }

    public List<Student> getStudents() {
        return students;
    }

    public void setStudents(List<Student> students) {
        this.students = students;
    }

    @Override
    public String toString() {
        return "GradeVo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", avgscore=" + avgscore +
                '}';
    }
}
