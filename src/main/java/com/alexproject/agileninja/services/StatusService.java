package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Status;
import com.alexproject.agileninja.repository.StatusRepository;

@Service
public class StatusService {

	@Autowired
	private StatusRepository statusRepository;
	
	// Read Only
	public List<Status> findAllStatus()
	{
		return statusRepository.findAll();
	}
	
	public Status findStatusById(Long id)
	{
		return statusRepository.findById(id).orElse(null);
	}
	
}
