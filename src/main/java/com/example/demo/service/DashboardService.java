package com.example.demo.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.ActivityDTO;
import com.example.demo.model.User;
import com.example.demo.repository.PaymentRepository;
import com.example.demo.repository.UserRepository;

@Service
public class DashboardService {
	
	@Autowired
    private UserRepository userRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    public List<ActivityDTO> getRecentActivities() {
        List<ActivityDTO> list = new ArrayList<>();

        // 1. Last Payments (Recent Activity)
        paymentRepository.findTop5ByOrderByPaymentDateDesc().forEach(p -> {
            list.add(new ActivityDTO("Payment Received", 
                p.getUser().getFirstName() + " - ₹" + p.getAmount(), 
                "Today", "payment", "fa-indian-rupee-sign"));
        });

        // 2. New Students with Batch (Last 5 days)
        LocalDate fiveDaysAgo = LocalDate.now().minusDays(5);
        userRepository.findRecentAdmissions(fiveDaysAgo).forEach(u -> {
        	String title;
            String description;
            
            // if batch assigned
            if (u.getBatch() != null) {
                title = "New Batch Assigned";
                description = u.getFirstName() + " joined " + u.getBatch().getBatchName();
            } else {
                // if not assigned
                title = "New Enrollment";
                description = u.getFirstName() + " joined ShadowStriker";
            }

            list.add(new ActivityDTO(title, description, "Recent", "event", "fa-user-check"));
        });

        return list;
    }

    public List<ActivityDTO> getUpcomingActivities() {
        List<ActivityDTO> list = new ArrayList<>();
        List<User> users = userRepository.findAll();

        for (User u : users) {

            if (u.getAdmissions() != null && u.getAdmissions().getTotalFees() != null) {
                double totalFees = u.getAdmissions().getTotalFees();
               
                double totalPaid = (u.getPayments() != null) ? u.getPayments().stream()
                        .filter(p -> "Paid".equalsIgnoreCase(p.getStatus()))
                        .mapToDouble(p -> p.getAmount())
                        .sum() : 0;

                if (totalPaid < totalFees) {
                    double due = totalFees - totalPaid;
                    list.add(new ActivityDTO("Fee Deadline", 
                        u.getFirstName() + " - Pending: ₹" + due, 
                        "Due", "payment", "fa-hourglass-half"));
                }
            }
            
            if (u.getBatch() == null) {
                 list.add(new ActivityDTO("Batch Pending", u.getFirstName() + " needs a batch", "Assign Now", "new", "fa-user-clock"));
            }
        }
        return list;
    }

}
