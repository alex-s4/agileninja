package com.alexproject.agileninja.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.alexproject.agileninja.models.Priority;
import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.models.Severity;
import com.alexproject.agileninja.models.Status;
import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.models.Type;

@Repository
public interface TicketRepository extends CrudRepository<Ticket, Long> {

	List<Ticket> findAll();
	
	Optional<Ticket> findTicketById(Long id);
	
	List<Ticket> findTicketsByTicketPriority(Priority priority);
	
	List<Ticket> findTicketsByTicketSeverity(Severity severity);
	
	List<Ticket> findTicketsByTicketStatus(Status status);
	
	List<Ticket> findTicketsByTicketType(Type type);
	
	List<Ticket> findTicketsByProject(Project project);
	
	Optional<Ticket> findTicketByTicketKey(String ticketKey);
	
	
}
