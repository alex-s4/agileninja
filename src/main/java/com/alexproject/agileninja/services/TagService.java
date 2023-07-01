package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Tag;
import com.alexproject.agileninja.repository.TagRepository;

@Service
public class TagService {

	@Autowired
	private TagRepository tagRepository;
	
	// Create
	public Tag createTag(Tag tag) {
		return tagRepository.save(tag);
	}
	
	// Read (all and one)
	public List<Tag> findAllTags(){
		return tagRepository.findAll();
	}
	
	public Tag findTagById(Long id) {
		return tagRepository.findById(id).orElse(null);
	}
	
	// Update
	public Tag updateTag(Tag tag) {
		return this.tagRepository.save(tag);
	}
	
	// Delete
	public void deleteTagById(Long id) {
		tagRepository.deleteById(id);
	}
}
