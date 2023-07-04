package com.alexproject.agileninja.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alexproject.agileninja.models.Comment;
import com.alexproject.agileninja.models.Priority;
import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.models.Severity;
import com.alexproject.agileninja.models.Status;
import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.models.Type;
import com.alexproject.agileninja.models.User;
import com.alexproject.agileninja.services.CommentService;
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
	@Autowired
	private CommentService commentService;
	
	
	// Render App's Home Page
	@GetMapping(value = {"/", "/dashboard"})
    public String index(
    		@RequestParam(value="proj",required=false) String pKeyParam,
    		@RequestParam(value="type", required=false) String issueTypeParam,
    		@RequestParam(value="status", required=false) String issueStatParam,
    		@RequestParam(value="prio", required=false) String issuePrioParam,
    		@RequestParam(value="severity", required=false) String issueSevParam,
    		@RequestParam(value="assigned", required=false) String issueAssignedParam,
    		Principal principal, 
    		Model model, 
    		Project project, 
    		Ticket ticket
    		) {
		
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
        
        
        model.addAttribute("newProject", new Project());
        model.addAttribute("newTicket", new Ticket());
        
        
        List<Project> allProjects = projectService.findAllProjects();
        List<Type> allTypes = typeService.findAllType();
        List<Status> allStatus = statusService.findAllStatus();
        List<Priority> allPriorities = priorityService.findAllPriority();
        List<Severity> allSeverities = severityService.findAllSeverity();
        List<User> allUsers = userService.findAllUsers();
        
        model.addAttribute("existingProjects", allProjects);
        model.addAttribute("statuses", allStatus);
        model.addAttribute("severities", allSeverities);
        model.addAttribute("priorities", allPriorities);
        model.addAttribute("types", allTypes);
        model.addAttribute("allUsers", allUsers);
        
        // To ensure status of all newly created tickets are BACKLOG (id: 1)
        model.addAttribute("backlog", statusService.findStatusById((long) 1));
        
        
        //System.out.println(userService.find.getTicketsAssigned().size());
        
        // Project Filter
        if(pKeyParam.isEmpty() && issueTypeParam.isEmpty() && issueStatParam.isEmpty() && issuePrioParam.isEmpty() && issueSevParam.isEmpty() & issueAssignedParam.isEmpty()) // If "proj" & "issueType" parameters are blank/null, returns all tickets
        {
        	model.addAttribute("ticketsByProject", ticketService.findAllTickets());
        } 
        else // If "proj" and "type" param has one or more values, it returns all tickets under that project
        {
        	List<Project> filteredProjects = new ArrayList<>();
        	List<Type> filteredTypes = new ArrayList<>();
        	List<Status> filteredStatuses = new ArrayList<>();
        	List<Priority> filteredPriorities = new ArrayList<>();
        	List<Severity> filteredSeverity = new ArrayList<>();
        	List<User> filteredAssignee = new ArrayList<>();
        	
        	
        	List<String> pKeyAsList = Arrays.asList(pKeyParam.split("\\s*,\\s*")); // Comma Separated String to List (Project)
        	List<String> issueTypeAsList = Arrays.asList(issueTypeParam.split("\\s*,\\s*")); // Comma Separated String to List (Type)
        	List<String> issueStatAsList = Arrays.asList(issueStatParam.split("\\s*,\\s*")); // Comma Separated String to List (Status)
        	List<String> issuePrioAsList = Arrays.asList(issuePrioParam.split("\\s*,\\s*")); // Comma Separated String to List (Priority)
        	List<String> issueSevAsList = Arrays.asList(issueSevParam.split("\\s*,\\s*")); // Comma Separated String to List (Priority)
        	List<String> issueAssigneeAsList = Arrays.asList(issueAssignedParam.split("\\s*,\\s*"));
        	
            for(String pKeySeparated : pKeyAsList) {
            	filteredProjects.add(projectService.findProjectByKey(pKeySeparated));
            	//System.out.println("Projects: "+pKeySeparated);
            }
            for(String issueTypeSeparated : issueTypeAsList) {
            	filteredTypes.add(typeService.findTypeByTypeName(issueTypeSeparated));
            	//System.out.println("Type: "+issueTypeSeparated);
            }
            for(String issueStatSeparated : issueStatAsList) {
            	filteredStatuses.add(statusService.findStatusByTicketStatus(issueStatSeparated));
            }
            for(String issuePrioSeparated : issuePrioAsList) {
            	filteredPriorities.add(priorityService.findPriorityByIssuePrio(issuePrioSeparated));
            }
            for(String issueSevSeparated : issueSevAsList) {
            	System.out.println(issueSevSeparated);
            	filteredSeverity.add(severityService.findSeverityByName(issueSevSeparated));
            }
            for(String issueAssignedSeparated : issueAssigneeAsList) {
            	filteredAssignee.add(userService.findByUsername(issueAssignedSeparated));
            }
            
            //System.out.println(pKeyAsList.size());
            
            // Get all objects when parameter is empty
            if(pKeyParam.isBlank() || issueTypeParam.isBlank() || issueStatParam.isBlank() || issuePrioParam.isBlank() || issueSevParam.isBlank() || issueAssignedParam.isBlank() )
            {
            	if(pKeyParam.isBlank()) {
                	filteredProjects.addAll(allProjects);
                	// model.addAttribute("ticketsByProject", ticketService.findTicketsByProjects(filteredProjects, filteredTypes, filteredStatuses)); 
                } 
                if (issueTypeParam.isBlank()) {
                	filteredTypes.addAll(allTypes);
                	// model.addAttribute("ticketsByProject", ticketService.findTicketsByProjects(filteredProjects, filteredTypes, filteredStatuses));
                } 
                if (issueStatParam.isBlank()) {
                	filteredStatuses.addAll(allStatus);
                	// model.addAttribute("ticketsByProject", ticketService.findTicketsByProjects(filteredProjects, filteredTypes, filteredStatuses)); 
                }
                if (issuePrioParam.isBlank()) {
                	filteredPriorities.addAll(allPriorities);
                }
                if (issueSevParam.isBlank()) {
                	filteredSeverity.addAll(allSeverities);	
                }
                if(issueAssignedParam.isBlank()) {
                	filteredAssignee.addAll(allUsers);
                }
                
                System.out.println(filteredSeverity);
                model.addAttribute("ticketsByProject", ticketService.findTicketsByProjects(filteredProjects, filteredTypes, filteredStatuses, filteredPriorities, filteredSeverity, filteredAssignee));
            }
            // Normal fetching of data if no parameters were blank
            else {
            	model.addAttribute("ticketsByProject", ticketService.findTicketsByProjects(filteredProjects, filteredTypes, filteredStatuses, filteredPriorities, filteredSeverity, filteredAssignee)); 
            }
            
            
        }
        
        
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
		
        // Retrieve ticket
		Ticket theTicket = ticketService.findTicketByKey(ticketKey);
		model.addAttribute("theTicket", theTicket);
        
        // Gets all the fixed objects and necessary data from tables in database
		model.addAttribute("newProject", new Project());
        model.addAttribute("newTicket", new Ticket());
        model.addAttribute("existingProjects", projectService.findAllProjects());
        model.addAttribute("statuses", statusService.findAllStatus());
        model.addAttribute("severities", severityService.findAllSeverity());
        model.addAttribute("priorities", priorityService.findAllPriority());
        model.addAttribute("types", typeService.findAllType());
        model.addAttribute("allUsers", userService.findAllUsers());
        
        // Gets all tickets
        model.addAttribute("allTickets", ticketService.findAllTickets());
        
        // Returns Backlog ticketStatus
        model.addAttribute("backlog", statusService.findStatusById((long) 1));
		
        // New Comment form
		model.addAttribute("newComment", new Comment());
		
		// Gets all the comments from the current ticket
		List<Comment> getTicketComments = ticketService.findTicketByKey(ticketKey).getComments();
		model.addAttribute("allComments", getTicketComments);
        
		return "ticketPage.jsp";
	}
	
	
	@PostMapping("/ticket/{ticketId}/comment/new")
	public String addComment (@PathVariable Long ticketId,
			Principal principal, 
			Model model, 
			Project project,
			Ticket ticket,
			Comment comment,
			RedirectAttributes redirectAttributes)
	{
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
        
        // Gets the key of current ticket
        String currentTicketKey = ticketService.findTicketById(ticketId).getTicketKey();
        
        // Successfully created a comment and redirect back to current page
		commentService.createComment(comment);
		return "redirect:/ticket/"+currentTicketKey;
	}
	
}
