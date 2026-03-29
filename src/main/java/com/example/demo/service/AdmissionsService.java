package com.example.demo.service;

import java.time.LocalDate;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Admissions;
import com.example.demo.model.User;
import com.example.demo.repository.AdmissionsRepository;
import com.example.demo.repository.UserRepository;

@Service
public class AdmissionsService {
	
	private static final Logger logger = LoggerFactory.getLogger(AdmissionsService.class);
	
	@Autowired
    private AdmissionsRepository admissionsRepository;

    @Autowired
    private UserRepository userRepository;
    
    // --- ENROLL STUDENT --- //
    public void enrollStudent(int userId, String courseName) {
        try {
            // Optional handling: .orElse(null) વાપરીને યુઝર મેળવો
            User user = userRepository.findById(userId).orElse(null);
            
            if (user != null) {
                
            	Admissions admission = user.getAdmissions();
            	if (admission == null) {
                    admission = new Admissions();
                    admission.setUser(user);
                    user.setAdmissions(admission);
                }
            	
            	String trimmedCourse = courseName.trim();
                admission.setCourseName(trimmedCourse);
                
                LocalDate today = LocalDate.now();
                admission.setJoinDate(today); 
                admission.setAdmissionDate(today);
                admission.setStatus("Active");
                admission.setPaymentStatus("Pending");

                // --- COURSE-WISE FEES LOGIC --- //
                admission.setTotalFees(switch (trimmedCourse) {
                    case "Kick-Boxing" -> 4000.0;
                    case "Mixed Martial Arts (MMA)" -> 6000.0;
                    case "Self Defense" -> 3000.0;
                    case "Stick" -> 3000.0;
                    case "Tonfa" -> 5000.0;
                    case "Baton" -> 5000.0;
                    case "Women's Self-Defense" -> 3000.0;
                    case "Personal Training (Any Technique)" -> 20000.0;
                    default -> 1500.0;
                });
                
                // --- EXPIRY LOGIC --- //
                admission.setExpiryDate(switch (trimmedCourse) {
                        case "Kick-Boxing" -> today.plusMonths(3);
                        case "Mixed Martial Arts (MMA)" -> today.plusMonths(6);
                        case "Self Defense" -> today.plusMonths(3);
                        case "Stick" -> today.plusMonths(2);
                        case "Tonfa" -> today.plusMonths(3);
                        case "Baton" -> today.plusMonths(3);
                        case "Women's Self-Defense" -> today.plusMonths(2);
                        case "Personal Training (Any Technique)" -> today.plusMonths(4);
                        default -> today.plusMonths(1);
                    });
                
                user.setAdmissions(admission);
                userRepository.save(user); 
                logger.info("User ID {} successfully enrolled in {}", userId, courseName);}
        		} catch (Exception e) {
                    logger.error("Error in enrollStudent: {}", e.getMessage());
                    throw e;
        }
    }

    // --- UPDATE ADMISSION DETAILS (Admin Dashboard) --- //
    public void updateAdmissionDetails(int userId, String phone, Double weight, String status) {
        try {
            Admissions admission = admissionsRepository.findByUserId(userId).orElse(null);

            if (admission == null) {
                User user = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
                
                admission = new Admissions();
                admission.setUser(user);
                admission.setJoinDate(LocalDate.now()); 
            }

            admission.setPhone(phone);
            admission.setWeight(weight);
            
            if (status != null) {
                admission.setStatus(status);
            }

            admissionsRepository.save(admission);
            logger.info("Admission record updated for User ID: {}", userId);
        } catch (Exception e) {
            logger.error("Error updating details: {}", e.getMessage());
            throw e;
        }
    }
    
    // --- DASHBOARD METHODS --- //
    public long getNewRegistrationsCount() {
        try {
            return admissionsRepository.findByJoinDate(LocalDate.now()).size();
        } catch (Exception e) {
            logger.error("Error fetching today's registration count: {}", e.getMessage());
            return 0;
        }
    }

    public List<Admissions> getRecentAdmissions() {
        try {
            LocalDate today = LocalDate.now();
            LocalDate rangeStart = today.minusDays(5);
            return admissionsRepository.findByJoinDateBetween(rangeStart, today);
        } catch (Exception e) {
            logger.error("Error fetching recent admissions: {}", e.getMessage());
            return List.of(); 
        }
    }
    
    public long getActiveAdmissionsCount() {
        try {
            return admissionsRepository.countByStatusIgnoreCase("Active");
        } catch (Exception e) {
            logger.error("Error counting active admissions: {}", e.getMessage());
            return 0;
        }
    }
    
    // Get all admissions for the Admin Dashboard
    public List<Admissions> getAllAdmissions() {
        return admissionsRepository.findAll();
    }

    public Admissions getAdmissionByUserId(int userId) {
        return admissionsRepository.findByUserId(userId).orElse(null);
    }
    
    public List<User> getAllUsersWithAdmissionDetails() {
        return admissionsRepository.findAllUsersWithAdmissions();
    }

}
