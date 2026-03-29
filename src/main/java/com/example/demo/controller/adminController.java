package com.example.demo.controller;

import java.io.IOException;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.TournamentResultDTO;
import com.example.demo.model.Admissions;
import com.example.demo.model.Attendance;
import com.example.demo.model.BatchTime;
import com.example.demo.model.Enquiry;
import com.example.demo.model.Payment;
import com.example.demo.model.Tournament;
import com.example.demo.model.TournamentParticipant;
import com.example.demo.model.User;
import com.example.demo.service.AdmissionsService;
import com.example.demo.service.AttendanceService;
import com.example.demo.service.BatchTimeService;
import com.example.demo.service.DashboardService;
import com.example.demo.service.DocumentsService;
import com.example.demo.service.EnquiryService;
import com.example.demo.service.PaymentService;
import com.example.demo.service.UserService;
import com.example.demo.service.TournamentService;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import jakarta.servlet.http.HttpServletResponse;



@Controller
@RequestMapping("/admin") 
public class adminController {
	
	@Autowired
    private UserService userService;
	
	@Autowired
    private EnquiryService enquiryService;
	
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
	
	@Autowired
    private TournamentService tournamentService;
	
	@Autowired
	private DashboardService dashboardService;
	
	// --- Admin Dashboard --- //
	@GetMapping("/dashboard")
	public String adminDashboard(Model model) {
		
		model.addAttribute("recentActivities", dashboardService.getRecentActivities());
		model.addAttribute("upcomingActivities", dashboardService.getUpcomingActivities());
		
	    model.addAttribute("users", userService.getAllUsers());
	    model.addAttribute("totalUsers", userService.getAllUsers().size());
	    
	    model.addAttribute("newUsers", admissionsService.getNewRegistrationsCount()); 
	    model.addAttribute("totalEnquiries", enquiryService.getTotalCount());
	    
	    Double revenue = paymentService.getTotalRevenue();
	    model.addAttribute("totalPayments", revenue != null ? revenue : 0.0);
	    
	    //model.addAttribute("recentAdmissions", userService.getAllUsers());
	    model.addAttribute("recentAdmissions", admissionsService.getAllUsersWithAdmissionDetails());
	    return "admin/admin-dashboard-page";
	}
	
	@GetMapping("/enquiries")
	public String showEnquiries(Model model) {
	
	    // Add data to the model for JSP to access
		model.addAttribute("enquiries", enquiryService.getAllEnquiries());

		model.addAttribute("totalEnquiriesCount", enquiryService.getTotalCount());
		model.addAttribute("convertedEnquiriesCount", enquiryService.getCountByStatus("Converted"));
		model.addAttribute("pendingEnquiriesCount", enquiryService.getCountByStatus("New"));
	    
	    return "admin/admin-enquiries-page"; // Name of your new JSP file
	}
	
	@PostMapping("/enquiries/save")
	public String saveEnquiry(@ModelAttribute Enquiry enquiry, RedirectAttributes redirectAttributes) {
		enquiry.setSubmittedAt(LocalDateTime.now());
	    enquiryService.saveEnquiry(enquiry);
	    redirectAttributes.addFlashAttribute("successMessage", "Enquiry added successfully!");
	    return "redirect:/admin/enquiries";
	}
	
	@GetMapping("/enquiries/updateStatus")
	public String updateStatus(@RequestParam("id") Long id, @RequestParam("status") String status, RedirectAttributes redirectAttributes) {
	    Enquiry enquiry = enquiryService.getEnquiryById(id);
	    if (enquiry != null) {
	        enquiry.setStatus(status);
	        enquiryService.updateEnquiry(enquiry);
	        
	        redirectAttributes.addFlashAttribute("successMsg", "Status successfully updated to: " + status);
	    }
	    return "redirect:/admin/enquiries";
	}
	
	@GetMapping("/enquiries/delete/{id}")
	public String deleteEnquiry(@PathVariable("id") Long id) {
	    enquiryService.deleteEnquiryById(id);
	    return "redirect:/admin/enquiries";
	}
	
	@GetMapping("/enquiries/view/{id}")
	public String viewEnquiry(@PathVariable("id") Long id, Model model) {
	    Enquiry enquiry = enquiryService.getEnquiryById(id);
	    model.addAttribute("enquiry", enquiry);
	    return "admin/admin-enquiries-viewDetails-page"; 
	}
	
