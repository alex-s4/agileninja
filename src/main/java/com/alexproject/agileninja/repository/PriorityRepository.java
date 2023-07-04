package com.alexproject.agileninja.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Priority;

@Repository
public interface PriorityRepository extends CrudRepository<Priority, Long> {
	
	List<Priority> findAll();
	
	Optional<Priority> findPriorityById(Long id);
	
	Optional<Priority> findPriorityByIssuePriority(String issuePriority);
	
}
