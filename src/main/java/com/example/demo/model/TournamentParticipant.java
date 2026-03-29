package com.example.demo.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "tournament_participants")
public class TournamentParticipant {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fullName;
    private String studentId; // Optional/Manual ID
    private String dob;
    private String gender;
    private int age;
    private double weight;
    
    @Column(name = "student_rank")
    private String rank; // Belt
    private Integer medal;
    private Integer kataMedal = 0;   
    private Integer kumiteMedal = 0; 
    private boolean isChampionship;
    private String technique;
    private String category; // Kata/Kumite
    private String dojoName;
    
    private double feeAmount;

    // Foreign Key reference to Tournament
    @ManyToOne
    @JoinColumn(name = "tournament_id")
    private Tournament tournament;

	public int getId() {return id;}
	public void setId(int id) {this.id = id;}

	public String getFullName() {return fullName;}
	public void setFullName(String fullName) {this.fullName = fullName;}

	public String getStudentId() {return studentId;}
	public void setStudentId(String studentId) {this.studentId = studentId;}

	public String getDob() {return dob;}
	public void setDob(String dob) {this.dob = dob;}

	public String getGender() {return gender;}
	public void setGender(String gender) {this.gender = gender;}

	public int getAge() {return age;}
	public void setAge(int age) {this.age = age;}

	public double getWeight() {return weight;}
	public void setWeight(double weight) {this.weight = weight;}

	public String getRank() {return rank;}
	public void setRank(String rank) {this.rank = rank;}

	public Integer getMedal() {return medal;}
	public void setMedal(Integer medal) {this.medal = medal;}
	
	public Integer getKataMedal() {return kataMedal;}
	public void setKataMedal(Integer kataMedal) {this.kataMedal = kataMedal;}
	
	public Integer getKumiteMedal() {return kumiteMedal;}
	public void setKumiteMedal(Integer kumiteMedal) {this.kumiteMedal = kumiteMedal;}
	
	public boolean isChampionship() {return isChampionship;}
	public void setChampionship(boolean isChampionship) {this.isChampionship = isChampionship;}
	
	public String getTechnique() {return technique;}
	public void setTechnique(String technique) {this.technique = technique;}
	
	public String getCategory() {return category;}
	public void setCategory(String category) {this.category = category;}
	
	public String getDojoName() {return dojoName;}
	public void setDojoName(String dojoName) {this.dojoName = dojoName;}
	
	public double getFeeAmount() {return feeAmount;}
	public void setFeeAmount(double feeAmount) {this.feeAmount = feeAmount;}
	
	public Tournament getTournament() {return tournament;}
	public void setTournament(Tournament tournament) {this.tournament = tournament;}
    
}
