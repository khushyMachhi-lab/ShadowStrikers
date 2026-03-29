<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Batch/Time - ShadowStrikers</title>
    
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
        	--maroon-dark: #5a0f14;
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
        .menu-item.logout:hover {background-color: var(--primary-dark); color: #ffffff !important;}
        
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

		.btn-maroon {background: linear-gradient(135deg, var(--maroon-dark) 0%, var(--primary-color) 100%); color: white; border: none; border-radius: 8px; transition: 0.3s;}
		.btn-maroon:hover {transform: translateY(-2px); box-shadow: 0 5px 15px rgba(146, 43, 62, 0.3); color: white;}
		.btn-outline-maroon {border: 2px solid var(--maroon); color: var(--maroon); border-radius: 8px; font-weight: 600;}
		.btn-outline-maroon:hover {background-color: var(--maroon); color: white;}
		.form-control:focus {border-color: var(--maroon); box-shadow: 0 0 0 0.25rem rgba(146, 43, 62, 0.1);}
		
		/* Modern Search Box inside Card */
		.search-box {position: relative;}
		.search-box i {position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #999;}
		.search-box .form-control {padding-left: 45px; border-radius: 10px; background: #f8f9fa; border: 1px solid #eee;}
		.search-box .form-control:focus {background: #fff; border-color: var(--primary-color); box-shadow: 0 0 0 0.25rem rgba(146, 43, 62, 0.1);}

		.text-maroon { color: var(--primary-color); }
    	
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
    		border: none; /* બોર્ડર કાઢી નાખી */
    		z-index: 1000;
    		font-weight: 600;
    		letter-spacing: 1px;
		}

		.floating-back-btn:hover {transform: translateY(-5px); background-color: #7a2434; box-shadow: 0 8px 20px rgba(146, 43, 62, 0.3); color: white !important;}
		.floating-back-btn i {font-size: 1.1rem;}
		
		.back-content i {font-size: 1.5rem; margin-bottom: 2px;}
		
		/* Filter Tabs */
		.filter-tabs {display: flex; gap: 12px; margin: 20px 0; overflow-x: auto; padding: 5px;}
		.filter-tab {padding: 8px 24px; background: white; border-radius: 50px; font-size: 0.9rem; font-weight: 600; color: var(--dark-color); cursor: pointer; transition: all 0.3s ease; border: 1px solid #eee; white-space: nowrap; box-shadow: 0 2px 4px rgba(0,0,0,0.05);}
		.filter-tab.active { background: var(--primary-gradient); color: white; border: none;}

		/* Batches Grid */
		.batches-grid {display: flex; flex-direction: column; gap: 15px; margin-top: 20px;}
		.batch-card {background: white; border-radius: 15px; padding: 15px 25px; border: 1px solid #f0f0f0; display: flex; align-items: center; justify-content: space-between; transition: all 0.3s ease; box-shadow: 0 4px 6px rgba(0,0,0,0.02);}
		.batch-card:hover {transform: translateX(10px); box-shadow: 0 8px 15px rgba(146, 43, 62, 0.1); border-color: var(--primary-color);}	
		.batch-main-info {flex: 2.5; } 
		.batch-timing-info {flex: 2; border-left: 1px solid #eee; padding-left: 20px;}
		.batch-name {font-size: 1.2rem; font-weight: 800; margin: 0; color: var(--dark-color); letter-spacing: -0.5px;}
		.batch-actions {display: flex; gap: 10px; margin-top: 20px; padding-top: 15px; border-top: 1px solid #eee;}

		/* Day Selection Styling in Modal */
		.days-text-simple {border-left: 2px solid #eee; padding-left: 12px; display: flex; align-items: center;}
		.day-btn {width: 35px; height: 35px; display: flex; align-items: center; justify-content: center; padding: 0; font-weight: 700; font-size: 0.8rem; transition: all 0.2s ease;}
		.btn-check:checked + .day-btn {background-color: var(--primary-color) !important; border-color: var(--primary-color) !important; color: white !important; box-shadow: 0 4px 8px rgba(146, 43, 62, 0.3);}
		.day-btn:hover {border-color: var(--primary-color); color: var(--primary-color);}
		
		/* Badge style adjustment for better alignment */
		.badge {text-transform: uppercase; letter-spacing: 0.5px;}		
		.heatmap-slot {width: 65px; height: 50px; margin: 4px auto; border-radius: 12px; display: flex; flex-direction: column; align-items: center; justify-content: center;}
		.active-slot {color: white; box-shadow: 0 4px 10px rgba(0,0,0,0.1);}	
		.empty-slot {background: #f1f3f5; border: 1px solid #e9ecef;}	
		.slot-time { font-size: 0.75rem; font-weight: 700; }
		.slot-cap { font-size: 0.6rem; opacity: 0.8; }

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
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="/admin/enquiries" class="menu-item">
                <i class="fas fa-question-circle"></i>
                <span>Enquiries</span>
            </a>
            <a href="/admin/admissions" class="menu-item">
                <i class="fas fa-user-plus"></i>
                <span>Admissions</span>
            </a>
            <a href="/admin/studentsRecords" class="menu-item active">
        		<i class="fas fa-users"></i> <span>Students Records</span>
    		</a>
            <a href="/admin/attendance" class="menu-item">
                <i class="fas fa-clipboard-check"></i>
                <span>Attendance</span>
            </a>
            <a href="/admin/payments" class="menu-item">
                <i class="fas fa-money-bill-wave"></i>
                <span>Payments</span>
            </a>
            <a href="/admin/tournaments" class="menu-item">
                <i class="fas fa-trophy"></i>
                <span>Tournaments</span>
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
                <h2>Batch & Timing</h2>
                <p class="text-muted">Manage student batches and daily schedules</p>
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
    	<div class="container-fluid">
    	
    	<c:if test="${not empty message}">
            <div class="alert alert-${alertType == 'success' ? 'success' : 'danger'} alert-dismissible fade show shadow-sm border-0 mb-4" 
                 role="alert" 
                 style="border-left: 5px solid ${alertType == 'success' ? '#28a745' : '#dc3545'} !important; border-radius: 12px; background: white;">
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${alertType == 'success'}">
                            <i class="fas fa-check-circle me-3 fa-lg text-success"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-exclamation-circle me-3 fa-lg text-danger"></i>
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <strong class="text-dark">${alertType == 'success' ? 'Success!' : 'Error!'}</strong> 
                        <span class="text-muted ms-1">${message}</span>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty successMsg}">
    		<div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4" 
         		role="alert" 
         		style="border-left: 5px solid #28a745 !important; border-radius: 12px; background: white;">
        		<div class="d-flex align-items-center">
            		<i class="fas fa-check-double me-3 fa-lg text-success"></i>
            	<div>
                	<strong class="text-dark">Attendance Finalized</strong> 
                	<div class="text-muted small">${successMsg}</div>
            	</div>
        	</div>
       			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    		</div>
		</c:if>
        
        	<div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
            	<div class="card-header bg-white border-0 p-4">
                	<div class="row align-items-center g-3">
                    	<div class="col-md-6">
                        	<div class="search-box">
                            	<i class="fas fa-search"></i>
                            	<input type="text" id="batchSearch" class="form-control" placeholder="Search by batch..." onkeyup="filterBatches()">
                        	</div>
                    	</div>
                    	<div class="col-md-6 text-md-end">
                        	<div class="d-flex gap-2 justify-content-md-end">
                            	<button class="btn btn-maroon shadow-sm" data-bs-toggle="modal" data-bs-target="#createBatchModal">
                                	<i class="fas fa-plus-circle me-2"></i>Create Batch
                            	</button>
                            	<button type="button" class="btn btn-outline-maroon" data-bs-toggle="modal" data-bs-target="#calendarModal">
    								<i class="fas fa-calendar-alt"></i> Calendar View
								</button>
                        	</div>
                    	</div>
                	</div>
            	</div>
        	</div>

        	<div class="filter-tabs">
            	<div class="filter-tab active">All Batches</div>
            	<div class="filter-tab">Active</div>
            	<div class="filter-tab">Full</div>
            	<div class="filter-tab">Morning</div>
            	<div class="filter-tab">Evening</div>
        	</div>

	<div class="batches-grid">
    	<c:forEach var="batch" items="${batches}">
        	<div class="batch-card" data-status="${batch.status}">
            	<div class="batch-main-info">
    				<h4 class="batch-name mb-1">${batch.batchName}</h4>
    
    			<div class="d-flex align-items-center gap-2">
        			<span class="fw-bold" style="font-size: 0.75rem; color: ${batch.batchType == 'Personal' ? '#922b3e' : '#0dcaf0'};">
            			${fn:toUpperCase(batch.batchType)}
        			</span>
                	<div class="days-text-simple ps-2" style="border-left: 2px solid #eee;">
            			<c:set var="daysList" value="" />
            			<c:if test="${fn:contains(batch.trainingDays, 'Mon')}"><c:set var="daysList" value="${daysList}M-" /></c:if>
            			<c:if test="${fn:contains(batch.trainingDays, 'Tue')}"><c:set var="daysList" value="${daysList}T-" /></c:if>
            			<c:if test="${fn:contains(batch.trainingDays, 'Wed')}"><c:set var="daysList" value="${daysList}W-" /></c:if>
            			<c:if test="${fn:contains(batch.trainingDays, 'Thu')}"><c:set var="daysList" value="${daysList}T-" /></c:if>
            			<c:if test="${fn:contains(batch.trainingDays, 'Fri')}"><c:set var="daysList" value="${daysList}F-" /></c:if>
            			<c:if test="${fn:contains(batch.trainingDays, 'Sat')}"><c:set var="daysList" value="${daysList}S-" /></c:if>
            			<c:if test="${fn:contains(batch.trainingDays, 'Sun')}"><c:set var="daysList" value="${daysList}S-" /></c:if>
            
            			<span class="text-muted small fw-bold">
                			${fn:length(daysList) > 0 ? fn:substring(daysList, 0, fn:length(daysList) - 1) : 'No days set'}
            			</span>
        			</div>
    			</div>
            </div>
            
            <div class="batch-timing-info">
                <div class="d-flex align-items-center mb-1">
                    <i class="fas fa-clock text-maroon me-2"></i>
                    <span class="small fw-bold">${batch.startTime} - ${batch.endTime}</span>
                </div>
                <div class="d-flex align-items-center">
                    <i class="fas fa-user-tie text-muted me-2"></i>
                    <span class="small text-muted">${batch.instructor}</span>
                </div>
            </div>
            
            <div class="batch-actions-horizontal">
    			<c:if test="${not empty batch.meetLink}">
        
        			<%-- ૧. Join Class બટન (હંમેશા અથવા શરત મુજબ) --%>
        			<c:if test="${!batch.live}">
            			<button type="button" class="btn btn-sm btn-success rounded-pill px-3" 
                    			onclick="handleClassStatus('${batch.id}', '${batch.meetLink}', true)">
                			<i class="fas fa-video me-1"></i> Join Class
            			</button>
        			</c:if>

        			<%-- ૨. Finish Class બટન (માત્ર જો ક્લાસ લાઈવ હોય તો જ) --%>
        			<c:if test="${batch.live}">
            			<form onsubmit="finalizeAttendance(event, '${batch.id}')" style="display:inline;">
    						<button type="submit" class="btn btn-sm btn-primary rounded-pill px-3">
        						<i class="fas fa-check-double"></i> Finish Class
    						</button>
						</form>
            
            			<%-- લાઈવ હોય ત્યારે ફરીથી મીટિંગમાં જવા માટે --%>
            			<a href="${batch.meetLink}" target="_blank" class="btn btn-sm btn-outline-success rounded-pill px-2">
                			<i class="fas fa-external-link-alt"></i>
            			</a>
        			</c:if>
    			</c:if>

    			<%-- Delete Button --%>
    			<a href="javascript:void(0)" onclick="confirmBatchDelete('${batch.id}')" class="btn btn-sm btn-outline-danger rounded-pill">
    				<i class="fas fa-trash-alt"></i>
				</a>
			</div>
        </div>
    </c:forEach>
</div>
</div>
</div>
</div>

	<div class="modal fade" id="calendarModal" tabindex="-1" aria-labelledby="calendarModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header text-white" style="background: var(--primary-gradient);">
                <h5 class="modal-title fw-bold" id="calendarModalLabel">
                    <i class="fas fa-calendar-alt me-2"></i>Weekly Batch Schedule
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-4" style="background: #f8f9fa;">
                <div class="heatmap-container bg-white shadow-sm rounded-4 p-4 overflow-auto">
                    <h4 class="text-center fw-bold mb-4">Weekly Capacity Overview</h4>
                    <table class="table table-borderless text-center align-middle">
                        <thead>
                            <tr class="text-muted small text-uppercase">
                                <th style="width: 80px;">Time</th>
                                <th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th><th>Sun</th>
                            </tr>
                        </thead>
                        <tbody>
							<c:set var="processedTimes" value="" />
                            <c:forEach var="timeSource" items="${batches}">
                                <c:if test="${!fn:contains(processedTimes, timeSource.startTime)}">
                                    <c:set var="processedTimes" value="${processedTimes}|${timeSource.startTime}" />
                                    <tr>
                                        <td class="fw-bold text-dark" style="min-width: 100px; font-size: 0.9rem;">
    										<fmt:parseDate value="${timeSource.startTime}" pattern="HH:mm" var="parsedTime" />
    										<fmt:formatDate value="${parsedTime}" pattern="hh:mm a" />
										</td>
                                        <c:forEach var="day" items="Mon,Tue,Wed,Thu,Fri,Sat,Sun">
                                            <td>
                                                <c:set var="batchFound" value="false" />
                                                <c:forEach var="b" items="${batches}">
                                                    <c:if test="${b.startTime == timeSource.startTime && fn:contains(b.trainingDays, day)}">
                                                        <div class="heatmap-slot active-slot" 
                                                             style="background: ${b.batchType == 'Personal' ? '#922b3e' : '#2ecc71'};">
                                                            <span class="slot-time">${b.startTime}</span>
                                                            <span class="slot-cap">${b.batchType == 'Personal' ? '1/1' : '18/25'}</span>
                                                        </div>
                                                        <c:set var="batchFound" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${!batchFound}">
                                                    <div class="heatmap-slot empty-slot"></div>
                                                </c:if>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
	
	
	<a href="${pageContext.request.contextPath}/admin/studentsRecords" class="floating-back-btn shadow" title="Back to Student Records">
    	<i class="fas fa-arrow-left"></i>
    	<span>BACK</span>
	</a>
	
	<div class="modal fade" id="createBatchModal" tabindex="-1" aria-labelledby="createBatchModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header text-white border-0" style="background: var(--primary-gradient);">
                    <h5 class="modal-title fw-bold" id="createBatchModalLabel">
                        <i class="fas fa-plus-circle me-2"></i>Create New Batch
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form action="${pageContext.request.contextPath}/admin/studentsRecords/batchTime/save" method="post">
                    <div class="modal-body p-4">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Batch Name</label>
                            <input type="text" name="batchName" class="form-control" placeholder="e.g. Evening Karate" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Start Time</label>
                                <input type="time" name="startTime" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">End Time</label>
                                <input type="time" name="endTime" class="form-control" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Instructor Name</label>
                            <input type="text" name="instructor" class="form-control" placeholder="Enter name" required>
                        </div>
                        
                        <div class="row">
    						<div class="col-md-6 mb-3">
        						<label class="form-label fw-bold">Batch Type</label>
        						<select name="batchType" class="form-select" id="batchTypeSelect" onchange="toggleCapacity()">
            						<option value="Group">Group Batch</option>
            						<option value="Personal">Personal Training (1-on-1)</option>
        						</select>
    						</div>
    						<div class="col-md-6 mb-3" id="capacityField">
        						<label class="form-label fw-bold">Max Capacity</label>
        						<input type="number" name="totalCapacity" class="form-control" placeholder="e.g. 20" id="batchCapacity">
    						</div>
						</div>
                        
                        <div class="mb-3">
    						<label class="form-label fw-bold d-block">Training Days</label>
    						<div class="d-flex flex-wrap gap-2">
        						<div class="day-selector">
            						<input type="checkbox" name="days" value="Mon" id="mon" class="btn-check">
            						<label class="btn btn-outline-secondary btn-sm rounded-circle day-btn" for="mon">M</label>
        						</div>
        						<div class="day-selector">
            						<input type="checkbox" name="days" value="Tue" id="tue" class="btn-check">
            						<label class="btn btn-outline-secondary btn-sm rounded-circle day-btn" for="tue">T</label>
        						</div>
        						<div class="day-selector">
            						<input type="checkbox" name="days" value="Wed" id="wed" class="btn-check">
            						<label class="btn btn-outline-secondary btn-sm rounded-circle day-btn" for="wed">W</label>
        						</div>
        						<div class="day-selector">
            						<input type="checkbox" name="days" value="Thu" id="thu" class="btn-check">
            						<label class="btn btn-outline-secondary btn-sm rounded-circle day-btn" for="thu">T</label>
        						</div>
        						<div class="day-selector">
            						<input type="checkbox" name="days" value="Fri" id="fri" class="btn-check">
            						<label class="btn btn-outline-secondary btn-sm rounded-circle day-btn" for="fri">F</label>
        						</div>
        						<div class="day-selector">
            						<input type="checkbox" name="days" value="Sat" id="sat" class="btn-check">
            						<label class="btn btn-outline-secondary btn-sm rounded-circle day-btn" for="sat">S</label>
        						</div>
        						<div class="day-selector">
            						<input type="checkbox" name="days" value="Sun" id="sun" class="btn-check">
            						<label class="btn btn-outline-secondary btn-sm rounded-circle day-btn" for="sun">S</label>
        						</div>
    						</div>
    						<small class="text-muted mt-1 d-block">Select all days that apply for this batch.</small>
						</div>
                        
                        <div class="mb-0">
                            <label class="form-label fw-bold">Status</label>
                            <select name="status" class="form-select">
                                <option value="Active">Active</option>
                                <option value="Full">Full</option>
                                <option value="Deactive">De-Active</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer border-0 p-4 pt-0">
                        <button type="button" class="btn btn-light px-4 rounded-pill" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-maroon px-4 rounded-pill">Save Batch</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="deleteBatchModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 400px;">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-body p-4 text-center">
                <div class="text-danger mb-3">
                    <i class="fas fa-exclamation-circle fa-4x"></i>
                </div>
                <h4 class="fw-bold text-dark">Are you sure?</h4>
                <p class="text-muted">Do you really want to delete this batch? This action cannot be undone.</p>
                
                <div class="d-flex gap-2 justify-content-center mt-4">
                    <button type="button" class="btn btn-light px-4 rounded-pill" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="finalDeleteBtn" class="btn btn-danger px-4 rounded-pill">Delete Now</a>
                </div>
            </div>
        </div>
    </div>
</div>

	<div class="modal fade" id="finishClassModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 450px;">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-body p-4 text-center">
                <div class="text-primary mb-3">
                    <i class="fas fa-check-double fa-4x" style="color: var(--primary-color);"></i>
                </div>
                <h4 class="fw-bold text-dark">Finalize Attendance?</h4>
                <p class="text-muted">Do you want to finalize today's attendance and close the class for <b>ShadowStrikers</b>?</p>
                
                <div class="d-flex gap-2 justify-content-center mt-4">
                    <button type="button" class="btn btn-light px-4 rounded-pill" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" id="confirmFinishBtn" class="btn btn-maroon px-4 rounded-pill">Yes, Finalize</button>
                </div>
            </div>
        </div>
    </div>
</div>
    
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
    <script>
    // ૧. મુખ્ય ફિલ્ટર ફંક્શન
    function applyAllFilters() {
        const searchTerm = document.getElementById("batchSearch").value.toLowerCase().trim();
        const activeTabElement = document.querySelector('.filter-tab.active');
        const activeTab = activeTabElement ? activeTabElement.innerText.toLowerCase().trim() : 'all batches';
        const cards = document.querySelectorAll(".batch-card");

        cards.forEach(card => {
            const batchName = card.querySelector(".batch-name").innerText.toLowerCase();
            const status = (card.getAttribute('data-status') || "").toLowerCase().trim();
            const timeStr = card.querySelector('.batch-timing-info span').innerText.toUpperCase();

            const matchesSearch = batchName.includes(searchTerm);

            let matchesTab = false;
            if (activeTab === 'all batches') {
                matchesTab = true;
            } else if (activeTab === 'active' || activeTab === 'full') {
                matchesTab = (status === activeTab);
            } else if (activeTab === 'morning') {
                matchesTab = timeStr.includes('AM');
            } else if (activeTab === 'evening') {
                matchesTab = timeStr.includes('PM');
            }

            if (matchesSearch && matchesTab) {
                card.style.setProperty('display', 'flex', 'important');
            } else {
                card.style.setProperty('display', 'none', 'important');
            }
        });
    }

    // ૨. સર્ચ અને ટેબ ઇવેન્ટ્સ
    function filterBatches() { applyAllFilters(); }

    document.querySelectorAll('.filter-tab').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            applyAllFilters();
        });
    });

    // ૩. હાઈ-લેવલ ક્લાસ સ્ટેટસ હેન્ડલર (Join/Start Class)
    function handleClassStatus(batchId, meetLink, isStarting) {
        // બટન પર લોડિંગ બતાવવા માટે
        const btn = event.currentTarget;
        const originalContent = btn.innerHTML;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Starting...';
        btn.disabled = true;

        fetch(`${pageContext.request.contextPath}/admin/studentsRecords/batchTime/toggle-class?batchId=` + batchId + '&status=' + isStarting, {
            method: 'POST'
        }).then(response => {
            if (response.ok) {
                if (isStarting) {
                    window.open(meetLink, '_blank');
                    // સક્સેસ મેસેજ બતાવ્યા પછી રિલોડ
                    setTimeout(() => location.reload(), 1000);
                }
            } else {
                alert("Could not start the class. Please try again.");
                btn.innerHTML = originalContent;
                btn.disabled = false;
            }
        }).catch(err => {
            console.error(err);
            btn.innerHTML = originalContent;
            btn.disabled = false;
        });
    }

    // ૪. ફિનીશ ક્લાસ એટેન્ડન્સ લોજિક (AJAX દ્વારા)
    // આ ફંક્શન તમે Finish Class ફોર્મમાં 'onsubmit' પર મૂકી શકો છો
    let currentBatchId = null; // ગ્લોબલ વેરિયેબલ બેચ આઈડી સ્ટોર કરવા માટે

	function finalizeAttendance(event, batchId) {
    	event.preventDefault(); // ફોર્મ સબમિટ થતું અટકાવો
    	currentBatchId = batchId; // આઈડી સેવ કરો
    
    	// બુટસ્ટ્રેપ મોડલ શો કરો
    	const myModal = new bootstrap.Modal(document.getElementById('finishClassModal'));
    	myModal.show();
	}

	// જ્યારે મોડલના 'Yes, Finalize' બટન પર ક્લિક થાય ત્યારે
	document.getElementById('confirmFinishBtn').addEventListener('click', function() {
    	const btn = this;
    	const originalText = btn.innerHTML;
    
    	btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Processing...';
    	btn.disabled = true;

    	fetch(`${pageContext.request.contextPath}/admin/attendance/finish-class?batchId=` + currentBatchId, {
        	method: 'POST'
    	}).then(response => {
        	if(response.ok) {
            	location.reload(); // એટેન્ડન્સ ફાઇનલ થયા પછી પેજ રિલોડ થશે
        	} else {
            	alert("Error finalizing attendance.");
            	btn.disabled = false;
            	btn.innerHTML = originalText;
        	}
    	}).catch(err => {
        	console.error(err);
        	btn.disabled = false;
        	btn.innerHTML = originalText;
    	});
	});

    // ૫. પર્સનલ ટ્રેનિંગ કેપેસિટી લોજિક
    function toggleCapacity() {
        const type = document.getElementById("batchTypeSelect").value;
        const capInput = document.getElementById("batchCapacity");
        if (type === "Personal") {
            capInput.value = 1;
            capInput.readOnly = true;
            capInput.style.backgroundColor = "#e9ecef";
        } else {
            capInput.value = "";
            capInput.readOnly = false;
            capInput.style.backgroundColor = "#ffffff";
            capInput.placeholder = "e.g. 20";
        }
    }

    // ૬. ડિલીટ કન્ફર્મ
    function confirmBatchDelete(batchId) {
        const deleteUrl = "${pageContext.request.contextPath}/admin/studentsRecords/batchTime/delete/" + batchId;
        document.getElementById('finalDeleteBtn').setAttribute('href', deleteUrl);
        new bootstrap.Modal(document.getElementById('deleteBatchModal')).show();
    }

    // ૭. એલર્ટ ઓટો-હાઇડ
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(() => {
            $('.alert').fadeOut('slow', function() {
                $(this).remove();
            });
        }, 4000);
    });
</script>
</body>
</html>