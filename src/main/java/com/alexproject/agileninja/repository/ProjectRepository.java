package com.alexproject.agileninja.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Project;

@Repository
public interface ProjectRepository extends CrudRepository<Project, Long> {

	List<Project> findAll();
	
	Optional<Project> findProjectById(Long id);
	
	Optional<Project> findProjectByProjectKey(String pKey);
}
