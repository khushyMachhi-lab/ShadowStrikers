<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tournament Registration - ShadowStrikers</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
        /* Synced with About Us Page */
        	--primary-color: #922b3e; /* Deep Maroon */
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	--dark-color: #1a1a2e;
        	--font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        
        /* Dashboard Specifics */
        	--accent-color: #c62b3c;
        	--success-color: #28a745;
        	--warning-color: #ffc107;
        	--danger-color: #dc3545;
        	--sidebar-width: 280px;
        }
        
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {font-family: var(--font-family); background: #f4f7f6; overflow-x: hidden;}
        
        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: var(--primary-color);
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            z-index: 1000;
            transition: all 0.3s ease;
            overflow-y: auto;
        }
        
        .sidebar-header {padding: 30px 25px; background-color: rgba(0,0,0,0.1); border-bottom: 1px solid rgba(255,255,255,0.1);}  
        .sidebar-brand {display: flex; align-items: center; gap: 12px; color: white; text-decoration: none; font-size: 1.4rem; font-weight: 800;}
        .sidebar-brand span {color: #ffffff !important; font-weight: 800; letter-spacing: 1px; text-transform: uppercase; font-size: 1.2rem;}  
        .sidebar-menu {padding: 30px 0;}
        
        .admin-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 8px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 25px;
            color: rgba(255,255,255,0.8) !important;
            text-decoration: none;
            transition: all 0.2s ease;
            position: relative;
            font-weight: 500;
            font-size: 1rem;
        }

        .menu-item i {color: rgba(255, 255, 255, 0.6); font-size: 1.2rem; width: 25px; text-align: center;}
        .menu-item:hover {background: rgba(255,255,255,0.1); color: #ffffff !important;}

        .menu-item.active {background-color: #ffffff !important; color: var(--primary-color) !important; font-weight: 700; border-left: 4px solid var(--accent-color);}
        .menu-item.active i {color: var(--primary-color) !important;}

        .menu-divider {height: 1px; background: rgba(255,255,255,0.2); margin: 15px 25px;}
        .menu-item.logout {color: #ffcfcf !important;}
        .menu-item.logout:hover {background-color: var(--primary-dark); color: #ffffff !important;}
        
        /* Main Content Wrapper - THIS FIXES THE SIDEBAR OVERLAP */
        .main-content {margin-left: var(--sidebar-width); min-height: 100vh; transition: all 0.3s ease;}

        /* Top Navbar */
        .top-navbar {
            background: #ffffff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-bottom: 1px solid #eee;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-left h2 {font-size: 1.8rem; font-weight: 800; color: var(--dark-color); margin: 0;}
        .navbar-right {display: flex; align-items: center; gap: 20px;}
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            padding: 8px 15px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .user-profile:hover {background: #f8f9fa;}
        .user-avatar {width: 45px; height: 45px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 1.1rem; overflow: hidden;}
        .user-avatar img {width: 100%; height: 100%; object-fit: cover;}
        .user-info h6 {margin: 0; font-weight: 700; color: var(--dark-color); font-size: 0.95rem;}

        /* Dashboard Content */
        .dashboard-content {padding: 40px 30px;}

        .reg-card {background: white; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; max-width: 800px; margin: auto;}
        .reg-header {background: linear-gradient(135deg, #5a0f14 0%, #922b3e 100%); color: white; padding: 40px; text-align: center; border-bottom: 4px solid var(--warning-color);}
        .reg-header i {font-size: 3rem; color: #ffffff; margin-bottom: 15px; filter: drop-shadow(0 5px 10px rgba(0,0,0,0.2));}
        .reg-body {padding: 40px;}

        .form-label {font-weight: 600; color: #4a5568; margin-bottom: 8px;}
        .form-control, .form-select {padding: 12px; border-radius: 10px; border: 2px solid #edf2f7; transition: 0.3s;}
        .form-control:focus {border-color: var(--primary-color); box-shadow: none;}

        .btn-register {
            background: var(--accent-color);
            border: none;
            padding: 15px 30px;
            border-radius: 10px;
            font-weight: 800;
            color: white;
            width: 100%;
            transition: 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-register:hover {background: #e55a2b; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255,107,53,0.3);}

        .category-box {border: 2px solid #edf2f7; border-radius: 10px; padding: 15px; cursor: pointer; transition: 0.3s; text-align: center;}
        .category-box:hover { border-color: var(--primary-color); background: #f8fbff; }

        input[type="checkbox"]:checked + .category-box {border-color: var(--primary-color); background: rgba(146, 43, 62, 0.1); box-shadow: 0 5px 15px rgba(146, 43, 62, 0.2);}
		input[type="checkbox"]:checked + .category-box i, input[type="checkbox"]:checked + .category-box span {color: var(--primary-color); font-weight: 700;}
        
        /* Floating Back Button Style */
		.floating-back-btn {
    		position: fixed;
    		bottom: 30px;
    		right: 30px;
    		background-color: #922b3e; /* તમારો થીમ કલર */
    		color: white !important;
    		padding: 12px 24px;
    		border-radius: 50px; /* આનાથી પિલ શેપ (લંબગોળ) આવશે */
    		display: flex;
    		align-items: center;
    		gap: 10px;
    		text-decoration: none;
    		transition: all 0.3s ease;
    		border: none; /* બોર્ડર કાઢી નાખી */
    		z-index: 1000;
    		font-weight: 600;
    		letter-spacing: 1px;
		}
		.floating-back-btn:hover {transform: translateY(-5px); background-color: #7a2434; box-shadow: 0 8px 20px rgba(146, 43, 62, 0.3); color: white !important;}
		.floating-back-btn i {font-size: 1.1rem;}
		
		.back-content i {font-size: 1.5rem; margin-bottom: 2px;}

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {left: calc(-1 * var(--sidebar-width));}
            .sidebar.active {left: 0;}
            .main-content {margin-left: 0;}
            .top-navbar {padding: 15px 20px;}
            .navbar-left h2 {font-size: 1.4rem;}
            .user-info {display: none;}
            .dashboard-content {padding: 25px 15px;}
        }
    </style>
</head>
<body>

	<div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <a href="/" class="sidebar-brand">
                <img src="${pageContext.request.contextPath}/logo/logo_2.png" alt="logo" style="height:30px;" />
                <span>ShadowStrikers</span>
            </a>
            <div class="admin-badge">Admin-Desk</div>
        </div>
        <div class="sidebar-menu">
            <a href="/admin/dashboard" class="menu-item">
                <i class="fas fa-th-large"></i> <span>Dashboard</span>
            </a>
            <a href="/admin/enquiries" class="menu-item">
                <i class="fas fa-question-circle"></i> <span>Enquiries</span>
            </a>
            <a href="/admin/admissions" class="menu-item">
                <i class="fas fa-user-plus"></i> <span>Admissions</span>
            </a>
            <a href="/admin/studentsRecords" class="menu-item">
        		<i class="fas fa-users"></i> <span>Students Records</span>
    		</a>
            <a href="/admin/attendance" class="menu-item">
                <i class="fas fa-clipboard-check"></i> <span>Attendance</span>
            </a>
            <a href="/admin/payments" class="menu-item">
                <i class="fas fa-money-bill-wave"></i> <span>Payments</span>
            </a>
            <a href="/admin/tournaments" class="menu-item active">
                <i class="fas fa-trophy"></i> <span>Tournaments</span>
            </a>
            
            <div class="menu-divider"></div>
            
            <a href="/logout" class="menu-item logout">
                <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-navbar">
            <div class="navbar-left">
                <h2>Add Participant</h2>
                <p class="text-muted">Register Participant</p>
            </div>
            <div class="navbar-right">
                <div class="user-profile">
                    <div class="user-avatar">
                        <img src="${pageContext.request.contextPath}/admin-photo/image-1.jpg" alt="Admin Avatar">
                    </div>
                    <div class="user-info">
                        <h6>Admin</h6>
                    </div>
                </div>
            </div>
        </div>

    <div class="container mt-5">
        <div class="reg-card mt-3">
            <div class="reg-header">
                <i class="fas fa-trophy"></i>
                <h2>Tournament Registration</h2>
            </div>
            
            <c:if test="${not empty toastMsg}">
    			<div id="successAlert" 
         			 class="alert alert-success alert-dismissible fade show shadow-sm mt-4 mx-3" 
        			 role="alert" 
         			 style="border-radius: 12px; border-left: 5px solid #28a745; margin-bottom: 0;">
        			<i class="fas fa-check-circle me-2"></i>
        			<strong>Success!</strong> ${toastMsg}
        			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    			</div>
			</c:if>

            <div class="reg-body">
                <form action="${pageContext.request.contextPath}/admin/tournaments/participant/registerParticipant" method="post">
                
                	<div class="row g-3 mb-4 p-3" style="background: #f8f9fa; border-radius: 15px; border: 1px dashed var(--primary-color);">
                    	<div class="col-md-12">
                        	<label class="form-label text-uppercase small" style="color: var(--primary-color);">Target Tournament</label>
                            	<select name="tournamentId" id="tournamentSelect" class="form-select form-select-lg" onchange="updateFeeAmount()" required>
                            	<option value="" selected disabled>-- Select Tournament --</option>
                            	<c:forEach items="${tournaments}" var="t">
                                	<option value="${t.id}" data-fee="${t.registrationFee}">${t.name} - ${t.eventYear}</option>
                                </c:forEach>
                             	</select>
                        </div>
                    </div>

        			<hr class="my-4 opacity-25">
                    
                    <div class="row g-3 mb-4">
                        <h5 class="fw-bold mb-3"><i class="fas fa-user me-2"></i>Personal Details</h5>
                        <div class="col-md-6">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" id="fullNameField" class="form-control" placeholder="Student Name" required>
                        </div>
                        <div class="col-md-6">
    						<label class="form-label">Student ID / Roll No</label>
    							<div class="input-group">
        							<input type="text" name="studentId" id="studentIdField" 
               							   class="form-control" value="${nextStudentId}" placeholder="Search by ID">
        							<button type="button" class="btn btn-dark" onclick="searchExistingStudent()">
            							<i class="fas fa-search"></i> Check
        							</button>
    							</div>
    							<small class="text-muted">Use auto-ID for new students; Search for existing.</small>
						</div>
                        </div>
                        
                        <div class="row g-3 mb-4">
                    	<div class="col-md-6">
            				<label class="form-label">Date of Birth</label>
            				<input type="date" name="dob" id="dobField" class="form-control" onchange="calculateAge()" required>
        				</div>
        				<div class="col-md-6">
        						<label class="form-label d-block">Gender</label>
        					<div class="mt-2">
            				<div class="form-check form-check-inline">
                				<input class="form-check-input" type="radio" name="gender" id="male" value="Male" checked>
                				<label class="form-check-label" for="male">Male</label>
            				</div>
            				<div class="form-check form-check-inline">
                				<input class="form-check-input" type="radio" name="gender" id="female" value="Female">
                				<label class="form-check-label" for="female">Female</label>
            				</div>
            				<div class="form-check form-check-inline">
                				<input class="form-check-input" type="radio" name="gender" id="other" value="Other">
                				<label class="form-check-label" for="other">Other</label>
            				</div>
        					</div>
        					</div>
        				<div class="col-md-6">
            				<label class="form-label">Age</label>
            				<input type="number" name="age" id="ageField" class="form-control" readonly placeholder="Auto-calculated">
        				</div>
        				<div class="col-md-6">
                            <label class="form-label">Weight (kg)</label>
                            <input type="number" name="weight" id="weightField" class="form-control" placeholder="For category grouping">
                        </div>
    					</div>
  
  						<div class="row g-3 mb-4">
    						<div class="col-md-6">
        						<label class="form-label">Current Belt / Rank</label>
        						<div class="input-group">
            						<span class="input-group-text bg-white"><i class="fas fa-ribbon text-muted"></i></span>
            						<select name="rank" id="rankField" class="form-select" required>
                						<option value="">Select Rank</option>
                						<option value="White">White Belt</option>
                						<option value="Yellow">Yellow Belt</option>
                						<option value="Green">Green Belt</option>
                						<option value="Orange">Orange Belt</option>
                						<option value="Blue">Blue Belt</option>
                						<option value="Purple">Purple Belt</option>
                						<option value="Brown">Brown Belt</option>
                						<option value="Black">Black Belt</option>
            						</select>
        						</div>
    						</div>

    						<div class="col-md-6">
        						<label class="form-label">Technique</label>
        						<div class="input-group">
            						<span class="input-group-text bg-white"><i class="fas fa-graduation-cap text-muted"></i></span>
            						<select name="technique" id="techniqueField" class="form-select" required>
                						<option value="">Select Technique</option>
                						<option value="Karate">Karate</option>
                						<option value="Taek-wondo">Taek-wondo</option>
                						<option value="Kickboxing">Kickboxing</option>
                						<option value="MMA">MMA</option>
                						<option value="Judo">Judo</option>
                           			</select>
        						</div>
    						</div>
						</div>
                    
						<div class="row g-3 mb-4">
    						<h5 class="fw-bold mb-3"><i class="fas fa-medal me-2"></i>Select Event Category (You can select multiple)</h5>
    
    						<div class="col-md-4">
        						<label class="w-100">
            						<input type="checkbox" name="category" value="Kata" class="btn-check" id="cat-kata">
            						<div class="category-box">
                						<i class="fas fa-pray d-block mb-2"></i>
                						<span>Kata</span>
            						</div>
        						</label>
    						</div>
    
    						<div class="col-md-4">
        						<label class="w-100">
            						<input type="checkbox" name="category" value="Kumite" class="btn-check" id="cat-kumite">
            						<div class="category-box">
                						<i class="fas fa-fist-raised d-block mb-2"></i>
                						<span>Kumite</span>
            						</div>
        						</label>
    						</div>
    
    						<div class="col-md-4">
        						<label class="w-100">
            					<input type="checkbox" name="category" value="Champion of Champions" class="btn-check" id="cat-coc">
            						<div class="category-box">
                						<i class="fas fa-crown d-block mb-2" style="color: #ffd700;"></i>
                						<span>Champion of Champions</span>
            						</div>
        						</label>
    						</div>
					</div>
                    
                    <div class="row g-3 mb-4">
    					<h5 class="fw-bold mb-3"><i class="fas fa-place-of-worship me-2"></i>Dojo Details</h5>
    				<div class="col-md-12">
       	 				<label class="form-label">Dojo Name</label>
        			<div class="input-group">
            			<span class="input-group-text bg-white"><i class="fas fa-university text-muted"></i></span>
            			<select name="dojoName" id="dojoField" class="form-select" required>
                			<option value="">Select Dojo / Branch</option>
                			<option value="Main Dojo">ShadowStriker Main Dojo</option>
                			<option value="North Branch">North City Branch</option>
                			<option value="South Branch">South Side Branch</option>
                			<option value="External">External (Guest Participant)</option>
            			</select>
        			</div>
        				<small class="text-muted">Select the home dojo of the participant</small>
    				</div>
					</div>
					
                    <div class="row g-3 mb-4">
    					<h5 class="fw-bold mb-3"><i class="fas fa-money-bill-wave me-2"></i>Payment Details</h5>
    					<div class="col-md-12">
        					<label class="form-label">Fees Amount</label>
        					<input type="number" name="feeAmount" class="form-control" placeholder="Enter amount here" required>
    					</div>
					</div>

                    <button type="submit" class="btn btn-register mt-3">Confirm Registration</button>
                </form>
            </div>
        </div>
	</div>
</div>
        
        <a href="${pageContext.request.contextPath}/admin/tournaments" class="floating-back-btn shadow" title="Back to tournaments">
    		<i class="fas fa-arrow-left"></i>
    		<span>BACK</span>
		</a>
		
	<div class="modal fade" id="notificationModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
            <div class="modal-header" style="background: var(--primary-color); color: white; border-top-left-radius: 20px; border-top-right-radius: 20px; border: none;">
                <h5 class="modal-title fw-bold" id="modalTitle">
                    <i class="fas fa-bell me-2"></i> System Message
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center py-4">
                <div id="modalIcon" class="mb-3">
                    </div>
                <h5 id="modalMessage" class="fw-bold text-dark mb-2"></h5>
                <p id="modalSubText" class="text-muted mb-0"></p>
            </div>
            <div class="modal-footer border-0 justify-content-center pb-4">
                <button type="button" class="btn px-5 rounded-pill shadow-sm" 
                        style="background: var(--primary-color); color: white; font-weight: 600;" 
                        data-bs-dismiss="modal">UNDERSTOOD</button>
            </div>
        </div>
    </div>
</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	
	function showModal(title, message, subtext, type) {
		
		if (typeof bootstrap === 'undefined') {
	        alert(message); // જો JS લોડ ના થઈ હોય તો સાદું એલર્ટ બતાવો
	        return;
	    }
		
        document.getElementById('modalTitle').innerHTML = '<i class="fas fa-bell me-2"></i> ' + title;
        document.getElementById('modalMessage').innerText = message;
        document.getElementById('modalSubText').innerText = subtext;
        
        const iconDiv = document.getElementById('modalIcon');
        if(type === 'success') {
            iconDiv.innerHTML = '<i class="fas fa-check-circle text-success" style="font-size: 3.5rem;"></i>';
        } else if(type === 'warning') {
            iconDiv.innerHTML = '<i class="fas fa-exclamation-triangle text-warning" style="font-size: 3.5rem;"></i>';
        } else {
            iconDiv.innerHTML = '<i class="fas fa-info-circle text-primary" style="font-size: 3.5rem;"></i>';
        }
        
        var myModal = new bootstrap.Modal(document.getElementById('notificationModal'));
        myModal.show();
    }
	
    // એક્ઝિસ્ટિંગ સ્ટુડન્ટ શોધવા માટે
    function searchExistingStudent() {
        const sid = document.getElementById('studentIdField').value;
        const defaultId = "${nextStudentId}";

        if(!sid) {
            showModal("Attention", "Please enter a Student ID", "Field cannot be empty.", "warning");
            return;
        }

        fetch(`${pageContext.request.contextPath}/admin/tournaments/participant/findExistingStudent?studentId=` + sid)
            .then(response => response.json())
            .then(data => {
                if(data && data.fullName) {
                    document.getElementById('fullNameField').value = data.fullName;
                    // અન્ય ફિલ્ડ્સ પણ અહીં ડેટા મુજબ સેટ કરી શકાય
                    showModal("Student Found!", "Existing record retrieved.", "Details for " + data.fullName + " have been auto-filled.", "success");
                } else {
                    showModal("Not Found", "No record found for this ID.", "Proceeding with new registration. ID reset to " + defaultId, "info");
                    document.getElementById('studentIdField').value = defaultId;
                    document.getElementById('fullNameField').value = "";
                }
            })
            .catch(err => {
                console.error(err);
                showModal("Error", "Something went wrong", "Could not connect to server.", "warning");
            });
    }

    // ઉંમર ગણવા માટે
    function calculateAge() {
        const dob = document.getElementById('dobField').value;
        if (dob) {
            const birthDate = new Date(dob);
            const today = new Date();
            let age = today.getFullYear() - birthDate.getFullYear();
            const m = today.getMonth() - birthDate.getMonth();
            if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
            document.getElementById('ageField').value = age;
        }
    }
    
    // ફોર્મ સબમિટ વેલિડેશન
    document.querySelector('form').onsubmit = function() {
        const checkboxes = document.querySelectorAll('input[name="category"]:checked');
        if (checkboxes.length === 0) {
            showModal("Selection Required", "Category missing!", "Please select at least one (Kata, Kumite, or COC).", "warning");
            return false;
        }
        return true;
    };
    
    // ફી અપડેટ કરવા માટે
    function updateFeeAmount() {
        const select = document.getElementById('tournamentSelect');
        const selectedOption = select.options[select.selectedIndex];
        const fee = selectedOption.getAttribute('data-fee');
        const feeInput = document.querySelector('input[name="feeAmount"]');
        if (feeInput && fee) {
            feeInput.value = fee;
        }
    }
    
    // પેજ લોડ થાય ત્યારે મેસેજ ચેક કરવા માટે
    document.addEventListener("DOMContentLoaded", function() {
    const alertElement = document.getElementById('successAlert');
    if (alertElement) {
        // ૫૦૦૦ મિલીસેકન્ડ (૫ સેકન્ડ) પછી બંધ થશે
        setTimeout(function() {
            // બૂટસ્ટ્રેપનું ક્લોઝ એનિમેશન વાપરવા માટે
            const bsAlert = new bootstrap.Alert(alertElement);
            bsAlert.close();
        }, 5000);
    }
});
    
   // બ્રાઉઝરની હિસ્ટ્રીમાંથી પાછા આવતી વખતે પેજ રિલોડ કરવા માટે
    window.onpageshow = function(event) {
        if (event.persisted) {
            window.location.reload();
        }
    };

    // ફોર્મ સબમિટ થયા પછી હિસ્ટ્રી સ્ટેટ બદલવા માટે
    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }
</script>
</body>
</html>