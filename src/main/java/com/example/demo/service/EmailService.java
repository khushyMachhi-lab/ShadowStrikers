package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	
	@Autowired
    private JavaMailSender mailSender;

    public void sendRegistrationEmail(String toEmail, String username) {
       
            if (toEmail == null || toEmail.isBlank()) {
                // Log a specific error instead of crashing
                System.err.println("ERROR: Cannot send email. Recipient email address is null or empty.");
                return;
            }
            
        SimpleMailMessage message = new SimpleMailMessage();
            
        // Use your configured email address as the sender
        message.setFrom("khushy.navik1997@gmail.com"); 
        message.setTo(toEmail);
        message.setSubject("Welcome, " + username + "!");
        
        String text = "Dear " + username + ",\n\n"
                    + "Thank you for registering! Your account has been successfully created."
                    + " We are excited to have you on board.\n\n"
                    + "Best regards,\n"
                    + "The Support Team";
                    
        message.setText(text);
        
        // Send the email
        mailSender.send(message);
        System.out.println("Registration Email Sent Successfully to: " + toEmail);
    }
    
    public void sendOtpEmail(String toEmail, String otp, String username) {
        if (toEmail == null || toEmail.isBlank()) {
            System.err.println("ERROR: Cannot send OTP. Recipient email address is null or empty.");
            return;
        }

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("khushy.navik1997@gmail.com"); 
        message.setTo(toEmail);
        message.setSubject("ShadowStrike - Password Reset OTP");

        String text = "Dear " + username + ",\n\n"
                    + "Your One-Time Password (OTP) for resetting your password is: " + otp + "\n\n"
                    + "This code is valid for 5 minutes. If you did not request this, please ignore this email.\n\n"
                    + "Best regards,\n"
                    + "The ShadowStrike Team";

        message.setText(text);
        mailSender.send(message);
        System.out.println("OTP Sent Successfully to: " + toEmail);
    }

}
