package com.example.demo.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.model.Admissions;
import com.example.demo.model.Documents;
import com.example.demo.model.Payment;
import com.example.demo.model.User;
import com.example.demo.service.AdmissionsService;
import com.example.demo.service.AttendanceService;
import com.example.demo.service.BatchTimeService;
import com.example.demo.service.DocumentsService;
import com.example.demo.service.PaymentService;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
@RequestMapping("/student") // Base mapping for the application
public class UserController {

	@Autowired
    private UserService userService;
	
	@Autowired
	private AdmissionsService admissionsService;
	
	@Autowired
	private BatchTimeService batchTimeService;
	
	@Autowired
	private DocumentsService documentsService;
	
	@Autowired
    private AttendanceService attendanceService;
	
	@Autowired
	private PaymentService paymentService;
	
	@GetMapping("/dashboard")
	public String showDashboard(HttpSession session, Model model) {
	    Object userId = session.getAttribute("userId");

	    if (userId != null) {
	        int id = Integer.parseInt(userId.toString());
	        
	        User user = userService.getUserById(id).orElse(null);

	        if (user != null) {
	            model.addAttribute("student", user); 
	            return "student/student-dashboard-page";
	        }
	    }
	    return "redirect:/login";
	}
	
	@PostMapping("/enrollCourse")
	public String enrollCourse(@RequestParam("courseName") String courseName, 
	                           HttpSession session, 
	                           RedirectAttributes redirectAttributes) {
	    
	    Object userIdObj = session.getAttribute("userId");
	    
	    if (userIdObj != null) {
	        int userId = Integer.parseInt(userIdObj.toString());

	        admissionsService.enrollStudent(userId, courseName);

	        redirectAttributes.addFlashAttribute("successMessage", "You have successfully enrolled in " + courseName + "!");
	        
	        return "redirect:/student/myClasses";
	    }
	    return "redirect:/login";
	}
	@PostMapping("/selectCourse")
	public String selectCourse(@RequestParam("courseName") String courseName, HttpSession session) {
	    
	    Integer userId = (Integer) session.getAttribute("userId"); 
	    
	    if (userId != null) {
	        admissionsService.enrollStudent(userId, courseName);
	        return "redirect:/student/dashboard?success=enrolled";
	    }
	    return "redirect:/login";
	}
	
	@GetMapping("/myProfile")
	public String showMyProfile(HttpSession session, Model model) {
	    // 1. Check who is logged in via Session
	    Object userId = session.getAttribute("userId");
	    if (userId == null) {return "redirect:/login";} // Security: if not logged in, go to login    

	    // 2. Fetch the FULL data for THIS specific user
	    int id = Integer.parseInt(userId.toString());
	    User user = userService.getUserById(id).orElse(null);

	    if (user != null) {
	        // 3. Send the data to the Profile JSP
	        model.addAttribute("student", user);
	        return "student/student-myProfile-page";
	    }

	    return "redirect:/login";
	}
	
	@PostMapping("/myProfile/updatePhoto")
	public String updatePhoto(@RequestParam("id") int id, 
	                          @RequestParam("profileImage") MultipartFile file, RedirectAttributes redirectAttributes) {

	    if (!file.isEmpty()) {
	        try {
	            // Use 'getUserById' because that's what is in your UserService
	            User user = userService.getUserById(id)
	                            .orElseThrow(() -> new RuntimeException("User not found"));

	            // Use your existing 'savePhotoFile' method to handle the file and DB save
	            userService.savePhotoFile(user, file);
	            return "redirect:/student/myProfile?success=true";
	        } catch (IOException e) {
	            e.printStackTrace();
	            return "redirect:/student/myProfile?error=upload_failed";
	        }
	    }
	    // This return path must exist in your @GetMapping
	    return "redirect:/student/myProfile"; 
	}
	
