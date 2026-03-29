<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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

        /* Create a spacious header section */
		.dashboard-header-wrapper {background: white; padding: 30px; border-radius: 20px; margin-bottom: 30px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.05);}
        
        /* Ensure the header row has breathing room */
		.main-content .d-flex.justify-content-between {margin-bottom: 2rem !important; padding-bottom: 1rem; border-bottom: 1px solid #e9ecef;}
        
        /* Stats Cards */
        .stat-card { background: white; border-radius: 15px; padding: 20px; border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.05); transition: 0.3s;}
        .stat-card:hover { transform: translateY(-5px);}
        .icon-box { width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 15px;}
        .insights-card {border-left: 6px solid var(--primary-color) !important; overflow: hidden; position: relative;}
		.quote-box {background: #fff5f6; border: 1px dashed var(--primary-color); border-radius: 10px; padding: 15px; position: relative; z-index: 1;}
		.watermark-icon {position: absolute; right: -10px; bottom: -10px; font-size: 5rem; color: rgba(146, 43, 62, 0.05); transform: rotate(-15deg); z-index: 0;}
		.x-small {font-size: 0.75rem;}
		.fw-medium {font-weight: 500;}
        
    	.btn-enroll-new {
        	background: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	color: white !important;
        	padding: 12px 25px;
        	border-radius: 30px;
        	font-weight: 700;
        	text-decoration: none;
        	display: inline-block;
        	transition: all 0.3s ease;
        	box-shadow: 0 5px 15px rgba(146, 43, 62, 0.3);
        	border: none;
    	}

    	.btn-enroll-new:hover {transform: translateY(-3px); box-shadow: 0 8px 20px rgba(146, 43, 62, 0.5); color: white;}
    	.btn-enroll-new i {font-size: 1.1rem; vertical-align: middle;}

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
            <a href="/student/dashboard" class="menu-item active">
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
        <div class="dashboard-header-wrapper">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="fw-bold">Welcome Back, ${student.firstName}!</h2>
                    <p class="text-muted mb-0">Keep training and stay sharp.</p>
                </div>

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
        
        <c:if test="${student.documents.status == 'Rejected'}">
    		<div class="alert shadow-sm border-0 d-flex align-items-center fade show mb-4" role="alert" 
         		 style="background: #fff5f5; border-left: 5px solid #dc3545 !important; border-radius: 15px; padding: 20px;">
        		<div class="bg-danger text-white d-flex align-items-center justify-content-center me-3 shadow-sm" 
             		 style="width: 50px; height: 50px; border-radius: 12px; flex-shrink: 0;">
            		<i class="fas fa-exclamation-circle fa-lg"></i>
        		</div>
        		<div class="flex-grow-1">
            		<div class="d-flex justify-content-between align-items-center">
                		<h5 class="fw-bold mb-1" style="color: #922b3e;">Action Required: Documents Rejected</h5>
                		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            		</div>
            		<p class="mb-2 text-dark">
                		Your submitted documents have been rejected by the administrator. 
                		<span class="badge bg-danger-subtle text-danger border border-danger-subtle ms-1">
                    		Reason: ${student.documents.remarks}
                		</span>
            		</p>
            		<a href="${pageContext.request.contextPath}/student/myProfile" class="btn btn-danger btn-sm rounded-pill px-4 fw-bold">
                		<i class="fas fa-upload me-2"></i>Re-upload Documents
            		</a>
        		</div>
    		</div>
		</c:if>
        
        <c:if test="${param.success eq 'Enrolled'}">
    		<div class="alert alert-success alert-dismissible fade show" role="alert">
        		
        		<strong>Congratulations!</strong> You have successfully enrolled in the course.
        		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    		</div>
		</c:if>
        
        <%-- SMART ENROLLMENT SECTION --%>
		<div class="card mb-4 border-0 shadow-sm overflow-hidden" style="border-radius: 15px; background: white;">
    		<c:choose>
        		<%-- CASE 1: Student is ALREADY ENROLLED --%>
        		<c:when test="${not empty student.admissions.courseName}">
            		<div class="row g-0 align-items-center">
                		<div class="col-auto p-4 bg-success text-white d-none d-md-block" style="opacity: 0.9;">
                    		<i class="fas fa-user-check fa-2x"></i>
                		</div>
                	<div class="col p-4">
                    	<h5 class="fw-bold mb-1" style="color: var(--primary-color);">My Active Program</h5>
                    	<p class="text-muted mb-1">You are currently training in <span class="badge bg-dark">${student.admissions.courseName}</span></p>
                    	<div class="d-flex align-items-center">
                        	<i class="far fa-calendar-alt text-danger me-2"></i>
                        	<small class="text-danger fw-bold">
    							Valid Until: 
    							<c:choose>
        							<c:when test="${not empty student.admissions.expiryDate}">
            							<fmt:parseDate value="${student.admissions.expiryDate}" pattern="yyyy-MM-dd" var="parsedExpiryDate" type="date" />
            							<fmt:formatDate value="${parsedExpiryDate}" pattern="dd MMM, yyyy" />
        							</c:when>
        							<c:otherwise>N/A</c:otherwise>
    							</c:choose>
							</small>
                    	</div>
                	</div>
                	<div class="col-auto p-4">
                    	<a href="${pageContext.request.contextPath}/courses" class="btn btn-outline-secondary btn-sm rounded-pill">
                        	Explore Other Courses
                    	</a>
                	</div>
            	</div>
        	</c:when>

        	<%-- CASE 2: Student is NOT ENROLLED (New or Expired) --%>
        	<c:otherwise>
            	<div class="row g-0 align-items-center">
                	<div class="col-auto p-4 bg-light d-none d-md-block">
                    	<i class="fas fa-user-plus fa-2x" style="color: var(--primary-color);"></i>
                	</div>
                	<div class="col p-4 border-end">
                    	<h5 class="fw-bold mb-1" style="color: var(--primary-color);">Level Up Your Skills!</h5>
                    	<p class="text-muted small mb-0">Select a program to start your martial arts journey.</p>
                	</div>
                	<div class="col-md-7 p-4">
                    	<form action="${pageContext.request.contextPath}/student/enrollCourse" method="post" class="row g-2">
                        	<div class="col-8">
                            	<select name="courseName" class="form-select border-2" required>
                                	<option value="" selected disabled>-- Choose a Program --</option>
                                	<option value="Kick-Boxing">Kick-Boxing (3 Months)</option>
                                	<option value="Mixed Martial Arts (MMA)">Mixed Martial Arts (MMA) (6 Months)</option>
                                	<option value="Self Defense">Self Defense (3 Months)</option>
                                	<option value="Stick">Stick (2 Months)</option>
                                	<option value="Tonfa">Tonfa (4 Months)</option>
                                	<option value="Betan">Betan (3 Months)</option>
                                	<option value="Women's Self-Defense">Women's Self-Defense (2 Months)</option>
                                	<option value="Personal Training (Any Technique)">Personal Training (Any Technique) (4 Months)</option>
                            	</select>
                        	</div>
                        	<div class="col-4">
                            	<button type="submit" class="btn btn-enroll-new w-100 py-2 shadow-sm">
                                	Enroll Now
                            	</button>
                        	</div>
                    	</form>
                	</div>
            		</div>
        		</c:otherwise>
    		</c:choose>
		</div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="icon-box bg-primary text-white"><i class="fas fa-user-check"></i></div>
                    <h6 class="text-muted">Attendance</h6>
                    <h3 class="fw-bold">${attendancePercentage}%</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="icon-box bg-info text-white"><i class="fas fa-clock"></i></div>
                    <h6 class="text-muted">Next Batch</h6>
                    <h3 class="fw-bold">
            			<c:choose>
                			<c:when test="${not empty student.batch}">
                    			${student.batch.startTime} 
                			</c:when>
                			<c:otherwise>
                    			Not Assigned
                			</c:otherwise>
            			</c:choose>
        			</h3>
        			<c:if test="${not empty student.batch}">
            			<small class="text-muted">${student.batch.batchName}</small>
        			</c:if>
                </div>
            </div>

            <div class="col-md-6">
                <div class="stat-card h-100 insights-card">
                	<i class="fas fa-fist-raised watermark-icon"></i>
                	
                	<div class="position-relative" style="z-index: 2;">
                    	<h5 class="fw-bold mb-4" style="color: var(--primary-color);">
                			<i class="fas fa-lightbulb me-2 text-warning"></i>Daily Dojo Insights
            			</h5>
                    	<div class="mb-4">
                			<h6 class="text-uppercase fw-bold text-muted x-small mb-2" style="letter-spacing: 1px;">Warrior's Wisdom</h6>
                			<div class="quote-box">
                    			<p class="mb-0 fw-medium" style="color: #5a0f14; font-style: italic; line-height: 1.6;">
                        			"The more you sweat in training, the less you bleed in combat."
                    			</p>
                			</div>
            			</div>
            			
                    	<hr class="opacity-10">
            			<div class="mt-3">
                			<div class="d-flex align-items-center mb-2">
                    			<span class="badge rounded-pill bg-dark me-2">Sensei's Tip</span>
                			</div>
                			<p class="small text-secondary mb-0">
                    			<strong>Focus on your breathing during high kicks.</strong> 
                    					Exhale sharply at the point of impact to generate more power.
                			</p>
            			</div>
                	</div>
            	</div>
        	</div>
		</div>
	</div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>