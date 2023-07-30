package com.alexproject.agileninja.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Priority;
import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.models.Severity;
import com.alexproject.agileninja.models.Status;
import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.models.Type;
import com.alexproject.agileninja.models.User;

@Repository
public interface TicketRepository extends CrudRepository<Ticket, Long>, PagingAndSortingRepository<Ticket, Long> {
	
	public static final String ROW_COUNT = "15";

	List<Ticket> findAll();
	List<Ticket> findAll(Sort sort);
	
	Optional<Ticket> findTicketById(Long id);
	
	List<Ticket> findTicketsByTicketPriority(Priority priority);
	
	List<Ticket> findTicketsByTicketSeverity(Severity severity);
	
	List<Ticket> findTicketsByTicketStatus(Status status);
	
	List<Ticket> findTicketsByTicketType(Type type);
	
	List<Ticket> findTicketsByProject(Project project);
	
	Optional<Ticket> findTicketByTicketKey(String ticketKey);
	
	List<Ticket> findTicketByProjectIn(List<Project> projects);
	
	
	@Query("SELECT t FROM Ticket t WHERE "
			+ "t.project in ?1 AND t.ticketType in ?2 AND t.ticketStatus in ?3 "
			+ "AND t.ticketPriority in ?4 AND t.ticketSeverity in ?5 AND t.assignee in ?6 ORDER BY t.ticketKey ASC")
	List<Ticket> findByProjectIn(List<Project> filteredProjects, 
								 List<Type> filteredTypes,
								 List<Status> filteredStatus,
								 List<Priority> filteredPriority,
								 List<Severity> filteredSeverity,
								 List<User> filteredAssignee);
	
	@Query("SELECT t FROM Ticket t WHERE "
			+ "t.project in :projects AND t.ticketType in :types AND t.ticketStatus in :statuses "
			+ "AND t.ticketPriority in :priorities AND t.ticketSeverity in :severities AND t.assignee in :assignees")
	List<Ticket> findByProjectIn(@Param(value="projects") List<Project> filteredProjects, 
								 @Param(value="types") List<Type> filteredTypes,
								 @Param(value="statuses") List<Status> filteredStatus,
								 @Param(value="priorities") List<Priority> filteredPriority,
								 @Param(value="severities") List<Severity> filteredSeverity,
								 @Param(value="assignees") List<User> filteredAssignee,
								 Sort sort);
	
	
	
	
}
