package com.example.demo.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Payment;
import com.example.demo.model.User;
import com.example.demo.repository.PaymentRepository;

@Service
public class PaymentService {
	
	@Autowired
    private PaymentRepository paymentRepository;
	
	public String saveScreenshot(MultipartFile file) throws IOException {
	    String uploadDir = "src/main/resources/static/payment-screenshots/";
	    Path uploadPath = Paths.get(uploadDir);

	    if (!Files.exists(uploadPath)) {
	        Files.createDirectories(uploadPath);
	    }

	    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	    try (InputStream inputStream = file.getInputStream()) {
	        Path filePath = uploadPath.resolve(fileName);
	        Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	    }
	    return fileName; 
	}
	
    public List<Payment> getPaymentsByUser(User user) {
        return paymentRepository.findByUserOrderByPaymentDateDesc(user);
    }

    // ૨. પેમેન્ટ સેવ કરવા માટે (જો તમારે જરૂર હોય તો)
    public Payment savePayment(Payment payment) {
        return paymentRepository.save(payment);
    }
    
    public Payment getPaymentById(Long id) {
        return paymentRepository.findById(id).orElse(null);
    }
    
    public List<Payment> getAllPayments() {
        return paymentRepository.findAll();
    }

    public Double getTotalRevenue() {
        Double revenue = paymentRepository.sumTotalRevenue();
        return (revenue != null) ? revenue : 0.0;
    }

    public Double getTotalPendingDues() {
        Double pending = paymentRepository.sumTotalPending();
        return (pending != null) ? pending : 0.0;
    }

    public double getTotalCollectedFees() {
        return getTotalRevenue();
    }

}
