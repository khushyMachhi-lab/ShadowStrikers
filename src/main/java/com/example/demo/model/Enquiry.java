package com.example.demo.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "enquiries")
public class Enquiry {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String fullName;
    private String email;
    private String subject;
    
    @Column(columnDefinition = "TEXT")
    private String message;
    
    @Column(name = "phone")
    private String phone;
    private String status;
    
    private LocalDateTime submittedAt;

    @PrePersist
    protected void onCreate() {
    	this.submittedAt = LocalDateTime.now();
    }

	public Long getId() {return id;}
	public void setId(Long id) {this.id = id;}

	public String getFullName() {return fullName;}
	public void setFullName(String fullName) {this.fullName = fullName;}

	public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}

	public String getSubject() {return subject;}
	public void setSubject(String subject) {this.subject = subject;}

	public String getMessage() {return message;}
	public void setMessage(String message) {this.message = message;}
	
	public String getPhone() {return phone;}
	public void setPhone(String phone) {this.phone = phone;}

	public String getStatus() {return status;}
	public void setStatus(String status) {this.status = status;}

	public LocalDateTime getSubmittedAt() {return submittedAt;}
	public void setSubmittedAt(LocalDateTime submittedAt) {this.submittedAt = submittedAt;}
    
	public String getOnlyDate() {
	    if (this.submittedAt != null) {
	        return this.submittedAt.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
	    }
	    return "";
	}
}