	@PostMapping("/myProfile/updateDetails")
	public String updateDetails(@RequestParam("id") int id, 
	                            @RequestParam("phone") String phone, 
	                            @RequestParam("weight") Double weight,
	                            @RequestParam("idProofFile") MultipartFile idProofFile,
	                            @RequestParam("medicalFile") MultipartFile medicalFile,
	                            RedirectAttributes redirectAttributes) throws IOException {
	
		User user = userService.getUserById(id).orElse(null);
		
	    if (user != null) {
	        // Accessing the Admissions object via the relationship
	        if (user.getAdmissions() == null) {
	        	Admissions newAdmissions = new Admissions();
	            newAdmissions.setUser(user); // Link to this user
	            user.setAdmissions(newAdmissions);
	        }
	            user.getAdmissions().setPhone(phone);
	            user.getAdmissions().setWeight(weight);
	            
	            Documents docs = user.getDocuments(); 
	            if (docs == null) {
	                docs = new Documents();
	                docs.setUser(user);
	                docs.setStatus("Pending"); // ડિફોલ્ટ સ્ટેટસ સેટ કરો
	                user.setDocuments(docs);
	            }
	            
	            if (!idProofFile.isEmpty() || !medicalFile.isEmpty()) {
	                
	                docs.setStatus("Pending"); // સ્ટેટસ રીસેટ
	                docs.setRemarks("");

	                if (!idProofFile.isEmpty()) {
	                	// ખાતરી કરો કે saveDocument મેથડ તમારી DocumentsService માં છે
	                	String idFileName = documentsService.saveDocument(idProofFile); 
	                	docs.setIdProof(idFileName);
	                	docs.setStatus("Pending");
	                }

	                if (!medicalFile.isEmpty()) {
	                	String medFileName = documentsService.saveDocument(medicalFile);
	                	docs.setMedicalCertificate(medFileName);
	                	docs.setStatus("Pending");
	                }
	            }
	            userService.updateUser(user); // Save the changes
	    }
	    return "redirect:/student/myProfile?success=true";
	}
	
	@GetMapping("/myClasses")
	public String showMyClasses(HttpSession session, Model model) {
		Object userId = session.getAttribute("userId");
	    
	    if (userId == null) {
	        return "redirect:/login";
	    }

	    // You MUST fetch and add the student so the header can show the photo
	    User user = userService.getUserById(Integer.parseInt(userId.toString())).orElse(null);

	    if (user != null) {
	        model.addAttribute("student", user);
	        return "student/student-myClasses-page";
	    }

	    return "redirect:/login";
    }
	
	@GetMapping("/myClasses/check-batch-status")
	@ResponseBody
	public ResponseEntity<Boolean> checkStatus(@RequestParam Long batchId) {
	    // સર્વિસ લેયર દ્વારા સ્ટેટસ મેળવો
	    boolean isLive = batchTimeService.isBatchLive(batchId);
	    return ResponseEntity.ok(isLive);
	}
	
	@GetMapping("/myAttendance")
    public String showMyAttendance(HttpSession session, Model model) {
        Object userId = session.getAttribute("userId");
        if (userId == null) return "redirect:/login";
        
        int id = Integer.parseInt(userId.toString());
        User user = userService.getUserById(id).orElse(null);

        if (user != null) {
            // ૧. સર્વિસમાંથી સ્ટેટ્સ મેળવો
            Map<String, Object> stats = attendanceService.getStudentAttendanceStats(user);
            
            String trainingDays = (user.getBatch() != null) ? user.getBatch().getTrainingDays() : "";
            LocalDate joinDate = LocalDate.parse(stats.get("joinDate").toString());
            
            // જો એક્સપાયરી ડેટ હોય તો તે લેવી, નહીતર આજની તારીખ
            LocalDate expiryDate = stats.get("expiryDate").toString().isEmpty() ? 
                                  LocalDate.now() : LocalDate.parse(stats.get("expiryDate").toString());

            // ૨. Join થી Expiry સુધીના કુલ વર્કિંગ ડેઝ (હવે આ આંકડો સાચો આવશે)
            int totalClasses = attendanceService.getTotalClassesBetweenDates(trainingDays, joinDate, expiryDate);
            
            model.addAttribute("student", user);
            model.addAttribute("trainingDays", trainingDays);
            model.addAttribute("totalClassesThisMonth", totalClasses); // UI માં આ 'Total Classes' કાર્ડમાં જશે
            
            model.addAttribute("attendanceRecords", stats.get("allRecords"));
            model.addAttribute("presentCount", stats.get("presentCountMonth"));
            model.addAttribute("absentCount", stats.get("absentCountMonth"));
            model.addAttribute("attendancePercentage", stats.get("attendancePercentage"));
            
            ObjectMapper mapper = new ObjectMapper();
            try {
                List<String> presentDatesList = (List<String>) stats.get("presentDates");
                model.addAttribute("presentDatesJson", mapper.writeValueAsString(presentDatesList));

                List<String> absentDatesList = (List<String>) stats.get("absentDates");
                model.addAttribute("absentDatesJson", mapper.writeValueAsString(absentDatesList));
            } catch (Exception e) {
                model.addAttribute("presentDatesJson", "[]");
                model.addAttribute("absentDatesJson", "[]");
            }
            
            model.addAttribute("joinDate", stats.get("joinDate"));
            model.addAttribute("expiryDate", stats.get("expiryDate"));
            
            return "student/student-myAttendance-page";
        }
        return "redirect:/login";
    }
	
