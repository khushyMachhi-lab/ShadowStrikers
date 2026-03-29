<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Progress - ShadowStrikers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
         /* Synced with About Us Page */
        	--primary-color: #922b3e; /* Deep Maroon */
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	--text-gradient: linear-gradient(135deg, #7b2d39 0%, #b14555 100%);
        	--secondary-color: #ffffff;
        	--dark-color: #1a1a2e;
        	--sidebar-bg: #1a1a2e;
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
        .menu-item.logout:hover { background-color: var(--primary-dark); color: #ffffff !important; }
		
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
        
        .main-content {margin-left: var(--sidebar-width); padding: 20px; min-height: 100vh; transition: all 0.3s ease;}
        
        /* Progress Card Styles */
        .progress-card {position: relative; min-height: 200px; background: #fff; border-radius: 15px; border: 1px solid #eee; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;}
        .progress-card:hover {transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1);}
        
        /* Coming Soon Overlay */
		.coming-soon-container {position: relative; overflow: hidden;}
		.coming-soon-overlay {position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(255, 255, 255, 0.8); backdrop-filter: blur(3px); display: flex; flex-direction: column; align-items: center; justify-content: center; z-index: 5; border-radius: 15px;}
		.coming-soon-badge {background: var(--primary-color); color: white; padding: 10px 25px; border-radius: 50px; font-weight: 800; font-size: 1.1rem; box-shadow: 0 4px 15px rgba(146, 43, 62, 0.3); text-transform: uppercase; letter-spacing: 1px; animation: pulse 2s infinite;}

		@keyframes pulse {
    		0% {transform: scale(1);}
    		50% {transform: scale(1.05);}
    		100% {transform: scale(1);}
		}

		.coming-soon-text {color: var(--dark-color); font-size: 0.85rem; margin-top: 10px; font-weight: 600;}
		.empty-state {text-align: center; padding: 50px; background: white; border-radius: 15px; border: 2px dashed #ccc;}
        
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
    		border: none; 
    		z-index: 1000;
    		font-weight: 600;
    		letter-spacing: 1px;
		}

		.floating-back-btn:hover {transform: translateY(-5px); background-color: #7a2434; box-shadow: 0 8px 20px rgba(146, 43, 62, 0.3); color: white !important;}
		.floating-back-btn i {font-size: 1.1rem;}
		
		/* Responsive */
        @media (max-width: 992px) {
            .sidebar {left: calc(-1 * var(--sidebar-width));}
            .sidebar.active {left: 0;}
            .main-content { margin-left: 0; }
            .top-navbar {padding: 15px 20px;}
            .navbar-left h2 {font-size: 1.4rem;}
            .user-info {display: none;}
            .dashboard-content {padding: 25px 15px;}
        }
        
    </style>
</head>
<body>
	
	<!-- Sidebar -->
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
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="/admin/enquiries" class="menu-item">
                <i class="fas fa-question-circle"></i>
                <span>Enquiries</span>
            </a>
            <a href="/admin/admissions" class="menu-item">
                <i class="fas fa-user-plus"></i>
                <span>Admissions</span>
            </a>
            <a href="/admin/studentsRecords" class="menu-item active">
        		<i class="fas fa-users"></i> <span>Students Records</span>
    		</a>
            <a href="/admin/attendance" class="menu-item">
                <i class="fas fa-clipboard-check"></i>
                <span>Attendance</span>
            </a>
            <a href="/admin/payments" class="menu-item">
                <i class="fas fa-money-bill-wave"></i>
                <span>Payments</span>
            </a>
            <a href="/admin/tournaments" class="menu-item">
                <i class="fas fa-trophy"></i>
                <span>Tournaments</span>
            </a>

            <div class="menu-divider"></div>

            <a href="/logout" class="menu-item logout">
                <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
            </a>
        </div>
    </div>
	
	<div class="main-content">
    <div class="d-flex align-items-center justify-content-center" style="min-height: 80vh;">
        <div class="text-center">
            <i class="fas fa-tools mb-4 text-muted opacity-25" style="font-size: 5rem;"></i>
            
            <h1 class="fw-bold display-3" style="color: var(--primary-color);">COMING SOON</h1>
            
            <p class="text-dark fw-bold fs-4 mt-3">
                <i class="fas fa-spinner fa-spin me-2"></i> Under Development
            </p>
            
            <hr class="mx-auto mt-4" style="width: 100px; height: 4px; background: var(--primary-color); border: none; border-radius: 10px;">
        </div>
    </div>
</div>

	<a href="${pageContext.request.contextPath}/admin/studentsRecords" class="floating-back-btn shadow" title="Back to Student Records">
    	<i class="fas fa-arrow-left"></i>
    	<span>BACK</span>
	</a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>