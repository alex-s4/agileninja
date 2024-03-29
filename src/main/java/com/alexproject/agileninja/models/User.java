package com.alexproject.agileninja.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;


@Entity
@Table(name="users")
public class User {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	// @NotEmpty(message="Username is required!")
    @Pattern(regexp="[A-Za-z]*$", message="Name must contain letters only")
    @Size(min=1, message="Please enter your first name.")
    private String firstName;
    
    // @NotEmpty(message="Username is required!")
    @Pattern(regexp="[A-Za-z]*$", message="Name must contain letters only")
    @Size(min=1, message="Please enter your last name.")
    private String lastName;
    
    @Size(min=3, message="Username must have at least 3 characters")
    private String username;
    
    // @NotEmpty(message="Email is required!")
    @Email(message="Please enter a valid email!")
    private String email;
    
    // private String role;
    
    // @NotEmpty(message="Password is required!")
    @Size(min=8, max=128, message="Password must be between 8 and 128 characters")
    private String password;
    
    @Transient
    @Size(min=8, max=128, message="Confirm Password must be between 8 and 128 characters")
    private String confirm;
    
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @OneToMany(mappedBy="projectOwner", fetch=FetchType.LAZY)
    private List<Project> projectsCreated;

    
    // A user can own many comments
    @OneToMany(mappedBy="user", fetch=FetchType.LAZY)
    private List<Comment> comments;
    
    // Ticket created by the user
    @OneToMany(mappedBy="reporter", fetch=FetchType.LAZY)
    private List<Ticket> ticketsCreated;
    
    // Ticket assigned from the user
    @OneToMany(mappedBy="assignee", fetch=FetchType.LAZY)
    private List<Ticket> ticketsAssigned;
    
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "users_roles", 
        joinColumns = @JoinColumn(name = "user_id"), 
        inverseJoinColumns = @JoinColumn(name = "role_id"))
    private List<Role> roles;
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
    public User() {}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public List<Project> getProjectsCreated() {
		return projectsCreated;
	}
	public void setProjectsCreated(List<Project> projectsCreated) {
		this.projectsCreated = projectsCreated;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public List<Ticket> getTicketsCreated() {
		return ticketsCreated;
	}
	public void setTicketsCreated(List<Ticket> ticketsCreated) {
		this.ticketsCreated = ticketsCreated;
	}
	public List<Ticket> getTicketsAssigned() {
		return ticketsAssigned;
	}
	public void setTicketsAssigned(List<Ticket> ticketsAssigned) {
		this.ticketsAssigned = ticketsAssigned;
	}
    public List<Role> getRoles() {
        return roles;
    }
    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
    
	
	// Custom methods
	public String getFullName() {
		String fullName = getFirstName() + " " + getLastName();
		return fullName;
	}
    
}
