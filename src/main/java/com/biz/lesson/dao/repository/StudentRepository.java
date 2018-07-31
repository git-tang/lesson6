package com.biz.lesson.dao.repository;

import com.biz.lesson.model.manage.Student;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface StudentRepository  extends PagingAndSortingRepository<Student,Integer> ,JpaSpecificationExecutor<Student> {

    public List<Student> findAll();

    @Modifying
    @Query("update Student set avgscore  = :avgscore where id = :id")
    public void updateAvgById(@Param("id") Integer id,@Param("avgscore") Integer avgscore);



    @Query("select student from Student student where student.studentid like :studentid% and student.name like %:name% " +
            "and student.birthday in (select x from Student x where x.birthday between :date1 and :date2)")
    public List<Student> sousuo2(@Param("studentid") String studentid, @Param("name")String name, @Param("date1")Date date1, @Param("date2")Date date2);

    @Modifying
    @Query("select student from Student student where student.studentid like :studentid% and student.name like %:name% ")
    public List<Student> sousuo(@Param("studentid") String studentid, @Param("name")String name);

    //@Query("select x from Student x where x.birthday between ?1 and ?2 ")


    public List<Student> findAllByStudentid(String x);

    public Student findById(Integer id);


    @Query("select student from Student student where student.grade.id =:id")
    List<Student> findByGradeId(@Param("id") Integer id);
}
