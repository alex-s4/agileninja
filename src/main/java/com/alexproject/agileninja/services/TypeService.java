package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Type;
import com.alexproject.agileninja.repository.TypeRepository;

@Service
public class TypeService {

	@Autowired
	private TypeRepository typeRepository;
	
	
	// Read Only
	public List<Type> findAllType()
	{
		return typeRepository.findAll();
	}
	
	public Type findTypeById(Long id)
	{
		return typeRepository.findById(id).orElse(null);
	}
	
}
