package com.example.demo.controller;

import java.io.IOException;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.model.Enquiry;
import com.example.demo.model.User;
import com.example.demo.service.EmailService;
import com.example.demo.service.EnquiryService;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;


@Controller
@RequestMapping("/") // Base mapping for the application
public class commonController {
	
	@Autowired
    private UserService userService;
	
	@Autowired
    private EnquiryService enquiryService;
	
	@Autowired
    private EmailService emailService;
	
	@GetMapping("/home")
	public String userHome() {
	    return "common/home-page";
	}
	
	@GetMapping("/aboutUs")
	public String userAboutUs() {
	    return "common/aboutUs-page";
	}
	
	@GetMapping("/courses")
	public String userCourses() {
	    return "common/courses-page";
	}
	
	@GetMapping("/gallery")
	public String userGallery() {
	    return "common/gallery-page";
	}
	
	@GetMapping("/events")
	public String userEvents() {
	    return "common/events-page";
	}
	
	@GetMapping("/contactUs")
	public String userContactUs() {
	    return "common/contactUs-page";
	}
	
	// --- NEW METHOD: HANDLE CONTACT FORM SUBMISSION --- //
    @PostMapping("/sendEnquiry")
    public String handleEnquiry(@ModelAttribute Enquiry enquiry, RedirectAttributes redirectAttributes) {
    	
    	// Manually setting them here if they aren't in the form
        if (enquiry.getStatus() == null) enquiry.setStatus("New");
    	
        // 1. Save to DB and Send Email via the service
        enquiryService.processEnquiry(enquiry);
        
        // 2. Add a success message for the JSP
        redirectAttributes.addFlashAttribute("enquirySuccess", "Thank you! Your message has been sent.");
        
        // 3. Redirect back to contact page to avoid form re-submission on refresh
        return "redirect:/contactUs";
    }
	
	// ====================================================================
    // 1. REGISTRATION FLOW
    // ====================================================================
	
	
	// --- 1. SHOW REGISTRATION FORM (GET: /register) --- //
    @GetMapping("/register")
    public String showRegistrationForm(@RequestParam(value = "course", required = false) String selectedCourse, Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("selectedCourse", selectedCourse); 
        return "forms/registration-page";
    }

