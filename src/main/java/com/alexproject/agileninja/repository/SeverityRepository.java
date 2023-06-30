package com.alexproject.agileninja.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Severity;

@Repository
public interface SeverityRepository extends CrudRepository<Severity, Long> {

	List<Severity> findAll();
	
	Optional<Severity> findSeverityById(Long id);
}
