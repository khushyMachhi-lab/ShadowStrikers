package com.example.demo.model;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import com.example.demo.validation.ValidPassword;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name= "users")
public class User {

	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private int id;
	
	private String firstName;
	private String lastName;
	
	@NotBlank(message = "Username is required")
	@Column(name = "user_name", unique = true, nullable = false)
	private String userName;
	
	@ValidPassword
	private String password;
	
	@Email(message = "Please enter a valid email format")
	@NotBlank(message = "Email is required")
	private String email;
	
	private String gender;
	private LocalDate birthdate;
	private String address;
	private String city;
	private String state;
	private String country;
	private String photo;
	
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Admissions admissions;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "batch_id") 
	private BatchTime batch;
	
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private Documents documents;
	
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private List<Payment> payments;

	public int getId() {return id;}
	public void setId(int id) {this.id = id;}
	
	public String getFirstName() {return firstName;}
	public void setFirstName(String firstName) {this.firstName = firstName;}
	
	public String getLastName() {return lastName;}
	public void setLastName(String lastName) {this.lastName = lastName;}

	
	public String getUserName() {return userName;}
	public void setUserName(String userName) {this.userName = userName;}
	
	
	public String getPassword() {return password;}
	public void setPassword(String password) {this.password = password;}
	
	public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}
	
	public String getGender() {return gender;}
	public void setGender(String gender) {this.gender = gender;}
	
	public LocalDate getBirthdate() {return birthdate;}
	public void setBirthdate(LocalDate birthdate) {this.birthdate = birthdate;}
	
	public int getAge() {
	    if (this.birthdate != null) {
	        return Period.between(this.birthdate, LocalDate.now()).getYears();
	    }
	    return 0;
	}
	
	public String getAddress() {return address;}
	public void setAddress(String address) {this.address = address;}
	
	public String getCity() {return city;}
	public void setCity(String city) {this.city = city;}
	
	public String getState() {return state;}
	public void setState(String state) {this.state = state;}
	
	public String getCountry() {return country;}
	public void setCountry(String country) {this.country = country;}
	
	public String getPhoto() {return photo;}
	public void setPhoto(String photo) {this.photo = photo;}
	
	// Optional: Helper method for the JSP to get the full image path
    @Transient // Tells JPA not to map this field to a database column
    public String getPhotosImagePath() {
        if (photo == null || id == 0) return "/images/default-profile.png"; // Default image path
        // Assumes your static file mapping is correct: /user-photos/{filename}
        return "/user-photos/" + this.photo;
    }
	
	public Admissions getAdmissions() { return admissions; }
	public void setAdmissions(Admissions admissions) { this.admissions = admissions; }
	
	public BatchTime getBatch() { return batch; }
	public void setBatch(BatchTime batch) { this.batch = batch; }
	
	public Documents getDocuments() {return documents;}
	public void setDocuments(Documents documents) {this.documents = documents;}
	
	@Transient
	private Attendance lastAttendance;
	
	@Transient 
	private double attendancePercentage;

	public Attendance getLastAttendance() { return lastAttendance; }
	public void setLastAttendance(Attendance lastAttendance) { this.lastAttendance = lastAttendance; }

	public double getAttendancePercentage() {return attendancePercentage;}
	public void setAttendancePercentage(double attendancePercentage) {this.attendancePercentage = attendancePercentage;}
	
	public List<Payment> getPayments() {return payments;}
	public void setPayments(List<Payment> payments) {this.payments = payments;}
	
}
