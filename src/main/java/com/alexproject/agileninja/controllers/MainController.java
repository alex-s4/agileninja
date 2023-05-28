package com.alexproject.agileninja.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.alexproject.agileninja.services.UserService;
import com.alexproject.agileninja.models.LoginUser;
import com.alexproject.agileninja.models.User;

@Controller
public class MainController {

	@Autowired
	UserService userServ;
	
	@GetMapping("/")
	public String index(Model mv)
	{
		mv.addAttribute("newUser", new User());
		mv.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}
}
