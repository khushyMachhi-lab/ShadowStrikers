package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.demo.model.Payment;
import com.example.demo.model.User;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
	
	List<Payment> findByStatus(String status);
	
    List<Payment> findByUserOrderByPaymentDateDesc(User user);
    
    List<Payment> findTop5ByOrderByPaymentDateDesc();

    @Query("SELECT SUM(p.amount) FROM Payment p WHERE p.status = 'Paid'")
    Double sumTotalRevenue();

    @Query("SELECT SUM(p.amount) FROM Payment p WHERE p.status = 'Pending'")
    Double sumTotalPending();
    
    @Query("SELECT p FROM Payment p WHERE p.status = 'Pending' ORDER BY p.id DESC")
    List<Payment> findUpcomingDuePayments();
}