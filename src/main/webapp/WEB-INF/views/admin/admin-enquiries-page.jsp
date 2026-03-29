<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enquiries - Admin Dashboard</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
        
        /* Main Content */
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

        /* Stats Cards */
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .stat-card:hover {transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.15);}
        .stat-icon  {width: 70px; height: 70px; border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 2rem; flex-shrink: 0;}
        .stat-icon.blue { background: rgba(13, 110, 253, 0.1); color: var(--primary-color);}
        .stat-icon.green { background: rgba(40, 167, 69, 0.1); color: var(--success-color);}
        .stat-icon.orange { background: rgba(255, 193, 7, 0.1); color: var(--warning-color);} 
        .stat-info {flex: 1;}
        .stat-number {font-size: 2rem; font-weight: 800; color: var(--dark-color); margin-bottom: 5px;}
        .stat-label {color: #666; font-size: 0.95rem; font-weight: 500;}
        
        .row-converted {background-color: rgba(40, 167, 69, 0.08) !important; border-left: 5px solid var(--success-color) !important;}

        /* Enquiries Table */
        .enquiries-card {
            width: 100%;
    		background: white;
    		border-radius: 15px;
    		padding: 25px;
    		box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .enquiries-header {display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;}
        .enquiries-header h3 {font-size: 1.5rem; font-weight: 800; color: var(--dark-color); margin: 0;}
        .btn-add {background: var(--success-color); color: white; padding: 12px 25px; border-radius: 10px; border: none; font-weight: 600; cursor: pointer; transition: all 0.3s ease;}
        .btn-add:hover {background: #218838; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);}
        
        .table-container {width: 100%; overflow: visible !important;}

        .enquiries-table {width: 100%; border-collapse: separate; border-spacing: 0 12px; table-layout: auto;}
        .enquiries-table thead th {background: #f8f9fa; color: #666; font-weight: 700; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; padding: 15px; border: none; text-align: left;}
        .enquiries-table thead th:first-child {border-radius: 10px 0 0 10px;}
        .enquiries-table thead th:last-child {border-radius: 0 10px 10px 0;}
        .enquiries-table tbody tr {background: #f8f9fa; transition: all 0.3s ease; position: relative;}
        .enquiries-table tbody tr:hover {background: white; box-shadow: 0 5px 15px rgba(0,0,0,0.1); z-index: 5;}
        .enquiries-table tbody td {padding: 20px 15px; border: none; vertical-align: middle; overflow: visible !important; position: relative;}
        .enquiries-table tbody tr td:first-child {border-radius: 10px 0 0 10px;}
        .enquiries-table tbody tr td:last-child {border-radius: 0 10px 10px 0;}
        .enquiries-table tr:has(.show) {z-index: 100 !important; position: relative;}
        .enquiries-table td:nth-child(2) {max-width: 250px; word-wrap: break-word; white-space: normal;}
        .enquiries-table td:nth-child(5) {width: 160px; white-space: nowrap;}
        
        .dropdown-menu {z-index: 9999 !important; position: absolute; margin-top: 0;}
        .dropdown.d-flex {justify-content: space-between; align-items: center; width: 100%;}

        .badge-status {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge-new {background: rgba(13, 110, 253, 0.1); color: var(--primary-color);}
        .badge-contacted {background: rgba(255, 193, 7, 0.1); color: var(--warning-color);}
        .badge-converted {background: rgba(40, 167, 69, 0.1); color: var(--success-color);}
        .badge-rejected {background: rgba(220, 53, 69, 0.1); color: var(--danger-color);}

        .btn-action {
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 0.9rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 0 3px;
        }

        .btn-action.view {background: rgba(13, 110, 253, 0.1); color: var(--primary-color);}
        .btn-action.delete {background: rgba(220, 53, 69, 0.1); color: var(--danger-color);}
        .btn-action:hover {transform: translateY(-2px); box-shadow: 0 5px 10px rgba(0,0,0,0.1);}

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
            .sidebar {left: -280px;}
            .sidebar.active {left: 0;}
            .main-content {margin-left: 0;}
            .sidebar-toggle {display: block;}
            .table-container {overflow-x: auto;}
            .stat-card {margin-bottom: 15px;}
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
            <a href="/admin/enquiries" class="menu-item active">
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
                <h2>Enquiries</h2>
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
    	<div class="row g-4 mb-4">
        	<div class="col-md-4">
            	<div class="stat-card blue">
                	<div class="stat-header">
                    	<div class="stat-icon blue">
                        	<i class="fas fa-question-circle"></i>
                    	</div>
                	</div>
                	<div class="stat-number">${totalEnquiriesCount != null ? totalEnquiriesCount : 0}</div>
                	<div class="stat-label">Total Enquiries</div>
            	</div>
        	</div>

        	<div class="col-md-4">
            	<div class="stat-card green">
                	<div class="stat-header">
                    	<div class="stat-icon green">
                        	<i class="fas fa-check-circle"></i>
                    	</div>
                	</div>
                	<div class="stat-number">${convertedEnquiriesCount != null ? convertedEnquiriesCount : 0}</div>
                	<div class="stat-label">Converted</div>
            	</div>
        	</div>

        	<div class="col-md-4">
            	<div class="stat-card orange">
                	<div class="stat-header">
                    	<div class="stat-icon orange">
                        	<i class="fas fa-clock"></i>
                    	</div>
                	</div>
                	<div class="stat-number">${pendingEnquiriesCount != null ? pendingEnquiriesCount : 0}</div>
                	<div class="stat-label">Pending (New)</div>
            	</div>
        	</div>
    	</div>
    
    	<div class="enquiries-card">
    	<div class="enquiries-header">
        <div class="d-flex justify-content-between align-items-center mb-3 w-100 p-0">
            
            <h5 class="mb-0 fw-bold px-3">
                <i class="fas fa-list-ul me-2"></i>All Enquiries
            </h5>

            <div class="d-flex align-items-center gap-2 ms-4">
                
                <div class="input-group" style="width: 260px;">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fas fa-search text-muted"></i>
                    </span>
                    <input type="text" id="tableSearch" class="form-control bg-light border-start-0" placeholder="Search name or ID...">
                </div>

                <select id="statusFilter" class="form-select bg-light" style="width: 150px;">
                    <option selected>All Statuses</option>
                    <option value="Converted">Converted</option>
                    <option value="Pending">Pending</option>
                </select>

                <button class="btn btn-success d-flex align-items-center px-3" style="height: 38px" data-bs-toggle="modal" data-bs-target="#addEnquiryModal">
                    <i class="fas fa-plus me-2"></i>Add
                </button>
            </div>
        </div>
		</div>

        <div class="table-container">
            <table class="enquiries-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Subject</th>
                        <th>Contact</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
				<tbody id="enquiryTableBody">
    				<c:forEach var="enquiry" items="${enquiries}">
        				<tr class="enquiry-row">
            				<td><strong>#${enquiry.id}</strong></td>
            				<td>
                				<strong>${enquiry.fullName}</strong><br>
                				<small class="text-muted">${enquiry.email}</small>
            				</td>
            				<td>${enquiry.subject}</td>
            				<td>${enquiry.phone}</td>
            				<td style="width: 160px;"> 
    							<div class="dropdown d-flex align-items-center justify-content-between bg-white p-1 rounded-pill shadow-sm" style="border: 1px solid #eee;">
                                   <span class="badge-status ${enquiry.status == 'Converted' ? 'badge-converted' : 
                                                               enquiry.status == 'Pending' ? 'badge-contacted' : 
                                                               enquiry.status == 'Closed' ? 'badge-rejected' : 'badge-new'}">
                                       ${enquiry.status != null ? enquiry.status : 'New'}
                                   </span>
                                   <button class="btn btn-link p-0 text-muted" data-bs-toggle="dropdown" data-bs-boundary="viewport"><i class="fas fa-ellipsis-v text-muted"></i></button>
                                   <ul class="dropdown-menu shadow border-0">
                                       <li><a class="dropdown-item" href="/admin/enquiries/updateStatus?id=${enquiry.id}&status=New">New</a></li>
                                       <li><a class="dropdown-item" href="/admin/enquiries/updateStatus?id=${enquiry.id}&status=Pending">Pending</a></li>
                                       <li><a class="dropdown-item text-success fw-bold" href="/admin/enquiries/updateStatus?id=${enquiry.id}&status=Converted">Converted</a></li>
                                       <li><hr class="dropdown-divider"></li>
                                       <li><a class="dropdown-item text-danger" href="/admin/enquiries/updateStatus?id=${enquiry.id}&status=Closed">Closed</a></li>
                                   </ul>
                                </div>
							</td>
            				<td>${enquiry.onlyDate}</td>
            				<td>
                				<div class="d-flex justify-content-center gap-2">
        							<a href="/admin/enquiries/view/${enquiry.id}" class="btn-action view" title="View Full Details">
            							<i class="fas fa-eye"></i>
        							</a>
        							<a href="javascript:void(0)" onclick="confirmDelete('${enquiry.id}')" class="btn-action delete" title="Delete">
    									<i class="fas fa-trash"></i>
									</a>
    							</div>
            				</td>
        				</tr>
    				</c:forEach>
				</tbody>
            </table>
        </div>
        
        <div class="d-flex justify-content-between align-items-center mt-4 px-3">
    		<div class="text-muted small">
    			Showing <span id="showingCount">0</span> of <span id="totalCount">0</span> enquiries
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
	
	<div class="modal fade" id="addEnquiryModal" tabindex="-1" aria-labelledby="addEnquiryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header text-white" style="background: var(--primary-color);">
                <h5 class="modal-title" id="addEnquiryModalLabel fw-bold">
                    <i class="fas fa-user-plus me-2"></i>Add New Enquiry
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/admin/enquiries/save" method="post">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Full Name</label>
                        <input type="text" name="fullName" class="form-control" placeholder="Enter student name" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Phone Number</label>
                            <input type="tel" name="phone" class="form-control" placeholder="10-digit number" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Subject/Course</label>
                            <input type="text" name="subject" class="form-control" placeholder="e.g. Karate, MMA">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="name@example.com">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Initial Status</label>
                        <select name="status" class="form-select">
                            <option value="New">New</option>
                            <option value="Pending">Pending</option>
                            <option value="Converted">Converted</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn text-white px-4" style="background: var(--primary-color);">Save Enquiry</button>
                </div>
            </form>
        </div>
    </div>
</div>   

	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel"><i class="fas fa-exclamation-triangle me-2"></i> Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this enquiry? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete Now</a>
            </div>
        </div>
    </div>
</div>                

	<!-- Mobile Sidebar Toggle -->
	<button class="sidebar-toggle" id="sidebarToggle">
    	<i class="fas fa-bars"></i>
	</button>

	<!-- Bootstrap JS Bundle -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    let currentPage = 1;
    const recordsPerPage = 10;

    function updateEnquiryDashboard() {
        const searchInput = document.getElementById('tableSearch');
        const statusFilter = document.getElementById('statusFilter');
        
        const searchValue = searchInput ? searchInput.value.toLowerCase() : "";
        let filterValue = statusFilter ? statusFilter.value.toLowerCase() : "";
        if (filterValue === "all statuses") {
            filterValue = "";
        }
        
        // .enquiry-row ક્લાસ તમારી દરેક એન્ટ્રી (DIV અથવા TR) માં હોવો જોઈએ
        const allRecords = document.querySelectorAll('.enquiry-row'); 
        
        // ૧. ફિલ્ટર લોજિક (Search + Status)
        let filteredRecords = [];
        allRecords.forEach(record => {
            const text = record.innerText.toLowerCase();
            const matchesSearch = text.includes(searchValue);
            const matchesStatus = filterValue === "" || text.includes(filterValue);

            if (matchesSearch && matchesStatus) {
                filteredRecords.push(record);
            } else {
                record.style.display = "none";
            }
        });

        // ૨. પેજીનેશન લોજિક
        const totalRecords = filteredRecords.length;
        const totalPages = Math.ceil(totalRecords / recordsPerPage);

        // જો ફિલ્ટરને કારણે પેજ સંખ્યા ઘટી જાય, તો પહેલા પેજ પર લાવો
        if (currentPage > totalPages && totalPages > 0) currentPage = 1;

        filteredRecords.forEach((record, index) => {
            const start = (currentPage - 1) * recordsPerPage;
            const end = start + recordsPerPage;
            
            if (index >= start && index < end) {
                record.style.display = "";
            } else {
                record.style.display = "none";
            }
        });

        // ૩. UI અપડેટ (Showing X to Y of Z)
        const totalDisplay = document.getElementById('totalCount');
        const showingDisplay = document.getElementById('showingCount');
        const pageNumDisplay = document.getElementById('pageNumber');

        if(totalDisplay) totalDisplay.innerText = totalRecords;
        
        if(showingDisplay) {
            const startRange = totalRecords === 0 ? 0 : (currentPage - 1) * recordsPerPage + 1;
            const endRange = Math.min(currentPage * recordsPerPage, totalRecords);
            showingDisplay.innerText = startRange + " to " + endRange;
        }
        
        if(pageNumDisplay) pageNumDisplay.innerText = totalPages === 0 ? 0 : currentPage;

        // ૪. બટન્સ કંટ્રોલ
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        
        if(prevBtn) prevBtn.disabled = (currentPage === 1 || totalPages === 0);
        if(nextBtn) nextBtn.disabled = (currentPage === totalPages || totalPages === 0);
    }

    function changePage(direction) {
        currentPage += direction;
        updateEnquiryDashboard();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // પેજ લોડ અને ઇવેન્ટ લિસનર્સ
    document.addEventListener('DOMContentLoaded', () => {
        updateEnquiryDashboard();

        const tableSearch = document.getElementById('tableSearch');
        const statusFilter = document.getElementById('statusFilter');
        const sidebarToggle = document.getElementById('sidebarToggle');

        if (tableSearch) {
            tableSearch.addEventListener('input', () => { currentPage = 1; updateEnquiryDashboard(); });
        }
        if (statusFilter) {
            statusFilter.addEventListener('change', () => { currentPage = 1; updateEnquiryDashboard(); });
        }
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                document.getElementById('sidebar').classList.toggle('active');
            });
        }
    });

    // Delete Confirmation
    function confirmDelete(enquiryId) {
        const deleteUrl = "${pageContext.request.contextPath}/admin/enquiries/delete/" + enquiryId;
        const confirmBtn = document.getElementById('confirmDeleteBtn');
        if (confirmBtn) confirmBtn.setAttribute('href', deleteUrl);
        
        const deleteModalEl = document.getElementById('deleteModal');
        if (deleteModalEl) {
            const myModal = new bootstrap.Modal(deleteModalEl);
            myModal.show();
        }
    }

    // Auto Refresh Table (Every 1 minute)
    function refreshEnquiryTable() {
        $.ajax({
            url: window.location.href,
            type: 'GET',
            success: function(data) {
                // અહીં '#enquiryTableBody' અથવા જે કન્ટેનર હોય તેને અપડેટ કરો
                const newContent = $(data).find('#enquiryTableBody').html();
                $('#enquiryTableBody').html(newContent);
                updateEnquiryDashboard(); // રિફ્રેશ પછી ફરીથી પેજીનેશન સેટ કરો
            }
        });
    }
    setInterval(refreshEnquiryTable, 60000);
</script>
</body>
</html>