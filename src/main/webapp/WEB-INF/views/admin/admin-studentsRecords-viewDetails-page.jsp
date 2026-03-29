<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile - ${user.firstName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {--maroon: #922b3e; --bg-light: #f8f9fa;}
        body {background: #f4f7f6; padding: 40px 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;}
        .profile-card {border-radius: 20px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; background: white;}
        .profile-header {background: var(--maroon); color: white; padding: 40px 30px; text-align: center; position: relative;}
        .profile-img {width: 140px; height: 140px; border-radius: 50%; border: 5px solid rgba(255,255,255,0.3); object-fit: cover; margin-bottom: 15px; background: white;}
        .section-title {border-bottom: 2px solid #f1f1f1; padding-bottom: 10px; margin-bottom: 20px; color: var(--maroon); font-weight: 700; display: flex; align-items: center; gap: 10px;}
        .info-label {color: #999; font-size: 0.75rem; text-transform: uppercase; font-weight: 700; margin-bottom: 2px;}
        .info-value {color: #333; font-weight: 600; margin-bottom: 15px; font-size: 1rem;}
        .doc-card {background: var(--bg-light); border-radius: 12px; padding: 15px; border: 1px dashed #ddd; transition: 0.3s;}
        .doc-card:hover {border-color: var(--maroon); background: #fff;}
        .divider {height: 1px; background: #eee; margin: 30px 0;}
        .badge-status {font-size: 0.85rem; padding: 6px 16px; border-radius: 50px; background: rgba(255,255,255,0.2); color: white; border: 1px solid rgba(255,255,255,0.4);}
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-11">
            <div class="card profile-card">
                <div class="profile-header">
                    <img src="${user.photosImagePath}" class="profile-img shadow" onerror="this.src='${pageContext.request.contextPath}/user-photos/default-avatar.jpg';">
                    <h2 class="mb-1">${user.firstName} ${user.lastName}</h2>
                    <p class="mb-3 opacity-75">Student ID: #SR-${user.id} | ${user.email}</p>
                    <span class="badge-status">
                        <i class="fas fa-circle me-1 small text-warning"></i> 
                        ${not empty user.admissions ? user.admissions.status : 'Active'}
                    </span>
                </div>
                
                <div class="card-body p-4 p-md-5">
                    <div class="row">
                        <div class="col-md-4 border-end">
                            <h5 class="section-title"><i class="fas fa-user border p-2 rounded-circle"></i> Personal Info</h5>
                            
                            <p class="info-label">Full Name</p>
                            <p class="info-value">${user.firstName} ${user.lastName}</p>
                            
                            <p class="info-label">Birthdate & Age</p>
                            <p class="info-value">${user.birthdate} (${user.age} Years)</p>
                            
                            <p class="info-label">Gender</p>
                            <p class="info-value text-capitalize">${user.gender}</p>
                            
                            <p class="info-label">Contact Number</p>
                            <p class="info-value">${not empty user.admissions ? user.admissions.phone : 'N/A'}</p>

                            <p class="info-label">Address</p>
                            <p class="info-value">${user.city}, ${user.state}</p>
                        </div>

                        <div class="col-md-4 border-end ps-md-4">
                            <h5 class="section-title"><i class="fas fa-graduation-cap border p-2 rounded-circle"></i> Training</h5>
                            
                            <p class="info-label">Course Name</p>
                            <p class="info-value text-maroon">${not empty user.admissions ? user.admissions.courseName : 'Basic Karate'}</p>
                            
                            <p class="info-label">Assigned Batch</p>
                            <div class="mb-3">
        						<p class="info-value mb-0">
            						${not empty user.batch ? user.batch.batchName : 'Not Assigned'}
        						</p>
        						<small class="text-dark fw-bold d-block mt-1">
            					<i class="far fa-clock me-1"></i>
            						${not empty user.batch ? user.batch.startTime : '--:--'} - ${not empty user.batch ? user.batch.endTime : '--:--'}
        						</small>
    						</div>

							<div class="mb-3">
        						<p class="info-label">Join Date</p>
        						<p class="info-value text-dark mb-2">
            						<i class="far fa-calendar-alt me-2 text-success"></i>
            						${not empty user.admissions ? user.admissions.joinDate : 'N/A'}
        						</p>
        
        						<p class="info-label">Expected End Date</p>
        						<p class="info-value text-dark fw-bold">
            						<i class="far fa-calendar-times me-2 text-danger"></i>
            						${not empty user.admissions ? user.admissions.expiryDate : 'N/A'}
        						</p>
    						</div>
    						
    						<p class="info-label">Current Weight</p>
    						<p class="info-value text-dark">
        						<i class="fas fa-weight-hanging me-2 text-muted"></i>
        						${not empty user.admissions ? user.admissions.weight : '0'} kg
    						</p>
                        </div>

                        <div class="col-md-4 ps-md-4">
                            <h5 class="section-title"><i class="fas fa-file-alt border p-2 rounded-circle"></i> Documents</h5>
                            
                            <div class="vstack gap-3">
                                <c:choose>
                                    <%-- ચેક કરો કે જો બંને ડોક્યુમેન્ટ ખાલી હોય --%>
                                    <c:when test="${empty user.documents.idProof && empty user.documents.medicalCertificate}">
                                        <div class="text-center py-4 px-2 border rounded-3 bg-light">
                                            <i class="fas fa-folder-open fa-2x text-muted mb-2"></i>
                                            <p class="text-muted small mb-0 italic">No records uploaded</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${not empty user.documents.idProof}">
                                            <div class="doc-card d-flex align-items-center justify-content-between">
                                                <div class="d-flex align-items-center gap-3">
                                                    <i class="fas fa-id-card fa-2x text-muted"></i>
                                                    <div>
                                                        <div class="fw-bold small">Aadhar Card/ID Proof</div>
                                                        <div class="text-muted extra-small" style="font-size: 0.7rem;">Identity Proof</div>
                                                    </div>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/displayDocument?path=${user.documents.idProof}" target="_blank" class="btn btn-sm btn-maroon text-white">
                                                <i class="fas fa-eye"></i></a>
                                            </div>
                                        </c:if>

                                        <c:if test="${not empty user.documents.medicalCertificate}">
                                            <div class="doc-card d-flex align-items-center justify-content-between">
                                                <div class="d-flex align-items-center gap-3">
                                                    <i class="fas fa-file-medical fa-2x text-muted"></i>
                                                    <div>
                                                        <div class="fw-bold small">Medical Certificate</div>
                                                        <div class="text-muted small" style="font-size: 0.7rem;">Fitness Proof</div>
                                                    </div>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/displayDocument?path=${user.documents.medicalCertificate}" target="_blank" class="btn btn-sm btn-maroon text-white">
                                                <i class="fas fa-eye"></i></a>
                                            </div>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div class="divider"></div>
                    
                    <div class="d-flex justify-content-center d-print-none mb-4">
    					<a href="${pageContext.request.contextPath}/admin/studentsRecords" 
       						class="btn btn-outline-secondary px-5 py-2 rounded-pill shadow-sm border-2">
        					<i class="fas fa-arrow-left me-2"></i>Back to Records
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