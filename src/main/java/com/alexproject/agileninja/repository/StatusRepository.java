package com.alexproject.agileninja.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Status;

@Repository
public interface StatusRepository extends CrudRepository<Status, Long> {

	List<Status> findAll();
	
	Optional<Status> findStatusById(Long id);
	
	Optional<Status> findStatusByIssueStatus(String issueStatus);
}
