package com.example.demo.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.model.Attendance;
import com.example.demo.model.BatchTime;
import com.example.demo.model.User;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
	
	// યુઝરના આધારે છેલ્લો રેકોર્ડ તારીખ મુજબ ઉતરતા ક્રમમાં મેળવવા માટે
    Optional<Attendance> findFirstByUserOrderByDateDesc(User user); 

    // બાકીની મેથડ્સ જે તમે વાપરો છો
    List<Attendance> findByUser(User user);
    
    Optional<Attendance> findByUserIdAndDate(Integer userId, LocalDate date);
    
    List<Attendance> findByBatchIdAndDateAndStatus(Long batchId, LocalDate date, String status);
    
    Optional<Attendance> findByUserAndDate(User user, LocalDate date);
    
    boolean existsByUserAndDateAndBatch(User user, LocalDate date, BatchTime batch);
}



