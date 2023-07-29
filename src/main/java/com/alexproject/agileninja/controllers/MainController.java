package com.alexproject.agileninja.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
import com.alexproject.agileninja.services.FileService;
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
	@Autowired
	private FileService fileService;
	
	
	// Render App's Home Page
	@GetMapping(value = {"/", "/dashboard"})
    public String index(
    		@RequestParam(value="proj",required=false) String pKeyParam,
    		@RequestParam(value="type", required=false) String issueTypeParam,
    		@RequestParam(value="status", required=false) String issueStatParam,
    		@RequestParam(value="prio", required=false) String issuePrioParam,
    		@RequestParam(value="severity", required=false) String issueSevParam,
    		@RequestParam(value="assigned", required=false) String issueAssignedParam,
    		@RequestParam(value="orderBy", required=false) String tableColumn,
    		Principal principal, 
    		Model model, 
    		Project project, 
    		Ticket ticket
    		) {
		
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
        
        // Initialize new objects on creation
        model.addAttribute("newProject", new Project());
        model.addAttribute("newTicket", new Ticket());
        
        // Gathers all data available in DB
        List<Project> allProjects = projectService.findAllProjects();
        List<Type> allTypes = typeService.findAllType();
        List<Status> allStatus = statusService.findAllStatus();
        List<Priority> allPriorities = priorityService.findAllPriority();
        List<Severity> allSeverities = severityService.findAllSeverity();
        List<User> allUsers = userService.findAllUsers();
        
        // These will be fetched to JSP side
        model.addAttribute("existingProjects", allProjects);
        model.addAttribute("statuses", allStatus);
        model.addAttribute("severities", allSeverities);
        model.addAttribute("priorities", allPriorities);
        model.addAttribute("types", allTypes);
        model.addAttribute("allUsers", allUsers);
        
        // To ensure status of all newly created tickets are BACKLOG (id: 1)
        model.addAttribute("backlog", statusService.findStatusById((long) 1));
        
        
        // TICKET FILTERING: 
        // Returns all tickets if all parameters are empty or null (no parameter)
        if((pKeyParam == null || pKeyParam.isEmpty()) && (issueTypeParam == null || issueTypeParam.isEmpty()) && (issueStatParam == null || issueStatParam.isEmpty()) && 
        	(issuePrioParam == null || issuePrioParam.isEmpty()) && (issueSevParam == null || issueSevParam.isEmpty()) && (issueAssignedParam == null || issueAssignedParam.isEmpty()))
        {
        	model.addAttribute("ticketsByProject", ticketService.findAllTickets());
        } 
        // Filters the ticket if parameter has values
        else 
        {
        	List<Project> filteredProjects = new ArrayList<>();
        	List<Type> filteredTypes = new ArrayList<>();
        	List<Status> filteredStatuses = new ArrayList<>();
        	List<Priority> filteredPriorities = new ArrayList<>();
        	List<Severity> filteredSeverity = new ArrayList<>();
        	List<User> filteredAssignee = new ArrayList<>();
        	
        	// Comma Separated String to List (Project)
        	if(pKeyParam!=null) 
        	{
        		List<String> pKeyAsList = Arrays.asList(pKeyParam.split("\\s*,\\s*"));
        		for(String pKeySeparated : pKeyAsList) {
                	filteredProjects.add(projectService.findProjectByKey(pKeySeparated));
        		}	
        	}
        	
        	
        	// Comma Separated String to List (Type)
        	if(issueTypeParam!=null) 
        	{
        		List<String> issueTypeAsList = Arrays.asList(issueTypeParam.split("\\s*,\\s*"));
        		for(String issueTypeSeparated : issueTypeAsList) {
                	filteredTypes.add(typeService.findTypeByTypeName(issueTypeSeparated));
                }
        	}
        	
        	
        	// Comma Separated String to List (Status)
        	if(issueStatParam!=null) 
        	{
        		List<String> issueStatAsList = Arrays.asList(issueStatParam.split("\\s*,\\s*"));
        		for(String issueStatSeparated : issueStatAsList) {
                	filteredStatuses.add(statusService.findStatusByTicketStatus(issueStatSeparated));
                }
        		
        	}
        	
        	
        	// Comma Separated String to List (Priority)
        	if(issuePrioParam!=null) 
        	{
        		List<String> issuePrioAsList = Arrays.asList(issuePrioParam.split("\\s*,\\s*")); 
        		for(String issuePrioSeparated : issuePrioAsList) {
                	filteredPriorities.add(priorityService.findPriorityByIssuePrio(issuePrioSeparated));
                }
        	}
        	
        	
        	// Comma Separated String to List (Severity)
        	if(issueSevParam!=null) 
        	{
        		List<String> issueSevAsList = Arrays.asList(issueSevParam.split("\\s*,\\s*")); 
        		for(String issueSevSeparated : issueSevAsList) {
                	// System.out.println(issueSevSeparated);
                	filteredSeverity.add(severityService.findSeverityByName(issueSevSeparated));
                }
        	}
        	
        	
        	// Comma Separated String to List (Assignee)
        	if(issueAssignedParam!=null) 
        	{
        		List<String> issueAssigneeAsList = Arrays.asList(issueAssignedParam.split("\\s*,\\s*"));
        		for(String issueAssignedSeparated : issueAssigneeAsList) {
                	filteredAssignee.add(userService.findByUsername(issueAssignedSeparated));
                }
        	}
        	
            
            // Get all objects when parameter is empty or null
            if(pKeyParam.isBlank() || issueTypeParam.isBlank() || issueStatParam.isBlank() || issuePrioParam.isBlank() || issueSevParam.isBlank() || issueAssignedParam.isBlank() ||
               pKeyParam == null || issueTypeParam == null || issueStatParam == null || issuePrioParam == null || issueSevParam == null || issueAssignedParam == null)
            {
            	if(pKeyParam.isBlank() || pKeyParam==null) {
                	filteredProjects.addAll(allProjects);
                } else {
                	model.addAttribute("filterProjSize", filteredProjects.size());
                }
                if (issueTypeParam.isBlank() || issueTypeParam==null) {
                	filteredTypes.addAll(allTypes);
                } else {
                	model.addAttribute("filterTypeSize", filteredTypes.size());
                }
                if (issueStatParam.isBlank() || issueStatParam==null) {
                	filteredStatuses.addAll(allStatus);
                } else {
                	model.addAttribute("filterStatSize", filteredStatuses.size());
                }
                if (issuePrioParam.isBlank() || issuePrioParam==null) {
                	filteredPriorities.addAll(allPriorities);
                } else {
                	model.addAttribute("filterPrioSize", filteredPriorities.size());
                }
                if (issueSevParam.isBlank() || issueSevParam==null) {
                	filteredSeverity.addAll(allSeverities);
                } else {
                	model.addAttribute("filterSevSize", filteredSeverity.size());
                }
                if(issueAssignedParam.isBlank() || issueAssignedParam==null) {
                	filteredAssignee.addAll(allUsers);
                } else {
                	model.addAttribute("filterAssSize", filteredAssignee.size());
                }
                
                model.addAttribute("ticketsByProject", ticketService.findTicketsByProjects(filteredProjects, filteredTypes, filteredStatuses, filteredPriorities, filteredSeverity, filteredAssignee, Sort.by("ticketStatus")));
                
                
            	//model.addAttribute("filterAssSize", filteredAssignee.size());
                
                	
                
            }
            // Normal fetching of data if no parameters were blank
            else {
            	
            	model.addAttribute("filterProjSize", filteredProjects.size());
            	model.addAttribute("filterTypeSize", filteredTypes.size());
            	model.addAttribute("filterStatSize", filteredStatuses.size());
            	model.addAttribute("filterPrioSize", filteredPriorities.size());
            	model.addAttribute("filterSevSize", filteredSeverity.size());
            	model.addAttribute("filterAssSize", filteredAssignee.size());
            	
            	model.addAttribute("ticketsByProject", ticketService.findTicketsByProjects(filteredProjects, filteredTypes, filteredStatuses, filteredPriorities, filteredSeverity, filteredAssignee, Sort.by("ticketStatus"))); 
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
        
		String createdTicketKey = ticket.getTicketKey();
		
		return "redirect:/ticket/" + createdTicketKey;
	}
	
	@GetMapping("/ticket/{ticketKey}")
	public String ticketPage(@PathVariable String ticketKey,
			@Valid @ModelAttribute("newComment") Comment comment,
			BindingResult result,
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
		
		if(result.getFieldError()!=null) {
			model.addAttribute("commentErrorMsg", result.getFieldError().getDefaultMessage());
		}
		
		
		// Gets all the comments from the current ticket
		List<Comment> getTicketComments = theTicket.getComments();
		model.addAttribute("allComments", getTicketComments);
        
		for(Comment theComment : getTicketComments) {
			String aCommentModel = "theComment" + theComment.getId();
			model.addAttribute(aCommentModel, commentService.findCommentById(theComment.getId()));
		}
		
		
		return "ticketPage.jsp";
	}
	
	
	@PutMapping("/ticket/{ticketId}/edit")
	public String updateTicket (@Valid @ModelAttribute("ticketId") Ticket ticket, BindingResult resultTicket, @RequestParam("fileUrl") MultipartFile incomingFile,
								@PathVariable Long ticketId, Principal principal, Model model, RedirectAttributes redirectAttributes)
	{
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
        
        // Gets the key of current ticket
        String currentTicketKey = ticketService.findTicketById(ticketId).getTicketKey();
        
        ticket.setFileUrl(fileService.save(incomingFile));
        
        // Successfully updated ticket info
        ticketService.updateTicket(ticket);
		
		return "redirect:/ticket/"+currentTicketKey;
	}
	
	
	@PostMapping("/ticket/{ticketId}/comment/new")
	public String addComment (@PathVariable Long ticketId,
			Principal principal, 
			Model model, 
			Project project,
			Ticket ticket,
			@Valid @ModelAttribute("newComment") Comment comment,
			BindingResult result,
			RedirectAttributes redirectAttributes)
	{
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));

        
        // Gets the key of current ticket
        String currentTicketKey = ticketService.findTicketById(ticketId).getTicketKey();
        
        model.addAttribute("bindingResult", result);
        
        if(result.hasErrors()) 
        {
        	redirectAttributes.addFlashAttribute("commentErrorMsg", result.getFieldError().getDefaultMessage());
        	System.out.println(result.getFieldError().getDefaultMessage());
        	
        	return "redirect:/ticket/"+currentTicketKey;
        }
        // Successfully created a comment and redirect back to current page
        else {
        	commentService.createComment(comment);
    		return "redirect:/ticket/"+currentTicketKey;
        }
        
		
	}
	
	@PutMapping("/ticket/{ticketId}/comment/{id}/edit")
	public String editComment (@PathVariable Long ticketId, @PathVariable Long id, @Valid @ModelAttribute("theComment") Comment comment, 
			Principal principal, 
			Model model, 
			Project project,
			RedirectAttributes redirectAttributes)
	{
		// Gets the info of current logged user - MANDATORY for all paths
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
		
        // Gets the key of current ticket
        String currentTicketKey = ticketService.findTicketById(ticketId).getTicketKey();
        
           		
        // Successfully updated comment info
        commentService.updateComment(comment);
        
		return "redirect:/ticket/"+currentTicketKey;
	}
	
	
}