package com.biz.lesson.dao.repository;

import com.biz.lesson.model.manage.Grade;
import com.biz.lesson.model.manage.Student;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface GradeRepository extends PagingAndSortingRepository<Grade,Integer> ,JpaSpecificationExecutor<Grade> {

    public List<Grade> findAll();
    public Grade findById(int id);

    @Modifying
    @Query("update Grade set name = :name where id = :id")
    public void updateGrade(@Param("id") int id, @Param("name")String name);
}
