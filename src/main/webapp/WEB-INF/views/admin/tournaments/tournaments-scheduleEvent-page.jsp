<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Tournament - ShadowStrikers</title>
    
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
        	--text-gradient: linear-gradient(135deg, #7b2d39 0%, #b14555 100%);
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

        /* Sidebar & Layout */
        .sidebar { 
        	position: fixed; 
        	top: 0; 
        	left: 0; 
        	height: 100vh; 
        	width: var(--sidebar-width); 
        	background: var(--primary-color); 
        	box-shadow: 4px 0 10px rgba(0,0,0,0.1);
        	z-index: 1000; 
        	overflow-y: auto; 
        	transition: all 0.3s ease; 
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
        	transition: all 0.3s ease; 
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
        
        /* Form Card */
        .schedule-card {background: white; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); max-width: 900px; margin: 30px auto; overflow: hidden;}
        .card-header-custom {background: linear-gradient(135deg, #5a0f14 0%, #922b3e 100%); color: white; padding: 20px 30px; display: flex; align-items: center; gap: 15px; border-bottom: 3px solid var(--warning-color);}
        .form-body {padding: 40px; background-color: #ffffff;} 
        .form-label {font-weight: 600; color: #4a5568; margin-bottom: 8px;}
        .form-control, .form-select {border: 2px solid #edf2f7; padding: 12px; border-radius: 10px; transition: 0.3s;}
        .form-control:focus {border-color: var(--primary-color); box-shadow: none;}

        .btn-submit {background: var(--primary-color); color: white; padding: 12px 30px; border-radius: 10px; font-weight: 700; border: none; transition: 0.3s;}
        .btn-submit:hover {background: #7a2434 !important; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(146, 43, 62, 0.3);}
        
        /* Floating Back Button Style */
		.floating-back-btn {
    		position: fixed;
    		bottom: 30px;
    		right: 30px;
    		background-color: #922b3e; 
    		color: white !important;
    		padding: 12px 24px;
    		border-radius: 50px; 
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
                <h2>Schedule Event</h2>
                <p class="text-muted">Create a new tournament entry</p>
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
        
        	<c:if test="${not empty successMessage}">
    			<div class="px-4 mt-3">
        		<div class="alert alert-success alert-dismissible fade show shadow-sm border-0" role="alert">
            		<i class="fas fa-check-circle me-2"></i> ${successMessage}
            		<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        		</div>
    			</div>
			</c:if>

        <div class="content-body px-4">
    	<div class="schedule-card">
        <div class="card-header-custom">
            <div class="icon-box bg-white text-maroon rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
        		<i class="fas fa-calendar-alt" style="color: #922b3e;"></i>
    		</div>
            <div>
                <h5 class="mb-0">Tournament Configuration</h5>
                <small class="text-white-50">Define the tournament name, duration, and year</small>
            </div>
        </div>

        <div class="form-body">
            <form action="${pageContext.request.contextPath}/admin/tournaments/createEvent/save" method="post">
                <div class="row g-4">
                    
                    <div class="col-md-9">
                        <label class="form-label">Tournament Name</label>
                        <input type="text" name="name" class="form-control" placeholder="e.g. State Level Karate Championship" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Event Year</label>
                        <select name="eventYear" id="dynamicYear" class="form-select" required></select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Start Date</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="far fa-calendar-alt text-primary"></i></span>
                            <input type="date" name="startDate" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">End Date</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="far fa-calendar-check text-success"></i></span>
                            <input type="date" name="endDate" class="form-control" required>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Reporting Time</label>
                        <input type="time" name="startTime" class="form-control" required>
                    </div>
                    <div class="col-md-6">
    					<label class="form-label">Registration Fee (₹)</label>
    					<input type="number" name="registrationFee" class="form-control" value="500" min="0" required>
					</div>

                    <div class="col-12">
                        <label class="form-label">Venue / Location</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="fas fa-map-marker-alt text-danger"></i></span>
                            <input type="text" name="location" class="form-control" placeholder="Full address of the stadium or dojo">
                        </div>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label">Visibility Status</label>
                        <select name="status" class="form-select">
                            <option value="Open">Open (Visible to Students)</option>
                            <option value="Closed">Closed (Archive Only)</option>
                            <option value="Draft">Draft (Only Admin can see)</option>
                        </select>
                    </div>

                    <div class="col-12 mt-5 text-end">
                        <button type="reset" class="btn btn-light px-4 me-2 border">Clear Fields</button>
                        <button type="submit" class="btn btn-submit px-5 shadow-sm">
                            <i class="fas fa-paper-plane me-2"></i>Schedule Tournament
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</div>

		<a href="${pageContext.request.contextPath}/admin/tournaments" class="floating-back-btn shadow" title="Back to tournaments">
    		<i class="fas fa-arrow-left"></i>
    		<span>BACK</span>
		</a>
		
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
		document.addEventListener("DOMContentLoaded", function() {
    	// 1. વર્ષ ડાયનેમિકલી લોડ કરવાનું લોજિક
    	const yearSelect = document.getElementById("dynamicYear");
    	const currentYear = new Date().getFullYear(); 
    	for (let i = 0; i < 5; i++) {
        	const year = currentYear + i;
        	const option = new Option(year, year);
        	yearSelect.add(option);
    	}

    	// 2. સક્સેસ મેસેજને 10 સેકન્ડ પછી ગાયબ કરવાનું લોજિક
    	const successAlert = document.querySelector('.alert-success');
    	if (successAlert) {
        	setTimeout(function() {
            	// Bootstrap ની 'fade' ઇફેક્ટનો ઉપયોગ કરીને ગાયબ કરો
            	successAlert.classList.remove('show');
            
            	// 0.5 સેકન્ડ પછી એલિમેન્ટને ડોમ (DOM) માંથી સાવ હટાવી દો
            	setTimeout(function() {
                	successAlert.remove();
            	}, 500);
        	}, 10000); // 10000ms = 10 સેકન્ડ
    	}
		});

		// 3. ડેટ વેલિડેશન લોજિક
		const startDateInput = document.querySelector('input[name="startDate"]');
		const endDateInput = document.querySelector('input[name="endDate"]');

		if (startDateInput && endDateInput) {	
    		startDateInput.addEventListener('change', function() {
        	if (startDateInput.value) {
            	endDateInput.min = startDateInput.value;
            	if (endDateInput.value && endDateInput.value < startDateInput.value) {
                	endDateInput.value = "";
            	}
        	}
    		});
		}
</script>

</body>
</html>