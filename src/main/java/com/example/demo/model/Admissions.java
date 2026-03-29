package com.example.demo.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "admissions")
public class Admissions {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
	
	private String phone;
    private Double weight;
    
    private String courseName; 
    private Double totalFees;
	private String paymentStatus;
	private String status = "Active";
    private LocalDate joinDate = LocalDate.now();
	
	@Column(name = "admission_date")
	private LocalDate admissionDate = LocalDate.now();
	
	private LocalDate expiryDate;
	
	@OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false) 
    private User user;
   
	public int getId() {return id;}
	public void setId(int id) {this.id = id;}
	
	public String getPhone() {return phone;}
	public void setPhone(String phone) {this.phone = phone;}
	
	public Double getWeight() {return weight;}
	public void setWeight(Double weight) {this.weight = weight;}
	
	public String getCourseName() {return courseName;}
	public void setCourseName(String courseName) {this.courseName = courseName;}

	public Double getTotalFees() {return totalFees;}
	public void setTotalFees(Double totalFees) {this.totalFees = totalFees;}
	
	public String getPaymentStatus() {return paymentStatus;}
	public void setPaymentStatus(String paymentStatus) {this.paymentStatus = paymentStatus;}
	
	public String getStatus() {return status;}
	public void setStatus(String status) {this.status = status;}
	
	public LocalDate getJoinDate() {return joinDate;}
	public void setJoinDate(LocalDate joinDate) {this.joinDate = joinDate;}
	
	public LocalDate getAdmissionDate() {return admissionDate;}
	public void setAdmissionDate(LocalDate admissionDate) {this.admissionDate = admissionDate;}
	
	public LocalDate getExpiryDate() {return expiryDate;}
	public void setExpiryDate(LocalDate expiryDate) {this.expiryDate = expiryDate;}
	
	public User getUser() {return user;}
	public void setUser(User user) {this.user = user;}
	
}
