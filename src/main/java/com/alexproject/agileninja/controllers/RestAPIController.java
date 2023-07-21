package com.alexproject.agileninja.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.services.TicketService;

@RestController
public class RestAPIController {
	
	@Autowired
	TicketService ticketService;
	
	@GetMapping("/api/issues")
	public List<Ticket> issueFilter()
	{
		return ticketService.findAllTickets();
	}

}
