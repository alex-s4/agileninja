package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Priority;
import com.alexproject.agileninja.repository.PriorityRepository;

@Service
public class PriorityService {

	@Autowired
	private PriorityRepository priorityRepository;
	
	// Read Only
	public List<Priority> findAllPriority()
	{
		return priorityRepository.findAll();
	}
	
	public Priority findPriorityById(Long id)
	{
		return priorityRepository.findById(id).orElse(null);
	}
	
	public Priority findPriorityByIssuePrio(String issuePriority)
	{
		return priorityRepository.findPriorityByIssuePriority(issuePriority).orElse(null);
	}
	
	
}
