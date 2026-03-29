<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Fight Club</title>
    
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
            color: var(--primary-color) !important;
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
            background-color: var(--primary-color);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover::after,
        .nav-link.active::after {
            width: 80%;
        }

        .nav-link:hover {
            color: var(--primary-color);
        }

        .btn-nav-register {
            border-radius: 20px;
            padding: 8px 20px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        
        /*.btn-primary:hover {
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
        }*/

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

        /* --- Contact Section Styles --- */
        .contact-section {
            padding: 100px 0;
        }

        .contact-info-card {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 30px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .contact-info-card h4 {
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }

        .info-icon {
            color: white;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            /*background-color: var(--primary-color);*/
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
            margin-right: 15px;
        }

        .info-text strong {
            display: block;
            color: var(--dark-color);
            font-size: 1.1rem;
        }

        .info-text span {
            color: #666;
            font-size: 0.95rem;
        }

        .map-placeholder {
            height: 400px;
            background-color: #e9ecef;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 1.5rem;
            margin-top: 30px;
            border: 2px solid #ddd;
            overflow: hidden;
        }
        
        /* Contact Form Styling */
        .contact-form-card {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 30px rgba(0,0,0,0.08);
        }

        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(255, 107, 53, 0.25);
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
                <i class="fas fa-users-cog me-2"></i>ShadowStrike
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
                        <a class="nav-link" href="/events">Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/contactUs">Contact Us</a>
                    </li>
                    <li class="nav-item ms-lg-3">
                        <a href="/register" class="btn btn-primary btn-nav-register text-white">
                            Register Now
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Animated Page Header -->
    <header class="page-header">
        <div class="container text-center">
            <h1>Ready to Start Your Training?</h1>
            <p>We're here to answer all your questions about classes, schedules, and membership.</p>
        </div>
    </header>

    <!-- Contact Section -->
    <section class="contact-section">
        <div class="container">
            <div class="text-center mb-5 fade-in">
                <h2 class="fw-bold display-4 text-dark-color">Get In Touch</h2>
                <p class="text-muted fs-5">Fill out the form or use the contact details below.</p>
            </div>
            
            <div class="row">
                <!-- Contact Form Column -->
                <div class="col-lg-7 fade-in">
                    <div class="contact-form-card">
                        <h3 class="fw-bold text-dark-color mb-4">Send Us a Message</h3>
                        
                        <form id="contactForm">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Your Full Name" required>
                                </div>
                                <div class="col-md-6 mt-3 mt-md-0">
                                    <input type="email" class="form-control" placeholder="Your Email Address" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <input type="text" class="form-control" placeholder="Subject (e.g., Trial Class Inquiry)" required>
                            </div>
                            <div class="mb-4">
                                <textarea class="form-control" rows="5" placeholder="Your Message..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg px-4 w-100">
                                Send Inquiry <i class="fas fa-paper-plane ms-2"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Contact Info Column -->
                <div class="col-lg-5 fade-in">
                    <div class="contact-info-card">
                        <h4>Academy Information</h4>
                        
                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
                            <div class="info-text">
                                <strong>Our Location</strong>
                                <span>450 Fight Street, Suite 101, Metro City, TX 77001</span>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-phone"></i></div>
                            <div class="info-text">
                                <strong>Call Us</strong>
                                <span>(555) 123-FIGHT (3444)</span>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-envelope"></i></div>
                            <div class="info-text">
                                <strong>Email Support</strong>
                                <span>info@fightclubacademy.com</span>
                            </div>
                        </div>

                        <h4 class="mt-4">Operating Hours</h4>
                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-clock"></i></div>
                            <div class="info-text">
                                <strong>Mon - Fri:</strong>
                                <span>6:00 AM - 10:00 PM</span>
                            </div>
                        </div>
                         <div class="info-item mb-0">
                            <div class="info-icon"><i class="fas fa-sun"></i></div>
                            <div class="info-text">
                                <strong>Sat - Sun:</strong>
                                <span>8:00 AM - 4:00 PM (Open Mat)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Map Placeholder -->
            <div class="row">
                <div class="col-12 fade-in">
                    <div class="map-placeholder">
                        <i class="fas fa-map-marked-alt me-2"></i> Placeholder for Interactive Google Map
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
                    <p class="mb-0 fw-bold">&copy; 2025 ShadowStrike - Fight Club. All rights reserved.</p>
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
        
        // Form Submission Handler (Prevents default action and shows a message)
        document.getElementById('contactForm').addEventListener('submit', function(event) {
            event.preventDefault();
            
            const formCard = document.querySelector('.contact-form-card');
            const existingAlert = document.getElementById('formAlert');
            if (existingAlert) existingAlert.remove();
            
            const alertDiv = document.createElement('div');
            alertDiv.id = 'formAlert';
            alertDiv.className = 'alert alert-success alert-dismissible fade show mt-3';
            alertDiv.setAttribute('role', 'alert');
            alertDiv.innerHTML = '<strong>Success!</strong> Your message has been sent. We will be in touch shortly.';
            alertDiv.innerHTML += '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>';
            
            formCard.prepend(alertDiv);
            this.reset(); // Clear the form
            
            setTimeout(() => {
                const freshAlert = document.getElementById('formAlert');
                if (freshAlert) new bootstrap.Alert(freshAlert).close();
            }, 5000);
        });
    </script>
</body>
</html>