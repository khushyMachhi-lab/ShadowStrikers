package com.example.demo.model;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "payments")
public class Payment {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String invoiceNumber; // દા.ત. INV-2025-001
    private LocalDate paymentDate;
    private Double amount;
    private String paymentType; // Tuition Fee, Hostel Fee, વગેરે
    private String status; // Paid, Pending
    
    private String screenshotPath;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

	public Long getId() {return id;}
	public void setId(Long id) {this.id = id;}

	public String getInvoiceNumber() {return invoiceNumber;}
	public void setInvoiceNumber(String invoiceNumber) {this.invoiceNumber = invoiceNumber;}

	public LocalDate getPaymentDate() {return paymentDate;}
	public void setPaymentDate(LocalDate paymentDate) {this.paymentDate = paymentDate;}

	public Double getAmount() {return amount;}
	public void setAmount(Double amount) {this.amount = amount;}

	public String getPaymentType() {return paymentType;}
	public void setPaymentType(String paymentType) {this.paymentType = paymentType;}

	public String getStatus() {return status;}
	public void setStatus(String status) {this.status = status;}

	public User getUser() {return user;}
	public void setUser(User user) {this.user = user;}
	
	public String getScreenshotPath() {return screenshotPath;}
	public void setScreenshotPath(String screenshotPath) {this.screenshotPath = screenshotPath;}
	   
}
