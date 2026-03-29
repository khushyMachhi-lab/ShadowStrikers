package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.model.TournamentParticipant;

@Repository
public interface TournamentParticipantRepository extends JpaRepository<TournamentParticipant, Integer> {
	
	List<TournamentParticipant> findByTournamentId(int tournamentId);
	TournamentParticipant findTopByOrderByIdDesc();
	TournamentParticipant findFirstByStudentIdOrderByIdDesc(String studentId);

}
