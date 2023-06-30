package com.alexproject.agileninja.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Type;

@Repository
public interface TypeRepository extends CrudRepository<Type, Long> {

	List<Type> findAll();
}
