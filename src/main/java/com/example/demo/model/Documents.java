package com.example.demo.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "student_documents")
public class Documents {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ફાઈલના નામ ડેટાબેઝમાં સ્ટોર થશે
    private String idProof; 
    private String medicalCertificate;
    
    private String status;
    private String remarks;
    
    @OneToOne
    @JoinColumn(name = "user_id") // User ટેબલ સાથે જોડાણ
    private User user;

	public Long getId() {return id;}
	public void setId(Long id) {this.id = id;}

	public String getIdProof() {return idProof;}
	public void setIdProof(String idProof) {this.idProof = idProof;}

	public String getMedicalCertificate() {return medicalCertificate;}
	public void setMedicalCertificate(String medicalCertificate) {this.medicalCertificate = medicalCertificate;}

	public String getStatus() {return status;}
	public void setStatus(String status) {this.status = status;}
	
	public String getRemarks() {return remarks;}
	public void setRemarks(String remarks) {this.remarks = remarks;}
	
	public User getUser() {return user;}
	public void setUser(User user) {this.user = user;}	

}
