package com.example.demo.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.dto.TournamentResultDTO;
import com.example.demo.model.Tournament;
import com.example.demo.model.TournamentParticipant;
import com.example.demo.repository.TournamentParticipantRepository;
import com.example.demo.repository.TournamentRepository;

@Service
public class TournamentService {
	
	@Autowired
    private TournamentRepository tournamentRepository;

	@Autowired
    private TournamentParticipantRepository participantRepository;
	
	public Map<String, Long> getTournamentDashboardStats() {
	    List<Tournament> all = tournamentRepository.findAll();
	    LocalDate today = LocalDate.now();

	    long upcoming = all.stream().filter(t -> t.getStartDate() != null && today.isBefore(t.getStartDate())).count();
	    long ongoing = all.stream().filter(t -> t.getStartDate() != null && t.getEndDate() != null)
	    	    .filter(t -> !today.isBefore(t.getStartDate()) && !today.isAfter(t.getEndDate()))
	    	    .count();
	    long completed = all.stream().filter(t -> t.getEndDate() != null && today.isAfter(t.getEndDate())).count();

	    Map<String, Long> stats = new HashMap<>();
	    stats.put("total", (long) all.size());
	    stats.put("upcoming", upcoming);
	    stats.put("ongoing", ongoing);
	    stats.put("completed", completed);
	    return stats;
	}

    // --- Tournament Methods ---
    public void saveTournament(Tournament tournament) {
        tournamentRepository.save(tournament);
    }

    public List<Tournament> getAllTournaments() {
        return tournamentRepository.findAll();
    }
    
    public Tournament getTournamentById(int id) {
        return tournamentRepository.findById(id).orElse(null);
    }
    
    public boolean deleteTournamentById(int id) {
        if (tournamentRepository.existsById(id)) {
            tournamentRepository.deleteById(id);
            return true;
        }
        return false;
    }
    
    // PARTICIPANT METHODS 
    public void registerParticipant(TournamentParticipant participant) {
        participantRepository.save(participant);
    }
    
    public List<TournamentParticipant> getAllParticipants() {
        // આ મેથડ રિપોઝીટરીમાંથી બધા જ પાર્ટિસિપન્ટ્સ ફેચ કરશે
        return participantRepository.findAll(); 
    }
    
    public List<TournamentParticipant> getParticipantsByTournamentId(int id) {
        return participantRepository.findByTournamentId(id);
    }
    
    public TournamentParticipant getLatestRecordByStudentId(String studentId) {
        return participantRepository.findFirstByStudentIdOrderByIdDesc(studentId);
    }
    
    public TournamentParticipant getLatestParticipant() {
        return participantRepository.findTopByOrderByIdDesc();
    }

    // ID દ્વારા સ્ટુડન્ટની વિગતો શોધવા માટે
    public TournamentParticipant findByStudentId(String sId) {
        return participantRepository.findFirstByStudentIdOrderByIdDesc(sId);
    }
    
    @Transactional
    public void updateRankings(List<TournamentResultDTO> results) {
    	for (TournamentResultDTO dto : results) {
            participantRepository.findById(dto.getParticipantId()).ifPresent(p -> {
                p.setKataMedal(dto.getKataMedal());
                p.setKumiteMedal(dto.getKumiteMedal());
                p.setChampionship(dto.isChampionship());
                participantRepository.save(p);
            });
    	}
    }
}