	// --- ADMISSIONS PAGE --- //
	@GetMapping("/admissions")
	public String showAdmissions(Model model) {
	    
		List<User> users = admissionsService.getAllUsersWithAdmissionDetails();
		model.addAttribute("admissionList", users);
	    
		model.addAttribute("totalAdmissionsCount", users.size());
	    model.addAttribute("activeReviewCount", admissionsService.getActiveAdmissionsCount());
	    
	    double totalFees = paymentService.getTotalCollectedFees(); 
	    model.addAttribute("totalFeesCollected", totalFees);
	    
	    return "admin/admin-admissions-page";
	}
	
	@GetMapping("/admissions/updateStatus")
	public String updateUserStatus(@RequestParam("id") int id, @RequestParam("status") String status) {
		
		admissionsService.updateAdmissionDetails(id, null, null, status);
	    return "redirect:/admin/admissions";
	}
	
	@GetMapping("/admissions/export")
	public void exportToExcel(HttpServletResponse response) throws IOException {
		List<Admissions> admissions = admissionsService.getAllAdmissions();
	    
		try (Workbook workbook = new XSSFWorkbook()) { 
	        Sheet sheet = workbook.createSheet("Admissions Registry");
	    
	    // Create Header Row
	    CellStyle headerStyle = workbook.createCellStyle();
	    Font font = workbook.createFont();
	    font.setBold(true);
	    headerStyle.setFont(font);
	    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

	    // Create Header Row
	    Row header = sheet.createRow(0);
	    String[] columns = {"ID", "First Name", "Last Name", "Email", "Course", "Join Date", "Status"};
	    for (int i = 0; i < columns.length; i++) {
	        Cell cell = header.createCell(i);
	        cell.setCellValue(columns[i]);
	        cell.setCellStyle(headerStyle); // Apply Style
	    }

	    // Fill Data Rows
	    int rowNum = 1;
	    for (Admissions admission : admissions) {
	    	User user = admission.getUser();
	        Row row = sheet.createRow(rowNum++);
	        row.createCell(0).setCellValue(user.getId());
	        row.createCell(1).setCellValue(user.getFirstName());
	        row.createCell(2).setCellValue(user.getLastName());
	        row.createCell(3).setCellValue(user.getEmail());
	        row.createCell(4).setCellValue(admission.getCourseName()); 
            row.createCell(5).setCellValue(admission.getJoinDate() != null ? admission.getJoinDate().toString() : "");
            row.createCell(6).setCellValue(admission.getStatus());
	    }
	    
	    // Auto-size columns for readability
	    for(int i = 0; i < columns.length; i++) {
	        sheet.autoSizeColumn(i);
	    }

	    // Set Response Headers for Download
	    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	    response.setHeader("Content-Disposition", "attachment; filename=Admissions_Report.xlsx");
	    
	    workbook.write(response.getOutputStream());
	    workbook.close();
		}
	}
	
	@GetMapping("/admissions/student-profile/{id}")
	public String showStudentProfile(@PathVariable("id") int id, Model model) {
	    
	    User user = userService.getUserById(id).orElse(null);
	    if (user == null) {
	        return "redirect:/admin/admissions?error=UserNotFound";
	    }
	    
	    Map<String, Object> stats = attendanceService.getStudentAttendanceStats(user);
	    model.addAttribute("user", user);
	    model.addAttribute("stats", stats);
	    return "admin/admin-admissions-viewDetails-page"; 
	}
	
	@GetMapping("/studentsRecords")
	public String showStudentsRecords(Model model) {
		List<User> userList = documentsService.getAllUsersWithDocs();
		model.addAttribute("admissionList", userList);
	    model.addAttribute("batches", batchTimeService.getAllBatches());
		return "admin/admin-studentsRecords-page";
	}
	
