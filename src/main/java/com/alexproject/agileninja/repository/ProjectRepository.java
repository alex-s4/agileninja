package com.alexproject.agileninja.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Project;

@Repository
public interface ProjectRepository extends CrudRepository<Project, Long> {

	List<Project> findAll();
}
