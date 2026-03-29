<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admissions - Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        :root {
        /* Synced with About Us Page */
        	--primary-color: #922b3e; /* Deep Maroon */
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
        .sidebar-brand i {font-size: 1.8rem; color: var(--accent-color);}
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

        /* Stats Section */
        .stat-card { 
        	background: white; 
        	border-radius: 15px; 
        	padding: 20px; 
        	display: flex; 
        	align-items: center; 
        	gap: 15px; 
        	box-shadow: 0 5px 15px rgba(0,0,0,0.05); 
        	margin-bottom: 25px;
        }
        
        .stat-icon {width: 55px; height: 55px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;} 
        .icon-green {background: rgba(40, 167, 69, 0.1); color: #28a745;} 
        .icon-orange {background: rgba(255, 107, 53, 0.1); color: #ff6b35;}
        .icon-blue { background: rgba(13, 110, 253, 0.1); color: #0d6efd; }

        /* Table Card */
        .data-card { 
        	background: white; 
        	border-radius: 15px; 
        	padding: 25px; 
        	box-shadow: 0 5px 20px rgba(0,0,0,0.05); 
        }
        
        .registry-filters { display: flex; gap: 12px; align-items: center;}

		.search-input-group {position: relative; width: 280px;}
		.search-input-group i {position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #999;}
		.search-input-group .form-control {padding-left: 35px; border-radius: 8px; height: 38px;}

		.status-select { width: 150px; border-radius: 8px; height: 38px; cursor: pointer;}
        
        .table-container {overflow-x: auto; margin-top: 20px;}
        .table {width: 100%; border-collapse: separate; border-spacing: 0 10px;}    
        .table thead th {background: #f8f9fa; padding: 15px; font-size: 0.85rem; text-transform: uppercase; color: #666; border: none;}
        .table tbody tr {background: #f8f9fa; transition: 0.3s;}
        .table tbody tr:hover {transform: scale(1.005); background: white; box-shadow: 0 5px 15px rgba(0,0,0,0.05);}   
        .table td {padding: 15px; border: none; vertical-align: middle;}

         Badges 
        .badge-pill {padding: 6px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 600;}
        
        #admissionSearch:focus, #statusFilter:focus {background-color: #fff !important; box-shadow: 0 0 0 0.25 red rgba(146, 43, 62, 0.1); border: 1px solid var(--primary-color) !important;}
        
        /* Color for Completed Status */
		.status-confirmed { background: rgba(40, 167, 69, 0.1); color: #28a745; padding: 5px 10px; border-radius: 20px; font-weight: 600;}
		.status-pending { background: rgba(255, 193, 7, 0.1); color: #ffc107; padding: 5px 10px; border-radius: 20px; font-weight: 600;}
		
        .payment-paid {color: #28a745; font-weight: 700;}
        .payment-unpaid {color: #dc3545; font-weight: 700;}
         
         /* Buttons */
        .btn-view {background: rgba(13, 110, 253, 0.1); color: #0d6efd; }
        .btn-icon-round {width: 45px; height: 45px; display: flex; align-items: center; justify-content: center; border-radius: 10px; transition: all 0.2s ease-in-out; padding: 0;}
		.btn-icon-round:hover {transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.15);}
		.btn-icon-round i {font-size: 1.2rem;}
        
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
            .table {font-size: 0.85rem;}
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
                <i class="fas fa-th-large"></i> <span>Dashboard</span>
            </a>
            <a href="/admin/enquiries" class="menu-item">
                <i class="fas fa-question-circle"></i> <span>Enquiries</span>
            </a>
            <a href="/admin/admissions" class="menu-item active">
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
                <h2>Admissions</h2>
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
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon icon-blue"><i class="fas fa-user-check"></i></div>
                        <div><h3 class="mb-0">${totalAdmissionsCount != null ? totalAdmissionsCount : '0'}</h3><p class="text-muted mb-0">Total Admissions</p></div>
                    </div>
                </div>
                <div class="col-md-4">
    				<div class="stat-card">
        				<div class="stat-icon icon-orange"><i class="fas fa-search"></i></div>
        				<div><h3 class="mb-0">${activeReviewCount != null ? activeReviewCount : '0'}</h3><p class="text-muted mb-0">Active Review</p></div>
    				</div>
				</div>
                <div class="col-md-4">
    				<div class="stat-card">
        				<div class="stat-icon icon-green"><i class="fas fa-file-invoice-dollar"></i></div>
        				<div>
            				<%-- Dynamic value format sathe --%>
            				<h3 class="mb-0">
                				₹<fmt:formatNumber value="${totalFeesCollected != null ? totalFeesCollected : 0}" pattern="#,##,###.##" />
            				</h3>
            				<p class="text-muted mb-0">Fees Collected</p>
        				</div>
    				</div>
				</div>
            </div>

            <div class="data-card p-4 bg-white rounded shadow-sm">
                 <div class="d-flex justify-content-between align-items-center mb-4">
    				<h4 class="mb-0 fw-bold">Admission Registry</h4>
    				
                    <div class="registry-filters">
    					<div class="search-input-group">
        					<i class="fas fa-search"></i>
        					<input type="text" id="admissionSearch" class="form-control" placeholder="Search student or ID..." onkeyup="updateDashboard()">
    					</div>
    
    					<select class="form-select status-select" id="statusFilter" onchange="updateDashboard()">
        					<option value="">All Status</option>
        					<option value="Active">Active</option>
        					<option value="Pending">Pending</option>
        					<option value="Closed">Closed</option>
    					</select>
    
    					<a href="${pageContext.request.contextPath}/admin/admissions/export" 
       						class="btn btn-outline-success d-flex align-items-center justify-content-center" 
       						title="Download Excel Report" 
       						style="width: 42px; height: 38px; border-radius: 8px;">
        						<i class="fas fa-file-download"></i>
    					</a>
					</div>
                </div>

                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Student Name</th>
                                <th>Course</th>
                                <th>Admit Date</th>
                                <th>Payment</th>
                                <th>Status</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="admissionTableBody">
                            <c:forEach var="u" items="${admissionList}">
                                <tr class="admission-row">
                                    <td><strong>#AD-${u.id}</strong></td>
                                    <td>
                                        <div class="fw-bold">${u.firstName} ${u.lastName}</div>
                                        <small class="text-muted">${u.email}</small>
                                    </td>
                                    <td><span class="badge bg-light text-dark border">${u.admissions != null ? u.admissions.courseName : 'No Course'}</span></td>
        							<td>
        								<c:choose>
                    						<c:when test="${u.admissions != null}">
                        						<fmt:parseDate value="${u.admissions.joinDate}" pattern="yyyy-MM-dd" var="jDate" type="date" />
                        						<fmt:formatDate value="${jDate}" pattern="dd MMM, yyyy" />
                    						</c:when>
                    						<c:otherwise>Not Started</c:otherwise>
                						</c:choose>
                					</td>
                                    <td>
                                    	<span class="${u.admissions != null && u.admissions.paymentStatus == 'Paid' ? 'payment-paid' : 'payment-unpaid'}">
                    						${u.admissions != null ? u.admissions.paymentStatus : 'Unpaid'}
                						</span>
                					</td>
                                    <td>
    									<div class="d-flex align-items-center justify-content-between">
        									<span class="badge-pill ${u.admissions != null && u.admissions.status == 'Active' ? 'status-confirmed' : 'status-pending'}">
                        						${u.admissions != null ? u.admissions.status : 'Pending'}
                    						</span>

        								<div class="dropdown">
    										<button class="btn btn-link text-muted p-0" type="button" data-bs-toggle="dropdown">
        										<i class="fas fa-ellipsis-v"></i>
    										</button>
    										<ul class="dropdown-menu dropdown-menu-end">
        										<li><h6 class="dropdown-header">Action</h6></li>
        										<c:if test="${u.admissions != null && u.admissions.status == 'Active'}">
            										<li>
                										<a class="dropdown-item text-danger" href="javascript:void(0)" onclick="confirmClose(${u.id})">
                    										<i class="fas fa-times-circle me-2"></i>Close Admission
                										</a>
            										</li>
        										</c:if>
        										<c:if test="${u.admissions == null || u.admissions.status == 'Closed'}">
            										<li>
                										<a class="dropdown-item text-success" href="${pageContext.request.contextPath}/admin/admissions/updateStatus?id=${u.id}&status=Active">
                    										<i class="fas fa-check-circle me-2"></i>Re-Activate
                										</a>
            										</li>
        										</c:if>
    										</ul>
										</div>
    									</div>
									</td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/admissions/student-profile/${u.id}" class="btn-action btn-view" title="View Profile">
        									<i class="fas fa-eye"></i>
    									</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty admissionList}">
                                <tr><td colspan="7" class="text-center py-5">No records found.</td></tr>
                            </c:if>
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
    
    <button class="sidebar-toggle" id="mobileToggle"><i class="fas fa-bars"></i></button>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
    <script>
    let currentPage = 1;
    const recordsPerPage = 10;

    function updateDashboard() {
        const searchTerm = document.getElementById('admissionSearch').value.toLowerCase();
        const filterStatus = document.getElementById('statusFilter').value.toLowerCase();
        const allRows = document.querySelectorAll('.admission-row');
        
        // ૧. ફિલ્ટરિંગ (Search + Status)
        let filteredRows = [];
        allRows.forEach(row => {
            if (row.cells.length < 2) return;

            const rowText = row.innerText.toLowerCase();
            const statusText = row.cells[5] ? row.cells[5].innerText.toLowerCase() : "";

            const matchesSearch = rowText.includes(searchTerm);
            const matchesStatus = filterStatus === "" || statusText.includes(filterStatus);

            if (matchesSearch && matchesStatus) {
                filteredRows.push(row);
            } else {
                row.style.display = "none";
            }
        });

        // ૨. પેજીનેશન લોજિક
        const totalRecords = filteredRows.length;
        const totalPages = Math.ceil(totalRecords / recordsPerPage) || 1;
        
        // જો ફિલ્ટર કર્યા પછી પેજની સંખ્યા ઘટી જાય, તો પહેલા પેજ પર આવી જવું
        if (currentPage > totalPages) currentPage = 1;

        // start અને end નક્કી કરવા (આ લાઈન તમારા કોડમાં નહોતી)
        const start = (currentPage - 1) * recordsPerPage;
        const end = start + recordsPerPage;

        filteredRows.forEach((row, index) => {
            if (index >= start && index < end) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });

        // ૩. UI Updates (Showing X to Y of Z)
        const showingStart = totalRecords === 0 ? 0 : start + 1;
        const showingEnd = Math.min(end, totalRecords);

        document.getElementById('pageNumber').innerText = currentPage;
        document.getElementById('showingCount').innerText = showingStart + " - " + showingEnd;
        document.getElementById('totalCount').innerText = totalRecords;

        // ૪. Button States (Disable/Enable)
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');

        if(prevBtn) prevBtn.disabled = (currentPage === 1);
        if(nextBtn) nextBtn.disabled = (currentPage === totalPages || totalRecords === 0);
    }

    function changePage(direction) {
        currentPage += direction;
        updateDashboard();
        // ટેબલની ટોચ પર સ્ક્રોલ કરવા માટે
        const tableContainer = document.querySelector('.table-container');
        if(tableContainer) tableContainer.scrollIntoView({ behavior: 'smooth' });
    }

    // Events
    document.addEventListener('DOMContentLoaded', updateDashboard);
    
    document.getElementById('admissionSearch').addEventListener('keyup', () => {
        currentPage = 1; 
        updateDashboard();
    });

    document.getElementById('statusFilter').addEventListener('change', () => {
        currentPage = 1;
        updateDashboard();
    });

    // Close Admission Confirmation
    function confirmClose(id) {
        Swal.fire({
            title: 'Are you sure?',
            text: "This will move the student to 'Closed' status!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#922b3e',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, Close it!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = '${pageContext.request.contextPath}/admin/admissions/updateStatus?id=' + id + '&status=Closed';
            }
        })
    }
</script>
</body>
</html>