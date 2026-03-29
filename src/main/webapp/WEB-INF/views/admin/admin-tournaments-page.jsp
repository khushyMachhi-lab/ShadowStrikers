<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tournaments - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
	<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css">
    
    <style>
        :root {
        	--primary-color: #922b3e; 
        	--secondary-color: #ffffff;
        	--dark-color: #1a1a2e;
        	--sidebar-width: 280px;
        	--font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
        
        /* Top Navbar */
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
        
        .tournament-content {padding: 30px;}

        /* Card Customizations */
        .t-card {border-radius: 15px; transition: transform 0.3s ease; border: none;}
        .t-card:hover {transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;}
        
        .edit-management-bar {background: #ffffff; border-radius: 12px; height: 80px; display: flex; align-items: center; width: 100%; margin-bottom: 25px;}
        
		.dataTables_filter {margin-top: 10px; text-align: right !important;}
		.dataTables_filter input {width: 250px !important; height: 38px; border-radius: 20px; border: 1px solid #ddd; padding: 5px 15px; outline: none; box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);}
		.dataTables_filter input:focus {border-color: #922b3e; box-shadow: 0 0 8px rgba(146, 43, 62, 0.2);}
		.dt-buttons {display: flex; justify-content: flex-end; width: 100%;}
		
        /* Table Scrollbar Styling */
		.table-responsive {max-height: 550px; overflow-y: auto; overflow-x: auto; border: none !important; border-radius: 10px; white-space: nowrap; scrollbar-width: thin; scrollbar-color: #922b3e #f1f1f1; padding-bottom: 15px;}
		.table-responsive::-webkit-scrollbar {height: 8px;}
		.table-responsive::-webkit-scrollbar-thumb {background: #922b3e; border-radius: 10px;}

		/* Sorting Arrows (Up/Down) દૂર કરવા માટે */
		table.dataTable thead .sorting::before,
		table.dataTable thead .sorting::after,
		table.dataTable thead .sorting_asc::before,
		table.dataTable thead .sorting_asc::after,
		table.dataTable thead .sorting_desc::before,
		table.dataTable thead .sorting_desc::after {
    		display: none !important;
		}

		table.dataTable thead th {cursor: default !important;}
        
        /* Table Specific Styling */
        .record-card-wrapper {background: white; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid #eee;}
        #tournamentTable {width: 100%; min-width: 1300px;}
        #tournamentTable td {max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;}
        #tournamentTable th:first-child, #tournamentTable td:first-child {min-width: 100px;}
        #tournamentTable td:last-child {min-width: 220px; white-space: normal;}
        #tournamentTable thead th {background-color: #f8f9fa; color: #444; font-weight: 700; text-transform: uppercase; font-size: 0.8rem; border: none; padding: 15px 10px;}
        #tournamentTable tbody td {padding: 15px 10px; vertical-align: middle; border-bottom: 1px solid #f1f1f1;}
        .dataTables_wrapper .dataTables_filter {margin-bottom: 20px;}
        
        .coc-badge {
    		background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
    		color: #000;
    		font-weight: 800;
    		padding: 5px 12px;
    		border-radius: 20px;
    		box-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
    		border: 1px solid #e6b800;
    		font-size: 0.75rem;
    		text-transform: uppercase;
    		display: inline-flex;
    		align-items: center;
    		gap: 5px;
		}

		.coc-row {background-color: rgba(255, 215, 0, 0.03) !important;}
        
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
    		<a href="/admin/studentsRecords" class="menu-item">
        		<i class="fas fa-users"></i> <span>Students Records</span>
    		</a>
            <a href="/admin/attendance" class="menu-item">
                <i class="fas fa-clipboard-check"></i> <span>Attendance</span>
            </a>
            <a href="/admin/payments" class="menu-item">
                <i class="fas fa-money-bill-wave"></i> <span>Payments</span>
            </a>
            <a href="/admin/tournaments" class="menu-item active">
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
                <h2>Tournaments</h2>
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
    
        <div class="tournament-content">
            <div class="row g-4 mb-4">
    			<div class="col-md-4">
                    <div class="card t-card text-center shadow-sm">
                        <div class="card-body py-4">
                            <div class="mx-auto mb-3" style="width: 60px; height: 60px; background: rgba(13,110,253,0.1); color: #0d6efd; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                                <i class="fas fa-calendar-plus"></i>
                            </div>
                            <h5 class="fw-bold">New Event</h5>
                            <p class="text-muted small">Create and schedule new competitions.</p>
                            <a href="${pageContext.request.contextPath}/admin/tournaments/createEvent" class="btn btn-primary btn-sm px-4 rounded-pill">Create Event</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card t-card text-center shadow-sm">
                        <div class="card-body py-4">
                            <div class="mx-auto mb-3" style="width: 60px; height: 60px; background: rgba(255,107,53,0.1); color: #ff6b35; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <h5 class="fw-bold">Add Participant</h5>
                            <p class="text-muted small">Manually enroll students into events.</p>
                            <a href="${pageContext.request.contextPath}/admin/tournaments/participant" class="btn btn-sm px-4 rounded-pill text-white" style="background:#ff6b35;">Participate Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card t-card text-center shadow-sm">
                        <div class="card-body py-4">
                            <div class="mx-auto mb-3" style="width: 60px; height: 60px; background: rgba(26,26,46,0.1); color: #1a1a2e; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                                <i class="fas fa-history"></i>
                            </div>
                            <h5 class="fw-bold">Tournament Records</h5>
                            <p class="text-muted small">View past results and history.</p>
                            <a href="${pageContext.request.contextPath}/admin/tournaments/records" class="btn btn-dark btn-sm px-4 rounded-pill">View Archive</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="edit-management-bar shadow-sm px-4">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <div class="d-flex align-items-center">
                        <div class="me-3" style="width: 50px; height: 50px; background: rgba(245,158,11,0.1); color: #f59e0b; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.2rem;">
                            <i class="fas fa-user-edit"></i>
                        </div>
                        <div>
                            <h6 class="mb-0 fw-bold">Update Tournament Results & Rankings</h6>
                            <p class="mb-0 text-muted small">Assign medals (Gold, Silver, Bronze) and Championship of Champions (COC) titles.</p>
                        </div>
                    </div>
                    <a href="/admin/tournaments/assignRank" class="btn btn-sm px-4 rounded-pill text-white" style="background: #f59e0b;">Edit & Rank Records</a>
                </div>
            </div> 

            <div class="record-card-wrapper shadow-sm">
                <div class="p-4 bg-white d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold mb-0 text-dark">Participant List</h5>
                        <p class="text-muted small mb-0">Select a tournament to view entries</p>
                    </div>
                    
                    <div class="d-flex align-items-center gap-3">
            			<div class="d-flex align-items-center gap-2">
                			<i class="fas fa-trophy text-warning" style="font-size: 1.2rem;"></i>
                			<select id="tournamentSelector" class="form-select form-select-sm shadow-sm" style="width: 250px; border-radius: 20px;" onchange="loadTournamentParticipants(this.value)">
                    			<option value="" ${selectedTournamentId == null ? 'selected' : ''}>-- All Participants --</option>
                    			<c:forEach var="t" items="${allTournaments}">
                        			<option value="${t.id}" ${t.id == selectedTournamentId ? 'selected' : ''}>
                            			${t.name} (${t.eventYear})
                        			</option>
                    			</c:forEach>
                			</select>
            			</div>
            
            			<div id="exportButtons" class="d-flex gap-2"></div>
        			</div>
    			</div>
    
    			<div class="bg-light border-bottom p-3 d-flex justify-content-end">
    				<div id="searchContainer" style="max-width: 260px; margin-right: 15px; width: 100%;">
    					<div class="position-relative">
        					<i class="fas fa-search position-absolute" style="left: 15px; top: 50%; transform: translateY(-50%); color: #999; z-index: 10;"></i>
        					<input type="text" id="customSearchInput" class="form-control shadow-sm" 
               					placeholder="Search by Student Name or ID..." 
               					style="padding-left: 40px; border-radius: 25px; width: 100%; border: 1px solid #ddd; height: 38px; font-size: 0.9rem;">
    					</div>
					</div>
				</div>     

                <div class="table-responsive px-4 pb-4" style="overflow-x: auto; white-space: nowrap;">
                    <table id="tournamentTable" class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>D.O.B</th>
                                <th>Age</th>
                                <th>Gender</th>
                                <th>Weight</th>
                                <th>Fees</th> <th>Belt</th>
                                <th class="text-center">Kata</th>
                                <th class="text-center">Kumite</th>
                                <th class="text-center">COC</th>
                                <th>Coach/Dojo</th>
                                <th>Tournament</th>
                            </tr>
                        </thead>
                        	<tbody>
                            		<c:forEach var="p" items="${participants}">
                                		<tr class="${p.championship ? 'coc-row' : ''}">
                                    		<td class="text-muted small">#SS-${p.studentId}</td>
                                    		<td class="fw-bold text-dark">${p.fullName}</td>
                                    		<td>${p.dob}</td>
                                    		<td><span class="badge bg-light text-dark border">${p.age} yrs</span></td>
                                    		<td>${p.gender}</td>
                                    		<td>${p.weight} kg</td>
                                    		<td>
                								<span class="fw-bold" style="color: #2e7d32; background: #e8f5e9; padding: 4px 10px; border-radius: 8px; font-size: 0.85rem; border: 1px solid #c8e6c9;">
                    								₹${p.feeAmount}
                								</span>
            								</td>
                                    		<td><span class="badge rounded-pill px-3" style="background-color: rgba(146, 43, 62, 0.1); color: #922b3e; border: 1px solid rgba(146, 43, 62, 0.2);">${p.rank}</span></td>
                                    		<td class="text-center">
                                        	<c:choose>
                                            	<c:when test="${p.category == 'Kata' || p.category == 'Both'}">
                                                	<i class="fas fa-check-circle text-success"></i>
                                            	</c:when>
                                            	<c:otherwise><span class="text-muted">—</span></c:otherwise>
                                        	</c:choose>
                                    		</td>
                                    		<td class="text-center">
                                        		<c:choose>
                                            		<c:when test="${p.category == 'Kumite' || p.category == 'Both'}">
                                                		<i class="fas fa-check-circle text-success"></i>
                                            		</c:when>
                                            		<c:otherwise><span class="text-muted">—</span></c:otherwise>
                                        		</c:choose>
                                    		</td>
                                    		<td class="text-center">
            									<c:choose>
            										<c:when test="${p.championship}">
                										<i class="fas fa-check-circle text-warning" style="font-size: 1.2rem; filter: drop-shadow(0 0 5px rgba(255,193,7,0.5));"></i>
            										</c:when>
            										<c:otherwise>
                										<span class="text-muted" style="font-size: 0.8rem;">—</span>
            										</c:otherwise>
        											</c:choose>
        									</td>
                                    		<td><i class="fas fa-university me-1 text-muted small"></i> ${p.dojoName}</td>
                                    		<td>
                								<span class="badge bg-light text-primary border" style="font-size: 0.8rem;">
                    								<i class="fas fa-trophy text-warning me-1"></i>
                    								<c:out value="${p.tournament.name}" />
                								</span>
            								</td>
                                		</tr>
                            		</c:forEach>
                        		</tbody>
                        	<tfoot class="bg-light fw-bold">
        						<tr>
            						<td colspan="6" class="text-end pe-4">Total Fees (This Page):</td>
            						<td class="text-start"><span id="totalFeesAmount" class="text-success">₹0</span></td>
            						<td colspan="6"></td>
        						</tr>
    						</tfoot>
                    	</table>
                	</div>
            	</div>
        	</div>
    	</div>

	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>	
	<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
	<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    
    $(document).ready(function() {
        // 1. DataTable Initialization
        var table = $('#tournamentTable').DataTable({
            "destroy": true,
            "ordering": false,
            "autoWidth": false,
            "pageLength": 10,
            "dom": 'rt<"d-flex justify-content-between align-items-center mt-3"ip>',
            "language": {
                "emptyTable": "No participants found.",
                "paginate": {
                    "next": '<i class="fas fa-chevron-right"></i>',
                    "previous": '<i class="fas fa-chevron-left"></i>'
                }
            },
            "footerCallback": function (row, data, start, end, display) {
                var api = this.api();
                var intVal = function (i) {
                    if (typeof i === 'string') {
                        let clean = i.replace(/<[^>]*>?/gm, '').replace(/[₹,]/g, '').trim();
                        return clean ? parseFloat(clean) : 0;
                    }
                    return typeof i === 'number' ? i : 0;
                };

                var total = api.column(6, { page: 'current' }).data().reduce(function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0);

                $('#totalFeesAmount').html('₹' + total.toLocaleString('en-IN'));
            },
            // --- અહીંથી બટન્સનો કલર સેટ કરવાનું લોજિક શરૂ થાય છે ---
            "drawCallback": function() {
                // એક્ટિવ પેજ નંબર (Red)
                $('.page-item.active .page-link').css({
                    'background-color': '#922b3e',
                    'border-color': '#922b3e',
                    'color': '#ffffff',
                    'box-shadow': 'none'
                });

                // બાકીના પેજ નંબર્સ અને Next/Prev (Red Text)
                $('.page-link').not('.active .page-link').css({
                    'color': '#922b3e',
                    'background-color': '#ffffff',
                    'border': '1px solid #dee2e6'
                });

                // હોવર ઇફેક્ટ (Black background)
                $('.page-link').on('mouseenter', function() {
                    $(this).css({
                        'background-color': '#1a1a2e',
                        'color': '#ffffff',
                        'border-color': '#1a1a2e'
                    });
                }).on('mouseleave', function() {
                    if ($(this).parent().hasClass('active')) {
                        $(this).css({
                            'background-color': '#922b3e',
                            'color': '#ffffff',
                            'border-color': '#922b3e'
                        });
                    } else {
                        $(this).css({
                            'background-color': '#ffffff',
                            'color': '#922b3e',
                            'border-color': '#dee2e6'
                        });
                    }
                });
            }
        });

        // 2. Export Buttons Setup
        new $.fn.dataTable.Buttons(table, {
            buttons: [
                { 
                    extend: 'excelHtml5', 
                    text: '<i class="fas fa-file-excel"></i>', 
                    className: 'btn btn-success btn-sm rounded-circle shadow-sm border-0' 
                },
                { 
                    extend: 'pdfHtml5', 
                    text: '<i class="fas fa-file-pdf"></i>', 
                    className: 'btn btn-danger btn-sm rounded-circle shadow-sm border-0',
                    orientation: 'landscape'
                },
                { 
                    extend: 'print', 
                    text: '<i class="fas fa-print"></i>', 
                    className: 'btn btn-dark btn-sm rounded-circle shadow-sm border-0' 
                }
            ]
        });
        table.buttons().container().appendTo('#exportButtons');

        // 3. Custom Search Logic
        $('#customSearchInput').on('keyup', function() {
            table.search(this.value).draw();
        });
    });

    function loadTournamentParticipants(tId) {
        let path = "${pageContext.request.contextPath}/admin/tournaments";
        window.location.href = (tId && tId !== "") ? path + "?tournamentId=" + tId : path;
    }
    </script>
</body>
</html>