	@GetMapping("/studentsRecords/profile/{id}")
	public String viewStudentProfile(@PathVariable("id") Long id, Model model) {
	    
	    // ૧. ID દ્વારા યુઝર (સ્ટુડન્ટ) નો ડેટા મેળવો
	    // આમાં .get() ને બદલે .orElse(null) વાપરવું સેફ છે
		User user = userService.getUserProfileById(id);
	    
	    if (user != null) {
	        // ૨. જો યુઝર મળી જાય, તો તેને મોડેલમાં એડ કરો
	        model.addAttribute("user", user);
	        
	        return "admin/admin-studentsRecords-viewDetails-page"; // તમારી નવી JSP ફાઈલનું પાથ
	    } else {
	        return "redirect:/admin/studentsRecords?error=UserNotFound";
	    }
	}
	
	@PostMapping("/studentsRecords/save")
	public String saveStudent(@ModelAttribute("user") User user) {
	    userService.registerUser(user); 
	    return "redirect:/admin/studentsRecords";
	}
	
	@GetMapping("/studentsRecords/batchTime")
	public String showStudentsRecordsBatchTime(Model model) {
	    
	    model.addAttribute("batches", batchTimeService.getAllBatches()); 
	    return "admin/studentsRecords/studentsRecords-batchTime-page";
	}
	
	@PostMapping("/studentsRecords/batchTime/save")
	public String saveBatch(@RequestParam(value = "days", required = false) List<String> days, 
	                        @ModelAttribute BatchTime batchTime, RedirectAttributes redirectAttributes) {
	    
		try {
	        // ૧. Training Days ને String માં કન્વર્ટ કરવું
	        if (days != null && !days.isEmpty()) {
	            batchTime.setTrainingDays(String.join(", ", days));
	        }
	        
	        // ૨. Google Meet Link જનરેટ કરવી
	        String meetLink = batchTimeService.generateGoogleMeetLink(batchTime.getBatchName());
	        if (meetLink != null) {
	            batchTime.setMeetLink(meetLink); 
	        }
	        
	        // ૩. બેચ સેવ કરવી
	        batchTimeService.saveBatch(batchTime);
	        
	        // ૪. Success Message (English)
	        redirectAttributes.addFlashAttribute("message", "Success! The batch '" + batchTime.getBatchName() + "' has been created successfully.");
	        redirectAttributes.addFlashAttribute("alertType", "success");

	    } catch (Exception e) {
	        // ૫. Error Message (English)
	        redirectAttributes.addFlashAttribute("message", "Error! Could not create batch: " + e.getMessage());
	        redirectAttributes.addFlashAttribute("alertType", "danger");
	    }
	    return "redirect:/admin/studentsRecords/batchTime";
	}
	
	@GetMapping("/studentsRecords/assignBatch/{studentId}/{batchId}")
	public String assignBatch(@PathVariable("studentId") int studentId, 
	                          @PathVariable("batchId") Long batchId) {
	    
	    User student = userService.getUserById(studentId).orElse(null);
	    BatchTime batch = batchTimeService.getBatchById(batchId); 

	    if (student != null && batch != null) {
	        student.setBatch(batch); 
	        userService.updateUser(student); 
	    }
	    return "redirect:/admin/studentsRecords";
	}
	
	@GetMapping("/studentsRecords/batchTime/delete/{id}")
	public String deleteBatch(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
	    try {
	        batchTimeService.deleteBatchById(id);
	        redirectAttributes.addFlashAttribute("message", "The batch has been deleted successfully.");
	        redirectAttributes.addFlashAttribute("alertType", "success");
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("message", "Error! Could not delete batch.");
	        redirectAttributes.addFlashAttribute("alertType", "danger");
	    }
	    return "redirect:/admin/studentsRecords/batchTime";
	}
	
	@PostMapping("/studentsRecords/batchTime/toggle-class")
	@ResponseBody
	public ResponseEntity<String> toggleClass(@RequestParam("batchId") Long batchId, @RequestParam("status") boolean status) {
	    try {
	        batchTimeService.updateBatchLiveStatus(batchId, status);
	        
	        String message = status ? "Class started successfully!" : "Class stopped successfully!";
	        return ResponseEntity.ok(message);
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
	    }
	}
	
	@GetMapping("/studentsRecords/documents")
	public String showStudentsRecordsDocuments(Model model) {
		List<User> userList = documentsService.getAllUsersWithDocs();
		model.addAttribute("admissionList", userList);
		return "admin/studentsRecords/studentsRecords-documents-page";
	}
	