	@PostMapping("/myAttendance/join")
    public ResponseEntity<String> markJoin(@RequestParam Long studentId, @RequestParam Long batchId) {
        try {
            attendanceService.markStudentJoin(studentId, batchId);
            return ResponseEntity.ok("Success");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
        }
    }
	
	@GetMapping("/myPayments")
	public String showMyPayments(HttpSession session, Model model) {
		Object userId = session.getAttribute("userId");
	    if (userId == null) return "redirect:/login";

	    int id = Integer.parseInt(userId.toString());
	    User user = userService.getUserById(id).orElse(null);

	    if (user != null) {
	        // ડેટાબેઝમાંથી આ યુઝરના પેમેન્ટ્સ લાવો
	        List<Payment> payments = paymentService.getPaymentsByUser(user);
	        
	        double totalPaid = payments.stream()
	                .filter(p -> "Paid".equalsIgnoreCase(p.getStatus()))
	                .mapToDouble(Payment::getAmount)
	                .sum();
	        
	        double totalCourseAmount = 0.0;
	        if (user.getAdmissions() != null && user.getAdmissions().getTotalFees() != null) {
	            totalCourseAmount = user.getAdmissions().getTotalFees(); 
	        } else {
	            // જો ડેટાબેઝમાં ફી નથી, તો કોર્સ મુજબ મેન્યુઅલી સેટ કરી શકાય (Temporary logic)
	            String course = (user.getAdmissions() != null) ? user.getAdmissions().getCourseName() : "";
	            if ("Kick-Boxing".equalsIgnoreCase(course)) {
	                totalCourseAmount = 12000.0; // 3 Months
	            } else if ("Mixed Martial Arts (MMA)".equalsIgnoreCase(course)) {
	                totalCourseAmount = 15000.0; // 6 Months
	            } else if ("Self Defense".equalsIgnoreCase(course)) {
	                totalCourseAmount = 6000.0; // 3 Months
	            } else if ("Stick".equalsIgnoreCase(course)) {
	                totalCourseAmount = 8000.0; // 2 Months
	            } else if ("Tonfa".equalsIgnoreCase(course)) {
	                totalCourseAmount = 8000.0; // 4 Months
	            } else if ("Betan".equalsIgnoreCase(course)) {
	                totalCourseAmount = 8000.0; // 3 Months
	            } else if ("Women's Self-Defense".equalsIgnoreCase(course)) {
	                totalCourseAmount = 5000.0; // 2 Months
	            } else if ("Personal Training (Any Technique)".equalsIgnoreCase(course)) {
	                totalCourseAmount = 10000.0; // 4 Months
	            } else {
	                totalCourseAmount = 1000.0; // Default
	            }
	        }
	        
	        double outstandingBalance = totalCourseAmount - totalPaid;
	        
	        model.addAttribute("student", user);
	        model.addAttribute("payments", payments);
	        model.addAttribute("totalCourseAmount", totalCourseAmount);
	        model.addAttribute("totalPendingAmount", outstandingBalance);
	        
	        return "student/student-myPayments-page";
	    }
	    return "redirect:/login";
	}

	
	@PostMapping("/myPayments/submitPayment")
	public String processPayment(@RequestParam Double amount, 
	                             @RequestParam String paymentType,
	                             @RequestParam String txnId,
	                             @RequestParam("file") MultipartFile file,
	                             HttpSession session) throws IOException {
		Object userId = session.getAttribute("userId");
	    if (userId == null) return "redirect:/login";
	    
	    User user = userService.getUserById(Integer.parseInt(userId.toString())).orElse(null);

	    if (user != null) {
	        Payment payment = new Payment();
	        payment.setUser(user);
	        payment.setAmount(amount);
	        payment.setPaymentType(paymentType);
	        payment.setInvoiceNumber(txnId); 
	        payment.setStatus("Pending");    
	        payment.setPaymentDate(LocalDate.now());

	        String savedFileName = paymentService.saveScreenshot(file);
	        payment.setScreenshotPath(savedFileName);

	        paymentService.savePayment(payment);
	    }

	    return "redirect:/student/myPayments?success";
	}
	
