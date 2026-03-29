package com.example.demo.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Attendance;
import com.example.demo.model.BatchTime;
import com.example.demo.model.User;
import com.example.demo.repository.AttendanceRepository;
import com.example.demo.repository.BatchTimeRepository;
import com.example.demo.repository.UserRepository;

import jakarta.transaction.Transactional;

@Service
public class AttendanceService {
	
	@Autowired
    private AttendanceRepository attendanceRepository;
	
	@Autowired
    private UserRepository userRepository;
	
	@Autowired
    private BatchTimeRepository batchTimeRepository;
       
    public void markStudentJoin(Long studentId, Long batchId) {
        LocalDate today = LocalDate.now();
        
        Optional<Attendance> existing = attendanceRepository.findByUserIdAndDate(studentId.intValue(), today);
        
        if (existing.isEmpty()) {
            Attendance att = new Attendance();
            att.setDate(today);
            att.setStartTime(LocalTime.now());
            att.setStatus("In-Progress");
            
            User user = userRepository.findById(studentId.intValue())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            att.setUser(user);
            
            BatchTime batch = batchTimeRepository.findById(batchId)
                    .orElseThrow(() -> new RuntimeException("Batch not found"));
            att.setBatch(batch);
            
            attendanceRepository.save(att);
            System.out.println("Attendance marked as In-Progress for: " + user.getFirstName());
        }
    }

    @Transactional
    public void finishClassCompletely(Long batchId) {
        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();

        List<Attendance> activeSessions = attendanceRepository.findByBatchIdAndDateAndStatus(batchId, today, "In-Progress");
        for (Attendance a : activeSessions) {
            a.setStatus("Present");
            a.setEndTime(now);
            attendanceRepository.save(a);
        }

        List<User> allBatchStudents = userRepository.findByBatchId(batchId);
        for (User student : allBatchStudents) {
            Optional<Attendance> record = attendanceRepository.findByUserAndDate(student, today);
            if (record.isEmpty()) {
                Attendance absentRecord = new Attendance();
                absentRecord.setUser(student);
                absentRecord.setBatch(student.getBatch());
                absentRecord.setDate(today);
                absentRecord.setStatus("Absent");
                attendanceRepository.save(absentRecord);
            }
        }

        BatchTime batch = batchTimeRepository.findById(batchId)
                .orElseThrow(() -> new RuntimeException("Batch not found"));
        batch.setLive(false); 
        batchTimeRepository.save(batch);
    }
    
    @Transactional
    public void saveOrUpdateManualAttendance(int studentId, LocalDate date, String status) {
        User student = userRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // રેકોર્ડ શોધો, જો ન હોય તો નવો બનાવો
        Attendance attendance = attendanceRepository.findByUserAndDate(student, date)
                .orElse(new Attendance());

        attendance.setUser(student);
        attendance.setDate(date);
        attendance.setStatus(status);

        if (student.getBatch() != null) {
            attendance.setBatch(student.getBatch());
        }

        attendanceRepository.save(attendance);
    }

