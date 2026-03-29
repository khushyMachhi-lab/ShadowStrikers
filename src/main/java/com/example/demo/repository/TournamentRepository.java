package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.model.Tournament;

public interface TournamentRepository extends JpaRepository<Tournament, Integer> {
	long count();
    long countByStatus(String status);
}
