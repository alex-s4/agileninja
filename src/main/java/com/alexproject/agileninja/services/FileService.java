package com.alexproject.agileninja.services;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService {

	private final Path root = Paths.get("uploads");
	
	public void init() throws IOException{
		if (!Files.exists(root)) {
			try {
				Files.createDirectories(root);
			} catch (IOException e) {
				throw new RuntimeException("Download folder not initialized");
			}
		}
	}
	
	public String save(MultipartFile file) {
		try {
			Path savepath = this.root.resolve(file.getOriginalFilename());
			Files.copy(file.getInputStream(), savepath);
			return savepath.toString();
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
		
	}
	
	
	// Load to view the file
	public Resource load(String fileName) {
		try {
			Path file = root.resolve(fileName);
			Resource resource = new UrlResource(file.toUri());
			if(resource.exists() || resource.isReadable()) {
				return resource;
			}else {
				throw new RuntimeException("File Not Readable");
			}
		} catch (MalformedURLException e) {
			throw new RuntimeException("Error:" + e.getMessage());
		}
	}
	
	
}
