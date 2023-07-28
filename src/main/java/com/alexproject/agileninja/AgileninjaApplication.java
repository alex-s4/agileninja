package com.alexproject.agileninja;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;

import com.alexproject.agileninja.services.FileService;

@SpringBootApplication
@Controller
public class AgileninjaApplication implements CommandLineRunner{
	
	@Autowired
	private FileService fileService;

	public static void main(String[] args) {
		SpringApplication.run(AgileninjaApplication.class, args);
		
	}

	public void run (String... arg) throws Exception{
		this.fileService.init();
	}
	
}
