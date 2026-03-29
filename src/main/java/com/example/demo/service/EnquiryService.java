package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.demo.model.Enquiry;
import com.example.demo.repository.EnquiryRepository;

@Service
public class EnquiryService {
	
	@Autowired 
	private EnquiryRepository enquiryRepository;
	
    @Autowired 
    private JavaMailSender mailSender;

    public void processEnquiry(Enquiry enquiry) {
    	
    	if (enquiry.getStatus() == null || enquiry.getStatus().isEmpty()) {
            enquiry.setStatus("New");
        }
    	
        // 1. Save to Database for Dashboard
        enquiryRepository.save(enquiry);

        // 2. Send Email to Admin
        SimpleMailMessage mail = new SimpleMailMessage();
        mail.setTo("khushy.navik1997@gmail.com"); // Your Admin Email
        mail.setSubject("New Web Enquiry: " + enquiry.getSubject());
        mail.setText("From: " + enquiry.getFullName() + " (" + enquiry.getEmail() + "\nPhone: " + enquiry.getPhone() +")\n\n" + 
                     "Message: " + enquiry.getMessage());
        
        mailSender.send(mail);
    }
    
    // Add this to help the Controller
    public List<Enquiry> getAllEnquiries() {
        return enquiryRepository.findAllByOrderBySubmittedAtDesc();
    }
    
    public void saveEnquiry(Enquiry enquiry) {
        enquiryRepository.save(enquiry);
    }

    // Add this for the Dashboard count card
    public long getTotalCount() {
        return enquiryRepository.count();
    }
    
    public long getCountByStatus(String status) {
        return enquiryRepository.countByStatus(status);
    }

    public long getHighPriorityCount() {
        return enquiryRepository.countBySubjectContainingIgnoreCase("High");
    }
    
    public void deleteEnquiryById(Long id) {
        enquiryRepository.deleteById(id);
    }

    public Enquiry getEnquiryById(Long id) {
        return enquiryRepository.findById(id).orElse(null);
    }
    
    public void updateEnquiry(Enquiry enquiry) {       
        enquiryRepository.save(enquiry); // .save() works for both inserting new records and updating existing ones
    }

}
