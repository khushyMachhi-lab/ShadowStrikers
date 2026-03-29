<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Records - Admin Dashboard</title>
    
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

        /* Reuse Sidebar and Layout Styles from Dashboard */
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
        
        .dashboard-content {padding: 40px 30px;}
        
        /* Tournament Card Styles */
        .t-card {
    		background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
            height: 100%;
            border: none;
		}

		.t-card:hover {transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;}
	
		.stat-icon {transition: transform 0.3s ease;}
		.t-card:hover .stat-icon {transform: scale(1.1);}
        
        /* Table and Profile styles */
        .card-container { 
        	background: white; 
        	border-radius: 15px; 
        	padding: 30px; 
        	box-shadow: 0 5px 20px rgba(0,0,0,0.08); 
        }
        
        .student-avatar {width: 45px; height: 45px; border-radius: 50%; object-fit: cover; border: 2px solid #eee;} 
         
        .custom-table {width: 100%; border-collapse: separate; border-spacing: 0 10px;}       
        .custom-table tbody tr {background: #f8f9fa; transition: 0.3s;}    
        .custom-table tbody tr:hover {background: white; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transform: scale(1.01);}    
        .custom-table td {padding: 15px; vertical-align: middle;}
        
        .btn-action {padding: 8px 12px; border-radius: 8px; text-decoration: none; font-size: 0.9rem;}
        
        .table thead th {background-color: #f8f9fa; color: #6c757d; font-weight: 600; font-size: 0.85rem; text-transform: uppercase; padding: 15px 10px; border: none;}
		.table tbody td {padding: 15px 10px; border-bottom: 1px solid #f0f0f0; vertical-align: middle;}

		.bg-soft-primary {background-color: rgba(13, 110, 253, 0.1); color: #0d6efd;}

        /* Search Bar */
        .search-box {position: relative; margin-bottom: 25px;}   
        .search-box input {padding: 12px 20px 12px 45px; border-radius: 10px; border: 1px solid #ddd; width: 100%; max-width: 400px;}
        
        .search-box i {position: absolute; left: 15px; top: 15px; color: #999;}
		.extra-small {font-size: 0.65rem; letter-spacing: 0.5px;}
		
		.dropdown-menu {min-width: 200px; font-size: 0.9rem;}
		.dropdown-item:hover {background-color: #f8f9fa; color: var(--primary-color);}
		.dropdown-header {color: #999; letter-spacing: 0.5px;}

		/* ત્રણ ટપકાં વાળા બટન માટે */
		.btn-light:hover {background-color: #eee;}

        /* Responsive */
        @media (max-width: 992px) {
        	.sidebar { left: -280px; }
        	.main-content { margin-left: 0; }
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
            	<i class="fas fa-th-large"></i>	<span>Dashboard</span>
            </a>
            <a href="/admin/enquiries" class="menu-item">
            	<i class="fas fa-question-circle"></i> <span>Enquiries</span>
            </a>
            <a href="/admin/admissions" class="menu-item">
            	<i class="fas fa-user-plus"></i> <span>Admissions</span>
            </a>
            <a href="/admin/studentsRecords" class="menu-item active">
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
            
            <div class="menu-divider" style="height: 1px; background: rgba(255,255,255,0.1); margin: 15px 25px;"></div>
            
            <a href="/logout" class="menu-item logout">
            	<i class="fas fa-sign-out-alt"></i> <span>Logout</span>
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-navbar">
            <div class="navbar-left">
            	<h2>Student Records</h2>
            </div>
            <div class="navbar-right">
                <div class="user-profile">
                    <div class="user-avatar">
                    	<img src="${pageContext.request.contextPath}/admin-photo/image-1.jpg" alt="Admin">
                    </div>
                    <div class="user-info"><h6>Admin</h6></div>
                </div>
            </div>
        </div>

 <div class="dashboard-content">
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card t-card text-center border-0 shadow-sm">
                <div class="t-body py-4">
                    <div class="stat-icon mx-auto mb-3" style="width: 60px; height: 60px; background: rgba(245, 158, 11, 0.1); color: #f59e0b; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h5 class="fw-bold">Batch / Time</h5>
                    <p class="text-muted small">Manage student shifts, batch timings, and schedules.</p>
                    <a href="/admin/studentsRecords/batchTime" class="btn btn-sm px-4 rounded-pill" style="background: #f59e0b; color: white; border: none; font-weight: 600;">
                        Assign Timing
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card t-card text-center border-0 shadow-sm">
                <div class="t-body py-4">
                    <div class="stat-icon mx-auto mb-3" style="width: 60px; height: 60px; background: rgba(13, 110, 253, 0.1); color: #0d6efd; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                        <i class="fas fa-file-contract"></i>
                    </div>
                    <h5 class="fw-bold">Documents</h5>
                    <p class="text-muted small">Verify ID proofs, medical certificates, and forms.</p>
                    <a href="/admin/studentsRecords/documents" class="btn btn-sm px-4 rounded-pill" style="background: #0d6efd; color: white; border: none; font-weight: 600;">
                        View Documents
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card t-card text-center border-0 shadow-sm">
                <div class="t-body py-4">
                    <div class="stat-icon mx-auto mb-3" style="width: 60px; height: 60px; background: rgba(25, 135, 84, 0.1); color: #198754; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h5 class="fw-bold">Progress</h5>
                    <p class="text-muted small">Track belt ranking, performance, and grading history.</p>
                    <a href="/admin/studentsRecords/progress" class="btn btn-sm px-4 rounded-pill" style="background: #198754; color: white; border: none; font-weight: 600;">
                        Track Progress
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="card-container shadow-sm p-4 mt-4" style="background: white; border-radius: 15px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold text-dark mb-0">Student Directory</h4>
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="studentSearch" placeholder="Search students..." class="form-control ps-5 rounded-pill">
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th class="ps-4">ID</th>
                    <th>Student</th>
                    <th>Course</th>
                    <th>Batch</th>
                    <th>Duration</th>
                    <th>Status</th>
                    <th class="text-end pe-4">Action</th>
                </tr>
            </thead>
            <tbody id="studentTableBody">
                <c:forEach var="user" items="${admissionList}">
                    <tr>
                        <td class="ps-4 fw-bold">#${user.id}</td>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/user-photos/${user.photo}" 
                         			 class="rounded-circle me-3" 
                         			 style="width: 45px; height: 45px; object-fit: cover; border: 2px solid #f0f0f0;"
                         			 onerror="this.src='${pageContext.request.contextPath}/user-photos/default-avatar.jpg'; this.onerror=null;">
                    		<div>
                                <div>
                                    <div class="fw-bold text-dark">${user.firstName} ${user.lastName}</div>
                                </div>
                            </div>
                            </div>
                        </td>
                        <td>
                        	<span class="badge bg-soft-primary text-primary">
                    			  ${user.admissions != null ? user.admissions.courseName : 'No Course'}
                			</span>
                		</td>                        
                		<td>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <button class="btn btn-link text-muted p-0" type="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu shadow border-0">
                                    <li class="dropdown-header small">Assign New Batch</li>
                                    <c:forEach var="b" items="${batches}">
                                        <li><a class="dropdown-item small" href="/admin/studentsRecords/assignBatch/${user.id}/${b.id}">${b.batchName} (${b.startTime})</a></li>
                                    </c:forEach>
                                </ul>
                                <span class="small fw-semibold text-dark">${user.batch != null ? user.batch.batchName : 'Not Set'}</span>
                            </div>
                        </td>

                        <td>
                            <button class="btn btn-sm btn-outline-secondary rounded-pill px-3" onclick="showDuration('${user.firstName}', '${user.admissions.admissionDate}', '${user.admissions.expiryDate}')">
                                View
                            </button>
                        </td>
                        
                        <td>
                        	<span class="badge ${user.admissions.status == 'Active' ? 'bg-success' : 'bg-secondary'} rounded-pill">
                        		  ${user.admissions != null ? user.admissions.status : 'N/A'}
                            </span>
                        </td>
                        
                        <td class="text-end pe-4">
                            <a href="/admin/studentsRecords/profile/${user.id}" class="btn btn-sm btn-light border rounded-pill">View Info</a>
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

<div class="modal fade" id="durationModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header text-white border-0" style="background: var(--primary-gradient);">
                <h6 class="modal-title fw-bold"><i class="fas fa-history me-2"></i>Course Duration</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 text-center">
                <p class="mb-1 text-muted small text-uppercase fw-bold">Student Name</p>
                <h5 id="modalStudentName" class="mb-4 fw-bold text-dark">-</h5>
                
                <div class="row g-0 bg-light rounded-3 p-3">
                    <div class="col-6 border-end">
                        <p class="mb-0 text-muted extra-small">START DATE</p>
                        <p id="modalStartDate" class="mb-0 fw-bold text-success">-</p>
                    </div>
                    <div class="col-6">
                        <p class="mb-0 text-muted extra-small">END DATE</p>
                        <p id="modalEndDate" class="mb-0 fw-bold text-danger">-</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // --- પેજીનેશન સેટિંગ્સ ---
    const recordsPerPage = 10; // એક પેજ પર કેટલા સ્ટુડન્ટ બતાવવા છે તે સંખ્યા
    let currentPage = 1;
    let filteredRows = [];

    // પેજ લોડ થાય ત્યારે બધી રો (rows) ને એક એરેમાં સ્ટોર કરી લો
    const allRows = Array.from(document.querySelectorAll('#studentTableBody tr'));

    function updateTable() {
        const searchValue = document.getElementById('studentSearch').value.toLowerCase().trim();
        
        // ૧. સર્ચ ફિલ્ટર લાગુ કરો (નામ, ID અથવા કોર્સ કંઈ પણ સર્ચ કરી શકાશે)
        filteredRows = allRows.filter(row => {
            return row.innerText.toLowerCase().includes(searchValue);
        });

        const totalRecords = filteredRows.length;
        const totalPages = Math.ceil(totalRecords / recordsPerPage) || 1;

        // જો સર્ચ કરવાથી પેજ ઓછા થઈ જાય, તો કરંટ પેજ એડજસ્ટ કરો
        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        // ૨. પહેલા બધી રો છુપાવી દો
        allRows.forEach(row => row.style.display = 'none');

        // ૩. કેલ્ક્યુલેશન: કઈ રો બતાવવી
        const start = (currentPage - 1) * recordsPerPage;
        const end = start + recordsPerPage;
        
        // ફિલ્ટર કરેલી રો માંથી અત્યારના પેજની રો અલગ તારવો
        const rowsToShow = filteredRows.slice(start, end);
        rowsToShow.forEach(row => row.style.display = '');

        // ૪. UI અપડેટ (લેબલ્સ અને બટન્સ)
        document.getElementById('totalCount').innerText = totalRecords;
        document.getElementById('showingCount').innerText = rowsToShow.length;
        document.getElementById('pageNumber').innerText = currentPage;

        // બટન્સને એનેબલ કે ડિસેબલ કરો
        const prevBtn = document.getElementById('prevBtn').parentElement;
        const nextBtn = document.getElementById('nextBtn').parentElement;

        if (currentPage === 1) {
            prevBtn.classList.add('disabled');
        } else {
            prevBtn.classList.remove('disabled');
        }

        if (currentPage === totalPages || totalRecords === 0) {
            nextBtn.classList.add('disabled');
        } else {
            nextBtn.classList.remove('disabled');
        }
    }

    // પેજ બદલવા માટેનું ફંક્શન (Next/Prev બટન માટે)
    function changePage(direction) {
        currentPage += direction;
        updateTable();
        // ટેબલ પર પાછા જવા માટે સ્ક્રોલ (જો જરૂર હોય તો)
        // window.scrollTo({ top: document.getElementById('studentTableBody').offsetTop - 100, behavior: 'smooth' });
    }

    // સર્ચ બોક્સમાં ટાઈપ કરતી વખતે ઇવેન્ટ
    document.getElementById('studentSearch').addEventListener('keyup', function() {
        currentPage = 1; // નવી સર્ચ વખતે હંમેશા પહેલા પેજ પર જવું
        updateTable();
    });

    // Duration Modal બતાવવા માટેનું ફંક્શન
    function showDuration(name, start, end) {
        document.getElementById('modalStudentName').innerText = name;
        document.getElementById('modalStartDate').innerText = start;
        document.getElementById('modalEndDate').innerText = (end && end !== 'null' && end !== '') ? end : 'Not Set';
        
        var myModal = new bootstrap.Modal(document.getElementById('durationModal'));
        myModal.show();
    }

    // પેજ લોડ થાય ત્યારે ટેબલ ઇનિશિયલાઈઝ કરો
    document.addEventListener('DOMContentLoaded', updateTable);
</script>
</body>
</html>