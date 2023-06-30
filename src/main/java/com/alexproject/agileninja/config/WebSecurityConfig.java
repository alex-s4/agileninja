package com.alexproject.agileninja.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class WebSecurityConfig {

	@Autowired
	private UserDetailsService userDetailsService;
	
	// Bcrypt
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
       
		// PLATFORM:  .requestMatchers("/css/**", "/js/**", "/registration").permitAll()
		// .requestMatchers used on Spring 3.0 Above use .antMatchers instead
		http.authorizeHttpRequests()
               .antMatchers("/css/**", "/js/**", "/img/**", "/registration", "/registrationAdmin").permitAll() //URL w/o Authentication
               .antMatchers("/admin/**").hasRole("ADMIN") // PLATFORM: .antMatchers("/admin/**").access("hasRole('ADMIN')") has ERROR [The method access(AuthorizationManager<RequestAuthorizationContext>) in the type AuthorizeHttpRequestsConfigurer<HttpSecurity>.AuthorizedUrl is not applicable for the arguments (String)]
               .antMatchers("/forum/**").hasAnyRole("ADMIN" , "USER") //URL That both ROLES has access 
               .anyRequest().authenticated()
                .and()
            .formLogin()
                .loginPage("/login") //default page on any route , REQUIRE LOGIN
                .permitAll()
                .and()
            .logout()
                .permitAll();
	
		return http.build();	
	}
		
	
		/** configureGlobal(AuthenticationManagerBuilder): 
		 * This method is configuring Spring Security to use our custom implementation 
		 * of the UserDetailsService with Bcrypt.
		 */
		public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
	        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder());
	    }
	
	
		
		// Other Notes:
		// Code generated/suggested from code below using LOMBOK library
//		http.
//                authorizeHttpRequests()
//                .antMatchers("/css/**", "/js/**", "/registration").permitAll()
//                .anyRequest().authenticated()
//                .and()
//                .formLogin(login -> login
//                        .loginPage("/login")
//                        .permitAll())
//                .logout(logout -> logout
//                        .permitAll());
//	
//		return http.build();	
		
}
