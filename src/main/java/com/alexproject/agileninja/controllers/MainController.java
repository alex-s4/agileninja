package com.alexproject.agileninja.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.alexproject.agileninja.models.Project;
import com.alexproject.agileninja.services.UserService;

@Controller
public class MainController {
	
	@Autowired
	private UserService userService;

	@GetMapping(value = {"/", "/dashboard"})
    public String index(
    		Principal principal, Model model) {
    	String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
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
