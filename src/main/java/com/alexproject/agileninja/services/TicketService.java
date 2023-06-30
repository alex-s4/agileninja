package com.alexproject.agileninja.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.repository.TicketRepository;

@Service
public class TicketService {

	@Autowired
	private TicketRepository ticketRepository;
	
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
	
	
}
