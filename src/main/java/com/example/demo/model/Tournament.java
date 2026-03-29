package com.example.demo.model;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "tournaments")
public class Tournament {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private String eventYear;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;

    private String startTime; // Reporting Time
    private double registrationFee;
    private String location;
    private String status;
    
	public int getId() {return id;}
	public void setId(int id) {this.id = id;}
	
	public String getName() {return name;}
	public void setName(String name) {this.name = name;}
	
	public String getEventYear() {return eventYear;}
	public void setEventYear(String eventYear) {this.eventYear = eventYear;}
	
	public LocalDate getStartDate() {return startDate;}
	public void setStartDate(LocalDate startDate) {this.startDate = startDate;}
	
	public LocalDate getEndDate() {return endDate;}
	public void setEndDate(LocalDate endDate) {this.endDate = endDate;}
	
	public String getStartTime() {return startTime;}
	public void setStartTime(String startTime) {this.startTime = startTime;}
	
	public double getRegistrationFee() {return registrationFee;}
	public void setRegistrationFee(double registrationFee) {this.registrationFee = registrationFee;}
	
	public String getLocation() {return location;}
	public void setLocation(String location) {this.location = location;}
	
	public String getStatus() {return status;}
	public void setStatus(String status) {this.status = status;}
	
	@OneToMany(mappedBy = "tournament", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<TournamentParticipant> participants;

	public int getParticipantsCount() {
	    return (participants != null) ? participants.size() : 0;
	}
    
}
