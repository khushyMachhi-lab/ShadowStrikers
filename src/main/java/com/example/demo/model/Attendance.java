package com.example.demo.model;

import java.time.LocalDate;
import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(name="attendance", uniqueConstraints = {
	    @UniqueConstraint(columnNames = {"user_id", "date"})
	})
public class Attendance {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

	private LocalDate date;
    private LocalTime startTime;
    private LocalTime endTime;
    private String status; // e.g., "Present", "Absent"

    @ManyToOne
    @JoinColumn(name = "user_id") // Links to your User entity
    @JsonIgnore
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "batch_id")
    @JsonIgnore
    private BatchTime batch;

    public Attendance() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }
    
    public LocalTime getStartTime() {return startTime;}
	public void setStartTime(LocalTime startTime) {this.startTime = startTime;}

	public LocalTime getEndTime() {return endTime;}
	public void setEndTime(LocalTime endTime) {this.endTime = endTime;}

	public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public BatchTime getBatch() { return batch; }
    public void setBatch(BatchTime batch) { this.batch = batch; }

}
