package com.alexproject.agileninja.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.services.PriorityService;
import com.alexproject.agileninja.services.ProjectService;
import com.alexproject.agileninja.services.SeverityService;
import com.alexproject.agileninja.services.StatusService;
import com.alexproject.agileninja.services.TicketService;
import com.alexproject.agileninja.services.TypeService;
import com.alexproject.agileninja.services.UserService;

@Controller
public class MainController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired 
	private StatusService statusService;
	
	@Autowired 
	private SeverityService severityService;
	
	@Autowired 
	private PriorityService priorityService;
	
	@Autowired 
	private TypeService typeService;
	
	@Autowired
	private TicketService ticketService;
	
	// Render App's Home Page
	@GetMapping(value = {"/", "/dashboard"})
    public String index(
    		Principal principal, Model model, Project project, Ticket ticket) {
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
        
        model.addAttribute("newProject", new Project());
        model.addAttribute("newTicket", new Ticket());
        model.addAttribute("existingProjects", projectService.findAllProjects());
        model.addAttribute("statuses", statusService.findAllStatus());
        model.addAttribute("severities", severityService.findAllSeverity());
        model.addAttribute("priorities", priorityService.findAllPriority());
        model.addAttribute("types", typeService.findAllType());
        model.addAttribute("allUsers", userService.findAllUsers());
        
        model.addAttribute("allTickets", ticketService.findAllTickets());
        
        model.addAttribute("backlog", statusService.findStatusById((long) 1));
        
        
        return "index.jsp";
    }
	
	// Post action on creating new project
	@PostMapping("/project/new")
	public String newProject(Principal principal, 
			Model model, 
			Project project, 
			RedirectAttributes redirectAttributes)
	{
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
		
        
        // Successfully Created a Project
        redirectAttributes.addFlashAttribute("newProjSuccess", "Project Succesfully Created!");
		projectService.createProject(project);
		
		return "redirect:/";
	}
	
	@PostMapping("/ticket/new")
	public String newTicket(Principal principal, 
			Model model, 
			Project project,
			Ticket ticket,
			RedirectAttributes redirectAttributes)
	{
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
		
        
        // Will generate a ticketKey before saving the ticket to database
        ticketService.generateTicketKey(project, ticket);
        
		
		// Successfully Created a Ticket
        redirectAttributes.addFlashAttribute("newTktSuccess", "Ticket Succesfully Created!");
		ticketService.createTicket(ticket);
        
		return "redirect:/";
	}
	
	@GetMapping("/ticket/{ticketKey}")
	public String ticketPage(@PathVariable String ticketKey,
			Principal principal, 
			Model model, 
			Project project,
			Ticket ticket,
			RedirectAttributes redirectAttributes)
	{
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
		
		Ticket theTicket = ticketService.findTicketByKey(ticketKey);
		
		model.addAttribute("theTicket", theTicket);
        
        
        
		return "ticketPage.jsp";
	}
	
	
}
