package com.example.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.User;
import com.example.demo.repository.AdmissionsRepository;
import com.example.demo.repository.UserRepository;

@Service 
@Transactional
public class UserService {
	
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private AdmissionsRepository admissionsRepository;

    @Autowired
    @Lazy
    private EmailService emailService;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
   
    @Value("${file.upload-dir:./src/main/resources/static/user-photos/}") 
    private String uploadDir;
    
    // --- PHOTO MANAGEMENT --- //
    public void savePhotoFile(User user, MultipartFile multipartFile) throws IOException {
        try {
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) { 
                Files.createDirectories(uploadPath);
            }

            // Deletion Logic
            if (user.getPhoto() != null && !user.getPhoto().isEmpty()) {
                try {
                    Path oldFilePath = uploadPath.resolve(user.getPhoto());
                    Files.deleteIfExists(oldFilePath);
                } catch (IOException e) {
                    logger.warn("Could not delete old photo for user {}: {}", user.getId(), e.getMessage());
                }
            }

            // New File Logic
            String fileName = user.getId() + "_" + System.currentTimeMillis() + "_" + multipartFile.getOriginalFilename();
            
            try (var inputStream = multipartFile.getInputStream()) {
                Path filePath = uploadPath.resolve(fileName);
                Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
            } 

            user.setPhoto(fileName);
            userRepository.save(user); 
            logger.info("Photo saved successfully for user ID: {}", user.getId());
            
        } catch (IOException e) {
            logger.error("IO Exception while saving photo: {}", e.getMessage());
            throw new IOException("Failed to store file", e);
        }
    }

    // --- USER REGISTRATION --- //
    public User registerUser(User user) {
        try {
            
            // Password hashing
            if (user.getPassword() != null) {
                user.setPassword(passwordEncoder.encode(user.getPassword()));
            }

            User savedUser = userRepository.save(user);

            // Email Sending with Try-Catch
            try {
                emailService.sendRegistrationEmail(savedUser.getEmail(), savedUser.getUserName());
            } catch (Exception e) {
                logger.error("Registration email failed for {}: {}", savedUser.getEmail(), e.getMessage());
            }

            return savedUser;
        } catch (Exception e) {
            logger.error("Error during user registration: {}", e.getMessage());
            throw e; 
        }
    }
    
    // --- AUTHENTICATION & SEARCH --- //
    public User authenticate(String loginId, String password) {
        try {
        	User user = userRepository.findByEmail(loginId).orElse(null);
        	
        	if (user == null) {
                user = userRepository.findByUserName(loginId).orElse(null);
            }
        	
            if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            	logger.info("Login successful for: {}", loginId);
                return user;
            }
        } catch (Exception e) {
        	logger.error("Authentication error for {}: {}", loginId, e.getMessage());
        }
        return null;
    }
    
    // --- READ Single User by UserName --- //
    public User findByUserName(String userName) { 
    	return userRepository.findByUserName(userName).orElse(null);
    }
    
    // --- READ User Email id --- //
    public User findByEmail(String email) { 
    	return userRepository.findByEmail(email).orElse(null);
    }
    
    // --- READ Single User by ID --- //
    public Optional<User> getUserById(int id) { 
    	return userRepository.findById(id); 
    }
    
    // --- READ (Get all registered users) --- //
    public List<User> getAllUsers() { return userRepository.findAll(); }
        
    // --- PASSWORD UPDATE --- //
    public void updatePassword(String email, String newPassword) {
        try {
        	User user = userRepository.findByEmail(email).orElse(null);
            if (user != null) {
                user.setPassword(passwordEncoder.encode(newPassword)); 
                userRepository.save(user);
                logger.info("Password updated for user: {}", email);
            }
        } catch (Exception e) {
            logger.error("Error updating password for {}: {}", email, e.getMessage());
        }
    }	
   
    // --- DASHBOARD --- //
    public long getTotalAdmissionsCount() { return userRepository.count(); }

    public long getActiveStatusCount() {
        
        try {
            return admissionsRepository.countByStatusIgnoreCase("Active");
        } catch (Exception e) {
            return 0;
        }
    }  

    // --- UPDATE & DELETE --- //
    public User updateUser(User userDetails) { 
        return userRepository.save(userDetails); 
    }
    
    public void deleteUser(int id) { 
        try {
            userRepository.deleteById(id); 
        } catch (Exception e) {
            logger.error("Error deleting user {}: {}", id, e.getMessage());
        }
    }
    
    public User getUserProfileById(Long id) {
        // ID દ્વારા સ્ટુડન્ટની બધી જ ડિટેલ્સ (Personal + Admissions) મેળવો
        return userRepository.findById(id).orElse(null);
    }
}
