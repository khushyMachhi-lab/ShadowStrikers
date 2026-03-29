package com.example.demo.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.model.Documents;
import com.example.demo.model.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	Optional<User> findByEmail(String email);
	
    Optional<User> findByUserName(String userName);

	List<User> findByBatchId(Long batchId);
	
	List<User> findByBatchIsNull();

	@Query("SELECT u FROM User u JOIN u.admissions a WHERE a.admissionDate >= :date")
	List<User> findRecentAdmissions(@Param("date") LocalDate date);

	List<User> findAllByOrderByIdDesc();

	Optional<User> findById(Long id);
}
