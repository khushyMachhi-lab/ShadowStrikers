<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payments - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        :root {
            --primary-color: #922b3e; 
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
        
        .user-badge {
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
        .menu-item:hover {background-color: var(--primary-dark); color: #ffffff !important;}
        .menu-item.active {background-color: #ffffff !important; color: var(--primary-color) !important; font-weight: 700; border-left: 4px solid var(--accent-color);}     
    	.menu-item.active i {color: var(--primary-color) !important;}
        .menu-divider { height: 1px; background: rgba(255,255,255,0.2); margin: 15px 25px;}
        .menu-item.logout {color: #ffcfcf !important;}
        .menu-item.logout:hover {background-color: var(--primary-dark); color: #ffffff !important;}
        
        /* Content Styles */
        .main-content {margin-left: var(--sidebar-width); min-height: 100vh; background: #f4f7f6; padding: 30px 50px;}
		
		.top-navbar { 
            background: white; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
            padding: 20px 30px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            position: sticky; 
            top: 0; 
            z-index: 100; 
        }
        
        .navbar-left h2 {font-size: 1.8rem; font-weight: 800; background: var(--text-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin: 0;}
        .navbar-left p {color: #666; margin: 0; font-size: 0.95rem;}

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
        
        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
            box-shadow: 0 4px 12px rgba(146, 43, 62, 0.3);
        }

        .user-info h6 {margin: 0; font-weight: 700; color: var(--dark-color); font-size: 0.95rem;}
        
        /* Page Content */
        .page-content { padding-top: 20px; position: relative; z-index: 1; }
        
        /* Hero Card with Balance */
        .balance-hero {
            background: var(--primary-gradient);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            color: white;
            box-shadow: 0 10px 30px rgba(146, 43, 62, 0.3);
            position: relative;
            overflow: hidden;
        }

        .balance-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }

        .balance-content {position: relative; z-index: 2;}
        .balance-label {font-size: 0.9rem; opacity: 0.9; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 1px;}
        .balance-amount {font-size: 3.5rem; font-weight: 900; margin-bottom: 20px; text-shadow: 0 2px 10px rgba(0,0,0,0.2);}
        .balance-actions {display: flex; gap: 15px; flex-wrap: wrap;}

        .balance-btn {
            padding: 12px 30px;
            border: 2px solid rgba(255,255,255,0.3);
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            color: white;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .balance-btn:hover {background: white; color: var(--primary-color); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.2);}       
        
        /* Invoice Generator */
        .invoice-section {background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.05);}
        .invoice-filters {display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap;}
        .filter-select {padding: 10px 20px; border: 2px solid #e0e0e0; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;}
        .filter-select:focus {outline: none; border-color: var(--primary-color);}
        .invoice-item {display: flex; justify-content: space-between; align-items: center; padding: 20px; background: white; border-radius: 12px; margin-bottom: 15px; border: 1px solid #eee; transition: 0.3s;}
        .invoice-item:hover {background: #f8f9fa;}
        .invoice-info {flex: 1;}
        .invoice-number {font-weight: 700; color: var(--primary-color); margin-bottom: 5px;}
        .invoice-date {font-size: 0.85rem;color: #666;}
        .invoice-download {padding: 8px 15px; background: var(--primary-gradient); color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 700; font-size: 0.9rem; transition: all 0.3s ease; position: relative; z-index: 10;}
        .invoice-download:hover {transform: translateY(-2px);box-shadow: 0 4px 12px rgba(146, 43, 62, 0.3);}
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar { left: -280px; }
            .sidebar.active { left: 0; }
            .main-content { margin-left: 0; }
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
            .content-grid { grid-template-columns: 1fr; }
            .page-content { padding: 25px 15px; }
        }

        @media (max-width: 576px) {
            .stats-grid { grid-template-columns: 1fr; }
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
        	<div class="user-badge">My-Desk</div>
        </div>
        <div class="sidebar-menu">
            <a href="/student/dashboard" class="menu-item">
            	<i class="fas fa-home"></i> <span>My Dashboard</span>
            </a>
            <a href="/student/myProfile" class="menu-item">
            	<i class="fas fa-user-graduate"></i> <span>My Profile</span>
           	</a>
           	<a href="/student/myClasses" class="menu-item">
            	<i class="fas fa-user-graduate"></i> <span>My Classes</span>
            </a>
            <a href="/student/myAttendance" class="menu-item">
            	<i class="fas fa-calendar-check"></i> <span>My Attendance</span>
            </a>
            <a href="/student/myPayments" class="menu-item active">
            	<i class="fas fa-wallet"></i> <span>My Payments</span>
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
                <h2>My Payments</h2>
                <p class="text-muted">Manage your fees and transactions</p>
            </div>
            <div class="navbar-right">
                <div class="user-profile">
                    <div class="user-avatar" style="overflow: hidden;">
    					<c:choose>
        					<c:when test="${not empty student.photo}">
            					<img src="${pageContext.request.contextPath}/user-photos/${student.photo}" 
                 					alt="Profile" 
                 					style="width: 100%; height: 100%; object-fit: cover;">
        					</c:when>
        					<c:otherwise>
            					<span>${student.firstName.substring(0,1)}</span>
        					</c:otherwise>
    					</c:choose>
					</div>
					<div class="user-info">
    					<h6>${student.firstName} ${student.lastName}</h6>
					</div>
                </div>
            </div>
        </div>
        
        <div class="page-content">
        
        	<!-- Balance Hero Card -->
            <div class="balance-hero d-flex justify-content-between align-items-end">
                <div class="balance-content">
                    <div class="balance-label">Total Outstanding Balance</div>
                    <div class="balance-amount">₹${totalPendingAmount}</div>
                    <div class="balance-actions">
                        <button class="balance-btn" data-bs-toggle="modal" data-bs-target="#payNowModal">
                            <i class="fas fa-credit-card"></i> Pay Now
                        </button>
                    </div>
                </div>
                <div class="text-end pb-2">
        			<div class="small opacity-75 text-uppercase fw-bold" style="letter-spacing: 1px;">Total Course Amount</div>
        			<h3 class="fw-900 mb-0" style="font-size: 2rem;">₹${totalCourseAmount}</h3>
        			
        			<span class="badge bg-white text-dark rounded-pill px-3 py-2 mt-2" style="font-size: 0.8rem;">
            			<i class="fas fa-award me-1 text-danger"></i> 
            			${student.admissions.courseName}
        			</span>
    			</div>
            </div> 
    
    		<!-- Invoice Generator -->
            <div class="invoice-section mb-4">
                <h4 class="mb-4 fw-bold text-dark">
        			<i class="fas fa-file-invoice-dollar me-2" style="color: var(--primary-color);"></i>
                        Invoices & Receipts
                    </h4>
                </div>
				<div class="invoice-content-wrapper mt-4">
                <div class="invoice-filters">
                    <select class="filter-select">
                        <option>All Invoices</option>
                        <option>This Year</option>
                        <option>Last 6 Months</option>
                        <option>Custom Range</option>
                    </select>
                    <select class="filter-select">
                        <option>All Types</option>
                        <option>Course Fees</option>
                        <option>Other</option>
                    </select>
                </div>

				<c:forEach var="payment" items="${payments}">
                <div class="invoice-item">
                    <div class="invoice-info">
                        <div class="invoice-number">Invoice #${payment.invoiceNumber}</div>
                        <div class="invoice-date">
                        	${payment.paymentDate} • ₹${payment.amount}
                        	<span class="badge ${payment.status == 'Paid' ? 'bg-success' : 'bg-warning'}" 
                          		  style="font-size: 0.7rem; margin-left: 10px;">
                        	    ${payment.status}
                    		</span>
                    	</div>
                    	<div class="text-muted small">${payment.paymentType}</div>
                    </div>
                    <button class="invoice-download" onclick="downloadInvoice('${payment.id}')">
                        <i class="fas fa-download"></i> 
                    </button>
                 </div>
                 </c:forEach>

    			 <c:if test="${empty payments}">
        			 <div class="text-center p-4">
            			 <p class="text-muted">No payment records found.</p>
        			 </div>
    			 </c:if>
            </div>
         </div>
       </div>
       
<div class="modal fade" id="payNowModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow">
            <div class="modal-header text-white" style="background: var(--primary-gradient);">
                <h5 class="modal-title fw-bold">
                    <i class="fas fa-shield-alt me-2"></i>Complete Your Payment
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form action="/student/myPayments/submitPayment" method="POST" enctype="multipart/form-data">
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-5 border-end text-center">
                            <h6 class="fw-bold mb-3 text-muted">Scan to Pay</h6>
                            <div class="p-2 border rounded bg-light mb-3">
                                <img src="${pageContext.request.contextPath}/QR Code/Shadowstrikers_UPI.png" alt="UPI QR Code" class="img-fluid" style="max-width: 180px;">
                            </div>
                            <p class="small mb-1">UPI ID: <strong>yourupi@okaxis</strong></p>
                            <p class="text-danger fw-bold mb-0">Amount: ₹${totalPendingAmount}</p>
                            <hr class="d-md-none">
                        </div>

                        <div class="col-md-7 ps-md-4">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Select Fee Type</label>
                                <select class="form-select" name="paymentType" required>
                                    <option value="Course Fees">Course Fees</option>
                                    <option value="Tournament Fees">Tournament Fees</option>
                                    <option value="Uniform/Gear">Uniform/Gear</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Paying Amount (₹)</label>
                                <input type="number" name="amount" class="form-control" value="${totalPendingAmount}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">UPI Transaction ID</label>
                                <input type="text" name="txnId" class="form-control" placeholder="12-digit Ref No." required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Upload Screenshot</label>
                                <input type="file" name="file" class="form-control" accept="image/*" required>
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-warning mt-3 py-2 small mb-0">
                        <i class="fas fa-info-circle me-1"></i> Admin will verify your Transaction ID and Screenshot before approving.
                    </div>
                </div>

                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success px-4">
                        <i class="fas fa-check-circle me-1"></i> Submit Payment
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

	<script>
		function downloadInvoice(paymentId) {
    		console.log("Downloading invoice for ID: " + paymentId);
    		window.location.href = "${pageContext.request.contextPath}/student/myPayments/downloadInvoice/" + paymentId;
		}
</script>

</body>
</html>