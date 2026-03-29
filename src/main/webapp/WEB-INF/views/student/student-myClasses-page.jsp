<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Classes - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
        .page-content {padding: 40px;}

        /* No Batch Assigned Message */
        .no-batch-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 500px;
            text-align: center;
        }

        .no-batch-icon {
            width: 150px;
            height: 150px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 4rem;
            margin-bottom: 30px;
            box-shadow: 0 8px 30px rgba(146, 43, 62, 0.4);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {transform: scale(1); box-shadow: 0 8px 30px rgba(146, 43, 62, 0.4);}
            50% {transform: scale(1.05); box-shadow: 0 8px 30px rgba(146, 43, 62, 0.6), 0 0 0 20px rgba(146, 43, 62, 0);}
        }

        .no-batch-title {font-size: 2rem; font-weight: 900; color: var(--dark-color); margin-bottom: 15px;}
        .no-batch-message {font-size: 1.1rem; color: #666; max-width: 600px; line-height: 1.8; margin-bottom: 30px;}

        .contact-admin-btn {
            background: var(--primary-gradient);
            color: white;
            padding: 15px 35px;
            border-radius: 50px;
            border: none;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(146, 43, 62, 0.4);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .contact-admin-btn:hover {transform: translateY(-3px); box-shadow: 0 12px 30px rgba(146, 43, 62, 0.6); color: white;}
        
        /* Batch Card */
        .batch-card {background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.1); transition: all 0.4s ease; border: 3px solid transparent;}
        .batch-card:hover {transform: translateY(-5px); box-shadow: 0 15px 50px rgba(0,0,0,0.15); border-color: rgba(146, 43, 62, 0.3);}
        .batch-header {background: var(--primary-gradient); padding: 40px 35px; color: white; position: relative; overflow: hidden;}
        .batch-header::before {content: ''; position: absolute; top: -50%; right: -20%; width: 300px; height: 300px; background: rgba(255,255,255,0.1); border-radius: 50%;}
        .batch-name {font-size: 2rem; font-weight: 900; margin-bottom: 10px; position: relative; z-index: 1;}
        .batch-subtitle {font-size: 1.1rem; opacity: 0.95; position: relative; z-index: 1;}
        .batch-body {padding: 35px;}
        .batch-content-wrapper {display: flex; justify-content: space-between; align-items: center; gap: 20px; padding-top: 20px; grid-template-columns: repeat(2, 1fr); flex: 1;}

        .info-grid {display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px; margin-bottom: 30px;}
        .info-item {display: flex; align-items: center; gap: 15px; padding: 20px; background: #f8f9fa; border-radius: 12px; transition: all 0.3s ease; border-left: 4px solid transparent;}
        .info-item:hover {background: #fff5f7; transform: translateX(5px); border-left-color: var(--accent-color); box-shadow: 0 4px 12px rgba(146, 43, 62, 0.1);}
        .info-icon {width: 50px; height: 50px; background: var(--primary-gradient); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.3rem; flex-shrink: 0; box-shadow: 0 4px 12px rgba(146, 43, 62, 0.3);}
        .info-content {flex: 1;}
        .info-label {font-size: 0.8rem; color: #666; text-transform: uppercase; font-weight: 700; margin-bottom: 5px; letter-spacing: 0.5px;}
        .info-value {font-size: 1.1rem; font-weight: 700; color: var(--dark-color);}

        /* Action Buttons */
        .action-container {flex-shrink: 0; min-width: 250px; display: flex; justify-content: flex-end;}
        .action-buttons {display: grid; grid-template-columns: 1fr 1fr; gap: 20px; padding-top: 30px; border-top: 2px solid #f0f0f0;}
        
        .btn-action {
        	padding: 20px 30px;
        	border-radius: 15px; 
        	border: none; 
        	font-weight: 700; 
        	font-size: 1.1rem; 
        	cursor: pointer; 
        	transition: all 0.3s ease; 
        	display: flex; 
        	align-items: center; 
        	justify-content: center; 
        	gap: 12px; 
        	text-decoration: none; 
        	width: 100%;
        	max-width: 250px;
    		height: fit-content;
    	}
    	
        .btn-join-meet {background: linear-gradient(135deg, var(--success-color) 0%, #20c997 100%); color: white; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3); border: 2px solid transparent; transition: all 0.3s ease;}       
        .btn-disabled {background: #e0e0e0 !important; color: #888888 !important; border: 2px solid #cccccc !important; cursor: not-allowed; box-shadow: none !important; transform: none !important;}
        .btn-join-meet:hover {transform: translateY(-3px); box-shadow: 0 10px 30px rgba(40, 167, 69, 0.5); color: white; border: 2px solid #ff0000 !important; background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);}

        /* Live Class Indicator */
        .live-indicator {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.2);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 700;
            margin-top: 15px;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(10px);
        }

        .live-dot {width: 10px; height: 10px; background: #ff4444; border-radius: 50%; animation: blink 1.5s ease-in-out infinite; box-shadow: 0 0 10px #ff4444;}
        @keyframes blink {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.3; transform: scale(0.8); }
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {left: -280px;}
            .sidebar.active {left: 0;}
            .main-content {margin-left: 0;}
            .sidebar-toggle {display: flex; align-items: center; justify-content: center;}
            .info-grid {grid-template-columns: 1fr;}
            .action-buttons {grid-template-columns: 1fr;}
            .page-content {padding: 25px 15px;}
            .batch-content-wrapper {flex-direction: column; align-items: stretch;}
    		.action-container {justify-content: center;}
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
           	<a href="/student/myClasses" class="menu-item active">
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
        <div class="top-navbar">
            <div class="navbar-left">
                <h2>My Classes</h2>
                <p class="text-muted">Your assigned batch and schedule</p>
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
        
        	<c:if test="${not empty successMessage}">
        		<div class="alert alert-dismissible fade show border-0 shadow-sm rounded-4 p-4 mb-4" 
             		 style="background: linear-gradient(135deg, #fff 0%, #fdf2f4 100%); border-left: 5px solid var(--primary-color) !important;">
            	<div class="d-flex align-items-center">
                	<div class="welcome-icon-circle me-3" 
                         style="width: 50px; height: 50px; background: var(--primary-gradient); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; box-shadow: 0 4px 12px rgba(146, 43, 62, 0.2);">
                    	<i class="fas fa-hand-sparkles"></i>
                	</div>
                	<div>
                    	<h5 class="fw-bold mb-1" style="color: var(--primary-color);">Welcome to the Academy, ${student.firstName}!</h5>
                    	<p class="mb-0 text-muted">Your enrollment was successful. You can now access your training schedule and live classes below.</p>
                	</div>
                		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            	</div>
        		</div>
    		</c:if>
            
            <%-- Check if student has assigned batch --%>
            <c:choose>
                <%-- NO BATCH ASSIGNED --%>
                <c:when test="${empty student.batch}">
                    <div class="no-batch-container">
                        <div class="no-batch-icon">
                            <i class="fas fa-calendar-times"></i>
                        </div>
                        <h2 class="no-batch-title">No Batch Assigned Yet</h2>
                        <p class="no-batch-message">
                            You haven't been assigned to a batch yet. Please contact the academy administrator to get enrolled in a training batch. Once assigned, your class schedule and meeting links will appear here.
                        </p>
                        <button type="button" class="contact-admin-btn" data-bs-toggle="modal" data-bs-target="#contactAdminModal">
    						<i class="fas fa-envelope"></i>
    						   Contact Admin
						</button>
                    </div>
                </c:when>
                
                <%-- BATCH ASSIGNED --%>
                <c:otherwise>
                    <div class="batch-card">
    					<div class="batch-header">
        					<div class="batch-name">${student.batch.batchName}</div>
        					<div class="batch-subtitle">${student.batch.batchType} | ${student.batch.trainingDays}</div>
        
        					<%-- આ લાઈનથી 'Class is LIVE' ઇન્ડિકેટર દેખાશે --%>
        					<c:if test="${student.batch.live}">
            					<div class="live-indicator">
                					<span class="live-dot"></span> Class is LIVE
            					</div>
        					</c:if>
    					</div>

    				<div class="batch-body">
    					<div class="batch-content-wrapper">
        					<div class="info-grid">
            					<div class="info-item">
                					<div class="info-icon"><i class="fas fa-clock"></i></div>
                					<div class="info-content">
                    					<div class="info-label">Schedule</div>
                    					<div class="info-value">${student.batch.startTime} - ${student.batch.endTime}</div>
                					</div>
            					</div>
            
            					<div class="info-item">
                					<div class="info-icon"><i class="fas fa-user-tie"></i></div>
                					<div class="info-content">
                    					<div class="info-label">Instructor</div>
                    					<div class="info-value">${student.batch.instructor}</div>
                					</div>
            					</div>
        					</div>

        					<div class="action-container">
            					<c:choose>
                					<c:when test="${student.batch.live}">
                    					<a href="${student.batch.meetLink}" target="_blank" id="joinBtn" 
                       					   class="btn-action btn-join-meet" 
                       					   onclick="markAttendanceInWeb(${student.id}, ${student.batch.id})">
                        					<i class="fab fa-google"></i> Join Class Now
                    					</a>
                					</c:when>
                					<c:otherwise>
                    					<button class="btn-action btn-disabled" disabled 
                            					title="Waiting for Admin to start the class">
                        					<i class="fab fa-google"></i> Waiting...
                    					</button>
                					</c:otherwise>
            						</c:choose>
        					</div>
    					</div>
					</div>
				</div>
            </c:otherwise>
        </c:choose>
    </div>    
</div>
    
    <div class="modal fade" id="contactAdminModal" tabindex="-1" aria-labelledby="contactModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
            <div class="modal-header text-white" style="background: var(--primary-gradient); border-radius: 20px 20px 0 0; padding: 25px;">
                <h5 class="modal-title fw-bold" id="contactModalLabel"><i class="fas fa-headset me-2"></i> Contact Academy Admin</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <p class="text-muted mb-4">Please contact the admin via the following channels for your batch and training schedule.:</p>
                
                <div class="d-flex align-items-center mb-4 p-3 rounded-4" style="background: #e9f7ef; border: 1px solid #d4edda;">
                    <div class="icon-box me-3" style="font-size: 2rem; color: #25D366;">
                        <i class="fab fa-whatsapp"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold mb-0">WhatsApp Support</h6>
                        <a href="https://wa.me/917041551670" target="_blank" class="text-decoration-none fw-bold" style="color: #25D366;">+91 70415 51670</a>
                    </div>
                </div>

                <div class="d-flex align-items-center p-3 rounded-4" style="background: #f4f7f6; border: 1px solid #dee2e6;">
                    <div class="icon-box me-3" style="font-size: 1.8rem; color: var(--primary-color);">
                        <i class="fas fa-envelope-open-text"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold mb-0">Official Email</h6>
                        <a href="mailto:shadowStrikers@gmail.com" class="text-decoration-none fw-bold" style="color: var(--primary-color);">shadowStrikers@gmail.com</a>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 pb-4">
                <button type="button" class="btn btn-secondary px-4 rounded-pill" data-bs-toggle="modal" data-bs-target="#contactAdminModal">Close</button>
            </div>
        </div>
    </div>
	</div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    
    	function markAttendanceInWeb(studentId, batchId) {
        	// Sending data to controller by AJAX 
        	fetch('/student/myAttendance/join?studentId=' + studentId + '&batchId=' + batchId, {
            	method: 'POST'
        	})
        	.then(response => {
            	if (!response.ok) {
                	console.error("Attendance could not be marked, but joining meet...");
            	}
        	})
        	.catch(error => console.error('Error:', error));
    	}
        
    	<c:if test="${not empty student.batch}">
        setInterval(function() {
            const batchId = "${student.batch.id}";
            fetch('${pageContext.request.contextPath}/student/check-batch-status?batchId=' + batchId)
                .then(response => response.json())
                .then(isLiveNow => {
                    const hasJoinButton = document.getElementById("joinBtn") !== null;
                    if (isLiveNow !== hasJoinButton) {
                        location.reload();
                    }
                })
                .catch(err => console.error("Status Check Error:", err));
        }, 10000);
        </c:if>
        
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }
    </script>

</body>
</html>