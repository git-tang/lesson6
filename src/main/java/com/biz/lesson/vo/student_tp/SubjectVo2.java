package com.biz.lesson.vo.student_tp;

public class SubjectVo2 {

    private  int id;

    private String  name;

    private int he;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public SubjectVo2(int id, String name, int he) {
        this.id = id;
        this.name = name;
        this.he = he;
    }

    public SubjectVo2() {
    }

    @Override
    public String toString() {
        return "SubjectVo2{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", he=" + he +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getHe() {
        return he;
    }

    public void setHe(int he) {
        this.he = he;
    }
}
