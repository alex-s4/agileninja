package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Comment;
import com.alexproject.agileninja.repository.CommentRepository;

@Service
public class CommentService {

	@Autowired
	private CommentRepository commentRepository;
	
	// Create
	public Comment createComment(Comment comment)
	{
		return commentRepository.save(comment);
	}
	
	// Read (all and by id)
	public List<Comment> findAllComment()
	{
		return commentRepository.findAll();
	}
	
	public Comment findCommentById(Long id)
	{
		return commentRepository.findById(id).orElse(null);
	}
	
	// Update
	public Comment updateComment(Comment comment)
	{
		return this.commentRepository.save(comment);
	}
	
	// Delete
	public void deleteCommentById(Long id)
	{
		commentRepository.deleteById(id);
	}
	
}
