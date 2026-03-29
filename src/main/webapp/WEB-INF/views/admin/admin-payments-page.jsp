<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payments - Admin Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
        /* Synced with About Us Page */
        	--primary-color: #922b3e; /* Deep Maroon */
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 100%);
        	--dark-color: #1a1a2e;
        	--sidebar-width: 280px;
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

        /* Sidebar & Layout (Identical to Dashboard) */
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
        
        /* Nav & Cards */
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
       
        .payment-content {padding: 30px;}

        /* Payment Specific UI */
        .finance-card {
            background: white; 
            border-radius: 15px; 
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05); 
            border-left: 5px solid var(--primary-color);
        }
        
        .finance-card.success {border-left-color: var(--success-color);}    
        .finance-card.warning {border-left-color: #ffc107;}

        .payment-table-card {background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.08);}
        
        .status-pill {padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600;}
        
        .paid {background: rgba(40, 167, 69, 0.1); color: var(--success-color);}  
        .pending {background: rgba(255, 193, 7, 0.1); color: #856404;}
        
        .modal-backdrop {z-index: 1040 !important;}		
		.modal {z-index: 1050 !important;}
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar { left: calc(-1 * var(--sidebar-width)); }
            .sidebar.active { left: 0; }
            .main-content { margin-left: 0; }
            .sidebar-toggle { display: flex; align-items: center; justify-content: center; }
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
            <a href="/admin/payments" class="menu-item active">
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
                <h2>Payments Management</h2>
                <p class="text-muted">Track revenue and student fees</p>
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

        <div class="payment-content">
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="finance-card success">
                        <small class="text-muted text-uppercase fw-bold">Total Revenue</small>
                        <h3 class="mb-0 mt-1">₹${totalRevenue}</h3>
                        <div class="text-success mt-2" style="font-size: 0.85rem;">
                            <i class="fas fa-arrow-up"></i> 12% from last month
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="finance-card warning">
                        <small class="text-muted text-uppercase fw-bold">Pending Dues</small>
                        <h3 class="mb-0 mt-1">₹${pendingDues}</h3>
                        <div class="text-muted mt-2" style="font-size: 0.85rem;">
                            From ${pendingCount} students
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="finance-card">
                        <small class="text-muted text-uppercase fw-bold">Transactions</small>
                        <h3 class="mb-0 mt-1">${transactionCount}</h3>
                        <div class="text-muted mt-2" style="font-size: 0.85rem;">This current month</div>
                    </div>
                </div>
            </div>

            <div class="payment-table-card">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0">Recent Transactions</h5>
                    <div class="d-flex gap-2">
                        <input type="text" class="form-control form-control-sm" placeholder="Search student...">
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addPaymentModal">
            				<i class="fas fa-plus"></i> 
        				</button>
                        <div class="dropdown">
            				<button class="btn btn-light btn-sm border dropdown-toggle" type="button" data-bs-toggle="dropdown">
                				<i class="fas fa-filter me-1"></i> 
            				</button>
            				<ul class="dropdown-menu shadow border-0">
                				<li><a class="dropdown-item" href="/admin/payments">All Transactions</a></li>
                				<li><hr class="dropdown-divider"></li>
                				<li><a class="dropdown-item" href="/admin/payments?status=Paid">Paid Only</a></li>
                				<li><a class="dropdown-item" href="/admin/payments?status=Pending">Pending Only</a></li>
            				</ul>
       	 				</div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Transaction ID</th>
                                <th>Student Name</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Method</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pay" items="${paymentsList}">
                                <tr>
                                    <td class="text-muted fw-bold">#TRX-${pay.id}</td>
                                    <td>
                                        <div class="fw-bold">${pay.user.firstName} ${pay.user.lastName}</div>
                                        <small class="text-muted">${pay.user.batch.batchName}</small>
                                    </td>
                                    <td>${pay.paymentDate}</td>
                                    <td class="fw-bold">₹${pay.amount}</td>
                                    <td><span class="badge bg-light text-dark border">${pay.paymentType}</span></td>
                                    <td>
                                        <span class="status-pill ${pay.status == 'Paid' ? 'paid' : 'pending'}">
                                            ${pay.status}
                                        </span>
                                    </td>
                                    <td>
    									<button class="btn btn-sm btn-outline-primary" 
            									onclick="viewPaymentDetails('${pay.id}', '${pay.invoiceNumber}', '${pay.amount}', '${pay.status}', '${pay.screenshotPath}')"
            									title="View Details">
        									<i class="fas fa-eye"></i>
    									</button>
    
    									<c:if test="${pay.status == 'Pending'}">
        									<a href="/admin/payments/approve-payment/${pay.id}" class="btn btn-sm btn-success" title="Approve">
            									<i class="fas fa-check"></i>
        									</a>
    									</c:if>
    
    									<button class="btn btn-sm btn-outline-danger" 
            									onclick="downloadInvoiceAdmin('${pay.id}')" 
            									title="Download PDF">
        									<i class="fas fa-file-pdf"></i>
    									</button>
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
    
    <div class="modal fade" id="addPaymentModal" tabindex="-1" aria-labelledby="addPaymentModalLabel">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header" style="background: var(--primary-gradient); color: white;">
                <h5 class="modal-title fw-bold"><i class="fas fa-wallet me-2"></i>Record New Payment</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/admin/payments/save-payment" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Select Student</label>
                        <select name="userId" class="form-select" required>
                            <option value="">-- Choose Student --</option>
                            <c:forEach var="s" items="${allStudents}">
                                <option value="${s.id}">${s.firstName} ${s.lastName} (${s.batch.batchName})</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Amount (₹)</label>
                            <input type="number" name="amount" class="form-control" placeholder="0.00" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Payment Status</label>
                            <select name="status" class="form-select">
                                <option value="Paid">Paid</option>
                                <option value="Pending">Pending</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Payment Type / Method</label>
                        <select name="paymentType" class="form-select">
                            <option value="Course Fee">Course Fees</option>
                            <option value="Registration Fees">Registration Fees</option>
                            <option value="Tournament Fees">Tournament Fees</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary px-4" style="background: var(--primary-color);">Save Transaction</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="viewPaymentModal" tabindex="-1" aria-labelledby="viewPaymentModalLabel">
    <div class="modal-dialog modal-md">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title">Payment Verification</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="fw-bold text-muted">Transaction ID:</label>
                    <p id="modalTxnId" class="fw-bold text-primary"></p>
                </div>
                <div class="mb-3 text-center">
                    <label class="fw-bold d-block mb-2">Payment Screenshot</label>
                    <div class="p-2 border rounded bg-light">
                        <img id="modalScreenshot" src="/images/no-image.png" class="img-fluid" style="max-height: 300px;">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    
 	// Pagination Variables
    const recordsPerPage = 10; 
    let currentPage = 1;
    let filteredItems = [];

    // ૧. પેજ લોડ થાય ત્યારે અને સર્ચ વખતે અપડેટ કરો
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.querySelector('input[placeholder="Search student..."]');
        if(searchInput) {
            searchInput.addEventListener('input', function() {
                currentPage = 1; 
                updatePaymentTable();
            });
        }
        updatePaymentTable();
    });

    // ૨. ટેબલ, કાઉન્ટ અને પેજીનેશન અપડેટ કરવાનું ફંક્શન
    function updatePaymentTable() {
        const allRows = Array.from(document.querySelectorAll('table tbody tr'));
        const searchTerm = document.querySelector('input[placeholder="Search student..."]').value.toLowerCase().trim();

        // ફિલ્ટર લોજિક
        filteredItems = allRows.filter(row => {
            const studentName = row.cells[1].innerText.toLowerCase();
            const txnId = row.cells[0].innerText.toLowerCase();
            return studentName.includes(searchTerm) || txnId.includes(searchTerm);
        });

        const totalRecords = filteredItems.length;
        const totalPages = Math.ceil(totalRecords / recordsPerPage) || 1;

        // બધી રો છુપાવો
        allRows.forEach(row => row.style.display = 'none');
        
        // હાલના પેજની રો બતાવો
        const startIndex = (currentPage - 1) * recordsPerPage;
        const endIndex = startIndex + recordsPerPage;
        
        filteredItems.slice(startIndex, endIndex).forEach(row => {
            row.style.display = 'table-row';
        });

        // કાઉન્ટ અપડેટ (Showing X of Y)
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

        // બટન સ્ટેટસ અને પેજ નંબર
        document.getElementById('pageNumber').innerText = currentPage;
        document.getElementById('prevBtn').disabled = (currentPage === 1);
        document.getElementById('nextBtn').disabled = (currentPage === totalPages || totalRecords === 0);
    }

    // ૩. પેજ બદલવાનું ફંક્શન
    function changePage(direction) {
        const totalPages = Math.ceil(filteredItems.length / recordsPerPage);
        if (currentPage + direction >= 1 && currentPage + direction <= totalPages) {
            currentPage += direction;
            updatePaymentTable();
        }
    }
    
    document.querySelector('input[placeholder="Search student..."]').addEventListener('keyup', function() {
        let filter = this.value.toUpperCase();
        let rows = document.querySelector("table tbody").rows;
        
        for (let i = 0; i < rows.length; i++) {
            let firstCol = rows[i].cells[1].textContent.toUpperCase();
            if (firstCol.indexOf(filter) > -1) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }      
        }
    });
    
    function viewPaymentDetails(id, txnId, amount, status, path) {
        document.getElementById('modalTxnId').innerText = txnId;
        
        let imgElement = document.getElementById('modalScreenshot');
        
        console.log("Image Path: ", path);
        
        if (path && path !== 'null' && path !== '' && path !== 'undefined') {
        	imgElement.src = "/admin/payments/get-payment-image/" + path;
    	} else {
    		imgElement.src = "https://placehold.co/400x300?text=No+Screenshot+Available";
    	}
        
        var modalElement = document.getElementById('viewPaymentModal');
        var myModal = bootstrap.Modal.getOrCreateInstance(modalElement);
        myModal.show();
    }
    
    function downloadInvoiceAdmin(paymentId) {
        window.location.href = "/student/myPayments/downloadInvoice/" + paymentId;
    }
    
    </script>
</body>
</html>