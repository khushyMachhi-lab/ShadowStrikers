<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Documents - ShadowStrikers</title>
    
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
        
        .dashboard-content {padding: 40px 30px;}
        
        .card-container {background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.08);}

        /* Document Specific Styles */
        .doc-status-badge {padding: 6px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600;}
        .status-verified {background: rgba(40, 167, 69, 0.1); color: #28a745; border: 1px solid #28a745;}
        .status-pending {background: rgba(255, 193, 7, 0.1); color: #ffc107; border: 1px solid #ffc107;}
        .status-missing {background: rgba(220, 53, 69, 0.1); color: #dc3545; border: 1px solid #dc3545;}
        .status-rejected {background: rgba(220, 53, 69, 0.1); color: #dc3545; border: 1px solid #dc3545;}
        
        .custom-table td {vertical-align: middle; padding: 18px 15px;}
        .file-icon {font-size: 1.2rem; margin-right: 8px;}
        
		.search-wrapper {position: relative; width: 300px;}
		.search-wrapper i {position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #999;}
		.search-wrapper .form-control {padding-left: 35px; border-radius: 8px;}
		
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
            .main-content {margin-left: 0;}
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
                <i class="fas fa-th-large"></i> <span>Dashboard</span>
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

            <div class="menu-divider"></div>

            <a href="/logout" class="menu-item logout">
                <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-navbar">
            <div class="navbar-left">
                <h2>Document Verification</h2>
                <p class="text-muted">Manage student identity and medical records</p>
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
            <div class="card-container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>Document Submissions</h3>
                    <div class="search-wrapper">
    					<i class="fas fa-search"></i>
    					<input type="text" id="docSearch" class="form-control" placeholder="Search student or ID...">
					</div>                
				</div>

                <div class="table-responsive">
                    <table class="table table-hover custom-table">
                        <thead class="table-light">
                            <tr>
                            	<th>ID</th>
                                <th>Student Name</th>
                                <th>ID Proof (Aadhar/Voter)</th>
                                <th>Medical Fitness</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        
						<tbody id="documentTableBody">
    						<c:forEach var="student" items="${admissionList}">
        						<tr>
        							<td><strong>#AD-${student.id}</strong></td>
            						<td class="fw-bold">${student.firstName} ${student.lastName}</td>
            
            						<td>
                						<c:choose>
                    						<c:when test="${not empty student.documents.idProof}">
                        						<div class="d-flex flex-column gap-1">
                            						<span class="doc-status-badge status-verified">
                                						<i class="fas fa-check-circle me-1"></i> Uploaded
                            						</span>
                            						<a href="/admin/studentsRecords/documents/download/${student.documents.idProof}" class="btn btn-sm btn-outline-primary py-0 px-2 mt-1" style="font-size: 11px;">
                                						<i class="fas fa-download me-1"></i> Download ID
                            						</a>
                        						</div>
                    						</c:when>
                    						<c:otherwise>
                        						<span class="doc-status-badge status-missing">Missing</span>
                    						</c:otherwise>
                						</c:choose>
            						</td>

            						<td>
                						<c:choose>
                    						<c:when test="${not empty student.documents.medicalCertificate}">
                        						<div class="d-flex flex-column gap-1">
                            						<c:choose>
                                						<c:when test="${student.documents.status == 'Verified'}">
                                    						<span class="doc-status-badge status-verified">Verified</span>
                                						</c:when>
                                						<c:when test="${student.documents.status == 'Rejected'}">
        													<span class="doc-status-badge status-rejected">Rejected</span>
    													</c:when>
    													<c:otherwise>
        													<span class="doc-status-badge status-pending">Pending Approval</span>
    													</c:otherwise>
                            						</c:choose>
                            							<a href="/admin/studentsRecords/documents/download/${student.documents.medicalCertificate}" class="btn btn-sm btn-outline-info py-0 px-2 mt-1" style="font-size: 11px;">
                                							<i class="fas fa-download me-1"></i> Download Medical
                            							</a>
                        						</div>
                    						</c:when>
                    						<c:otherwise>
                        						<span class="doc-status-badge status-missing">Missing</span>
                    						</c:otherwise>
                						</c:choose>
            						</td>

            						<td>
    									<div class="d-flex gap-2">      
        									<c:choose>
            									<%-- જો ડોક્યુમેન્ટ્સ જ નથી (ID Proof અને Medical બંને ખાલી છે) --%>
            									<c:when test="${empty student.documents.idProof && empty student.documents.medicalCertificate}">
                									<span class="text-muted small">No documents to verify</span>
            									</c:when>
            
            									<c:otherwise>
                									<%-- જો ડોક્યુમેન્ટ્સ હોય તો જ બટન્સ બતાવવા --%>
                									<c:if test="${student.documents.status != 'Verified'}">
                    									<form action="${pageContext.request.contextPath}/admin/studentsRecords/documents/updateStatus" method="POST">
                        									<input type="hidden" name="docId" value="${student.documents.id}">
                        									<input type="hidden" name="status" value="Verified">
                        									<%-- Remarks મોકલવા જરૂરી છે ભલે ખાલી હોય, જેથી 400 એરર ન આવે --%>
                        									<input type="hidden" name="remarks" value=""> 
                        									<button type="submit" class="btn btn-sm btn-success" title="Approve">
                            									<i class="fas fa-check"></i>
                        									</button>
                    									</form>

                    									<button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#rejectModal${student.documents.id}">
                        									<i class="fas fa-times"></i>
                    									</button>
                    								</c:if>
                								</c:otherwise>         									
        									</c:choose>
    									</div>
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
    
    <a href="${pageContext.request.contextPath}/admin/studentsRecords" class="floating-back-btn shadow" title="Back to Student Records">
    	<i class="fas fa-arrow-left"></i>
    	<span>BACK</span>
	</a>
	
	<c:forEach var="student" items="${admissionList}">
    	<c:if test="${not empty student.documents}">
        	<div class="modal fade" id="rejectModal${student.documents.id}" tabindex="-1" aria-hidden="true">
            	<div class="modal-dialog modal-dialog-centered">
                	<div class="modal-content">
                    	<div class="modal-header bg-danger text-white">
                        	<h5 class="modal-title">Reject Documents - ${student.firstName}</h5>
                        	<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    	</div>
                    	<form action="/admin/studentsRecords/documents/updateStatus" method="POST">
                        	<div class="modal-body">
                            	<input type="hidden" name="docId" value="${student.documents.id}">
                            	<input type="hidden" name="status" value="Rejected">
                            	<label class="form-label fw-bold">Reason for Rejection:</label>
                            	<textarea name="remarks" class="form-control" rows="3" placeholder="e.g. Image is blur, Invalid ID number..." required></textarea>
                        	</div>
                        	<div class="modal-footer">
                            	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            	<button type="submit" class="btn btn-danger">Confirm Reject</button>
                        	</div>
                    	</form>
                	</div>
            	</div>
        	</div>
    	</c:if>
	</c:forEach>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    // --- પૃષ્ઠ દીઠ કેટલા રેકોર્ડ્સ બતાવવા તે સેટ કરો ---
    const recordsPerPage = 10; 
    let currentPage = 1;
    let filteredRows = [];

    // બધી રો (rows) ને એક વાર મેળવી લો
    const allRows = Array.from(document.querySelectorAll('#documentTableBody tr'));

    function updateTable() {
        const val = document.getElementById('docSearch').value.toLowerCase().trim();
        
        // ૧. સર્ચ ફિલ્ટર લાગુ કરો
        filteredRows = allRows.filter(row => {
            return row.innerText.toLowerCase().includes(val);
        });

        const totalRecords = filteredRows.length;
        const totalPages = Math.ceil(totalRecords / recordsPerPage) || 1;

        // પેજ નંબર ચેક કરો (જો સર્ચમાં રેકોર્ડ્સ ઓછા થઈ જાય તો)
        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        // ૨. બધી રો ને છુપાવો
        allRows.forEach(row => row.style.display = 'none');

        // ૩. હાલના પેજ મુજબ રો બતાવો
        const start = (currentPage - 1) * recordsPerPage;
        const end = start + recordsPerPage;
        
        const rowsToShow = filteredRows.slice(start, end);
        rowsToShow.forEach(row => row.style.display = '');

        // ૪. UI અપડેટ કરો (Count અને Buttons)
        document.getElementById('totalCount').innerText = totalRecords;
        document.getElementById('showingCount').innerText = rowsToShow.length;
        document.getElementById('pageNumber').innerText = currentPage;

        // બટન્સને એનેબલ/ડિસેબલ કરો
        document.getElementById('prevBtn').parentElement.classList.toggle('disabled', currentPage === 1);
        document.getElementById('nextBtn').parentElement.classList.toggle('disabled', currentPage === totalPages);
    }

    // પેજ બદલવા માટેનું ફંક્શન
    function changePage(direction) {
        currentPage += direction;
        updateTable();
        // પેજ ઉપર સ્ક્રોલ કરવા માટે (વૈકલ્પિક)
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // સર્ચ બોક્સમાં ટાઈપ કરતી વખતે
    document.getElementById('docSearch').addEventListener('keyup', function() {
        currentPage = 1; // સર્ચ વખતે હંમેશા પહેલા પેજ પર આવી જવું
        updateTable();
    });

    // પેજ લોડ થાય ત્યારે પહેલી વાર રન કરો
    document.addEventListener('DOMContentLoaded', updateTable);

</script>
</body>
</html>