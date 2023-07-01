package com.alexproject.agileninja.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.models.Ticket;
import com.alexproject.agileninja.services.PriorityService;
import com.alexproject.agileninja.services.ProjectService;
import com.alexproject.agileninja.services.SeverityService;
import com.alexproject.agileninja.services.StatusService;
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
	

	@GetMapping(value = {"/", "/dashboard"})
    public String index(
    		Principal principal, Model model, Project project, Ticket ticket) {
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
        
        
        return "index.jsp";
    }
	
//	@GetMapping("/project/new")
//    public String createProject(@Valid @ModelAttribute("project") Project project, BindingResult result,
//    		Principal principal, Model model) {
//    	
//        return "index.jsp";
//    }
//	
	
}
