package com.alexproject.agileninja.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Priority;
import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.models.Severity;
import com.alexproject.agileninja.models.Status;
import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.models.Type;
import com.alexproject.agileninja.models.User;
import com.alexproject.agileninja.repository.ProjectRepository;
import com.alexproject.agileninja.repository.TicketRepository;

@Service
@Transactional
public class TicketService {

	@Autowired
	private TicketRepository ticketRepository;
	@Autowired
	private ProjectRepository projectRepository;

	private static final int PAGE_SIZE = 10;
	
	// Create
	public Ticket createTicket(Ticket ticket)
	{
		return ticketRepository.save(ticket);
	}
	
	// Read (all and by ID)
	public List<Ticket> findAllTickets()
	{
		return ticketRepository.findAll();
	}
	public List<Ticket> findAllTickets(Sort sort)
	{
		return ticketRepository.findAll(sort);
	}
	
	public Ticket findTicketById(Long id)
	{
		return ticketRepository.findById(id).orElse(null);
	}
	
	// Update
	public Ticket updateTicket(Ticket ticket)
	{
		return this.ticketRepository.save(ticket);
	}
	
	// Delete
	public void deleteTicketById(Long id)
	{
		ticketRepository.deleteById(id);
	}
	
	// Others
	// Generate ticketKey field: ${projectKey}-${ticketId}
	public void generateTicketKey(Project project, Ticket ticket)
	{
		String pKey = ticket.getProject().getProjectKey();
		Long ticketProjId = (long) project.getTickets().size()+1;
		String tKey = pKey+"-"+ticketProjId;
		
		ticket.setTicketKey(tKey);
	}
	
	// Returns ticket by ticketKey
	public Ticket findTicketByKey(String ticketKey)
	{
		return ticketRepository.findTicketByTicketKey(ticketKey).orElse(null);
	}
	
	// Returns all tickets by specified project
	public List<Ticket> findTicketsByProjKey(String projectKey)
	{
		return ticketRepository.findTicketsByProject(projectRepository.findProjectByProjectKey(projectKey).orElse(null));
	}
	
	// Returns all tickets by specified projects
	public List<Ticket> findTicketsByProjects(List<Project> filteredProjects, 
											  List<Type> filteredTypes, 
											  List<Status> filteredStatus,
											  List<Priority> filteredPriority,
											  List<Severity> filteredSeverity,
											  List<User> filteredAssignee)
	{
		return ticketRepository.findByProjectIn(filteredProjects, filteredTypes, filteredStatus, filteredPriority, filteredSeverity, filteredAssignee);
	}
	
	public List<Ticket> findTicketsByProjects(List<Project> filteredProjects, 
			  List<Type> filteredTypes, 
			  List<Status> filteredStatus,
			  List<Priority> filteredPriority,
			  List<Severity> filteredSeverity,
			  List<User> filteredAssignee,
			  Sort sort)
	{
		return ticketRepository.findByProjectIn(filteredProjects, filteredTypes, filteredStatus, filteredPriority, filteredSeverity, filteredAssignee, sort);
	}
	
	
	// Returns all tickets by specified projects and set number of tickets per page
//	public Page<Ticket> findTicketsByProjectsPerPage(List<Project> filteredProjects, 
//											  List<Type> filteredTypes, 
//											  List<Status> filteredStatus,
//											  List<Priority> filteredPriority,
//											  List<Severity> filteredSeverity,
//											  List<User> filteredAssignee,
//											  int pageNumber)
//	{
//		PageRequest pageRequest = PageRequest.of(pageNumber, PAGE_SIZE, Sort.Direction.ASC, "ticketKey");
//		Page<Ticket> tickets = ticketRepository.findAll(pageRequest);
//		
//		return ticketRepository.findAll(pageRequest);
//	}
	
	
	
}
