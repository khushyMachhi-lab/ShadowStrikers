<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
    	
    	:root {
        	--primary-color: #922b3e;
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	--text-gradient: linear-gradient(135deg, #7b2d39 0%, #b14555 100%);     	
        	--dark-color: #1a1a2e;
        	--accent-color: #c62b3c;
        	--font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    	}    
    	
    	* {margin: 0; padding: 0; box-sizing: border-box;}
    	body {font-family: var(--font-family); background-color: #f7f7f7; overflow-x: hidden;}

    	/* NAVIGATION */
    	.navbar {
        	position: fixed; 
    		top: 0;
    		width: 100%;
    		z-index: 1030; 
    		backdrop-filter: blur(10px);
    		background-color: rgba(255, 255, 255, 0.95);
    		box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    		transition: all 0.3s ease;
    		padding-top: 1rem;
            padding-bottom: 1rem;
    	}
    	
    	.navbar-brand {font-weight: 700; color: var(--primary-color) !important;}
    	.nav-link {color: var(--primary-color) !important; font-weight: 700; text-shadow: none !important; transition: all 0.3s ease; padding-left: 1rem !important; padding-right: 1rem !important;}       
        .nav-link:hover, .nav-link.active {color: var(--accent-color) !important;}
        .navbar-toggler { border: none; }
		.navbar-toggler:focus { box-shadow: none; }
		.navbar-toggler-icon {background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(146, 43, 62, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e") !important;}

    	.gradient-text {
        	background: var(--text-gradient);
        	-webkit-background-clip: text;
        	-webkit-text-fill-color: transparent;
        	font-weight: 900;
    	}
    	
    	/* SYNCED PAGE HEADER (Hero) */
    	.page-header {position: relative; background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), var(--primary-gradient); color: white; padding: 180px 0 120px; overflow: hidden; margin-top: 0 !important; text-align: center;}
        .page-header h1 {font-size: 3.5rem; font-weight: 800; margin-bottom: 15px; animation: slideInDown 0.8s ease-out; text-shadow: 2px 2px 20px rgba(0,0,0,0.3);} 
        .page-header p {font-size: 1.3rem; opacity: 0.95; animation: slideInUp 0.8s ease-out;}

        @keyframes slideInDown {
            from {opacity: 0; transform: translateY(-50px);}
            to {opacity: 1; transform: translateY(0);}
        }

        @keyframes slideInUp {
            from {opacity: 0; transform: translateY(50px);}
            to {opacity: 1; transform: translateY(0);}
        }
        
        /* SYNCED BUTTONS */
        .btn-nav-login {
        	background: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	color: white !important;
        	border: none !important;
        	padding: 10px 25px;
        	border-radius: 25px; 
        	font-weight: 700 !important;
        	box-shadow: 0 8px 15px rgba(146, 43, 62, 0.4), inset 0 2px 4px rgba(255, 255, 255, 0.2);
        	transition: all 0.3s ease;
    	}
    	
    	.btn-nav-login:hover {
        	transform: translateY(-3px);
        	box-shadow: 0 12px 20px rgba(146, 43, 62, 0.6);
    	}
    	
    	/* Tab Button */
		.event-filter-tabs .nav-pills .nav-link.active {background: var(--primary-gradient) !important; color: white !important; border: none; box-shadow: 0 4px 12px rgba(146, 43, 62, 0.3);}
		.event-filter-tabs .nav-pills .nav-link {color: var(--primary-color) !important; border: 1px solid var(--primary-color); margin: 0 5px; transition: all 0.3s ease;}
		.event-filter-tabs .nav-pills .nav-link:hover {background-color: rgba(146, 43, 62, 0.05);}
    	
    	/* EVENT CARDS */
    	.events-section {padding: 80px 0; margin-top: 40px;}
    	.event-card {background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.05); transition: 0.3s; margin-bottom: 30px;}
    	.event-card:hover {transform: translateY(-10px);}
    	.event-card-image {height: 200px; background-size: cover; background-position: center; position: relative;}
    	.event-card-date {position: absolute; top: 15px; left: 15px; background: white; padding: 10px; border-radius: 10px; text-align: center; font-weight: 700;}
    	.event-card-date .day {display: block; font-size: 1.5rem; color: var(--primary-color);}
    	.event-card-content {padding: 25px;}
    	.event-card-meta span {display: block; margin-bottom: 10px; font-size: 0.95rem; color: #555;}
		.event-card-meta i {color: var(--primary-color); margin-right: 5px; width: 25px;}
    	.event-card .btn-primary { background: var(--primary-gradient) !important; border: none !important; font-weight: 600; padding: 12px; box-shadow: 0 4px 15px rgba(146, 43, 62, 0.2); transition: all 0.3s ease;}
		.event-card .btn-primary:hover:not(.disabled) {transform: translateY(-2px); box-shadow: 0 6px 20px rgba(146, 43, 62, 0.4);}
		.event-card .btn-primary.disabled {background: #ccc !important; color: #666 !important; box-shadow: none;}
		.events-section .btn-outline-primary {color: var(--primary-color) !important; border-color: var(--primary-color) !important; font-weight: 600; padding: 10px 25px; border-radius: 8px; transition: all 0.3s ease;}
		.events-section .btn-outline-primary:hover {background: var(--primary-gradient) !important; color: white !important; border-color: transparent !important; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(146, 43, 62, 0.3);}
    	  
    	.fa-trophy.text-secondary {color: var(--primary-color) !important; opacity: 0.7;}
    	
        /* FOOTER */
    	footer {background-color: var(--primary-color); color: white; padding: 40px 0;}
    	footer a { color: #f8d7da; text-decoration: none; transition: 0.3s; }
    	footer a:hover { color: white; }

        /* Responsive */
        @media (max-width: 768px) {
    		.page-header {padding: 120px 0 60px;}
    		.page-header h1 {font-size: 2.2rem;}
    		.event-card-image {height: 180px;}
    		.event-filter-tabs .nav-pills {flex-direction: column; width: 100%;}
    		.event-filter-tabs .nav-item {margin-bottom: 10px;}
    		.events-section {padding: 40px 0; margin-top: 20px;}
    		.event-card-meta span {display: block; margin-bottom: 5px; font-size: 0.85rem;}	
		}
		
		.fade-in { opacity: 0; transform: translateY(30px); transition: 0.6s all ease; }
    	.fade-in.visible { opacity: 1; transform: translateY(0); }
		
    </style>
</head>
<body>

    <!-- 1. Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container-fluid container-xl">
            <a class="navbar-brand text-white fw-bold" href="${pageContext.request.contextPath}/">
    			<img src="${pageContext.request.contextPath}/logo/logo_2.png" alt="logo" style="height:40px;" />
    			<span class="ms-2 fw-bold gradient-text" style="font-size:22px;">ShadowStrikers</span>
			</a>  
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/home">Home</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="/aboutUs">About Us</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="/courses">Courses</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="/gallery">Gallery</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link active" href="/events">Events</a>
                    </li>
                    <li class="nav-item">	
                    	<a class="nav-link" href="/contactUs">Contact Us</a>
                    </li>
                    <li class="nav-item ms-lg-3">
                        <a href="/login" class="btn btn-primary btn-nav-login text-white">
                            Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Animated Page Header -->
    <header class="page-header">
        <div class="container text-center">
            <h1>Upcoming Events</h1>
            <p>Don't miss out on tournaments, seminars, and belt testing days.</p>
        </div>
    </header>
    
    <!-- Events Section -->
    <section class="events-section">
        <div class="container">
            <div class="text-center mb-5 fade-in">
                <h2 class="fw-bold display-4 text-dark-color">Mark Your Calendar</h2>
                <p class="text-muted fs-5">Opportunities to test your skills and learn from masters.</p>
            </div>
            
            <div class="d-flex justify-content-center mb-5 event-filter-tabs fade-in">
                <ul class="nav nav-pills">
                    <li class="nav-item">
                        <a class="nav-link active" data-bs-toggle="pill" href="#upcoming">Upcoming Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="pill" href="#past">Past Highlights</a>
                    </li>
                </ul>
            </div>

            <div class="tab-content">
                <!-- Upcoming Events Tab -->
                <div class="tab-pane fade show active" id="upcoming">
                    <div class="row">
                        
                        <!-- Event 1: Annual BJJ Open Tournament -->
                        <div class="col-lg-4 col-md-6 fade-in">
                            <div class="event-card">
                                <div class="event-card-image" style="background-image: url('https://source.unsplash.com/800x500/?jiujitsu,tournament');">
                                    <div class="event-card-date">
                                        <span class="day">15</span>
                                        <span class="month">Dec</span>
                                    </div>
                                </div>
                                <div class="event-card-content">
                                    <h3>Annual BJJ Open</h3>
                                    <p class="text-muted">Compete against the region's best grapplers for glory and prize money.</p>
                                    <div class="event-card-meta">
                                        <span><i class="fas fa-clock"></i> 8:00 AM - 5:00 PM</span>
                                        <span><i class="fas fa-map-marker-alt"></i> Main Academy Arena</span>
                                        <span><i class="fas fa-users"></i> All Levels (Adult & Youth Divisions)</span>
                                    </div>
                                    <a href="#" class="btn btn-primary w-100"><i class="fas fa-ticket-alt me-2"></i> Register to Compete</a>
                                </div>
                            </div>
                        </div>

                        <!-- Event 2: Striking Seminar with Master Khan -->
                        <div class="col-lg-4 col-md-6 fade-in">
                            <div class="event-card">
                                <div class="event-card-image" style="background-image: url('https://source.unsplash.com/800x500/?muaythai,seminar');">
                                    <div class="event-card-date">
                                        <span class="day">2</span>
                                        <span class="month">Jan</span>
                                    </div>
                                </div>
                                <div class="event-card-content">
                                    <h3>Master Khan Seminar</h3>
                                    <p class="text-muted">A three-hour intensive seminar on advanced Muay Thai elbow and knee techniques.</p>
                                    <div class="event-card-meta">
                                        <span><i class="fas fa-clock"></i> 1:00 PM - 4:00 PM</span>
                                        <span><i class="fas fa-map-marker-alt"></i> Striking Room B</span>
                                        <span><i class="fas fa-users"></i> Intermediate and Up</span>
                                    </div>
                                    <a href="#" class="btn btn-primary w-100"><i class="fas fa-clipboard-check me-2"></i> Book Your Spot</a>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Event 3: Kids Belt Grading -->
                        <div class="col-lg-4 col-md-6 fade-in">
                            <div class="event-card">
                                <div class="event-card-image" style="background-image: url('https://source.unsplash.com/800x500/?martial,arts,kids,test');">
                                    <div class="event-card-date">
                                        <span class="day">28</span>
                                        <span class="month">Feb</span>
                                    </div>
                                </div>
                                <div class="event-card-content">
                                    <h3>Youth Grading Day</h3>
                                    <p class="text-muted">The official grading day for all youth students advancing to their next belt rank.</p>
                                    <div class="event-card-meta">
                                        <span><i class="fas fa-clock"></i> 10:00 AM - 12:00 PM</span>
                                        <span><i class="fas fa-map-marker-alt"></i> Dojang Floor</span>
                                        <span><i class="fas fa-users"></i> Youth Program Students Only</span>
                                    </div>
                                    <a href="#" class="btn btn-primary w-100 disabled"><i class="fas fa-info-circle me-2"></i> Registration Closed</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Past Events Tab (Placeholder) -->
                <div class="tab-pane fade" id="past">
                    <div class="row">
                        <div class="col-12 text-center py-5 fade-in">
                            <i class="fas fa-trophy text-secondary mb-3" style="font-size: 3rem;"></i>
                            <h4 class="text-dark-color fw-bold">No Past Events Currently Archived</h4>
                            <p class="text-muted">Check back soon! We are compiling highlights and photos from our previous events, including the 2024 Summer Championships.</p>
                            <a href="/gallery" class="btn btn-outline-primary mt-3">View Gallery Highlights</a>
                        </div>
                    </div>
                </div>
            </div>    
        </div>
    </section>
    
    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <div class="row">
                <div class="col-md-12">
                    <p class="mb-0 fw-bold">&copy; 2025 ShadowStrikers Academy. All rights reserved.</p>
                    <div class="mt-3">
                        <a href="#" class="text-decoration-none text-secondary me-4 fs-4"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="text-decoration-none text-secondary me-4 fs-4"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-decoration-none text-secondary fs-4"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Scroll Animation Observer
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });
    </script>

</body>
</html>