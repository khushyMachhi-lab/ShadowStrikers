<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Fight Club</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Custom Styles */
        :root {
            --primary-color: #0d6efd;
            --secondary-color: #6c757d;
            --accent-color: #ff6b35;
            --dark-color: #1a1a2e;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            position: relative;
            overflow: hidden;
            z-index: 1;
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
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }

        /* --- Animated Page Header --- */
        .page-header {
            position: relative;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 150px 0 80px;
            margin-top: 56px;
            overflow: hidden;
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
            font-weight: 800;
            margin-bottom: 15px;
            animation: slideInDown 0.8s ease-out;
            text-shadow: 2px 2px 20px rgba(0,0,0,0.3);
        }

        .page-header p {
            font-size: 1.3rem;
            opacity: 0.95;
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* --- Parallax About Section --- */
        .about-section {
            padding: 100px 0;
            position: relative;
        }

        .about-content {
            display: flex;
            align-items: center;
            gap: 60px;
            margin-bottom: 80px;
        }

        .about-image {
            flex: 1;
            position: relative;
            animation: fadeInLeft 1s ease-out;
        }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .about-image::before {
            content: '';
            position: absolute;
            top: -20px;
            left: -20px;
            width: 100%;
            height: 100%;
            border: 3px solid var(--primary-color);
            border-radius: 15px;
            z-index: -1;
        }

        .about-image img {
            width: 100%;
            height: 450px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            transition: transform 0.5s ease;
        }

        .about-image:hover img {
            transform: scale(1.05);
        }

        .about-text {
            flex: 1;
            animation: fadeInRight 1s ease-out;
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .about-text h2 {
            font-size: 2.8rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 25px;
            position: relative;
            display: inline-block;
        }

        .about-text h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            border-radius: 2px;
        }

        .about-text p {
            font-size: 1.15rem;
            line-height: 1.9;
            color: #555;
            margin-bottom: 20px;
        }

        /* --- Animated Mission & Vision Cards --- */
        .mission-vision-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 100px 0;
            position: relative;
        }

        .mv-card {
            background: white;
            border-radius: 20px;
            padding: 50px;
            height: 100%;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .mv-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            transition: left 0.6s;
        }

        .mv-card:hover::before {
            left: 100%;
        }

        .mv-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3);
        }

        .mv-card-icon {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 25px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        .mv-card-icon i {
            font-size: 2.5rem;
            color: white;
        }

        .mv-card h3 {
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 20px;
            color: var(--dark-color);
        }

        .mv-card p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #666;
        }

        /* --- Dynamic Values Section --- */
        .values-section {
            padding: 100px 0;
            background: #fff;
        }

        .value-item {
            padding: 40px;
            border-radius: 15px;
            background: linear-gradient(135deg, #f5f7fa 0%, #fff 100%);
            margin-bottom: 25px;
            transition: all 0.4s ease;
            border-left: 5px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .value-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 0;
            background: linear-gradient(180deg, var(--primary-color), var(--accent-color));
            transition: height 0.4s ease;
        }

        .value-item:hover::before {
            height: 100%;
        }

        .value-item:hover {
            transform: translateX(10px);
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            background: white;
        }

        .value-item h4 {
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 12px;
            font-size: 1.4rem;
        }

        .value-item h4 i {
            color: var(--primary-color);
            margin-right: 10px;
        }

        .value-item p {
            color: #666;
            margin: 0;
            font-size: 1.05rem;
            line-height: 1.7;
        }

        /* --- Footer --- */
        footer {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #adb5bd;
            padding: 40px 0;
        }

        footer a {
            transition: all 0.3s ease;
        }

        footer a:hover {
            color: var(--primary-color) !important;
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

        /* Responsive */
        @media (max-width: 768px) {
            .about-content {
                flex-direction: column;
            }

            .page-header h1 {
                font-size: 2.2rem;
            }

            .about-text h2 {
                font-size: 2rem;
            }

            .stat-number {
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
                        <a class="nav-link active" href="/about">About</a>
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
                        <a class="nav-link" href="/contactUs">Contact Us</a>
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
            <h1>About Our Fight Club</h1>
            <p>Where Discipline Meets Excellence in Martial Arts</p>
        </div>
    </header>

    <!-- Instructor Profile Section -->
    <section class="about-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-3 fw-bold">Meet Your Master Instructor</h2>
                <p class="text-muted fs-5">World-class trainer dedicated to your martial arts excellence</p>
            </div>

            <!-- Main Instructor Profile -->
            <div class="about-content">
                <div class="about-image">
                    <img src="https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=800" alt="Master John Smith">
                </div>
                <div class="about-text">
                    <h2>Master John Smith</h2>
                    <div class="mb-3">
                        <span class="badge bg-primary fs-6 me-2">Chief Instructor</span>
                        <span class="badge bg-danger fs-6">5th Dan Black Belt</span>
                    </div>
                    <p>
                        With over 20 years of martial arts mastery, Master John Smith stands as one of the most respected instructors in the field. His journey began at age 8, and he has since dedicated his life to perfecting multiple disciplines including Karate, Taekwondo, and Brazilian Jiu-Jitsu.
                    </p>
                    <p>
                        Master Smith has trained national champions and holds certifications from international martial arts federations. His teaching philosophy focuses on building not just fighters, but disciplined individuals who excel in all aspects of life.
                    </p>
                    <p>
                        <strong>Specializations:</strong> Competition Training, Traditional Forms, Self-Defense, Mental Conditioning
                    </p>
                    <p>
                        <strong>Achievements:</strong> National Champion (3x), International Referee, Master Trainer Certification
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission & Vision Section -->
    <section class="mission-vision-section">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="mv-card fade-in">
                        <div class="mv-card-icon">
                            <i class="fas fa-fire"></i>
                        </div>
                        <h3>Our Mission</h3>
                        <p>
                            To ignite the warrior spirit within every individual through world-class martial arts training. We empower our students with unshakeable confidence, razor-sharp discipline, and combat-ready skills that extend far beyond the mat.
                        </p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mv-card fade-in">
                        <div class="mv-card-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <h3>Our Vision</h3>
                        <p>
                            To be recognized globally as the ultimate martial arts academy—where champions are born, legends are made, and the true spirit of martial arts thrives in every student who walks through our doors.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <!-- Values Section -->
    <section class="values-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold display-4">Our Core Values</h2>
                <p class="text-muted fs-5">The pillars that define our warrior culture</p>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="value-item fade-in">
                        <h4><i class="fas fa-bolt"></i>Relentless Excellence</h4>
                        <p>We pursue perfection in every technique, every training session, and every challenge we face.</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="value-item fade-in">
                        <h4><i class="fas fa-shield-alt"></i>Unwavering Respect</h4>
                        <p>Honor, humility, and respect form the foundation of our martial arts tradition and community.</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="value-item fade-in">
                        <h4><i class="fas fa-dumbbell"></i>Iron Discipline</h4>
                        <p>Mental fortitude and physical discipline forge the warriors who emerge from our academy.</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="value-item fade-in">
                        <h4><i class="fas fa-heart"></i>Brotherhood</h4>
                        <p>We are a family united by passion, supporting each other's journey to greatness.</p>
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
        // Navbar Scroll Effect
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