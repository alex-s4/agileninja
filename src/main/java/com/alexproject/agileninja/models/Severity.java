package com.alexproject.agileninja.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name="severity")
public class Severity {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@NotEmpty(message="Issue Severity is required")
	private String issueSeverity;
	
	private String iconCode;
	
	// One to Many relationship with ticket
	@OneToMany(mappedBy="ticketSeverity", fetch=FetchType.LAZY)
	private List<Ticket> tickets;
	
	public Severity () {}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIssueSeverity() {
		return issueSeverity;
	}

	public void setIssueSeverity(String issueSeverity) {
		this.issueSeverity = issueSeverity;
	}

	public List<Ticket> getTickets() {
		return tickets;
	}

	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}

	public String getIconCode() {
		return iconCode;
	}

	public void setIconCode(String iconCode) {
		this.iconCode = iconCode;
	}
	
	public String getIconAndSeverityName() {
		return iconCode + issueSeverity;
	}
	
	
}
