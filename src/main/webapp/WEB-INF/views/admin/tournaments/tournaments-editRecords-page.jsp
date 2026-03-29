<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Tournament Records - ShadowStrikers</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    
    <style>
        :root {
        /* Synced with About Us Page */
        	--primary-color: #922b3e; /* Deep Maroon */
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	--text-gradient: linear-gradient(135deg, #7b2d39 0%, #b14555 100%);
        	--secondary-color: #ffffff;
        	--dark-color: #1a1a2e;
        	--sidebar-bg: #1a1a2e;
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

        /* Content */
        .content-body {padding: 40px 30px;}
        
        /* Tournament Selector */
        .selector-section {position: relative; background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 30px; z-index: 10;}     
        .selector-header {font-size: 1.3rem; font-weight: 800; color: var(--dark-color); margin-bottom: 20px; display: flex; align-items: center; gap: 10px;}      
        .selector-header i {color: var(--accent-color);}
            
        .tournament-select {width: 100%; padding: 15px 20px; border: 2px solid #e0e0e0; border-radius: 10px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: all 0.3s ease; background: white; appearance: auto !important; -webkit-appearance: auto !important;}    
        .tournament-select:focus {outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(146, 43, 62, 0.1);}
        
        /* Table Card */
        .table-card {background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);}       
        .table-header {display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; padding-bottom: 20px; border-bottom: 2px solid #f0f0f0;}    
        .table-title {font-size: 1.5rem; font-weight: 900; color: var(--dark-color); display: flex; align-items: center; gap: 10px;}   
        .table-title i {color: var(--accent-color);}
        
        .action-buttons {display: flex; gap: 10px;}   
        .save-btn, .export-btn {color: white; padding: 12px 25px; border: none; border-radius: 10px; font-weight: 700; cursor: pointer; transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 8px;}    
        .save-btn {background: var(--primary-gradient);}
        .export-btn {background: linear-gradient(135deg, #28a745 0%, #20c997 100%);}     
        .save-btn:hover, .export-btn:hover {transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.2);}
        
        /* Custom Table */
        .ranking-table {width: 100%; border-collapse: collapse;}    
        .ranking-table thead {position: sticky; top: 0; z-index: 10; background: white;}
        
        .ranking-table th {padding: 15px 10px; text-align: center; font-size: 0.8rem; font-weight: 800; color: #666; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 3px solid var(--primary-color); border-right: 1px solid #dee2e6;}     
        .ranking-table th:last-child {border-right: none;}     
        .ranking-table tbody tr {transition: all 0.3s ease; border-bottom: 1px solid #f0f0f0;}
        
        .ranking-table tbody tr:hover {background: #f8f9fa;}     
        .ranking-table td {padding: 15px 10px; vertical-align: middle; text-align: center; border-right: 1px solid #f0f0f0;}     
        .ranking-table td:last-child {border-right: none;}
        
        .student-name {font-weight: 700; color: var(--dark-color); font-size: 1rem; text-align: left;}
        .student-id {font-size: 0.8rem; color: #999; display: block; margin-top: 3px;}
        
        .technique-text {color: #666; font-size: 0.85rem;}
        
        /* Category Columns */
        .category-column {background: rgba(146, 43, 62, 0.02);}
        
        /* Rank Dropdown - Compact */
        .rank-dropdown {width: 100%; min-width: 140px; padding: 8px 10px; border: 2px solid #e0e0e0; border-radius: 6px; font-weight: 600; font-size: 0.85rem; cursor: pointer; transition: all 0.3s ease; background: white;}     
        .rank-dropdown:focus {outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(146, 43, 62, 0.1);}     
        .rank-dropdown.gold {border-color: var(--gold); background: rgba(255, 215, 0, 0.15); font-weight: 800; color: #b8860b;}      
        .rank-dropdown.silver {border-color: var(--silver); background: rgba(192, 192, 192, 0.15); font-weight: 800; color: #696969;}
        .rank-dropdown.bronze {border-color: var(--bronze); background: rgba(205, 127, 50, 0.15); font-weight: 800; color: #8b4513;}
        
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

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {left: calc(-1 * var(--sidebar-width));}
            .sidebar.active {left: 0;}
            .main-content {margin-left: 0;}
            .top-navbar {padding: 15px 20px;}
            .navbar-left h2 {font-size: 1.4rem;}
            .user-info {display: none;}
            .table-responsive {overflow-x: auto;}
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            <a href="/" class="sidebar-brand">
                <img src="${pageContext.request.contextPath}/logo/logo_2.png" alt="logo" style="height:30px;" />
                <span>ShadowStrikers</span>
            </a>
            <div class="admin-badge">Admin-Desk</div>
        </div>

        <div class="sidebar-menu">
            <a href="/admin/dashboard" class="menu-item">	
            	<i class="fas fa-th-large"></i>	<span>Dashboard</span>
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
                <h2>Assign Rankings</h2>
                <p class="text-muted mb-0">Declare tournament winners and rankings</p>
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
            
            <!-- Tournament Selector -->
            <div class="selector-section">
                <div class="selector-header">
                    <i class="fas fa-search"></i> Select Tournament to Assign Medals
                </div>
                <select class="tournament-select" id="tournamentSelect" onchange="loadParticipants()">
                    <option value="">-- Choose a tournament --</option>
                   <c:forEach items="${allTournaments}" var="t">
        				<option value="${t.id}">${t.name} - ${t.eventYear}</option>
    				</c:forEach>
                </select>
            </div>
 
            <!-- Rankings Table -->
            <div class="table-card">
                <div class="table-header">
                    <h3 class="table-title">
                        <i class="fas fa-medal"></i>
                        <span id="displayTournamentName">Tournament Records</span>
                    </h3>
                    <div class="action-buttons">
                        <button class="export-btn" onclick="exportToExcel()">
                            <i class="fas fa-file-excel"></i>
                            Export to Excel
                        </button>
                        <button class="save-btn" onclick="saveRankings()">
                            <i class="fas fa-save"></i>
                            Save Rankings
                        </button>
                    </div>
                </div>
 
                <div class="table-responsive">
                    <table class="ranking-table" id="rankingTable">
                        <thead>
                            <tr>
                                <th rowspan="2" style="width: 10%;">Student ID</th>
                                <th rowspan="2" style="width: 15%;">Student Name</th>
                                <th rowspan="2" style="width: 15%;">Technique</th>
                                <th colspan="3" class="category-column" style="background: rgba(146, 43, 62, 0.08);">Categories</th>
                            </tr>
                            <tr>
                                <th class="category-column" style="width: 18%;">Kata</th>
                                <th class="category-column" style="width: 18%;">Kumite</th>
                                <th class="category-column" style="width: 19%;">Championship of Champion</th>
                            </tr>
                        </thead>
                        <tbody id="participantTableBody">
    						<c:forEach items="${participants}" var="p">
        						<tr data-participant-id="${p.id}">
            						<td><strong>${p.studentId}</strong></td>
            						<td><div class="student-name">${p.fullName}</div></td>
            						<td>
                						<span class="technique-text">${p.technique}</span>
            						</td>
            						<td class="category-column">
                						<select class="rank-dropdown ${p.kataMedal == 1 ? 'gold' : (p.kataMedal == 2 ? 'silver' : (p.kataMedal == 3 ? 'bronze' : ''))}" 
                        						onchange="updateDropdownStyle(this)">
                    						<option value="0" ${p.kataMedal == 0 ? 'selected' : ''}>-</option>
                    						<option value="1" ${p.kataMedal == 1 ? 'selected' : ''}>🥇 Gold</option>
                    						<option value="2" ${p.kataMedal == 2 ? 'selected' : ''}>🥈 Silver</option>
                    						<option value="3" ${p.kataMedal == 3 ? 'selected' : ''}>🥉 Bronze</option>
                						</select>
            						</td>
            
            						<td class="category-column">
                						<select class="rank-dropdown ${p.kumiteMedal == 1 ? 'gold' : (p.kumiteMedal == 2 ? 'silver' : (p.kumiteMedal == 3 ? 'bronze' : ''))}" 
                        						onchange="updateDropdownStyle(this)">
                    						<option value="0" ${p.kumiteMedal == 0 ? 'selected' : ''}>-</option>
                    						<option value="1" ${p.kumiteMedal == 1 ? 'selected' : ''}>🥇 Gold</option>
                    						<option value="2" ${p.kumiteMedal == 2 ? 'selected' : ''}>🥈 Silver</option>
                    						<option value="3" ${p.kumiteMedal == 3 ? 'selected' : ''}>🥉 Bronze</option>
                						</select>
            						</td>
            
            						<td class="category-column text-center">
                						<input type="checkbox" class="form-check-input" style="transform: scale(1.5);" 
                       						${p.championship ? 'checked' : ''} onchange="this.value = this.checked">
            						</td>
        						</tr>
    						</c:forEach>
						</tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-between align-items-center mt-4 px-3">
    				<div class="text-muted small">
        				Showing <span id="showingCount">0</span> of <span id="totalCount">0</span> records
    				</div>
    				<nav>
        				<ul class="pagination mb-0">
            				<li class="page-item">
                			<button class="page-link" id="prevBtn" onclick="changePage(-1)" style="color: var(--primary-color);">
                    			<i class="fas fa-chevron-left"></i>
                			</button>
            				</li>
            				<li class="page-item disabled">
                				<span class="page-link" id="pageNumber" style="background: var(--primary-color); color: white;">1</span>
            				</li>
            				<li class="page-item">
                			<button class="page-link" id="nextBtn" onclick="changePage(1)" style="color: var(--primary-color);">
                    			<i class="fas fa-chevron-right"></i>
                			</button>
            				</li>
        				</ul>
    				</nav>
				</div>         
            </div>
        </div>
    </div>
    
    	<a href="${pageContext.request.contextPath}/admin/tournaments" class="floating-back-btn shadow" title="Back to tournaments">
    		<i class="fas fa-arrow-left"></i>
    		<span>BACK</span>
		</a>
		
		<div class="toast-container position-fixed bottom-0 end-0 p-3">
  			<div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
    			<div class="toast-header" style="background: var(--primary-color); color: white;">
      				<strong class="me-auto">ShadowStrikers</strong>
      				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
    			</div>
    			<div class="toast-body" id="toastMessage"></div>
  			</div>
		</div>
 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    
 // Pagination Variables
    let currentPage = 1;
    const recordsPerPage = 10; // એક પેજ પર કેટલા રેકોર્ડ બતાવવા છે
    let allRows = [];

    document.addEventListener("DOMContentLoaded", function() {
        // ટેબલના બધા જ રો (rows) મેળવો
        allRows = Array.from(document.querySelectorAll('#participantTableBody tr'));
        
        // જો કોઈ ટૂર્નામેન્ટ સિલેક્ટ હોય, તો જ પેજીનેશન ચલાવો
        if (allRows.length > 0) {
            updateTableDisplay();
        } else {
            document.getElementById('showingCount').innerText = "0";
            document.getElementById('totalCount').innerText = "0";
        }
        
        // ટૂર્નામેન્ટનું નામ હેડરમાં સેટ કરવા માટે
        const select = document.getElementById('tournamentSelect');
        if(select.value !== "") {
            document.getElementById('displayTournamentName').innerText = select.options[select.selectedIndex].text;
        }
    });

    function updateTableDisplay() {
        const totalRecords = allRows.length;
        const totalPages = Math.ceil(totalRecords / recordsPerPage);

        // કયા રેકોર્ડ બતાવવા તેનું કેલ્ક્યુલેશન
        const startIndex = (currentPage - 1) * recordsPerPage;
        const endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

        // બધા રો ને છુપાવી દો અને ફક્ત આ પેજના રો બતાવો
        allRows.forEach((row, index) => {
            if (index >= startIndex && index < endIndex) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });

        // કાઉન્ટ અપડેટ કરો (Showing X of Y)
        document.getElementById('showingCount').innerText = (totalRecords === 0) ? 0 : (startIndex + 1) + "-" + endIndex;
        document.getElementById('totalCount').innerText = totalRecords;
        
        // પેજ નંબર અપડેટ કરો
        document.getElementById('pageNumber').innerText = currentPage;

        // બટન ઇનેબલ/ડિસેબલ કરો
        document.getElementById('prevBtn').disabled = (currentPage === 1);
        document.getElementById('nextBtn').disabled = (currentPage === totalPages || totalPages === 0);
        
        // બટન વિઝ્યુઅલ ફીડબેક (ઓપ્શનલ)
        document.getElementById('prevBtn').style.opacity = (currentPage === 1) ? "0.5" : "1";
        document.getElementById('nextBtn').style.opacity = (currentPage === totalPages || totalPages === 0) ? "0.5" : "1";
    }

    function changePage(direction) {
        const totalPages = Math.ceil(allRows.length / recordsPerPage);
        const nextStep = currentPage + direction;

        if (nextStep >= 1 && nextStep <= totalPages) {
            currentPage = nextStep;
            updateTableDisplay();
            // પેજ ઉપર સ્ક્રોલ કરવા માટે
            window.scrollTo({ top: document.querySelector('.table-card').offsetTop - 100, behavior: 'smooth' });
        }
    }
    
    	// ટૂર્નામેન્ટ બદલાતા હેડર અને ડેટા અપડેટ કરવા માટે
    	function loadParticipants() {
    		const select = document.getElementById('tournamentSelect');
    		const tId = select.value;
    
    		if (tId !== "") {
        	// આ લાઇન પેજને નવેસરથી લોડ કરશે અને પ્લેયર્સનો ડેટા લાવશે
        	window.location.href = "${pageContext.request.contextPath}/admin/tournaments/assignRank?tournamentId=" + tId;
    		}	
		}

    	// ડ્રોપડાઉનનો કલર (Gold/Silver/Bronze) બદલવા માટે
    	function updateDropdownStyle(selectElement) {
        	const rank = selectElement.value;
        
        	// જૂના ક્લાસ કાઢી નાખો
        	selectElement.classList.remove('gold', 'silver', 'bronze');
        
        	// સિલેક્શન મુજબ નવો ક્લાસ ઉમેરો
        	if (rank == 1) {
            	selectElement.classList.add('gold');
        	} else if (rank == 2) {
            	selectElement.classList.add('silver');
        	} else if (rank == 3) {
            	selectElement.classList.add('bronze');
        	}
    	}
    	
    	function showToast(message) {
    	    document.getElementById('toastMessage').innerText = message;
    	    const toast = new bootstrap.Toast(document.getElementById('liveToast'));
    	    toast.show();
    	}

    	// બધા રેન્કિંગ ડેટાબેઝમાં સેવ કરવા માટે (Real Logic)
    	function saveRankings() {
    		const rows = document.querySelectorAll('#participantTableBody tr');
    		const rankings = [];

    		rows.forEach(row => {
        		const pId = row.getAttribute('data-participant-id');
        		const selects = row.querySelectorAll('select');
        		const checkbox = row.querySelector('input[type="checkbox"]');
        
        		if (pId) {
            		rankings.push({
            			participantId: parseInt(pId),
            			kataMedal: parseInt(selects[0].value) || 0,
                        kumiteMedal: parseInt(selects[1].value) || 0,
                        championship: checkbox.checked
            		});
        		}
    		});	
    		
    		if (rankings.length === 0) {
    	        showToast("⚠️ No participants found to update.");
    	        return;
    	    }

        	// Backend Controller ને ડેટા મોકલો
        	fetch(`${pageContext.request.contextPath}/admin/tournaments/editRecords/saveRankings`, {
            	method: 'POST',
            	headers: { 'Content-Type': 'application/json' },
            	body: JSON.stringify(rankings)
        	})
        	.then(response => response.text())
        	.then(res => {
            	if (res === "success") {
            		showToast("🏆 Rankings updated!")
            	} else {
            		showToast("❌ Error: " + res);
            	}
        	})
        	.catch(err => {
            	console.error("Error:", err);
            	showToast("⚠️ Failed to connect to server.");
        	});
    	}

    	// એક્સેલ એક્સપોર્ટ (ડાયનેમિક ફાઇલ નામ સાથે)
    	function exportToExcel() {
        	const table = document.getElementById('rankingTable');
        	const tournamentName = document.getElementById('displayTournamentName').innerText;
        	
        	try {
        		const wb = XLSX.utils.table_to_book(table);      
        		const date = new Date().toISOString().split('T')[0];
        		const filename = `${tournamentName}_Rankings_${date}.xlsx`.replace(/\s+/g, '_');
        
        		XLSX.writeFile(wb, filename);
        		showToast("📊 Excel file downloaded: " + filename);
        	} catch (e) {
                showToast("❌ Failed to export Excel.");
            }
    	}

    	// પેજ લોડ થાય ત્યારે ચેક કરો કે જો કોઈ ટૂર્નામેન્ટ પહેલેથી સિલેક્ટ હોય તો નામ સેટ થઈ જાય
    	document.addEventListener("DOMContentLoaded", function() {
        	if(document.getElementById('tournamentSelect').value !== "") {
            	loadParticipants();
        	}
    	});
</script>
</body>
</html>