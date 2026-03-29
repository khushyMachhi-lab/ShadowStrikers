<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events - Fight Club Academy</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Custom Styles (Consistent with existing pages) */
        :root {
            --primary-color: #0d6efd; 
            --secondary-color: #6c757d;
            --accent-color: #ff6b35; /* Orange/Red for energy */
            --dark-color: #1a1a2e; /* Deep Navy/Black for background/text */
            --header-start: #667eea;
            --header-end: #764ba2;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            overflow-x: hidden;
        }

        /* --- Navbar Styles --- */
        .navbar {
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--dark-color) !important;
        }

        .nav-link {
            font-weight: 500;
            color: #333;
            transition: color 0.3s;
            position: relative;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 50%;
            background-color: var(--accent-color);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover::after,
        .nav-link.active::after {
            width: 80%;
        }

        .nav-link:hover {
            color: var(--accent-color);
        }

        .btn-nav-register {
            border-radius: 20px;
            padding: 8px 20px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .btn-primary {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }
        
        .btn-primary:hover {
            background-color: #d15a2c;
            border-color: #d15a2c;
        }

        .btn-nav-register::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
            z-index: -1;
        }

        .btn-nav-register:hover::before {
            left: 100%;
        }

        /* --- Page Header (Hero Section Style) --- */
        .page-header {
            position: relative;
            background: linear-gradient(135deg, var(--header-start) 0%, var(--header-end) 100%);
            color: white;
            padding: 200px 0 100px; 
            margin-top: 0; 
            overflow: hidden;
            min-height: 50vh; 
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="0.1" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') no-repeat bottom;
            background-size: cover;
            animation: wave 10s linear infinite;
        }

        @keyframes wave {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        .page-header h1 {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 15px;
            animation: slideInDown 0.8s ease-out;
            text-shadow: 2px 2px 20px rgba(0,0,0,0.4);
        }

        .page-header p {
            font-size: 1.3rem;
            opacity: 0.95;
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInDown {
            from { opacity: 0; transform: translateY(-50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* --- Events Specific Styles --- */
        .events-section {
            padding: 100px 0;
        }

        .event-card {
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 30px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .event-card-image {
            height: 250px;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .event-card-date {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: var(--accent-color);
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            text-align: center;
            line-height: 1;
            font-weight: 700;
        }

        .event-card-date .day {
            display: block;
            font-size: 1.8rem;
        }
        
        .event-card-date .month {
            display: block;
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        .event-card-content {
            padding: 30px;
        }

        .event-card-content h3 {
            color: var(--dark-color);
            font-weight: 800;
            margin-bottom: 15px;
        }

        .event-card-meta span {
            display: block;
            margin-bottom: 8px;
            font-size: 0.95rem;
            color: #555;
        }
        
        .event-card-meta i {
            color: var(--accent-color);
            width: 25px;
        }
        
        .event-card .btn {
            margin-top: 15px;
        }
        
        /* Upcoming vs Past filter styling */
        .event-filter-tabs .nav-link {
            color: var(--dark-color);
            border: 1px solid #dee2e6;
            border-radius: 50px;
            margin: 0 5px;
            padding: 10px 25px;
            transition: all 0.3s ease;
        }
        
        .event-filter-tabs .nav-link.active,
        .event-filter-tabs .nav-link:hover {
            background-color: var(--accent-color);
            color: white;
            border-color: var(--accent-color);
        }

        /* --- Footer --- */
        footer {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #adb5bd;
            padding: 40px 0;
            position: relative;
            z-index: 10;
        }

        footer a {
            transition: all 0.3s ease;
            color: #adb5bd;
            text-decoration: none;
        }

        footer a:hover {
            color: var(--accent-color) !important;
            transform: translateY(-3px);
        }

        /* Scroll animations */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
             .page-header h1 {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-fist-raised me-2"></i>FightClub Academy
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="/home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/courses">Courses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/gallery">Gallery</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/">Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/users">Contact Us</a>
                    </li>
                    <li class="nav-item ms-lg-3">
                        <a href="/register" class="btn btn-primary btn-nav-register text-white">
                            Join Now
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

            <div class="text-center mt-5 fade-in">
                 <p class="text-muted">Need to host your event or seminar with us? <a href="/users" class="text-decoration-none fw-bold" style="color: var(--accent-color);">Contact our team for gym rental availability.</a></p>
            </div>
            
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <div class="row">
                <div class="col-md-12">
                    <p class="mb-0 fw-bold">&copy; 2024 Fight Club Academy. All rights reserved.</p>
                    <div class="mt-3">
                        <a href="#" class="text-decoration-none me-4 fs-4"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="text-decoration-none me-4 fs-4"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-decoration-none fs-4"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Navbar Scroll Effect (Copied from previous pages for consistency)
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                navbar.style.boxShadow = '0 4px 20px rgba(0,0,0,0.15)';
            } else {
                navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                navbar.style.boxShadow = '0 2px 10px rgba(0,0,0,0.1)';
            }
        });

        // Scroll Animation Observer (Fade In)
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target); // Stop observing once visible
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>