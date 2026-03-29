package com.example.demo.dto;

public class TournamentResultDTO {
	
	private int participantId;
	private Integer kataMedal;   
    private Integer kumiteMedal; 
    private boolean championship;  
    
	public int getParticipantId() {return participantId;}
	public void setParticipantId(int participantId) {this.participantId = participantId;}
	
	public Integer getKataMedal() {return kataMedal;}
	public void setKataMedal(Integer kataMedal) {this.kataMedal = kataMedal;}
	
	public Integer getKumiteMedal() {return kumiteMedal;}
	public void setKumiteMedal(Integer kumiteMedal) {this.kumiteMedal = kumiteMedal;}
	
	public boolean isChampionship() {return championship;}
	public void setChampionship(boolean championship) {this.championship = championship;}
	
}
