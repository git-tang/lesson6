package com.biz.lesson.model.manage;

import com.biz.lesson.dao.repository.StudentRepository;
import javafx.scene.control.DatePicker;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.biz.lesson.model.manage.*;
import org.springframework.beans.factory.annotation.Autowired;

@Entity
@Table(name = "user_student")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(length = 20)
    private String studentid;

    @Column(length = 20)
    private String name;

    private String img;

    @Column(length = 4)
    private String sex;

    private Date birthday;

    @ManyToOne
    private Grade grade;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "student_id")
    private List<Subject> subjects = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "student_id")
    private List<Mark> marks = new ArrayList<>();


    private Integer avgscore;

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", studentid='" + studentid + '\'' +
                ", name='" + name + '\'' +
                ", img='" + img + '\'' +
                ", sex='" + sex + '\'' +
                ", birthday=" + birthday +
                ", subjects=" + subjects +
                ", marks=" + marks +
                ", avgscore=" + avgscore +
                '}';
    }
    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStudentid() {
        return studentid;
    }

    public void setStudentid(String studentid) {
        this.studentid = studentid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }


    public List<Subject> getSubjects() {
        return subjects;
    }

    public void setSubjects(List<Subject> subjects) {
        this.subjects = subjects;
    }

    public List<Mark> getMarks() {
        return marks;
    }

    public void setMarks(List<Mark> marks) {
        this.marks = marks;
    }

    public Integer getAvgscore() {
        return avgscore;
    }

    public void setAvgscore(Integer avgscore) {

        this.avgscore = avgscore;
    }
}
