package com.alexproject.agileninja.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestAPIController {
	
	
	@GetMapping("/issues")
	public String issueFilter(@RequestParam(value="proj",required=false) String pKeyParam,
    		@RequestParam(value="type", required=false) String issueTypeParam,
    		@RequestParam(value="status", required=false) String issueStatParam,
    		@RequestParam(value="prio", required=false) String issuePrioParam,
    		@RequestParam(value="severity", required=false) String issueSevParam,
    		@RequestParam(value="assigned", required=false) String issueAssignedParam)
	{
		return "You searched for " + pKeyParam;
	}

}
