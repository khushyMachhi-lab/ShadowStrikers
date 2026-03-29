package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.model.Enquiry;

public interface EnquiryRepository extends JpaRepository<Enquiry, Long> {
	// fetch all enquiries and sort them by the submission date (Newest first)
	List<Enquiry> findAllByOrderBySubmittedAtDesc();
	
	long countByStatus(String status);
	long countBySubjectContainingIgnoreCase(String keyword);
} 