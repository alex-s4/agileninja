package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Severity;
import com.alexproject.agileninja.repository.SeverityRepository;

@Service
public class SeverityService {
	
	@Autowired
	private SeverityRepository severityRepository;
	
	// Read Only
	public List<Severity> findAllSeverity()
	{
		return severityRepository.findAll();
	}
	
	public Severity findSeverityById(Long id)
	{
		return severityRepository.findById(id).orElse(null);
	}

}