    // ૧. મુખ્ય સ્ટેટ્સ મેથડ - જે હવે Join થી Expiry સુધીના દિવસો ગણશે
    public Map<String, Object> getStudentAttendanceStats(User user) {
        List<Attendance> records = attendanceRepository.findByUser(user);
        LocalDate now = LocalDate.now();
        
        LocalDate joinDate = (user.getAdmissions() != null && user.getAdmissions().getJoinDate() != null) 
                             ? user.getAdmissions().getJoinDate() : now;
        LocalDate expiryDate = (user.getAdmissions() != null && user.getAdmissions().getExpiryDate() != null) 
                               ? user.getAdmissions().getExpiryDate() : null;

        long presentThisMonth = 0;
        long absentThisMonth = 0;
        List<String> presentDates = new ArrayList<>();
        List<String> absentDates = new ArrayList<>();

        for (Attendance r : records) {
            if ("Present".equals(r.getStatus())) {
                presentDates.add(r.getDate().toString());
                if (r.getDate().getMonth() == now.getMonth() && r.getDate().getYear() == now.getYear()) {
                    presentThisMonth++;
                }
            } else if ("Absent".equals(r.getStatus())) {
                absentDates.add(r.getDate().toString());
                if (r.getDate().getMonth() == now.getMonth() && r.getDate().getYear() == now.getYear()) {
                    absentThisMonth++;
                }
            }
        }

        // ૨. Join Date થી Expiry Date સુધીના કુલ વર્કિંગ ડેઝ ગણો
        String trainingDaysStr = (user.getBatch() != null) ? user.getBatch().getTrainingDays() : "";
        int totalWorkingDaysInRange = 0;

        if (!trainingDaysStr.isEmpty() && expiryDate != null) {
            totalWorkingDaysInRange = getTotalClassesBetweenDates(trainingDaysStr, joinDate, expiryDate);
        }

        // ૩. એટેન્ડન્સ રેટ (કુલ હાજર / રેન્જ વચ્ચેના કુલ ક્લાસ)
        long totalPresentAllTime = records.stream().filter(r -> "Present".equals(r.getStatus())).count();
        double percentage = (totalWorkingDaysInRange > 0) ? (double) (totalPresentAllTime * 100) / totalWorkingDaysInRange : 0.0;

        Map<String, Object> stats = new HashMap<>();
        stats.put("presentCountMonth", presentThisMonth);
        stats.put("absentCountMonth", absentThisMonth);
        stats.put("attendancePercentage", Math.round(percentage)); 
        stats.put("presentDates", presentDates);
        stats.put("absentDates", absentDates);
        stats.put("joinDate", joinDate.toString());
        stats.put("expiryDate", (expiryDate != null) ? expiryDate.toString() : "");
        stats.put("allRecords", records);
        stats.put("totalWorkingDaysInRange", totalWorkingDaysInRange);
        
        return stats;
    }

    // ૪. તારીખની રેન્જ વચ્ચેના વર્કિંગ ડેઝ ગણવાની મેથડ (આ મેથડ 'today' ને ધ્યાનમાં નથી લેતી)
    public int getTotalClassesBetweenDates(String trainingDaysStr, LocalDate startDate, LocalDate endDate) {
        if (trainingDaysStr == null || trainingDaysStr.isEmpty() || startDate == null || endDate == null) return 0;

        int totalClasses = 0;
        List<String> activeDays = Arrays.stream(trainingDaysStr.split(","))
                .map(String::trim)
                .map(String::toUpperCase)
                .map(day -> day.length() == 3 ? convertToFullDayName(day) : day)
                .collect(Collectors.toList());

        LocalDate tempDate = startDate;
        while (!tempDate.isAfter(endDate)) {
            if (activeDays.contains(tempDate.getDayOfWeek().name())) {
                totalClasses++;
            }
            tempDate = tempDate.plusDays(1);
        }
        return totalClasses;
    }

    private String convertToFullDayName(String shortDay) {
        switch (shortDay) {
            case "MON": return "MONDAY";
            case "TUE": return "TUESDAY";
            case "WED": return "WEDNESDAY";
            case "THU": return "THURSDAY";
            case "FRI": return "FRIDAY";
            case "SAT": return "SATURDAY";
            case "SUN": return "SUNDAY";
            default: return shortDay;
        }
    }
    
    public List<User> getStudentsWithStats() {

    	List<User> students = userRepository.findAllByOrderByIdDesc();      
        for (User student : students) {
            Optional<Attendance> last = attendanceRepository.findFirstByUserOrderByDateDesc(student);
            student.setLastAttendance(last.orElse(null)); 

            Map<String, Object> stats = getStudentAttendanceStats(student);
            student.setAttendancePercentage(Double.parseDouble(stats.get("attendancePercentage").toString()));
        }
        return students;
    }

    public List<Attendance> getStudentHistory(User user) {
        return attendanceRepository.findByUser(user);
    }
}