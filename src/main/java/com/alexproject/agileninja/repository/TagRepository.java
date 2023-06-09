package com.alexproject.agileninja.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Tag;
import com.alexproject.agileninja.models.Ticket;

@Repository
public interface TagRepository extends CrudRepository<Tag, Long> {

	List<Tag> findAll();
	
	
}
