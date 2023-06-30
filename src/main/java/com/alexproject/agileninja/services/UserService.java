package com.alexproject.agileninja.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.User;
import com.alexproject.agileninja.repository.RoleRepository;
import com.alexproject.agileninja.repository.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	@Autowired
    private RoleRepository roleRepository;
	@Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	
	// Saves a client with only the user role
	public void saveWithUserRole(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepository.findByName("ROLE_USER"));
        userRepository.save(user);
    }
	
	
	// Saves a client with only the admin role
	public void saveUserWithAdminRole(User user) {
		
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepository.findAllById((long) 2));
        userRepository.save(user);
    }    
	
	
	// Finds a user by their Username
	public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
	
	
}
