<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
        /* Synced with About Us Page */
        	--primary-color: #922b3e; 
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
        .menu-item.logout:hover {background-color: var(--primary-dark); color: #ffffff !important;}
        
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
        .dashboard-content {
            padding: 40px 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 15px 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .stat-card::before {content: ''; position: absolute; top: 0; left: 0; width: 5px; height: 100%;}
        .stat-card.blue::before { background: var(--primary-color); }
        .stat-card.orange::before { background: var(--accent-color); }
        .stat-card.green::before { background: var(--success-color); }
        .stat-card.purple::before { background: #667eea; }
        .stat-card:hover {transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.15);}

        .stat-header {display: flex; justify-content: space-between; align-items: start; margin-bottom: 20px;}
        
        .stat-icon {width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;}
        .stat-icon.blue { background: rgba(13, 110, 253, 0.1); color: var(--primary-color); }
        .stat-icon.orange { background: rgba(255, 107, 53, 0.1); color: var(--accent-color); }
        .stat-icon.green { background: rgba(40, 167, 69, 0.1); color: var(--success-color); }
        .stat-icon.purple { background: rgba(102, 126, 234, 0.1); color: #667eea; }

        .stat-trend {font-size: 0.85rem; padding: 5px 10px; border-radius: 20px; font-weight: 600;}
        .stat-trend.up {background: rgba(40, 167, 69, 0.1); color: var(--success-color);}
        .stat-number {font-size: 2 rem; font-weight: 800; color: var(--dark-color); margin-bottom: 5px;}
        .stat-label {color: #666; font-size: 1rem; font-weight: 500;}
        
        /* Container for the list inside the card */
		.activity-scroll-container {
    		max-height: 300px; 
    		overflow-y: auto;
    		padding-right: 10px; 
		}

		/* Custom Scrollbar Styling (Optional but recommended for a modern look) */
		.activity-scroll-container::-webkit-scrollbar {width: 6px;}
		.activity-scroll-container::-webkit-scrollbar-track {background: #f1f1f1; border-radius: 10px;}
		.activity-scroll-container::-webkit-scrollbar-thumb {background: #ccc; border-radius: 10px;}
		.activity-scroll-container::-webkit-scrollbar-thumb:hover {background: var(--primary-color);}

        .card-container {background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.08); margin-bottom: 30px;}
        .card-container h3 {font-size: 1.5rem; font-weight: 800; color: var(--dark-color); margin-bottom: 25px;}
        
        .table-container {overflow-x: auto;}
        .custom-table {width: 100%; border-collapse: separate; border-spacing: 0 10px;}
        .custom-table thead th {background: transparent; color: #666; font-weight: 700; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 0.5px; padding: 15px; border: none;}
        .custom-table tbody tr {background: #f8f9fa; transition: all 0.3s ease;}
        .custom-table tbody tr:hover {background: white; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transform: scale(1.01);}
        .custom-table tbody td {padding: 20px 15px; border: none; vertical-align: middle;}
        .custom-table tbody tr td:first-child {border-radius: 10px 0 0 10px;}
        .custom-table tbody tr td:last-child {border-radius: 0 10px 10px 0;}

        .badge-status {padding: 6px 15px; border-radius: 20px; font-size: 0.85rem; font-weight: 600;}
        .badge-active {background: rgba(40, 167, 69, 0.1); color: var(--success-color);}
        .badge-pending {background: rgba(255, 193, 7, 0.1); color: var(--warning-color);}
        .badge-inactive {background: rgba(108, 117, 125, 0.1); color: #666;;}

        .btn-action {padding: 8px 15px; border-radius: 8px; font-size: 0.9rem; border: none; cursor: pointer; transition: all 0.3s ease; margin: 0 3px;}
        .btn-action.delete {background-color: #dc3545; color: #fff;}
        .btn-action:hover {transform: translateY(-2px); box-shadow: 0 5px 10px rgba(0,0,0,0.1);}   
   	 	
        .search-bar {display: flex; gap: 15px; margin-bottom: 20px;}
        .search-bar input {flex: 1; padding: 12px 20px; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease;}
        .search-bar input:focus {outline: none; border-color: var(--primary-color);}
        .search-bar select {padding: 12px 20px; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; cursor: pointer;}

        .recent-item {display: flex; align-items: center; gap: 15px; padding: 15px; border-radius: 10px; background: #f8f9fa; margin-bottom: 12px; transition: all 0.3s ease;}
        .recent-item:hover {background: white; box-shadow: 0 5px 15px rgba(0,0,0,0.08);}
        
        .recent-icon {width: 45px; height: 45px; border-radius: 10px; display: flex; align-items: center;justify-content: center; flex-shrink: 0; font-size: 1.2rem;}
        .recent-icon.new { background: rgba(40, 167, 69, 0.1); color: var(--success-color); }
        .recent-icon.payment { background: rgba(255, 193, 7, 0.1); color: var(--warning-color); }
        .recent-icon.event { background: rgba(13, 110, 253, 0.1); color: var(--primary-color); }
        .recent-content {flex: 1;}

        .recent-content h6 {font-weight: 700; margin-bottom: 3px; color: var(--dark-color);}
        .recent-content p {font-size: 0.85rem; color: #666; margin: 0;}
        .recent-time {font-size: 0.8rem; color: #999;}

        /* Mobile Toggle */
        .sidebar-toggle {
            display: none;
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            z-index: 999;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {left: calc(-1 * var(--sidebar-width));}
            .sidebar.active {left: 0;}
            .main-content {margin-left: 0;}
            .sidebar-toggle {display: flex; align-items: center; justify-content: center;}
            .top-navbar {padding: 15px 20px;}
            .navbar-left h2 {font-size: 1.4rem;}
            .user-info {display: none;}
            .dashboard-content {padding: 25px 15px;}
            .stat-number {font-size: 2rem;}
            .custom-table {font-size: 0.85rem;}
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
            <a href="/admin/dashboard" class="menu-item active">
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
            <a href="/admin/tournaments" class="menu-item">
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
                <h2>Admin-Dashboard</h2>
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

    <div class="dashboard-content">
    <div class="row">
        <div class="col-lg-8">
            <div class="row g-3"> <div class="col-md-6">
                    <div class="stat-card blue">
                        <div class="stat-header">
                            <div class="stat-icon blue"><i class="fas fa-users"></i></div>
                        </div>
                        <div class="stat-number">${totalUsers}</div>
                        <div class="stat-label">Total Users</div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="stat-card purple">
                        <div class="stat-header">
                            <div class="stat-icon purple"><i class="fas fa-user-plus"></i></div>
                        </div>
                        <div class="stat-number">${newUsers}</div>
                        <div class="stat-label">New Registrations</div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="stat-card orange">
                        <div class="stat-header">
                            <div class="stat-icon orange"><i class="fas fa-question-circle"></i></div>
                        </div>
                        <div class="stat-number">${totalEnquiries}</div>
                        <div class="stat-label">Total Enquiries</div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="stat-card green">
                        <div class="stat-header">
                            <div class="stat-icon green"><i class="fas fa-money-bill-wave"></i></div>
                        </div>
                        <div class="stat-number">
                        	<fmt:formatNumber value="${not empty totalPayments ? totalPayments : 0}" 
                      						  type="currency" 
                      						  currencySymbol="₹" 
                      						  maxFractionDigits="0"/>
                        </div>
                        <div class="stat-label">Total Payments</div>
                    </div>
                </div>
            </div>
                    
            <div class="card-container mt-2">
                <h3>Recent Admissions</h3>
                <div class="table-container">
                    <table class="table custom-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Course</th> <th>Admission Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="adm" items="${recentAdmissions}">
                                <tr>
                                    <td>${adm.firstName} ${adm.lastName}</td>
                                    <td>
                                    	<span class="badge bg-light text-dark border">
                							${adm.admissions != null ? adm.admissions.courseName : 'No Course'}
            							</span>
                                    <td>
    									<c:choose>
        									<c:when test="${adm.admissions != null}">
                    							<fmt:parseDate value="${adm.admissions.admissionDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                    							<fmt:formatDate value="${parsedDate}" pattern="dd MMM, yyyy" />
                							</c:when>
        									<c:otherwise>
            									<span class="text-muted">N/A</span>
        									</c:otherwise>
    									</c:choose>
									</td>
                                    <td>
                                        <span class="badge-status 
                							${adm.admissions != null && adm.admissions.status == 'Active' ? 'badge-active' : 'badge-pending'}">
                							${adm.admissions != null ? adm.admissions.status : 'Pending'}
            							</span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/admissions/student-profile/${adm.id}" 
       										class="btn-action view" 
       										title="View Profile" 
       										style="background: rgba(13, 110, 253, 0.1); color: var(--primary-color); display: inline-flex; align-items: center; justify-content: center; text-decoration: none;">
        										<i class="fas fa-eye"></i>
    									</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentAdmissions}">
                                <tr><td colspan="4" class="text-center">No recent admissions found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        
                <div class="col-lg-4">
                    
                    <div class="card-container">
                        <h3>Recent Activity</h3>
                        <div class="activity-scroll-container">
                        	<c:forEach var="act" items="${recentActivities}">

                        		<div class="recent-item">
                            		<div class="recent-icon ${act.type.toLowerCase()}">
                        				<i class="fas ${act.icon}"></i>
                    				</div>
                    				<div class="recent-content">
                        				<h6>${act.title}</h6>
                        				<p>${act.description}</p>
                    				</div>
                    					<span class="recent-time text-muted small">${act.timeOrDate}</span>
                				</div>
            				</c:forEach>
            				<c:if test="${empty recentActivities}">
                				<p class="text-center text-muted py-3">No recent activities found.</p>
            				</c:if>
        				</div>
    				</div>
                    
                    <div class="card-container">
                        <h3>Upcoming Activity</h3>
                        <div class="activity-scroll-container">
                        	<c:forEach var="upcoming" items="${upcomingActivities}">
                        
                        		<div class="recent-item border-start border-3 ${upcoming.type == 'payment' ? 'border-danger' : 'border-warning'}">
                    				<div class="recent-icon ${upcoming.type}">
                        				<i class="fas ${upcoming.icon}"></i>
                    				</div>
                    				<div class="recent-content">
                        				<h6>${upcoming.title}</h6>
                        				<p class="small text-dark fw-bold">${upcoming.description}</p>
                    				</div>
                    					<span class="recent-time badge ${upcoming.type == 'payment' ? 'bg-danger' : 'bg-warning'} text-white">
                        					${upcoming.timeOrDate}
                    					</span>
                				</div>
            				</c:forEach>
            				<c:if test="${empty upcomingActivities}">
                				<p class="text-center text-muted py-3">All caught up! No pending tasks.</p>
            				</c:if>
        				</div>
    				</div>
				</div>
           </div> 
        </div>
    </div>

    <button class="sidebar-toggle" id="sidebarToggle">
        <i class="fas fa-bars"></i>
    </button>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    
        // Sidebar toggle for mobile
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');

        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const isClickInsideSidebar = sidebar.contains(event.target);
            const isClickOnToggle = sidebarToggle.contains(event.target);

            if (!isClickInsideSidebar && !isClickOnToggle && sidebar.classList.contains('active')) {
                sidebar.classList.remove('active');
            }
        });
    </script>
</body>
</html>
