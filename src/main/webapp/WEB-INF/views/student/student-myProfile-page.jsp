<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        :root {
            --primary-color: #922b3e; 
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	--font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        	
        /* Dashboard Specifics */
        	--accent-color: #c62b3c;
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
               
        .main-content {margin-left: var(--sidebar-width); padding: 30px;}
       
		.edit-photo-icon {
    		position: absolute;
    		top: 5px;
    		right: 5px;
    		background: white;
    		color: var(--primary-color);
    		width: 35px;
    		height: 35px;
    		border-radius: 50%;
    		display: flex;
    		align-items: center;
    		justify-content: center;
    		cursor: pointer;
    		box-shadow: 0 2px 8px rgba(0,0,0,0.2);
    		transition: all 0.3s ease;
    		border: 2px solid var(--primary-color);
    		z-index: 10;
		}
		
		.edit-photo-icon:hover {background: var(--primary-color); color: white; transform: scale(1.1);}

        /* Profile Header */
        .profile-cover {height: 200px; background: var(--primary-gradient); border-radius: 20px;}
        .profile-card {background: white; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); margin-top: -75px; padding: 30px; text-align: center;}
        .profile-img-container {position: relative; display: inline-block;}
        .profile-img {width: 150px; height: 150px; border-radius: 50%; border: 5px solid white; object-fit: cover; box-shadow: 0 5px 15px rgba(0,0,0,0.1);}

        .course-badge {
    		background: linear-gradient(135deg, #922b3e 0%, #5a0f14 100%);
    		color: #ffffff;
    		padding: 8px 20px;
    		border-radius: 50px;
    		font-size: 0.9rem;
    		font-weight: 700;
    		display: inline-flex;
    		align-items: center;
    		gap: 10px;
    		text-transform: uppercase;
    		letter-spacing: 1px;
    		border: 2px solid #ffeb3b; 
    		box-shadow: 0 4px 15px rgba(146, 43, 62, 0.4);
    		transition: all 0.3s ease;
    		cursor: default;
		}

		.course-badge:hover {transform: translateY(-2px); box-shadow: 0 6px 20px rgba(146, 43, 62, 0.6); border-color: #ffffff;}
		.course-badge i {color: #ffeb3b; font-size: 1.1rem; filter: drop-shadow(0 0 5px rgba(255, 235, 59, 0.5));}
		
        /* Information Section */
        .info-label { color: #888; font-size: 0.85rem; font-weight: 600; text-transform: uppercase; }
        .info-value { color: var(--dark-color); font-weight: 600; font-size: 1.05rem; }
        
        .detail-section {background: white; border-radius: 20px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); height: 100%;}
        
        .nav-pills .nav-link { color: #555; font-weight: 600; border-radius: 10px; padding: 10px 20px; transition: 0.3s; }
		.nav-pills .nav-link.active { background-color: var(--primary-color) !important; color: white !important; }
		.badge { font-size: 0.85rem; padding: 6px 12px; border-radius: 8px; }
        
        /* Modal Customization */
        .modal-header { background: var(--primary-color); color: white; }
        .btn-save { background: var(--primary-color); color: white; border: none; }
        .btn-save:hover { background: #7a2434; color: white; }

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
            <a href="/student/myProfile" class="menu-item active">
            	<i class="fas fa-user-graduate"></i> <span>My Profile</span>
            </a>
            <a href="/student/myClasses" class="menu-item">
            	<i class="fas fa-user-graduate"></i> <span>My Classes</span>
            </a>
            <a href="/student/myAttendance" class="menu-item">
            	<i class="fas fa-calendar-check"></i> <span>My Attendance</span>
            </a> 
            <a href="/student/myPayments" class="menu-item">
            	<i class="fas fa-wallet"></i> <span>My Payments</span>
            </a>
           
            <div class="menu-divider"></div>
                <a href="/logout" class="menu-item logout">
                	<i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                </a>
        </div>
    </div>

    <div class="main-content">
        <div class="container-fluid">
        
        <c:if test="${param.success == 'true'}">
    	<div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
        	<i class="fas fa-check-circle me-2"></i>
        	<strong>Success!</strong> Your profile has been updated.
        	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    	</div>
		</c:if>
            <div class="profile-cover"></div>

            <div class="row">
                <div class="col-lg-4">
                    <div class="profile-card">
                        <div class="profile-img-container mb-3">
                            <img src="${pageContext.request.contextPath}/user-photos/${student.photo}" class="profile-img" onerror="this.src='${pageContext.request.contextPath}/user-photos/default-avatar.jpg'">
                            <div class="rank-badge-overlay">
                                <i class="fas fa-medal"></i>
                            </div>
                            <form id="photoForm" action="/student/myProfile/updatePhoto" method="POST" enctype="multipart/form-data">
            					<input type="hidden" name="id" value="${student.id}">
            					<input type="file" id="photoInput" name="profileImage" style="display: none;" onchange="this.form.submit()">
            					<label for="photoInput" class="edit-photo-icon" title="Change Profile Photo">
                					<i class="fas fa-camera"></i>
            					</label>
        					</form>
                        </div>
                        
                        <h3 class="fw-bold mb-1">${student.firstName} ${student.lastName}</h3>
                        
                        <p class="text-muted mb-3">Student ID: #ST-${student.id}</p>
                        
                        <span class="badge course-badge px-3 py-2 rounded-pill shadow-sm fw-bold">
        					<i class="fas fa-user-ninja"></i> 
        					<c:out value="${student.admissions.courseName}" />
    					</span>
                        
                        <hr class="my-4 opacity-50">
                        
                        <div class="row text-start">
                            <div class="col-6 mb-3">
    							<p class="info-label mb-0">Join Date</p>
    							<c:choose>
        							<c:when test="${not empty student.admissions.joinDate}">
            							<fmt:parseDate value="${student.admissions.joinDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
            							<p class="info-value mb-0">
                							<fmt:formatDate value="${parsedDate}" pattern="dd MMM, yyyy" />
            							</p>
        							</c:when>
        							<c:otherwise>
            							<p class="info-value mb-0 text-muted">Not Available</p>
        							</c:otherwise>
    							</c:choose>
    						</div>
                            <div class="col-6 mb-3">
                                <p class="info-label mb-0">Age</p>
                                <p class="info-value mb-0">${student.age > 0 ? student.age.toString().concat(' Years') : 'N/A'}</p>
                            </div>
                        </div>
                        
                        <button class="btn btn-outline-dark btn-sm w-100 mb-2" data-bs-toggle="modal" data-bs-target="#editModal">
                            <i class="fas fa-edit me-2"></i>Add Personal Info
                        </button>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="detail-section mt-4 mt-lg-0">
                        <ul class="nav nav-pills mb-4" id="pills-tab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="pills-personal-tab" data-bs-toggle="pill" data-bs-target="#pills-personal" type="button">Personal Info</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pills-martial-tab" data-bs-toggle="pill" data-bs-target="#pills-martial" type="button">Martial Arts</button>
                            </li>
                            <li class="nav-item" role="presentation">
    							<button class="nav-link" id="pills-documents-tab" data-bs-toggle="pill" data-bs-target="#pills-documents" type="button">Documents</button>
							</li>
                        </ul>
                        
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-personal">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label class="info-label">Full Name</label>
                                        <p class="info-value border-bottom pb-2">${student.firstName} ${student.lastName}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="info-label">Email Address</label>
                                        <p class="info-value border-bottom pb-2">${student.email}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="info-label">Phone Number</label>
                                        <p class="info-value border-bottom pb-2 text-primary">
    										${empty student.admissions.phone ? '<span class="text-muted">Not Added</span>' : student.admissions.phone}
										</p>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="info-label">Gender</label>
                                        <p class="info-value border-bottom pb-2">${student.gender}</p>
                                    </div>
                                    <div class="col-md-12">
    									<label class="info-label">Current Address</label>
    									<p class="info-value border-bottom pb-2">${student.address}, ${student.city}, ${student.state}</p>
									</div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="pills-martial">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label class="info-label">Current Dojo</label>
                                        <p class="info-value text-primary"><i class="fas fa-university me-2"></i>ShadowStriker Main Dojo</p>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="info-label">Instructor</label>
                                        <p class="info-value">Sensei Gunjesh Machhi</p>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="info-label">Body Weight</label>
                                       	<p class="info-value text-danger">
    										${empty student.admissions.weight ? '<span class="text-muted">Not Set</span>' : student.admissions.weight.toString().concat(' kg')}
										</p>
                                    </div>
                                    <div class="col-md-6">
    									<label class="info-label">Specialization</label>
    									<p class="info-value">${student.admissions.courseName}</p>
									</div>
                                </div>
                            </div>
                            
                            <div class="tab-pane fade" id="pills-documents">
    							<div class="row g-4">
        							<div class="col-md-12">
            							<h5 class="fw-bold mb-3"><i class="fas fa-file-alt me-2 text-primary"></i>Verification Status</h5>
            
            							<div class="table-responsive">
                							<table class="table table-bordered align-middle">
                    							<thead class="table-light">
                        							<tr>
                            							<th>Document Type</th>
                            							<th>File Name</th>
                            							<th>Status</th>
                        							</tr>
                    							</thead>
                    							<tbody>
                        							<tr>
                            							<td class="fw-bold">ID Proof (Aadhar/Voter)</td>
                            							<td>
                                							<c:choose>
                                    							<c:when test="${not empty student.documents.idProof}">
                                        							<a href="/admin/studentsRecords/documents/download/${student.documents.idProof}" class="text-decoration-none">
                                            							<i class="fas fa-file-download me-1"></i> View ID Proof
                                        							</a>
                                    							</c:when>
                                    						<c:otherwise><span class="text-muted">Not Uploaded</span></c:otherwise>
                                							</c:choose>
                            							</td>
                            							<td>
                                							<c:choose>
                                    							<c:when test="${student.documents.status == 'Verified'}">
                                        							<span class="badge bg-success"><i class="fas fa-check-circle me-1"></i> Verified</span>
                                    							</c:when>
                                    							<c:when test="${student.documents.status == 'Rejected'}">
                                        							<span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i> Rejected</span>
                                    							</c:when>
                                    							<c:otherwise>
                                        							<span class="badge bg-warning text-dark"><i class="fas fa-clock me-1"></i> Pending</span>
                                    							</c:otherwise>
                                							</c:choose>
                            							</td>
                        							</tr>

                        							<tr>
                            							<td class="fw-bold">Medical Certificate</td>
                            							<td>
                                							<c:choose>
                                    							<c:when test="${not empty student.documents.medicalCertificate}">
                                        							<a href="/admin/studentsRecords/documents/download/${student.documents.medicalCertificate}" class="text-decoration-none">
                                            							<i class="fas fa-file-medical me-1"></i> View Medical Cert.
                                        							</a>
                                    							</c:when>
                                    							<c:otherwise><span class="text-muted">Not Uploaded</span></c:otherwise>
                                							</c:choose>
                            							</td>
                            							<td>
                                							<c:choose>
                                    							<c:when test="${student.documents.status == 'Verified'}">
                                        							<span class="badge bg-success"><i class="fas fa-check-circle me-1"></i> Verified</span>
                                    							</c:when>
                                    							<c:when test="${student.documents.status == 'Rejected'}">
                                        							<span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i> Rejected</span>
                                    							</c:when>
                                    							<c:otherwise>
                                        							<span class="badge bg-warning text-dark"><i class="fas fa-clock me-1"></i> Pending</span>
                                    							</c:otherwise>
                                							</c:choose>
                            							</td>
                        							</tr>
                    							</tbody>
                							</table>
            							</div>

            							<c:if test="${student.documents.status == 'Rejected'}">
                							<div class="alert alert-danger mt-3 border-start border-5 border-danger shadow-sm">
                    							<h6 class="fw-bold mb-1"><i class="fas fa-exclamation-triangle me-2"></i> Action Required: Documents Rejected</h6>
                    							<p class="mb-0 small"><strong>Reason:</strong> ${student.documents.remarks}</p>
                    							<hr class="my-2">
                    							<p class="mb-0 small text-dark italic">Please update your documents using the "Add Personal Info" button below to avoid admission cancellation.</p>
                							</div>
            							</c:if>
        							</div>
    							</div>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Update Profile Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="/student/myProfile/updateDetails" method="POST" enctype="multipart/form-data">
                    <div class="modal-body p-4">
                        <input type="hidden" name="id" value="${student.id}">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="text" name="phone" class="form-control" placeholder="Enter phone number" value="${student.admissions.phone}">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Weight (kg)</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-weight-hanging"></i></span>
                                <input type="number" step="0.1" name="weight" class="form-control" placeholder="Enter weight in kg" value="${student.admissions.weight}">
                            </div>
                        </div>
                        
                        <div class="mb-3">
            				<label class="form-label fw-bold">ID Proof (Aadhar/Voter ID)</label>
            				<div class="input-group">
                				<span class="input-group-text"><i class="fas fa-id-card"></i></span>
                				<input type="file" name="idProofFile" class="form-control" accept=".pdf,.jpg,.png">
            				</div>
            				<small class="text-muted">Allowed: JPG, PNG, PDF (Max: 20MB)</small>
        				</div>

        				<div class="mb-3">
            				<label class="form-label fw-bold">Medical Fitness Certificate</label>
            				<div class="input-group">
                				<span class="input-group-text"><i class="fas fa-file-medical"></i></span>
                				<input type="file" name="medicalFile" class="form-control" accept=".pdf,.jpg,.png">
            				</div>
            				<small class="text-muted">Allowed: JPG, PNG, PDF (Max: 20MB)</small>
        				</div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-save px-4">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    
    	document.addEventListener('DOMContentLoaded', function() {
        	const urlParams = new URLSearchParams(window.location.search);
        
        	// Success Alert for Profile Update
        	if (urlParams.has('success')) {
            	Swal.fire({
                	title: 'Success!',
                	text: 'Your profile has been updated successfully.',
                	icon: 'success',
                	confirmButtonColor: '#922b3e', // Your Theme Maroon Color
                	timer: 3000,
                	timerProgressBar: true
            	});
        	}

        	// Error Alert for Upload Failure
        	if (urlParams.has('error')) {
            	Swal.fire({
                	title: 'Error!',
                	text: 'Something went wrong while uploading your photo.',
                	icon: 'error',
                	confirmButtonColor: '#922b3e'
            	});
        	}
    	});
    	
    	setTimeout(function() {
        	let alert = document.querySelector(".alert");
        	if(alert) {
            	alert.style.transition = "opacity 0.5s ease";
            	alert.style.opacity = "0";
            	setTimeout(() => alert.remove(), 500);
        	}
    	}, 3000);
    </script>
</body>
</html>