	@GetMapping("/studentsRecords/documents/download/{fileName}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
	    try {
	        Path filePath = Paths.get("src/main/resources/static/documents/").resolve(fileName).normalize();
	        Resource resource = new UrlResource(filePath.toUri());

	        if (resource.exists()) {
	            return ResponseEntity.ok()
	                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
	                .contentType(MediaType.APPLICATION_OCTET_STREAM)
	                .body(resource);
	        }
	        return ResponseEntity.notFound().build();
	    } catch (Exception e) {
	        return ResponseEntity.internalServerError().build();
	    }
	}
	
	@PostMapping("/studentsRecords/documents/updateStatus")
	public String updateDocumentStatus(@RequestParam("docId") Long docId, 
	                                   @RequestParam("status") String status, 
	                                   @RequestParam(value = "remarks", required = false) String remarks,
	                                   RedirectAttributes redirectAttributes) {
	    try {
	        documentsService.updateStatus(docId, status, remarks);
	        
	        if ("Verified".equals(status)) {
	            redirectAttributes.addFlashAttribute("successMsg", "Document approved successfully!");
	        } else {
	            redirectAttributes.addFlashAttribute("errorMsg", "Document rejected with remarks.");
	        }
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("errorMsg", "Something went wrong!");
	    }
	    
	    return "redirect:/admin/studentsRecords/documents"; // તમારા ડોક્યુમેન્ટ લિસ્ટ પેજનું URL
	}
	
	@GetMapping("/studentsRecords/progress")
	public String showProgressPage(Model model) {
	    
		model.addAttribute("admissionList", userService.getAllUsers());
	    return "admin/studentsRecords/studentsRecords-progress-page";
	}
	
	@GetMapping("/attendance")
	public String showAttendance(Model model) {
		List<User> students = attendanceService.getStudentsWithStats();
	    
	    model.addAttribute("studentList", students);
	    return "admin/admin-attendance-page";
	}
	
	@PostMapping("/attendance/finish-class")
	public String finishClass(@RequestParam("batchId") Long batchId, RedirectAttributes redirectAttributes) {
		attendanceService.finishClassCompletely(batchId);

	    redirectAttributes.addFlashAttribute("successMsg", "Attendance updated successfully!");
	    return "redirect:/admin/studentsRecords/batchTime";
	}
	
	@PostMapping("/attendance/manual-save")
	@ResponseBody
	public ResponseEntity<String> saveManualAttendance(
	        @RequestParam("studentId") int studentId,
	        @RequestParam("date") String date,
	        @RequestParam("status") String status) {
	    
	    try {
	        LocalDate attendanceDate = LocalDate.parse(date);
	       
	        attendanceService.saveOrUpdateManualAttendance(studentId, attendanceDate, status);
	        
	        return ResponseEntity.ok("Attendance updated successfully");
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body("Error: " + e.getMessage());
	    }
	}
	
	@GetMapping("/attendance/history/{id}")
	@ResponseBody
	public List<Attendance> getAttendanceHistory(@PathVariable("id") int id) {
	    User user = userService.getUserById(id).orElse(null);
	    if (user != null) {
	        return attendanceService.getStudentHistory(user);
	    }
	    return new ArrayList<>();
	}
	
	@GetMapping("/payments")
	public String showPayments(@RequestParam(name = "status", required = false) String status, Model model) {
		
		List<Payment> paymentsList = paymentService.getAllPayments();
		
		if (status != null && !status.isEmpty()) {
	        paymentsList = paymentService.getAllPayments().stream()
	                .filter(p -> p.getStatus().equalsIgnoreCase(status))
	                .toList();
	    } else {
	        paymentsList = paymentService.getAllPayments();
	    }
		
		Double totalRevenue = paymentService.getTotalRevenue();
	    Double pendingDues = paymentService.getTotalPendingDues();
		
		model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0.0); 
	    model.addAttribute("pendingDues", pendingDues != null ? pendingDues : 0.0);
	    model.addAttribute("paymentsList", paymentsList);
	    model.addAttribute("transactionCount", paymentsList.size());
	    model.addAttribute("allStudents", userService.getAllUsers());
	    
