package com.biz.lesson.dao.repository;

import com.biz.lesson.model.manage.Subject;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SubjectRepository extends PagingAndSortingRepository<Subject,Integer>,JpaSpecificationExecutor<Subject> {

    public List<Subject> findAll();


    @Modifying
    @Query(value = "update user_subject set sum = :sum where name = :name",nativeQuery = true)
    public void updateCount(@Param("sum")int sum,@Param("name")String name);



    @Modifying
    @Query(value = "update user_subject set avgscore = :avgscore where name = :name", nativeQuery = true)
    public void updateAvg(@Param("avgscore")Integer avgscore,@Param("name")String name);


    @Modifying
    @Query("update Subject set name = :name where id = :id")
    public void updateById(@Param("id") int id,@Param("name") String name);


    @Query("select subject from  Subject subject where subject.id = :id ")
    public Subject findAllById(@Param("id")int  id);
}
