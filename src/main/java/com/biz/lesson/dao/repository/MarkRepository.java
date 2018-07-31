package com.biz.lesson.dao.repository;

import com.biz.lesson.model.manage.Mark;
import com.biz.lesson.model.manage.Subject;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MarkRepository extends PagingAndSortingRepository<Mark,Integer>,JpaSpecificationExecutor<Mark> {

    @Query(value = "select count(name) as  he from Mark where name =:name")
    public Integer getGradeCount(@Param("name") String name);

    @Query("select avg(score) as  he from Mark where name = :name")
    public Integer getAvg(@Param("name") String name);

    public List<Mark> findAll();

    public List<Mark> findAllByName(String name);

    @Modifying
    @Query("delete from Mark where name = :name")
    public void deleteByName(@Param("name") String name);

    @Modifying
    @Query("update Mark set name = :name2 where name = :name")
    public void updateByName(@Param("name") String name,@Param("name2") String name2);

    @Modifying
    @Query("update Mark set score = :score where id = :mid")
    public void updateById(@Param("mid") int mid,@Param("score") int score);
}