		return "admin/admin-payments-page";
	}
	
	@GetMapping("/payments/get-payment-image/{filename:.+}") 
	@ResponseBody
	public ResponseEntity<Resource> getPaymentImage(@PathVariable String filename) {
	    try {
	        Path filePath = Paths.get("src/main/resources/static/payment-screenshots/").resolve(filename).normalize();
	        Resource resource = new UrlResource(filePath.toUri());

	        if (resource.exists()) {
	            return ResponseEntity.ok()
	                    .contentType(MediaType.IMAGE_JPEG)
	                    .body(resource);
	        } else {
	            return ResponseEntity.notFound().build();
	        }
	    } catch (Exception e) {
	        return ResponseEntity.internalServerError().build();
	    }
	}
	
	@Transactional
	@GetMapping("/payments/approve-payment/{id}")
	public String approvePayment(@PathVariable("id") Long id) {
	    Payment payment = paymentService.getPaymentById(id);
	    if (payment != null) {
	        payment.setStatus("Paid");
	        paymentService.savePayment(payment);
	        
	        User user = payment.getUser();
	        if (user != null) {
	            Admissions admission = user.getAdmissions();
	            if (admission != null) {
	                admission.setPaymentStatus("Paid"); 
	                userService.updateUser(user);
	            }
	        }
	    }
	    return "redirect:/admin/payments?approved=true";
	}
	
	@PostMapping("/payments/save-payment")
    public String savePayment(@RequestParam("userId") int userId,
                              @RequestParam("amount") Double amount,
                              @RequestParam("paymentType") String paymentType,
                              @RequestParam("status") String status) {
        
        User user = userService.getUserById(userId).orElse(null);
        
        if (user != null) {
            Payment payment = new Payment();
            payment.setUser(user);
            payment.setAmount(amount);
            payment.setPaymentType(paymentType);
            payment.setStatus(status);
            payment.setPaymentDate(LocalDate.now());

            String trxId = "INV-" + System.currentTimeMillis() / 1000;
            payment.setInvoiceNumber(trxId);
            
            paymentService.savePayment(payment);
        }
        return "redirect:/admin/payments?success";
    }
	
	@GetMapping("/payments/details/{id}")
	@ResponseBody
	public Payment getPaymentDetails(@PathVariable("id") Long id) {
	    return paymentService.getPaymentById(id);
	}
	
	@GetMapping("/tournaments")
	public String showTournaments(@RequestParam(value="tournamentId", required=false) Integer tId, Model model) {
	    List<Tournament> allTournaments = tournamentService.getAllTournaments();
	    model.addAttribute("allTournaments", allTournaments);
	    
	    List<TournamentParticipant> participantsList;
	    
	    if (tId != null && tId != 0) { // જો કોઈ ચોક્કસ ટૂર્નામેન્ટ સિલેક્ટ કરી હોય
	        model.addAttribute("selectedTournamentId", tId);
	        participantsList = tournamentService.getParticipantsByTournamentId(tId);
	    } else { // 'All' માટે અથવા પહેલી વાર પેજ લોડ થાય ત્યારે
	        model.addAttribute("selectedTournamentId", null);
	        participantsList = tournamentService.getAllParticipants(); // બધો જ ડેટા લોડ કરો
	    }
	    model.addAttribute("participants", participantsList);
	    return "admin/admin-tournaments-page";
	}
	
	@GetMapping("/tournaments/createEvent")
	public String showTournamentsSchedule(Model model) {
		return "admin/tournaments/tournaments-scheduleEvent-page";
	}
	
	@PostMapping("/tournaments/createEvent/save")
	public String saveTournament(@ModelAttribute Tournament tournament, RedirectAttributes redirectAttributes) {
	    tournamentService.saveTournament(tournament); 
	    redirectAttributes.addFlashAttribute("successMessage", "Tournament scheduled successfully!");
	    return "redirect:/admin/tournaments/createEvent";
	}
	
	@GetMapping("/tournaments/participant")
	public String showTournamentsRegistration(Model model) {
	    model.addAttribute("tournaments", tournamentService.getAllTournaments());
	    
	    // --- નવો ID જનરેટ કરવાનું લોજિક ---
	    TournamentParticipant lastParticipant = tournamentService.getLatestParticipant(); 
	    String nextId;
	    
	    if (lastParticipant == null || lastParticipant.getStudentId() == null) {
	        nextId = "SS-T-1001"; 
	    } else {
	        try {
	            // ધારો કે છેલ્લો ID "SS-T-1005" છે, તો તેમાંથી 1005 કાઢીને +1 કરશે
	            String lastIdStr = lastParticipant.getStudentId().replaceAll("[^0-9]", "");
	            int lastIdNum = Integer.parseInt(lastIdStr);
	            nextId = "SS-T-" + (lastIdNum + 1);
	        } catch (Exception e) {
	            nextId = "SS-T-1001";
	        }
	    }
	    
	    model.addAttribute("nextStudentId", nextId); // આ વેલ્યુ JSP માં વાપરીશું
	    return "admin/tournaments/tournaments-addParticipant-page";
	}
	
	@PostMapping("/tournaments/participant/registerParticipant")
	public String registerParticipant(@RequestParam("tournamentId") int tournamentId, @ModelAttribute TournamentParticipant participant, RedirectAttributes redirectAttributes) {
		Tournament tournament = tournamentService.getTournamentById(tournamentId);
		participant.setTournament(tournament);
		tournamentService.registerParticipant(participant);
		redirectAttributes.addFlashAttribute("toastMsg", "Participant Added Successfully!");
	    return "redirect:/admin/tournaments/participant";
	}
	
	@GetMapping("/tournaments/participant/findExistingStudent")
	@ResponseBody 
	public TournamentParticipant findExistingStudent(@RequestParam("studentId") String studentId) {
	    TournamentParticipant existing = tournamentService.getLatestRecordByStudentId(studentId);
	    
	    if (existing != null) {
	        return existing;
	    } else {
	        return new TournamentParticipant();
	    }
	}
	
	@GetMapping("/tournaments/records")
	public String showTournamentsRecords(Model model) {
		List<Tournament> allTournaments = tournamentService.getAllTournaments();
	    model.addAttribute("allTournaments", allTournaments);
	    
	    Map<String, Long> stats = tournamentService.getTournamentDashboardStats();

	    model.addAttribute("totalCount", stats.get("total"));
	    model.addAttribute("upcomingCount", stats.get("upcoming"));
	    model.addAttribute("ongoingCount", stats.get("ongoing"));
	    model.addAttribute("completedCount", stats.get("completed"));
	   
		return "admin/tournaments/tournaments-tournamentsRecords-page";
	}

	@GetMapping("/tournaments/assignRank")
	public String showAssignRank(@RequestParam(value="tournamentId", required=false) Integer tId, Model model) {
	    // બધી જ ટૂર્નામેન્ટ્સ ડ્રોપડાઉન માટે
	    List<Tournament> allTournaments = tournamentService.getAllTournaments();
	    model.addAttribute("allTournaments", allTournaments);
	    
	    List<TournamentParticipant> participantsList;
	    
	    if (tId != null) {
	        model.addAttribute("selectedTournamentId", tId);
	        // પસંદ કરેલી ટૂર્નામેન્ટના પ્લેયર્સ મેળવવા માટે
	        participantsList = tournamentService.getParticipantsByTournamentId(tId);
	    } else {
	        model.addAttribute("selectedTournamentId", null);
	        participantsList = Collections.emptyList();
	    }
	    
	    model.addAttribute("participants", participantsList);
	    return "admin/tournaments/tournaments-editRecords-page"; 
	}
	
	@PostMapping("/tournaments/editRecords/saveRankings")
	@ResponseBody
	public String saveRankings(@RequestBody List<TournamentResultDTO> rankings) { 
	    try {
	        tournamentService.updateRankings(rankings);
	        return "success";
	    } catch (Exception e) {
	        return "error: " + e.getMessage();
	    }
	}
	
	@DeleteMapping("/tournaments/records/delete/{id}")
	@ResponseBody
    public ResponseEntity<String> deleteTournament(@PathVariable("id") int id) {
        try {
            // સર્વિસ લેયર દ્વારા ટૂર્નામેન્ટ ડિલીટ કરો
            boolean deleted = tournamentService.deleteTournamentById(id);
            
            if (deleted) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(404).body("Tournament not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error: " + e.getMessage());
        }
    }

}
