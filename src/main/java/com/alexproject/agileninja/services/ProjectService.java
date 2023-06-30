package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.repository.ProjectRepository;

@Service
public class ProjectService {

	@Autowired
	private ProjectRepository projectRepository;
	
	// Create
	public Project createProject(Project project) {
		return projectRepository.save(project);
	}
	
	// Read (all and one)
	public List<Project> findAllProjects(){
		return projectRepository.findAll();
	}
	public Project findProjectById(Long id) {
		return projectRepository.findById(id).orElse(null);
	}
	
	// Update
	public Project updateProject(Project project) {
		return this.projectRepository.save(project);
	}
	
	// Delete
	public void deleteProject(Long id) {
		projectRepository.deleteById(id);
	}
}
