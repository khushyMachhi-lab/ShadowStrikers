<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tournament Records - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
        /* Synced with About Us Page */
        	--primary-color: #922b3e; /* Deep Maroon */
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	--secondary-color: #ffffff;
        	--dark-color: #1a1a2e;
        	--gold: #FFD700;    
    		--silver: #C0C0C0;  
    		--bronze: #CD7F32;
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
        
        .content-body {padding: 40px 30px;}

        /* Stats Cards */
        .stats-grid {display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 30px;}   
        .stat-card {background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); transition: all 0.3s ease; border-left: 5px solid transparent;}
        
        .stat-card:hover {transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1);}
        .stat-card.total {border-left-color: var(--primary-color);}
        .stat-card.upcoming {border-left-color: var(--warning-color);}
        .stat-card.ongoing {border-left-color: var(--success-color);}
        .stat-card.completed {border-left-color: #6c757d;}
        
        .stat-header {display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px;}
        .stat-label {font-size: 0.85rem; color: #666; text-transform: uppercase; font-weight: 700; letter-spacing: 0.5px;}
        .stat-icon {width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; color: white;}
        
        .stat-card.total .stat-icon {background: var(--primary-gradient);}
        .stat-card.upcoming .stat-icon {background: linear-gradient(135deg, var(--warning-color) 0%, #ff9800 100%);}
        .stat-card.ongoing .stat-icon {background: linear-gradient(135deg, var(--success-color) 0%, #20c997 100%);}
        .stat-card.completed .stat-icon {background: linear-gradient(135deg, #6c757d 0%, #495057 100%);}
        
        .stat-value {font-size: 2.5rem; font-weight: 900; color: var(--dark-color); line-height: 1; margin-bottom: 5px;}
        .stat-change {font-size: 0.85rem; color: #666;}
        
        /* Tournament Cards */
        .tournaments-section {background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 30px;}
        
        .section-header {display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; padding-bottom: 20px; border-bottom: 2px solid #f0f0f0;} 
        .section-title {font-size: 1.5rem; font-weight: 900; color: var(--dark-color); display: flex; align-items: center; gap: 10px;}       
        .section-title i {color: var(--accent-color);}
        
        .create-btn {background: var(--primary-gradient); color: white; padding: 12px 30px; border: none; border-radius: 10px; font-weight: 700; cursor: pointer; transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 8px;}  
        .create-btn:hover {transform: translateY(-2px); box-shadow: 0 8px 20px rgba(146, 43, 62, 0.3);}
        
        /* Filter Tabs */
        .filter-tabs {display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap;}   
        .filter-tab {padding: 10px 20px; border: 2px solid #e0e0e0; background: white; border-radius: 8px; font-size: 0.9rem; font-weight: 600; cursor: pointer; transition: all 0.3s ease;}
        .filter-tab:hover {border-color: var(--primary-color); color: var(--primary-color);}
        .filter-tab.active {background: var(--primary-gradient); color: white; border-color: var(--primary-color);}
        
        /* Tournament Grid */
        .tournaments-grid {display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 25px;}    
        .tournament-card {background: white; border: 2px solid #f0f0f0; border-radius: 15px; padding: 25px; transition: all 0.3s ease; position: relative; overflow: hidden;}  
        .tournament-card::before {content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 5px; background: var(--primary-gradient);}
        .tournament-card:hover {transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); border-color: var(--primary-color);}
        
        .tournament-header {display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px;}
        
        .tournament-status {padding: 6px 15px; border-radius: 20px; font-size: 0.75rem; font-weight: 700; text-transform: uppercase;}
        .tournament-status.upcoming {background: #fff3cd; color: #856404;}
        .tournament-status.ongoing {background: #d4edda; color: var(--success-color);}
        .tournament-status.completed {background: #f8f9fa; color: #6c757d;}
        
        .tournament-title {font-size: 1.3rem; font-weight: 800; color: var(--dark-color); margin-bottom: 10px;}       
        .tournament-details {display: flex; flex-direction: column; gap: 10px; margin-bottom: 20px;}
        
        .detail-item {display: flex; align-items: center; gap: 10px; font-size: 0.9rem; color: #666;}      
        .detail-item i {width: 20px; color: var(--primary-color);}
        
        .tournament-actions {display: flex; gap: 10px; padding-top: 15px; border-top: 1px solid #f0f0f0;}      
        .action-btn {flex: 1; padding: 10px; border: none; border-radius: 8px; font-size: 0.85rem; font-weight: 700; cursor: pointer; transition: all 0.3s ease; display: inline-flex; align-items: center; justify-content: center; gap: 6px;}
        
        .action-btn.primary {background: var(--primary-gradient); color: white;}
        .action-btn.primary:hover {transform: translateY(-2px); box-shadow: 0 5px 15px rgba(146, 43, 62, 0.3);}
        
        .action-btn.secondary {background: #f8f9fa; color: var(--dark-color); border: 2px solid #e0e0e0;}
        .action-btn.secondary:hover {background: white; border-color: var(--primary-color); color: var(--primary-color);}
        
        .action-btn.danger {background: #f8d7da; color: var(--danger-color);}
        .action-btn.danger:hover {background: var(--danger-color); color: white;}
        
        .detail-item .fa-money-check-alt {color: #28a745;}
        
        /* Modal */
        .modal {display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; align-items: center; justify-content: center;}
        .modal.active {display: flex;}
        .modal-header {font-size: 1.5rem; font-weight: 900; color: var(--dark-color); margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center;}
        .close-modal {cursor: pointer; font-size: 1.5rem; color: #666;}
        
        .form-group label {font-size: 0.9rem; font-weight: 700; color: var(--dark-color); margin-bottom: 8px; display: block;}
        .form-group input, .form-group select, .form-group textarea {width: 100%; padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 0.95rem; transition: all 0.3s ease;}
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(146, 43, 62, 0.1);}   
        
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
    		border: none; 
    		z-index: 1000;
    		font-weight: 600;
    		letter-spacing: 1px;
		}
		
		.floating-back-btn:hover {transform: translateY(-5px); background-color: #7a2434; box-shadow: 0 8px 20px rgba(146, 43, 62, 0.3); color: white !important;}
		.floating-back-btn i {font-size: 1.1rem;}
		
		.back-content i {font-size: 1.5rem; margin-bottom: 2px;}
		
		#deleteSuccessAlert {animation: slideInRight 0.5s ease-out; border-left: 5px solid #155724;}

		@keyframes slideInRight {
    		from { transform: translateX(100%); opacity: 0; }
    		to { transform: translateX(0); opacity: 1; }
		}
		
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {left: calc(-1 * var(--sidebar-width));}
            .sidebar.active {left: 0;}
            .main-content {margin-left: 0;}
            .stats-grid {grid-template-columns: repeat(2, 1fr);}
            .tournaments-grid {grid-template-columns: 1fr;}
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
                <h2 class="fw-bold">Tournament Records</h2>
                <p class="text-muted mb-0">Historical data and championship winners</p>
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

        <div class="content-body">
            
            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card total">
                    <div class="stat-header">
                        <div class="stat-label">Total Tournaments</div>
                        <div class="stat-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                    </div>
                    <div class="stat-value">${totalCount != null ? totalCount : 0}</div>
                    <div class="stat-change">All time</div>
                </div>
 
                <div class="stat-card upcoming">
                    <div class="stat-header">
                        <div class="stat-label">Upcoming</div>
                        <div class="stat-icon">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                    </div>
                    <div class="stat-value">${upcomingCount != null ? upcomingCount : 0}</div>
                    <div class="stat-change">Scheduled</div>
                </div>
 
                <div class="stat-card ongoing">
                    <div class="stat-header">
                        <div class="stat-label">Ongoing</div>
                        <div class="stat-icon">
                            <i class="fas fa-play-circle"></i>
                        </div>
                    </div>
                    <div class="stat-value">${ongoingCount != null ? ongoingCount : 0}</div>
                    <div class="stat-change">In Progress</div>
                </div>
 
                <div class="stat-card completed">
                    <div class="stat-header">
                        <div class="stat-label">Completed</div>
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                    <div class="stat-value">${completedCount != null ? completedCount : 0}</div>
                    <div class="stat-change">Finished</div>
                </div>
            </div>
            
            
            <!-- Tournaments Section -->
            <div class="tournaments-section">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-list"></i>
                        All Tournaments
                    </h3>
                </div>
                
                 <!-- Filter Tabs -->
                <div class="filter-tabs">
                    <button class="filter-tab active" onclick="filterTournaments('all', this)">All</button>
                    <button class="filter-tab" onclick="filterTournaments('upcoming', this)">Upcoming</button>
                    <button class="filter-tab" onclick="filterTournaments('ongoing', this)">Ongoing</button>
                    <button class="filter-tab" onclick="filterTournaments('completed', this)">Completed</button>
                </div>
                
                <!-- Tournaments Grid -->
                <div class="tournaments-grid" id="tournamentsGrid">
                
                	<c:if test="${empty allTournaments}">
    					<div class="text-center p-5">
        					<i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
        					<p class="text-muted">No tournaments found.</p>
    					</div>
					</c:if>

                    <c:forEach items="${allTournaments}" var="t">
                    	<div class="tournament-card" data-start="${t.startDate}" data-end="${t.endDate}">
                    		<div class="tournament-header">
                				<div class="tournament-status ${t.status.toLowerCase()}">${t.status}</div>
            				</div>
            				
            				<div class="tournament-title">${t.name} - ${t.eventYear}</div>
                        
                        <div class="tournament-details">
                            <div class="detail-item">
                                <i class="fas fa-calendar"></i>
                                <span>${t.startDate} to ${t.endDate}</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${t.location}</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-users"></i>
                                <span>${t.participantsCount} Participants</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-tag"></i>
                                <span>Kata & Kumite</span>
                            </div>
                            <div class="detail-item mt-1">
        						<i class="fas fa-money-check-alt"></i>
        						<span class="badge bg-light text-dark border" style="font-size: 0.85rem;">
            						Registration Fee: <strong>₹${t.registrationFee}</strong>
        						</span>
    						</div>
                        </div>
                        
                        <div class="tournament-actions">
                            <button class="action-btn danger" style="flex: 1;" onclick="confirmDelete('${t.id}', '${t.name}')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                 </c:forEach>
             </div>
         </div>
    </div>
</div>  

	<!--  <div class="modal fade" id="statsModal" tabindex="-1">
    	<div class="modal-dialog modal-dialog-centered modal-lg">
        	<div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
            	<div class="modal-header border-0 pb-0">
                	<h5 class="modal-title fw-bold" id="modalTName">Tournament Performance</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            	</div>
            	<div class="modal-body p-4">
                	<div class="row g-3">
                    	<div class="col-md-3">
                        	<div class="stat-box bg-participants shadow-sm">
                            	<i class="fas fa-users fa-2x mb-2"></i>
                            	<h3 id="totalParticipants">0</h3>
                            	<small>Participants</small>
                        	</div>
                    	</div>
                    	<div class="col-md-3">
                        	<div class="stat-box bg-gold shadow-sm">
                            	<i class="fas fa-medal fa-2x mb-2"></i>
                            	<h3 id="goldMedals">0</h3>
                            	<small>Gold (1st)</small>
                        	</div>
                    	</div>
                    	<div class="col-md-3">
                        	<div class="stat-box bg-silver shadow-sm">
                            	<i class="fas fa-medal fa-2x mb-2"></i>
                            	<h3 id="silverMedals">0</h3>
                            	<small>Silver (2nd)</small>
                        	</div>
                    	</div>
                    	<div class="col-md-3">
                        	<div class="stat-box bg-bronze shadow-sm">
                            	<i class="fas fa-medal fa-2x mb-2"></i>
                            	<h3 id="bronzeMedals">0</h3>
                            	<small>Bronze (3rd)</small>
                        	</div>
                    	</div>
                	</div>
            	</div>
        	</div>
    	</div>
	</div> -->
	
	<div id="deleteSuccessAlert" class="alert alert-success alert-dismissible fade show shadow" 
     	style="display:none; position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
    	<strong>Success!</strong> Tournament deleted successfully.
    	<button type="button" class="btn-close" onclick="this.parentElement.style.display='none'"></button>
	</div>

	<div class="modal fade" id="deleteConfirmModal" tabindex="-1">
    	<div class="modal-dialog modal-dialog-centered">
        	<div class="modal-content shadow-lg" style="border-radius: 15px;">
            	<div class="modal-header border-0">
                	<h5 class="modal-title fw-bold text-danger">Confirm Delete</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            	</div>
            	<div class="modal-body text-center p-4">
                	<i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                	<p class="fs-5">Are you sure you want to delete <br><strong id="delTName"></strong>?</p>
                	<p class="text-muted small">This action cannot be undone.</p>
            	</div>
            	<div class="modal-footer border-0 justify-content-center pb-4">
                	<button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal" style="border-radius: 8px;">Cancel</button>
                	<button type="button" id="finalDeleteBtn" class="btn btn-danger px-4" style="border-radius: 8px;">Delete Now</button>
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
	
	const contextPath = "${pageContext.request.contextPath}";
	
	let tournamentIdToDelete = null;

	// ૧. મોડલ ખોલવા અને ID સેટ કરવા માટે
	function confirmDelete(id, name) {
	    tournamentIdToDelete = id;
	    document.getElementById('delTName').innerText = name;
	    const myModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
	    myModal.show();
	}

	// ૨. ફાઈનલ ડિલીટ એક્શન
	document.getElementById('finalDeleteBtn').addEventListener('click', function() {
	    if (tournamentIdToDelete) {
	        // અહીં તમારો AJAX/Fetch કોલ આવશે
	        const deleteUrl = contextPath + "/admin/tournaments/records/delete/" + tournamentIdToDelete;
	        console.log("Deleting at:", deleteUrl);
	        fetch(deleteUrl, {
	            method: 'DELETE'
	        })
	        .then(response => {
	            // મોડલ બંધ કરો
	        	const modalElement = document.getElementById('deleteConfirmModal');
	            bootstrap.Modal.getInstance(modalElement).hide();
	            
	            if (response.ok) {
	                showDeleteSuccess(); // પેલો ૧૦ સેકન્ડ વાળો મેસેજ
	                setTimeout(() => { location.reload(); }, 1500); // ૧.૫ સેકન્ડ પછી પેજ રિફ્રેશ
	            } else {
	                alert("Error deleting! Status: " + response.status);
	            }
	        })
	        .catch(err => {
	            console.error("Fetch Error:", err);
	            alert("Network error occurred.");
	        });
	    }
	});

	// ૩. ૧૦ સેકન્ડ માટે સક્સેસ મેસેજ બતાવવા માટે
	function showDeleteSuccess() {
	    const alertBox = document.getElementById('deleteSuccessAlert');
	    alertBox.style.display = 'block';

	    // ૧૦ સેકન્ડ (10000ms) પછી હાઈડ કરો
	    setTimeout(() => {
	        alertBox.style.display = 'none';
	    }, 10000);
	}
	
	/*function viewStats(tId, tName) {
    	document.getElementById('modalTName').innerText = tName;
    
    	// AJAX call to fetch stats from backend
    	fetch(`${pageContext.request.contextPath}/admin/tournaments/stats/` + tId)
        	.then(response => response.json())
        	.then(data => {
            	document.getElementById('totalParticipants').innerText = data.total;
            	document.getElementById('goldMedals').innerText = data.gold;
            	document.getElementById('silverMedals').innerText = data.silver;
            	document.getElementById('bronzeMedals').innerText = data.bronze;
            
            	new bootstrap.Modal(document.getElementById('statsModal')).show();
        	})
        	.catch(err => alert("Error fetching stats: " + err));
	}*/
	
	function filterTournaments(filterType, button) {
	    // ૧. બટન સ્ટાઇલ અપડેટ
	    document.querySelectorAll('.filter-tab').forEach(tab => tab.classList.remove('active'));
	    button.classList.add('active');

	    const cards = document.querySelectorAll('.tournament-card');
	    const today = new Date();
	    today.setHours(0, 0, 0, 0); // સમયને ઝીરો કરી દો જેથી માત્ર તારીખ ચેક થાય

	    cards.forEach(card => {
	        // કાર્ડમાંથી તારીખ લો (ખાતરી કરો કે તારીખ yyyy-mm-dd ફોર્મેટમાં હોય)
	        const startStr = card.getAttribute('data-start'); // આપણે હમણાં HTML માં ઉમેરીશું
	        const endStr = card.getAttribute('data-end');     // આપણે હમણાં HTML માં ઉમેરીશું
	        
	        const startDate = new Date(startStr);
	        const endDate = new Date(endStr);
	        
	        let currentStatus = "";

	        // તારીખ મુજબ લોજિક
	        if (today < startDate) {
	            currentStatus = "upcoming";
	        } else if (today >= startDate && today <= endDate) {
	            currentStatus = "ongoing";
	        } else {
	            currentStatus = "completed";
	        }

	        // ફિલ્ટર મેચિંગ
	        if (filterType === 'all' || currentStatus === filterType) {
	            card.style.display = 'block';
	        } else {
	            card.style.display = 'none';
	        }
	    });
	}
	    
    </script>
</body>
</html>