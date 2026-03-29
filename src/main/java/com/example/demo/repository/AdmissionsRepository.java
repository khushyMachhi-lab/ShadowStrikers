package com.example.demo.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.demo.model.Admissions;
import com.example.demo.model.User;
@Repository
public interface AdmissionsRepository extends JpaRepository<Admissions, Integer> {
	
	List<Admissions> findAllByOrderByIdDesc();

	Optional<Admissions> findByUserId(int userId);
	
	long countByStatusIgnoreCase(String status);
	
	List<Admissions> findByJoinDate(LocalDate joinDate);

    List<Admissions> findByJoinDateBetween(LocalDate start, LocalDate end);
    
    @Query("SELECT u FROM User u LEFT JOIN u.admissions a ORDER BY u.id DESC")
    List<User> findAllUsersWithAdmissions();
}
