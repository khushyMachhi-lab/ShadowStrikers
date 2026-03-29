<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile - ${user.firstName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {--maroon: #922b3e;}
        .text-maroon { color: var(--maroon); }
         body {background: #f4f7f6; padding: 40px 0;}
        .profile-card {border-radius: 15px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); overflow: hidden;}
        .profile-header {background: var(--maroon); color: white; padding: 30px; text-align: center; }
        .profile-img {width: 150px; height: 150px; border-radius: 50%; border: 5px solid white; object-fit: cover; margin-bottom: 15px;}
        .info-label {color: #888; font-size: 0.8rem; text-transform: uppercase; font-weight: 700;}
        .info-value {color: #333; font-weight: 500;}
        .section-title {border-bottom: 2px solid #eee; padding-bottom: 10px; margin-bottom: 20px; color: var(--maroon); font-weight: 700;}
        .table-container {background: #fff; border-radius: 10px;}
        .table-hover tbody tr:hover {background-color: rgba(146, 43, 62, 0.02);}
        .badge-status {font-size: 0.9rem; padding: 8px 15px; border-radius: 20px;}
        .divider {height: 1px; background: #eee; margin: 30px 0;}
        
        /* Responsive adjustments */
		@media (max-width: 768px) {
    		body { padding: 20px 0; }
    		.profile-card { border-radius: 0; }
    		.col-md-6.border-end { border-end: none !important; border-bottom: 1px solid #eee; padding-bottom: 20px; margin-bottom: 20px; }
		}
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card profile-card">
                    <div class="profile-header">
                        <img src="${user.photosImagePath}" 
         					alt="Profile Picture" 
         					class="profile-img shadow"
         					onerror="this.src='${pageContext.request.contextPath}/user-photos/default-avatar.jpg'; this.onerror=null;">
                        <h2 class="mb-1">${user.firstName} ${user.lastName}</h2>
                    	<p class="mb-2 opacity-75">@${user.firstName} | ID: ${user.id}</p>
                        <span class="badge bg-light text-dark badge-status">
                        	<i class="fas fa-user-check me-1 text-success"></i> ${not empty user.admissions ? user.admissions.status : 'Pending Registration'}
                        </span>
                    </div>
                    
                    <div class="card-body p-5">
                        <div class="row">
                            <div class="col-md-6 border-end">
            					<h5 class="section-title"><i class="fas fa-user me-2"></i>Personal Details</h5>
                                
                                <p class="info-label">Email Address</p>
                                <p class="info-value">${user.email}</p>
                                
                                <p class="info-label">Birthdate & Age</p>
                            	<p class="info-value">${user.birthdate} (${user.age} Years)</p>
                            	
                                <p class="info-label">Gender</p>
                            	<p class="info-value text-capitalize">${user.gender}</p>
                            	
                                <p class="info-label">Location</p>
                            	<p class="info-value">${user.city}, ${user.state}</p>
                            	
                            	<p class="info-label">Phone Number</p>
								<p class="info-value">
    								<c:choose>
        								<c:when test="${not empty user.admissions and not empty user.admissions.phone}">
            								<a href="tel:${user.admissions.phone}" class="text-decoration-none text-primary">
                								<i class="fas fa-phone-alt me-1 small"></i> ${user.admissions.phone}
            								</a>
        								</c:when>
        								<c:otherwise><span class="text-muted">Not Provided</span></c:otherwise>
    								</c:choose>
								</p>

                            	<p class="info-label">Weight</p>
                            	<p class="info-value text-danger">
                                	<c:choose>
                                    	<c:when test="${not empty user.admissions and not empty user.admissions.weight}">
            								${user.admissions.weight} kg
        								</c:when>
                                    	<c:otherwise>Not Set</c:otherwise>
                                	</c:choose>
                            	</p>
                        	</div>
                        	
                            <div class="col-md-6 ps-md-4">
                            	<h5 class="section-title"><i class="fas fa-graduation-cap me-2"></i>Training Info</h5>
                            
                            	<p class="info-label">Course Enrolled</p>
                            	<p class="info-value text-primary font-monospace">
    								${not empty user.admissions ? user.admissions.courseName : 'Not Enrolled Yet'}
								</p>
                            
                            	<p class="info-label">Join Date</p>
                           		<p class="info-value"><c:choose>
        							<c:when test="${not empty user.admissions and not empty user.admissions.joinDate}">
            							<fmt:parseDate value="${user.admissions.joinDate}" pattern="yyyy-MM-dd" var="jDate" type="date" />
            							<fmt:formatDate value="${jDate}" pattern="dd MMM, yyyy" />
        							</c:when>
        							<c:otherwise>N/A</c:otherwise>
    								</c:choose>
    							</p>
    							
    							<p class="info-label">Expected End Date</p>
								<p class="info-value text-danger fw-bold">
    								<c:choose>
        								<c:when test="${not empty user.admissions and not empty user.admissions.expiryDate}">
            								<fmt:parseDate value="${user.admissions.expiryDate}" pattern="yyyy-MM-dd" var="eDate" type="date" />
            									<i class="far fa-calendar-times me-1"></i>
            								<fmt:formatDate value="${eDate}" pattern="dd MMM, yyyy" />
        								</c:when>
        								<c:otherwise><span class="text-muted">Not Calculated</span></c:otherwise>
    								</c:choose>
								</p>
                            
                            	<p class="info-label">Assigned Batch</p>
                            	<p class="info-value text-maroon">
                                	<c:choose>
                                    	<c:when test="${not empty user.batch}">
                                        	${user.batch.batchName} <br>
                                        	<small class="text-muted">(${user.batch.startTime} - ${user.batch.endTime})</small>
                                    	</c:when>
                                    	<c:otherwise><span class="text-muted italic">Pending Assignment</span></c:otherwise>
                                	</c:choose>
                            	</p>

                            	<p class="info-label">Current Payment Status</p>
                            	<p class="info-value">
                                	<span class="badge ${user.admissions != null and user.admissions.paymentStatus == 'Paid' ? 'bg-success' : 'bg-warning'}">
        								${not empty user.admissions ? user.admissions.paymentStatus : 'Pending'}
    								</span>
                            	</p>
                        	</div>
                    	</div>
                    	
                    	<div class="mt-5">
                        	<h5 class="section-title"><i class="fas fa-file-invoice-dollar me-2"></i>Payment History</h5>
                        	<div class="table-responsive table-container">
                            	<table class="table table-hover align-middle">
                                	<thead class="table-light">
                                    	<tr>
                                        	<th>Date</th>
                                        	<th>Invoice #</th>
                                        	<th>Amount</th>
                                        	<th>Type</th>
                                        	<th>Status</th>
                                        	<th class="text-center">Action</th>
                                    	</tr>
                                	</thead>
                                	<tbody>
                                    	<c:forEach var="p" items="${user.payments}">
                                        	<tr>
                                            	<td>${p.paymentDate}</td>
                                            	<td><code class="small">${p.invoiceNumber}</code></td>
                                            	<td class="fw-bold text-dark">
    												₹<fmt:formatNumber value="${p.amount}" pattern="#,##,###.00" />
												</td>
                                            	<td>${p.paymentType}</td>
                                            	<td>
                                                	<span class="badge rounded-pill ${p.status == 'Paid' ? 'bg-success' : 'bg-warning text-dark'}">
                                                    	${p.status}
                                                	</span>
                                            	</td>
                                            	<td class="text-center">
                                                	<c:if test="${not empty p.screenshotPath}">
                                                    	<a href="${pageContext.request.contextPath}/admin/payments/get-payment-image/${p.screenshotPath}" 
                                                       	   target="_blank" class="btn btn-outline-dark btn-sm rounded-pill px-3">
                                                           <i class="fas fa-eye me-1"></i> View Receipt
                                                    	</a>
                                                	</c:if>
                                            	</td>
                                        	</tr>
                                    	</c:forEach>
                                    	<c:if test="${empty user.payments}">
                                        	<tr>
                                            	<td colspan="6" class="text-center py-4 text-muted">
                                                	<i class="fas fa-info-circle me-1"></i> No transactions recorded for this student.
                                            	</td>
                                        	</tr>
                                    	</c:if>
                                	</tbody>
                            	</table>
                        	</div>
                    	</div>
                        
                        <div class="divider"></div>
                        
                        <div class="d-flex justify-content-center gap-3 d-print-none">
                            <a href="${pageContext.request.contextPath}/admin/admissions" class="btn btn-outline-secondary px-4 rounded-pill">
                                <i class="fas fa-arrow-left me-2"></i>Back
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>