	@GetMapping("/myPayments/downloadInvoice/{id}")
	public void downloadInvoice(@PathVariable("id") Long id, HttpServletResponse response) {
	    Payment payment = paymentService.getPaymentById(id);
	    if (payment == null) return;

	    try {
	        response.setContentType("application/pdf");
	        response.setHeader("Content-Disposition", "attachment; filename=Invoice_" + payment.getInvoiceNumber() + ".pdf");

	        Document document = new Document(PageSize.A4);
	        PdfWriter.getInstance(document, response.getOutputStream());
	        document.open();

	        // Styles
	        BaseColor themeColor = new BaseColor(146, 43, 62); // ShadowStriker Primary Red: #922b3e
	        Font headerFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.WHITE);
	        Font titleFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, themeColor);
	        Font normalFont = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL);
	        Font whiteFont = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, BaseColor.WHITE);

	        // Header Table (Logo + Name)
	        PdfPTable headerTable = new PdfPTable(2);
	        headerTable.setWidthPercentage(100);
	        headerTable.setWidths(new int[]{3, 1});

	        PdfPCell cell = new PdfPCell(new Phrase("SHADOW STRIKER KARATE ACADEMY", headerFont));
	        cell.setBackgroundColor(themeColor);
	        cell.setPadding(15);
	        cell.setBorder(Rectangle.NO_BORDER);
	        headerTable.addCell(cell);

	        try {
	            // Path must be correct as per your deployment
	            String logoPath = "src/main/resources/static/logo/logo_2.png";
	            Image logo = Image.getInstance(logoPath);
	            logo.scaleToFit(60, 60);
	            PdfPCell logoCell = new PdfPCell(logo);
	            logoCell.setBackgroundColor(themeColor);
	            logoCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	            logoCell.setPadding(5);
	            logoCell.setBorder(Rectangle.NO_BORDER);
	            headerTable.addCell(logoCell);
	        } catch (Exception e) {
	            headerTable.addCell(new PdfPCell(new Phrase("")));
	        }
	        document.add(headerTable);

	        document.add(new Paragraph("\n"));

	        // User and Course Information
	        PdfPTable infoTable = new PdfPTable(2);
	        infoTable.setWidthPercentage(100);
	       
	        String course = "N/A";
	        if (payment.getUser().getAdmissions() != null) {
	            course = payment.getUser().getAdmissions().getCourseName();
	        }
	        
	        PdfPCell leftCell = new PdfPCell();
	        leftCell.setBorder(Rectangle.NO_BORDER);
	        leftCell.addElement(new Paragraph("BILL TO:", titleFont));
	        leftCell.addElement(new Paragraph(payment.getUser().getFirstName() + " " + payment.getUser().getLastName(), normalFont));
	        leftCell.addElement(new Paragraph("Course: " + course, normalFont)); 
	        infoTable.addCell(leftCell);

	        PdfPCell rightCell = new PdfPCell();
	        rightCell.setBorder(Rectangle.NO_BORDER);
	        rightCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	        Paragraph p = new Paragraph("INVOICE INFO", titleFont);
	        p.setAlignment(Element.ALIGN_RIGHT);
	        rightCell.addElement(p);
	        Paragraph p2 = new Paragraph("Invoice #: " + payment.getInvoiceNumber() + "\nDate: " + payment.getPaymentDate(), normalFont);
	        p2.setAlignment(Element.ALIGN_RIGHT);
	        rightCell.addElement(p2);
	        infoTable.addCell(rightCell);
	        
	        document.add(infoTable);
	        document.add(new Paragraph("\n\n"));

	        // Payment Details Table
	        PdfPTable mainTable = new PdfPTable(3);
	        mainTable.setWidthPercentage(100);
	        mainTable.setWidths(new float[]{2, 1, 1});

	        String[] headers = {"Description", "Status", "Amount"};
	        for (String h : headers) {
	            PdfPCell hCell = new PdfPCell(new Phrase(h, whiteFont));
	            hCell.setBackgroundColor(themeColor);
	            hCell.setPadding(8);
	            hCell.setHorizontalAlignment(Element.ALIGN_CENTER);
	            mainTable.addCell(hCell);
	        }

	        mainTable.addCell(new PdfPCell(new Phrase(payment.getPaymentType(), normalFont)));
	        mainTable.addCell(new PdfPCell(new Phrase(payment.getStatus(), normalFont)));
	        mainTable.addCell(new PdfPCell(new Phrase("₹" + payment.getAmount(), normalFont)));

	        document.add(mainTable);

	        Paragraph total = new Paragraph("\nTotal Amount Paid: ₹" + payment.getAmount(), titleFont);
	        total.setAlignment(Element.ALIGN_RIGHT);
	        document.add(total);

	        document.add(new Paragraph("\n\n\n\n"));
	        Paragraph footer = new Paragraph("--------------------------------------------\nAuthorized Signature", normalFont);
	        footer.setAlignment(Element.ALIGN_RIGHT);
	        document.add(footer);

	        document.add(new Paragraph("\n\nThank you for being part of Shadow Striker Academy!", normalFont));

	        document.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
}
