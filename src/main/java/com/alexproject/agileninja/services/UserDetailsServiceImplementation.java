package com.alexproject.agileninja.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.alexproject.agileninja.models.Role;
import com.alexproject.agileninja.models.User;
import com.alexproject.agileninja.repository.UserRepository;

@Service
public class UserDetailsServiceImplementation implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;
	
	/** 
	// Finds the user by their username. If a user is found, it returns it 
	// with the correct authorities. If the username does not exist, the method 
	// throws an error.
	**/ 
	@Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username);
        
        if(user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), getAuthorities(user));
    }
	
	/**
	 Returns a list of authorities/permissions for a specific user. For example, 
	 our clients can be 'user', 'admin', or both. For Spring Security to implement 
	 authorization, we must get the name of the possibles roles for current user 
	 from our database and create a new `SimpleGrantedAuthority' object with those roles.
	**/
	private List<GrantedAuthority> getAuthorities(User user){
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        for(Role role : user.getRoles()) {
            GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(role.getName());
            authorities.add(grantedAuthority);
        }
        return authorities;
	}
	
	
}