    // --- 2. SUBMIT REGISTRATION FORM (POST: /register) --- //
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult bindingResult, @RequestParam("image") MultipartFile multipartFile,
    Model model) throws IOException { 

    // 1. CHECK FOR VALIDATION ERRORS
        if (bindingResult.hasErrors()) {
            return "forms/registration-page"; 
        }

        // 2. CHECK FOR USERNAME UNIQUENESS
        // Check if the userName is unique (a common service-layer check, 
        // often done with a custom validator, but shown here for context)
        if (userService.findByUserName(user.getUserName()) != null) {
            bindingResult.rejectValue("userName", "error.user", "This username is already taken.");
            return "forms/registration-page";
        }

        // 3. Save user and file
        User savedUser = userService.registerUser(user); // 1. Save user (without photo path)
        
        if (!multipartFile.isEmpty()) {
            // Save the file and update the database with the file name
            userService.savePhotoFile(savedUser, multipartFile); 
        }
        model.addAttribute("user", savedUser);
        //redirectAttributes.addFlashAttribute("registrationSuccess", "Account Created!");
        return "forms/registration-success-page";
    }

    @GetMapping("/success")
    public String showSuccessPage() {
        return "registration-success-page"; 
    }
    
    
    // ====================================================================
    // 2. LOGIN / DASHBOARD FLOW
    // ====================================================================
	
    
	// --- 3. SHOW LOGIN PAGE (GET: /login) --- //
    @GetMapping("/login")
    public String showLoginPage() {
        return "forms/login-page"; 
    }
    
    // --- 4. HANDLE LOGIN FORM SUBMISSION --- //
    @PostMapping("/login")
    public String handleLogin(
            @RequestParam("loginId") String loginId,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        // ADMIN CHECK
    	if ("gunjesh.m.machhi@gmail.com".equalsIgnoreCase(loginId)) {
            if (password.equals("Gunjesh@3004")) {
                return "redirect:/admin/dashboard";
            } else {
                model.addAttribute("loginError", "Invalid Admin Password");
                return "forms/login-page";
            }
        }

        // STUDENT CHECK
    	try { 
    		
    		User student = userService.findByUserName(loginId);
    		
    		if (student == null) {
                student = userService.findByEmail(loginId);
            }
            
            if ( student != null && userService.authenticate(loginId, password) != null) {
            	session.setAttribute("userId", student.getId());
                session.setAttribute("currentUser", student);
                return "redirect:/student/dashboard";
            } else {
                model.addAttribute("loginError", "Invalid Username or Password!");
                return "forms/login-page";
            }
        } catch (Exception e) {
            model.addAttribute("loginError", "Something went wrong. Please try again.");
            return "forms/login-page";
        }
    }
    
    // --- 5. SHOW SUCCESS/DASHBOARD PAGE (GET: /success-login) ---
    @GetMapping("/success-login")
    public String showSuccessPage(HttpSession session) { 
        if (session.getAttribute("currentUser") == null) {
            // If user is not logged in, deny access
            return "forms/login-page"; 
        }
        return "forms/success-page"; // JSP file name 
    }
    
    // 1. Show Forgot Password Page
    @GetMapping("forget-password")
    public String showForgotPassword() {
        return "forms/forget-password-page";
    }

    @PostMapping("/send-otp")
    public String sendOtp(@RequestParam("email") String email, HttpSession session, Model model) {
        
        // Use UserService to find user
        var user = userService.findByEmail(email);
        
        if (user != null) {
            // Generate 6-digit random OTP
            String otp = String.format("%06d", new Random().nextInt(999999));
            
            // Save OTP and Email in session for verification
            session.setAttribute("generatedOtp", otp);
            session.setAttribute("resetEmail", email);
            
            // Call our new method from EmailService
            emailService.sendOtpEmail(email, otp, user.getFirstName());
            
            model.addAttribute("email", email);
            return "forms/reset-password-page";
        } else {
            model.addAttribute("error", "No account found with this email address.");
            return "forms/forget-password-page";
        }
    }

    // 3. Verify OTP and Update Password
    @PostMapping("/verify-and-reset")
    public String verifyAndReset(@RequestParam("otp") String userOtp, 
                                 @RequestParam("newPassword") String newPassword, 
                                 HttpSession session, Model model) {
        
        String sessionOtp = (String) session.getAttribute("generatedOtp");
        String email = (String) session.getAttribute("resetEmail");

        // Logic check: OTP match
        if (sessionOtp != null && sessionOtp.equals(userOtp)) {
            
            // Use UserService to update DB
            userService.updatePassword(email, newPassword);
            
            // Clean up session for security
            session.invalidate();
            
            return "redirect:/login?resetSuccess=true";
        } else {
            model.addAttribute("error", "Invalid OTP. Please check your email again.");
            model.addAttribute("email", email);
            return "forms/reset-password-page";
        }
    }
    
    // --- 6. LOGOUT (GET: /logout) ---
    @GetMapping("/logout")
    public String handleLogout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate(); // End the session
        redirectAttributes.addFlashAttribute("logoutSuccess", "You have been successfully logged out.");
        return "redirect:/login"; // Redirect to the login page
    }
    
    
    // ====================================================================
    // 3. USER MANAGEMENT (CRUD)
    // ====================================================================
    
    
    // --- 7. LIST USERS (GET: /users) ---
    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "user-list"; // JSP file name
    }
    
    // --- 8. SHOW EDIT FORM (GET: /edit/{id}) ---
    @GetMapping("/users/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model) {
        User user = userService.getUserById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid user Id:" + id));
        
        // Pass the existing user object to the form for pre-filling
        model.addAttribute("users", user);
        
        return "user-edit-form"; // JSP file name
    }

    // --- 9. SUBMIT UPDATED DATA (POST: /update) ---
    @PostMapping("/users/update")
    public String updateUser(
        @ModelAttribute("users") User user,
        @RequestParam("image") MultipartFile multipartFile // ACCEPT THE FILE
    ) throws IOException {
        
        // Handle file upload only if a new file was provided
        if (!multipartFile.isEmpty()) {
            userService.savePhotoFile(user, multipartFile);
        } else if (user.getPhoto() == null || user.getPhoto().isEmpty()) {
            // If no new file, and photo field is empty (e.g., user removes photo on form), clear it
            user.setPhoto(null);
        }
        
        // Save the user (with or without new photo path)
        userService.updateUser(user);
        
        return "redirect:/users";
    }
    
    // --- 10. DELETE USER (GET: /users/delete/{id}) ---
    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        userService.deleteUser(id);
        // Redirect back to the user list page after deletion
        return "redirect:/users"; 
    }
}
