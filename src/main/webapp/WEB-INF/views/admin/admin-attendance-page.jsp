<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance - Admin Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
 
    
    <style>
        :root {
        /* Synced with About Us Page */
        	--primary-color: #922b3e; /* Deep Maroon */
        	--text-gradient: linear-gradient(135deg, #7b2d39 0%, #b14555 100%);
        	--secondary-color: #ffffff;
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
        
        /* ATTENDANCE */
        .attendance-container {padding: 30px;}   
        .attendance-card {position: relative; background: white; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 50px; padding-bottom: 30px; overflow: hidden0; border-left: none !important;}
        
        /* Filter Section */
        .filter-section { 
        	padding: 20px 25px;
        	border-bottom: 1px solid #edf2f7;
        	justify-content: space-between;
        	align-items: center;
        	display: flex; 
        	gap: 10px; 
        	flex-wrap: wrap; 
        	background: #fff; 
        }
        
        .filter-input {border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 12px; font-size: 0.9rem; color: #4a5568; outline: none;}    
        .filter-input:focus {border-color: var(--primary-color); outline: none; box-shadow: 0 0 0 2px rgba(146, 43, 62, 0.1);}
        .search-box {flex-grow: 0; min-width: 250px; position: relative;}  
        .search-box i {position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: #cbd5e0;}

        /* Attendance List Items */
        .attendance-list-item { 
        	position: relative;
        	display: flex; 
        	align-items: center; 
        	padding: 12px 25px;
        	padding-left: 25px !important;
        	background: #fff; 
        	border-bottom: 1px solid #f1f4f8; 
        	border-left: none !important;
        	transition: all 0.2s ease; 
        	text-decoration: none !important; 
        	color: inherit; 
        }
        
        .attendance-list-item::before {content: ''; position: absolute; left: 0; top: 0; height: 100%; width: 6px;}
		.attendance-list-item.is-present::before {background-color: #28a745;}
		.attendance-list-item.is-absent::before {background-color: #dc3545;}
		
        .attendance-list-item:hover {background-color: #f8fafc; transform: translateX(5px);}
        .attendance-list-item.is-present {background-color: #ffffff !important; border-left: none !important;}
		.attendance-list-item.is-absent {background-color: #ffffff !important; border-left: none !important;}
        .student-photo {width: 45px; height: 45px; border-radius: 50%; object-fit: cover; margin-right: 15px; background: #e2e8f0;} 
        .student-details {flex: 1;}  
        .student-name {font-size: 0.95rem; font-weight: 700; color: #2d3748; margin-bottom: 3px; display: block; letter-spacing: -0.2px;}
        .fw-500 {font-weight: 500;}
        
		/* Modal Header ની થીમ બદલવા */
		.modal-content {border-radius: 15px; overflow: hidden; border: none;}
		.modal-header {background: #922b3e; color: white; border: none;}
		.btn-close {filter: invert(1);}

		/* કેલેન્ડરની સાઈઝ નાની કરવા */
		#calendar {max-width: 500px; margin: 0 auto; font-size: 0.85rem; padding: 10px;}

		/* FullCalendar ની ડિઝાઈન કસ્ટમાઇઝ કરવા */
		.fc-header-toolbar {margin-bottom: 10px !important;}
		.fc-toolbar-title {font-size: 1.2rem !important; font-weight: 800; color: #922b3e;}

		/* તારીખના ખાના (Cells) સુધારવા */
		.fc-daygrid-day-frame {min-height: 50px !important;}
		.fc-daygrid-day-number {font-weight: 600; color: #444; padding: 5px !important;}

		.fc-col-header-cell-cushion, .fc-daygrid-day-number {text-decoration: none !important; color: var(--primary-color) !important;}

		/* Present/Absent ના કલર */
		.fc-bg-event.present-event {background-color: #d4edda !important; opacity: 1; border-left: 4px solid #28a745;}
		.fc-bg-event.absent-event {background-color: #f8d7da !important; opacity: 1; border-left: 4px solid #dc3545;}

		/* Non-working days (રજાના દિવસો) */
		.non-working-day {background-color: #f8f9fa !important; opacity: 0.5;}

		/* નેવિગેશન બટન્સ */
		.fc-button-primary {background-color: #922b3e !important; border: none !important; box-shadow: none !important;}
		.fc-day-today {background: rgba(146, 43, 62, 0.1) !important;}
		
		.btn-outline-primary {color: var(--primary-color) !important; border-color: var(--primary-color) !important; background-color: transparent !important; border-width: 1.5px; border-radius: 8px !important; transition: all 0.2s ease-in-out;}
		.btn-outline-primary:hover {background-color: var(--primary-color) !important; color: #ffffff !important; box-shadow: 0 4px 8px rgba(146, 43, 62, 0.2); transform: translateY(-1px);}
		.btn-outline-primary:active {transform: scale(0.95);}
		
		.attendance-list-item .fa-calendar-alt, .attendance-list-item .fa-calendar-day {color: inherit;}
        
        /* Progress Bar (Visualizing from Screenshot) */
        .progress-container {display: flex; width: 150px; height: 8px; background: #edf2f7; border-radius: 4px; overflow: hidden;}  
        .progress-segment {height: 100%;}
        .progress-low { background: var(--danger-color) !important; }
		.progress-mid { background: var(--warning-color) !important; }
		.progress-high { background: var(--success-color) !important; }
        
        /* Attendance Status Text */
        .status-text {display: flex; align-items: center; gap: 10px; color: #718096; font-size: 0.9rem; margin: 0 !important; white-space: nowrap;}  
        .status-text i {font-size: 1.1rem; color: #cbd5e0;}     
        .chevron-icon {color: #cbd5e0;}
        
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
            <a href="/admin/attendance" class="menu-item active">
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
                <h2>Attendance</h2>
                <p class="text-muted small mb-0">Monitor daily student presence and session logs.</p>
            </div>
            <div class="navbar-right">
                <div class="user-profile">
                    <div class="user-avatar">
                        <img src="${pageContext.request.contextPath}/admin-photo/image-1.jpg" alt="Admin Avatar">
                    </div>
                    <div class="user-info"><h6>Admin</h6></div>
                </div>
            </div>
        </div>

        <div class="attendance-container">
            <div class="attendance-card">
                
                <div class="filter-header d-flex justify-content-between align-items-center p-3" style="background: #fff; border-bottom: 1px solid #edf2f7;">
    				<h5 class="mb-0 fw-bold" style="color: #2d3748;">Attendance Registry</h5>

    				<div class="d-flex align-items-center">
        				<div class="search-box" style="position: relative;">
            				<input type="text" id="attendanceSearch" class="filter-input" placeholder="Search student or ID..." 
                   				style="width: 280px; border: 1px solid #e2e8f0; border-radius: 8px; padding: 7px 15px; padding-right: 35px; font-size: 0.9rem;">
            				<i class="fas fa-search" style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); color: #cbd5e0;"></i>
        				</div>
    				</div>
				</div>

                <div class="attendance-list">
                    
                    <c:forEach var="student" items="${studentList}">
    					<div class="attendance-list-item d-flex align-items-center justify-content-between 
             				${not empty student.lastAttendance ? (student.lastAttendance.status == 'Present' ? 'is-present' : 'is-absent') : ''}">
        
        					<div class="d-flex align-items-center" style="flex: 1.5; min-width: 250px;">
            					<img src="${student.photosImagePath}" class="student-photo" onerror="this.src='${pageContext.request.contextPath}/user-photos/default-avatar.jpg'; this.onerror=null;">
            					<div class="student-details">
            						<small class="text-muted fw-bold">#${student.id}</small>
                					<a href="/admin/attendance/detail?id=${student.id}" class="student-name text-decoration-none">${student.firstName} ${student.lastName}</a>
                					<div class="d-flex align-items-center gap-2">
                    					<div class="progress-container" style="width: 100px; height: 6px;">
                        					<div class="progress-segment ${student.attendancePercentage < 50 ? 'progress-low' : (student.attendancePercentage < 75 ? 'progress-mid' : 'progress-high')}" 
                             					 style="width: ${student.attendancePercentage}%;">
                        					</div>            				
                    					</div>
                    					<small class="text-muted" style="font-size: 0.75rem;">${student.attendancePercentage}%</small>
                					</div>
            					</div>
        					</div>

        					<div class="status-text d-flex align-items-center gap-2" style="flex: 1;">
            					<i class="fas fa-layer-group text-muted"></i>
            					<span class="small fw-500">
                					${not empty student.batch ? student.batch.batchName : 'No Batch Assigned'}
            					</span>
        					</div>

        					<div class="status-text d-flex align-items-center gap-2" style="flex: 1.2;">
            					<i class="fas fa-clock text-muted"></i>
            					<span class="small">
                					<c:choose>
                    					<c:when test="${not empty student.lastAttendance}">
                        					${student.lastAttendance.date}
                        					<span class="badge ${student.lastAttendance.status == 'Present' ? 'bg-success' : 'bg-danger'} ms-1" style="font-size: 0.65rem; padding: 3px 8px;">
                            					${student.lastAttendance.status}
                        					</span>
                    					</c:when>
                    					<c:otherwise>No records found</c:otherwise>
                					</c:choose>
            					</span>
        					</div>

        					<div class="d-flex align-items-center gap-3">
            					<button class="btn btn-sm btn-outline-primary rounded-3" 
                    					onclick="openAttendanceCalendar('${student.id}', '${student.firstName} ${student.lastName}', '${student.batch.trainingDays}', event)">
                					<i class="fas fa-calendar-alt"></i>
            					</button>
            					<div class="chevron-icon">
                					<i class="fas fa-chevron-right"></i>
            					</div>
        					</div>
        
    					</div>
					</c:forEach>
                    
                    <c:if test="${empty studentList}">
                        <div class="p-5 text-center text-muted">No attendance records found.</div>
                    </c:if>                   
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

	<div class="modal fade" id="calendarModal" tabindex="-1" aria-labelledby="calendarModalLabel" aria-hidden="true">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
            	<div class="modal-header">
                	<h5 class="modal-title" id="calendarStudentName">Attendance Calendar</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            	</div>
            	<div class="modal-body">
                	<div id="calendar"></div> 
                </div>
        	</div>
    	</div>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    // --- Global Variables ---
    const contextPath = "${pageContext.request.contextPath}";
    let calendar;
    
    // Pagination Variables
    const recordsPerPage = 10; 
    let currentPage = 1;
    let filteredItems = [];

    // --- 1. Initialization ---
    document.addEventListener('DOMContentLoaded', function() {
    	const searchInput = document.getElementById('attendanceSearch');
    
    	if(searchInput) {
        	searchInput.addEventListener('input', function() {
            	// સર્ચ કરતી વખતે હંમેશા પહેલા પેજ પર આવી જવું
            	currentPage = 1; 
            	updateDashboardState();
        	});
    	}
    
    	updateDashboardState();
	});

    // --- 2. Core Logic: Update List, Counts & Pagination ---
    function updateDashboardState() {
    	const allItems = Array.from(document.querySelectorAll('.attendance-list-item'));
    	const searchInput = document.getElementById('attendanceSearch');
    	const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : "";

    	// ફિલ્ટર લોજિક: નામ અને ID ચેક કરશે
    	filteredItems = allItems.filter(item => {
        	const studentName = item.querySelector('.student-name').innerText.toLowerCase();
        	const studentId = item.querySelector('.fw-bold').innerText.toLowerCase();
        	return studentName.includes(searchTerm) || studentId.includes(searchTerm);
    	});

    	const totalRecords = filteredItems.length;
    	const totalPages = Math.ceil(totalRecords / recordsPerPage) || 1;

    	// બધાને છુપાવો
    	allItems.forEach(item => {
        	item.classList.remove('d-flex');
        	item.style.display = 'none';
    	});
    
    	// ફિલ્ટર થયેલા અને પેજ મુજબના આઈટમ બતાવો
    	const startIndex = (currentPage - 1) * recordsPerPage;
    	const endIndex = startIndex + recordsPerPage;
    
    	filteredItems.slice(startIndex, endIndex).forEach(item => {
        	item.classList.add('d-flex');
        	item.style.display = 'flex';
    	});

    	// Counts અપડેટ કરો
    	const showingCountDisplay = document.getElementById('showingCount');
    	const totalCountDisplay = document.getElementById('totalCount');
    
    	if(totalCountDisplay) totalCountDisplay.innerText = totalRecords;
    	if(showingCountDisplay) {
        	if (totalRecords > 0) {
            	const currentShowing = filteredItems.slice(startIndex, endIndex).length;
            	showingCountDisplay.innerText = (startIndex + 1) + "-" + (startIndex + currentShowing);
        	} else {
            	showingCountDisplay.innerText = "0";
        	}
    	}

    	// પેજીનેશન બટન સ્ટેટસ
    	const prevBtn = document.getElementById('prevBtn');
    	const nextBtn = document.getElementById('nextBtn');
    	if(prevBtn) prevBtn.disabled = (currentPage === 1);
    	if(nextBtn) nextBtn.disabled = (currentPage === totalPages || totalRecords === 0);
	}

    // --- 3. Pagination Controls ---
    function changePage(direction) {
        const totalPages = Math.ceil(filteredItems.length / recordsPerPage);
        const newPage = currentPage + direction;

        if (newPage >= 1 && newPage <= totalPages) {
            currentPage = newPage;
            updateDashboardState();
            window.scrollTo(0, 0); 
        }
    }

    // --- 4. Calendar Logic ---
    function openAttendanceCalendar(studentId, studentName, trainingDaysStr, event) {
        if (event) { event.preventDefault(); event.stopPropagation(); }

        const titleEl = document.getElementById('calendarStudentName');
        if(titleEl) titleEl.innerText = studentName + "'s Attendance";

        const modalElement = document.getElementById('calendarModal');
        const modal = new bootstrap.Modal(modalElement, {
            focus: true, 
            keyboard: true
        });
        modal.show();

        const calendarEl = document.getElementById('calendar');
        if (calendar) { calendar.destroy(); }

        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            height: 'auto',
            headerToolbar: { left: 'prev', center: 'title', right: 'next' },
            dayCellDidMount: function(info) {
                if (!trainingDaysStr) return;
                let dayName = new Intl.DateTimeFormat('en-US', { weekday: 'long' }).format(info.date);
                if (!trainingDaysStr.toLowerCase().includes(dayName.toLowerCase())) {
                    info.el.classList.add('non-working-day');
                }
            },
            events: function(info, successCallback) {
                fetch(contextPath + '/admin/attendance/history/' + studentId)
                    .then(res => res.json())
                    .then(data => {
                        const events = data.map(r => ({
                            start: r.date,
                            display: 'background',
                            className: r.status === 'Present' ? 'present-event' : 'absent-event'
                        }));
                        successCallback(events);
                    })
                    .catch(err => console.error("Error:", err));
            },
            dateClick: function(info) {
                Swal.fire({
                    title: 'Mark Attendance',
                    text: "Mark attendance for " + info.dateStr + "?",
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#922b3e',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Present',
                    cancelButtonText: 'Absent',
                    reverseButtons: true
                }).then((result) => {
                    if (result.dismiss === Swal.DismissReason.backdrop || result.dismiss === Swal.DismissReason.esc) return;
                    let status = result.isConfirmed ? "Present" : "Absent";
                    saveManualAttendance(studentId, info.dateStr, status);
                });
            }
        });

        modalElement.addEventListener('shown.bs.modal', () => {
            calendar.render();
            calendar.updateSize();
        }, { once: true });
    }

    function saveManualAttendance(studentId, date, status) {
        fetch(contextPath + '/admin/attendance/manual-save', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `studentId=` + studentId + `&date=` + date + `&status=` + status
        }).then(res => {
            if(res.ok) {
                calendar.refetchEvents();
                Swal.fire({
                    toast: true, position: 'top-end', icon: 'success',
                    title: status + ' Marked!', showConfirmButton: false, timer: 1500
                });
            } else {
                Swal.fire('Error', 'Save Failed', 'error');
            }
        });
    }
</script>
</body>
</html>