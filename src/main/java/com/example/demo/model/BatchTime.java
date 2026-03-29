package com.example.demo.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "batches")
public class BatchTime {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String batchName;
    private String startTime;
    private String endTime;
    private String instructor;
    private String status; // Active, Full, Upcoming
    private String batchType; // Group or Personal
    private int totalCapacity;
    
    @Column(length = 500)
    private String trainingDays; // Stores as "Mon, Wed, Fri"
    
    private String meetLink; // Google Meet Link
    
    @Column(name = "is_live")
    private boolean isLive = false;

    // Default Constructor
    public BatchTime() {}

	public Long getId() {return id;}
	public void setId(Long id) {this.id = id;}

	public String getBatchName() {return batchName;}
	public void setBatchName(String batchName) {this.batchName = batchName;}

	public String getStartTime() {return startTime;}
	public void setStartTime(String startTime) {this.startTime = startTime;}

	public String getEndTime() {return endTime;}
	public void setEndTime(String endTime) {this.endTime = endTime;}

	public String getInstructor() {return instructor;}
	public void setInstructor(String instructor) {this.instructor = instructor;}

	public String getStatus() {return status;}
	public void setStatus(String status) {this.status = status;}

	public String getBatchType() {return batchType;}
	public void setBatchType(String batchType) {this.batchType = batchType;}

	public int getTotalCapacity() {return totalCapacity;}
    public void setTotalCapacity(int totalCapacity) {this.totalCapacity = totalCapacity;}

	public String getTrainingDays() {return trainingDays;}
	public void setTrainingDays(String trainingDays) {this.trainingDays = trainingDays;}

	public String getMeetLink() {return meetLink;}
	public void setMeetLink(String meetLink) {this.meetLink = meetLink;}

	public boolean isLive() {return isLive;}
	public void setLive(boolean isLive) {this.isLive = isLive;} 

}
