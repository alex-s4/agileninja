package com.alexproject.agileninja.models;

import java.text.SimpleDateFormat;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="tickets")
public class Ticket {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @NotEmpty(message="Ticket name should not be empty")
    private String ticketName;
    
    @Size(min=1, message="Please insert description")
    private String ticketDescription;
    
    private String ticketKey;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="project_id")
    private Project project;

    
    // One status can hold many tickets
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="status_id")
    private Status ticketStatus;
    
    // One severity can hold many tickets
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="severity_id")
    private Severity ticketSeverity;
    
    // One status can hold many tickets
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="priority_id")
    private Priority ticketPriority;
    
    // One type can hold many tickets
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="type_id")
    private Type ticketType;
    
    // Many to Many relationship with Tags
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
    		name="ticket_tag",
    		joinColumns=@JoinColumn(name="ticket_id"),
    		inverseJoinColumns=@JoinColumn(name="tag_id"))
    private List<Tag> tags;
    
    
    
    // A ticket can hold many comments
	@OneToMany(mappedBy="ticket", fetch=FetchType.LAZY)
	private List<Comment> comments;
	
	
	
	
	// User who created the ticket
	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="reporterUser_id")
	private User reporter;
	
	// User who got assigned to the ticket
	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="assignedUser_id")
	private User assignee;
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
    
    public Ticket() {}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	public String getTicketName() {
		return ticketName;
	}
	public void setTicketName(String ticketName) {
		this.ticketName = ticketName;
	}
	public String getTicketDescription() {
		return ticketDescription;
	}
	public void setTicketDescription(String ticketDescription) {
		this.ticketDescription = ticketDescription;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public Status getTicketStatus() {
		return ticketStatus;
	}
	public void setTicketStatus(Status ticketStatus) {
		this.ticketStatus = ticketStatus;
	}
	public Severity getTicketSeverity() {
		return ticketSeverity;
	}
	public void setTicketSeverity(Severity ticketSeverity) {
		this.ticketSeverity = ticketSeverity;
	}
	public Priority getTicketPriority() {
		return ticketPriority;
	}
	public void setTicketPriority(Priority ticketPriority) {
		this.ticketPriority = ticketPriority;
	}
	public Type getTicketType() {
		return ticketType;
	}
	public void setTicketType(Type ticketType) {
		this.ticketType = ticketType;
	}
	public List<Tag> getTags() {
		return tags;
	}
	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public User getReporter() {
		return reporter;
	}
	public void setReporter(User reporter) {
		this.reporter = reporter;
	}
	public User getAssignee() {
		return assignee;
	}
	public void setAssignee(User assignee) {
		this.assignee = assignee;
	}
	public String getTicketKey() {
		return ticketKey;
	}
	public void setTicketKey(String ticketKey) {
		this.ticketKey = ticketKey;
	}
	
	// Formatted Date and Time
	private static final String DATE_AND_TIME_PATTERN = "dd-MMM-yyyy h:mm a";
	private static final String DATE_PATTERN = "dd-MMM-yyyy";
	
	public String getCreatedAtFormatted() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_AND_TIME_PATTERN);
		String formattedDate = simpleDateFormat.format(createdAt);
		return formattedDate;
	}
	
	public String getUpdatedAtFormatted() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_AND_TIME_PATTERN);
		String formattedDate = simpleDateFormat.format(updatedAt);
		return formattedDate;
	}
	
	public String getCreatedAtFormattedDateOnly() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_PATTERN);
		String formattedDate = simpleDateFormat.format(createdAt);
		return formattedDate;
	}
	
	public String getUpdatedAtFormattedDateOnly() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_PATTERN);
		String formattedDate = simpleDateFormat.format(updatedAt);
		return formattedDate;
	}
    
}
