package com.alexproject.agileninja.controllers;

import java.security.Principal;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alexproject.agileninja.models.User;
import com.alexproject.agileninja.services.UserService;
import com.alexproject.agileninja.validator.UserValidator;

@Controller
public class Users {
	
	@Autowired
	private UserService userService;
	
	@Autowired 
	private UserValidator userValidator;
	
	// Registration via Spring Security
	@GetMapping("/registration")
    public String registerForm(@Valid @ModelAttribute("user") User user) {
        return "registrationPage.jsp";
    }
    
	@PostMapping("/registration")
	public String registration(
			@Valid @ModelAttribute("user") User user,
			BindingResult result,
			Model model,
			HttpSession session,
			RedirectAttributes redirectAttributes) 
	{
		
		// Use the validation from UserValidator class
		userValidator.validate(user, result);
		
		if(result.hasErrors()) {
			return "registrationPage.jsp";
		}
		else {
			// Error if username already exists
			if (userService.findByUsername(user.getUsername())!=null) {
				redirectAttributes.addFlashAttribute("registrationMessageError", "Username is already taken");
				return "redirect:/registration";
			} else {
				userService.saveWithUserRole(user);
				return "redirect:/login";
			}
			
			
		}
		
	}
	
	@PostMapping("/registrationAdmin")
	public String registrationAdmin(
			@Valid @ModelAttribute("user") User user,
			BindingResult result,
			Model model,
			HttpSession session,
			RedirectAttributes redirectAttributes)
	{
		// Use the validation from UserValidator class
		userValidator.validate(user, result);
		
		if(result.hasErrors()) {
			return "registrationPage.jsp";
		} else {
			// Error if username already exists
			if (userService.findByUsername(user.getUsername())!=null) {
				redirectAttributes.addFlashAttribute("registrationMessageError", "Username is already taken");
				return "redirect:/registration";
			} else {
				userService.saveUserWithAdminRole(user);
				return "redirect:/login";
			}
		}
		
	}
	
	
	// Login via Spring Security
	// Additional error validations upon logging in
    @GetMapping(value={"/login"})
    public String login(@RequestParam(value="error", required=false) String error, 
    		@RequestParam(value="logout", required=false) String logout, 
    		Model model) {
    	if(error != null) {
            model.addAttribute("errorMessage", "Login Failed, Please try again.");
        }
    	if(logout != null) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
    	
        return "loginPage.jsp";
    }
    
    
    
    
    
    
}
