<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Attendance - ShadowStrikers</title>
    
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

        /* Stats Cards */
        .stats-grid {display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 40px;}
        .stat-card {background: linear-gradient(to bottom right, #ffffff, #fdfdfd); padding: 30px 25px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); transition: all 0.3s ease; border-left: 5px solid transparent; border: 1px solid rgba(0,0,0,0.05);}
        .stat-card:hover {transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.12);}
        
        .stat-card.present { border-left-color: var(--success-color); }
        .stat-card.absent { border-left-color: var(--danger-color); }
        .stat-card.percentage { border-left-color: var(--primary-color); }
        .stat-card.total { border-left-color: var(--warning-color); }

        .stat-header {display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px;}
        .stat-label {font-size: 0.85rem; color: #666; text-transform: uppercase; font-weight: 700; letter-spacing: 0.5px;}
        .stat-icon {width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; color: white;}

        .stat-card.present .stat-icon { background: linear-gradient(135deg, var(--success-color) 0%, #20c997 100%); }
        .stat-card.absent .stat-icon { background: linear-gradient(135deg, var(--danger-color) 0%, #c82333 100%); }
        .stat-card.percentage .stat-icon { background: var(--primary-gradient); }
        .stat-card.total .stat-icon { background: linear-gradient(135deg, var(--warning-color) 0%, #ff9800 100%); }

        .stat-value {font-size: 2.5rem; font-weight: 900; color: var(--dark-color); line-height: 1; margin-bottom: 5px;}
        .stat-change {font-size: 0.85rem; color: #666;}

        .stat-change.positive { color: var(--success-color); }
        .stat-change.negative { color: var(--danger-color); }

        /* Main Content Area */
        .content-grid {display: grid; grid-template-columns: 2fr 1fr; gap: 30px;}

        /* Calendar Section */
        .calendar-section {background: white; border-radius: 15px; padding: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); overflow: visible;}
        .calendar-header {display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 2px solid #f0f0f0;}
        .calendar-title {font-size: 1.5rem; font-weight: 900; color: var(--dark-color);}
        .month-selector {display: flex; align-items: center; gap: 20px;}
        
        .month-btn {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            border: none;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .month-btn:hover {background: var(--primary-gradient); color: white;}
        .current-month {font-size: 1.1rem; font-weight: 700; color: var(--dark-color); min-width: 150px; text-align: center;}

        /* Calendar Grid */
        .calendar-grid {display: grid; grid-template-columns: repeat(7, 1fr); gap: 10px; padding: 15px; text-align: center;}
        .calendar-day-header {text-align: center; font-size: 0.8rem; font-weight: 700; color: #666; text-transform: uppercase; padding: 10px 0;}
        
        .calendar-day {
        	background-color: #ffffff;
        	color: #444;
        	aspect-ratio: 1 / 1; 
        	min-height: 50px;
        	border-radius: 10px; 
        	display: flex; 
        	align-items: center; 
        	justify-content: center; 
        	font-weight: 600; 
        	font-size: 1 rem; 
        	cursor: default; 
        	transition: all 0.3s ease; 
        	position: relative; 
        	border: 2px solid #eeeeee;
        }
        
        .calendar-day.empty {background: transparent; cursor: default; pointer-events: none;}
        .calendar-day.training-day {border: 1px solid var(--primary-color); color: var(--dark-color); background-color: #ffffff;}
        .calendar-day.present {background-color: #f0fff4 !important; color: #28a745 !important; border: 2px solid #28a745 !important; box-shadow: 0 0 8px rgba(40, 167, 69, 0.2);}
        .calendar-day.absent {background-color: #fff5f5 !important; color: #dc3545 !important; border: 2px solid #dc3545 !important; box-shadow: 0 0 8px rgba(220, 53, 69, 0.2);}
        .calendar-day.today {background: #ffffff !important; color: var(--dark-color) !important; border: 2px solid #000000 !important; font-weight: 800; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); position: relative;}
        .calendar-day:not(.empty):hover {transform: scale(1.1); z-index: 10; box-shadow: 0 4px 15px rgba(0,0,0,0.2);} 
        .calendar-day.not-working {background-color: #fafafa !important; color: #d1d1d1 !important; border: 1px dashed #cccccc !important; cursor: default; pointer-events: none; opacity: 0.8;}

        /* Recent Attendance List */
        .recent-section {background: white; border-radius: 20px; padding: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.08);}
        .recent-header {font-size: 1.3rem; font-weight: 900; color: var(--dark-color); margin-bottom: 25px; padding-bottom: 15px; border-bottom: 2px solid #f0f0f0; display: flex; align-items: center; gap: 10px;}
        .recent-header i {color: var(--accent-color);}
        
        .attendance-list {display: flex; flex-direction: column; gap: 15px;}
        .attendance-item {display: flex; align-items: center; justify-content: space-between; padding: 15px; background: #f8f9fa; border-radius: 12px; transition: all 0.3s ease; border-left: 4px solid transparent;}
        .attendance-item:hover {background: white; box-shadow: 0 4px 12px rgba(0,0,0,0.08); transform: translateX(5px);}
        .attendance-item.present { border-left-color: var(--success-color); }       
        .attendance-item.progress {border-left: 4px solid #fd7e14; background: #fff4e6;}
		.attendance-status.progress {color: #fd7e14; background: #fff4e6; padding: 5px 10px; border-radius: 20px; font-size: 0.85rem; font-weight: 600;}
        .attendance-item.absent { border-left-color: var(--danger-color); }
        .attendance-date {display: flex; flex-direction: column;}

        .date-day {font-size: 1.1rem; font-weight: 800; color: var(--dark-color);}
        .date-info {font-size: 0.8rem; color: #666;}

        .attendance-status {padding: 8px 20px; border-radius: 20px; font-size: 0.85rem; font-weight: 700; text-transform: uppercase;}
        .attendance-status.present {background: #d4edda; color: var(--success-color);}
        .attendance-status.absent {background: #f8d7da; color: var(--danger-color);}

        /* Legend */
        .legend {display: flex; gap: 20px; margin-top: 25px; padding-top: 20px; border-top: 2px solid #f0f0f0; flex-wrap: wrap;}
        .legend-item {display: flex; align-items: center; gap: 8px; font-size: 0.9rem; color: #666;}
        .legend-box {width: 20px; height: 20px; border-radius: 5px; border: 2px solid;}
        .legend-box.present {background: #f0fff4; border: 2px solid #28a745;}
		.legend-box.absent {background: #fff5f5; border: 2px solid #dc3545;}
		.legend-box.today {background: #ffffff; border: 2px solid #000000;}

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {left: -280px;}
            .sidebar.active {left: 0;}
            .main-content {margin-left: 0; padding: 20px;}
            .stats-grid {grid-template-columns: repeat(2, 1fr);}
            .content-grid {grid-template-columns: 1fr;}
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
            <a href="/student/myAttendance" class="menu-item active">
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
                <h2>My Attendance</h2>
                <p class="text-muted">Tracking your discipline</p>
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
            
            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card present">
                    <div class="stat-header">
                        <div class="stat-label">Classes Attended</div>
                        <div class="stat-icon">
                            <i class="fas fa-check"></i>
                        </div>
                    </div>
                    <div class="stat-value">${presentCount}</div>
                    <div class="stat-change positive">
                        <i class="fas fa-arrow-up"></i> Over all
                    </div>
                </div>

                <div class="stat-card absent">
                    <div class="stat-header">
                        <div class="stat-label">Classes Missed</div>
                        <div class="stat-icon">
                            <i class="fas fa-times"></i> 
                        </div>
                    </div>
                    <div class="stat-value">${absentCount}</div>
                    <div class="stat-change">
                        <i class="fas fa-minus"></i> Over all
                    </div>
                </div>

                <div class="stat-card percentage">
                    <div class="stat-header">
                        <div class="stat-label">Attendance Rate</div>
                        <div class="stat-icon">
                            <i class="fas fa-percentage"></i>
                        </div>
                    </div>
                    <div class="stat-value">${attendancePercentage}%</div>
                    <div class="stat-change positive">
                        <i class="fas fa-arrow-up"></i> Overall Performance
                    </div>
                </div>

                <div class="stat-card total">
                    <div class="stat-header">
                        <div class="stat-label">Total Classes</div>
                        <div class="stat-icon">
                            <i class="fas fa-calendar"></i>
                        </div>
                    </div>
                    <div class="stat-value">${totalClassesThisMonth}</div>                    
                    <div class="stat-change">
                        Over all
                    </div>
                </div>
            </div>

            <!-- Main Content Grid -->
            <div class="content-grid">
                <!-- Calendar Section -->
                <div class="calendar-section">
                    <div class="calendar-header">
                        <h3 class="calendar-title">
                            <i class="fas fa-calendar-alt"></i> <span id="monthDisplay"></span>
                        </h3>
                        <div class="month-selector">
                            <button class="month-btn" onclick="changeMonth(-1)">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button class="month-btn" onclick="changeMonth(1)">
            					<i class="fas fa-chevron-right"></i>
        					</button>
                        </div>
                    </div>

                    <!-- Calendar Grid -->
                    <div class="calendar-grid" id="calendarGrid"></div>

                    <!-- Legend -->
                    <div class="legend">
                        <div class="legend-item">
                            <div class="legend-box present"></div>
                            <span>Present</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box absent"></div>
                            <span>Absent</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box today"></div>
                            <span>Today</span>
                        </div>
                    </div>
                </div>

                <!-- Recent Attendance -->
                <div class="recent-section">
                    <h3 class="recent-header">
                        <i class="fas fa-history"></i>
                        Recent Records
                    </h3>

                    <div class="attendance-list">
    					<c:forEach var="record" items="${attendanceRecords}">
    						<div class="attendance-item 
        						${record.status == 'Present' ? 'present' : (record.status == 'In-Progress' ? 'progress' : 'absent')}">
        
        						<div class="attendance-date">
            						<div class="date-day">${record.date}</div>
            						<div class="date-info text-capitalize">
                						<c:choose>
                    						<c:when test="${record.status == 'Present'}">Completed Session</c:when>
                    						<c:when test="${record.status == 'In-Progress'}">Session Ongoing</c:when>
                    						<c:otherwise>Missed</c:otherwise>
                						</c:choose>
            						</div>
        						</div>

        						<div class="attendance-status ${record.status == 'Present' ? 'present' : (record.status == 'In-Progress' ? 'progress' : 'absent')}">
            						<i class="fas ${record.status == 'Present' ? 'fa-check-circle' : (record.status == 'In-Progress' ? 'fa-clock' : 'fa-times-circle')}"></i> 
            							${record.status}
        						</div>
    						</div>
						</c:forEach>
    					<c:if test="${empty attendanceRecords}">
        					<p class="text-center text-muted">No attendance records found yet.</p>
    					</c:if>
					</div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    let currentDateObj = new Date(); 
    
    // JSON ડેટા લોડ કરવો
    const presentDates = JSON.parse('${presentDatesJson}' || '[]');
    const absentDates = JSON.parse('${absentDatesJson}' || '[]');
    const trainingDaysStr = "${trainingDays}";
    
    // ૧. Java માંથી આવતી joinDate અને expiryDate ને JavaScript Date ઓબ્જેક્ટમાં ફેરવો
    const joinDateStr = "${joinDate}"; 
    const expiryDateStr = "${expiryDate}";
    
    const joinDateObj = new Date(joinDateStr);
    joinDateObj.setHours(0, 0, 0, 0);

    const expiryDateObj = expiryDateStr ? new Date(expiryDateStr) : null;
    if (expiryDateObj) expiryDateObj.setHours(0, 0, 0, 0);

    function renderCalendar() {
        const grid = document.getElementById("calendarGrid");
        const display = document.getElementById("monthDisplay");
        if(!grid || !display) return; 

        const year = currentDateObj.getFullYear();
        const month = currentDateObj.getMonth();
        const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        display.innerText = months[month] + " " + year;

        let htmlContent = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat']
            .map(d => `<div class="calendar-day-header">${d}</div>`).join('');

        const firstDay = new Date(year, month, 1).getDay();
        const lastDate = new Date(year, month + 1, 0).getDate();
        
        const today = new Date(); 
        today.setHours(0, 0, 0, 0);

        // ખાલી ખાના (Previous Month days)
        for (let x = 0; x < firstDay; x++) {
            htmlContent += `<div class="calendar-day empty"></div>`;
        }

        const activeDays = trainingDaysStr.toUpperCase().split(',').map(d => d.trim());

        for (let i = 1; i <= lastDate; i++) {
            const date = new Date(year, month, i);
            date.setHours(0, 0, 0, 0); 
            
            const dayNameShort = date.toLocaleString('en-us', {weekday: 'short'}).toUpperCase();
            const dateStr = year + "-" + String(month + 1).padStart(2, '0') + "-" + String(i).padStart(2, '0');
            
            let isWorking = activeDays.some(d => dayNameShort.includes(d));
            let cls = "calendar-day"; 

            // --- મુખ્ય લોજિક (Join Date થી Expiry Date સુધી) ---
            
            // ૧. જો તારીખ એડમિશન (joinDate) પહેલાની હોય અથવા એક્સપાયરી (expiryDate) પછીની હોય
            if (date < joinDateObj || (expiryDateObj && date > expiryDateObj)) {
                cls += " not-working";
            } 
            // ૨. જો તે બેચનો વર્કિંગ ડે ન હોય
            else if (!isWorking) {
                cls += " not-working";
            } 
            // ૩. જો તે વર્કિંગ ડે હોય અને રેન્જમાં હોય (ભલે ભવિષ્યમાં હોય)
            else {
    			cls += " training-day";
    
    			// ૧. જો પ્રેઝન્ટ હોય તો ગ્રીન કલર જ રહેવો જોઈએ
    			if (presentDates.includes(dateStr)) {
        			cls += " present";
    			} 
    			// ૨. જો આજની તારીખ હોય (અને પ્રેઝન્ટ ન હોય) તો જ બ્લેક બોર્ડર (today class) લાગે
    			else if (date.getTime() === today.getTime()) {
        			cls += " today";
    			}
    			// ૩. બાકીના કિસ્સામાં એબસન્ટ અથવા નોર્મલ
    			else if (absentDates.includes(dateStr) || (date < today)) {
        			cls += " absent";
    			}
			}
            htmlContent += `<div class="` + cls.trim() + `">` + i + `</div>`;
        }
        grid.innerHTML = htmlContent;
    }

    function changeMonth(step) {
        currentDateObj.setMonth(currentDateObj.getMonth() + step);
        renderCalendar();
    }

    document.addEventListener("DOMContentLoaded", renderCalendar);
</script>
</body>
</html>