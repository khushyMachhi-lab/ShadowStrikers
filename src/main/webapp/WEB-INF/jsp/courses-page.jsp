<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses - Fight Club</title>
    
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

        /* --- Page Header --- */
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

        /* --- Courses Section --- */
        .courses-section {
            padding: 100px 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }

        .course-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            margin-bottom: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .course-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3);
        }

        .course-image {
            width: 100%;
            height: 250px;
            overflow: hidden;
            position: relative;
        }

        .course-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .course-card:hover .course-image img {
            transform: scale(1.1);
        }

        .course-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.85rem;
        }

        .course-content {
            padding: 30px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .course-title {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 15px;
        }

        .course-description {
            color: #666;
            font-size: 1rem;
            line-height: 1.7;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .course-features {
            list-style: none;
            padding: 0;
            margin-bottom: 25px;
        }

        .course-features li {
            padding: 8px 0;
            color: #555;
            font-size: 0.95rem;
        }

        .course-features li i {
            color: var(--primary-color);
            margin-right: 10px;
            width: 20px;
        }

        .course-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }

        .course-price {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--primary-color);
        }

        .course-price span {
            font-size: 1rem;
            color: #999;
            font-weight: 400;
        }

        .btn-enroll {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            border: none;
            font-weight: 700;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-enroll:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }

        /* --- Level Indicator --- */
        .level-indicator {
            display: flex;
            gap: 5px;
            margin-bottom: 15px;
        }

        .level-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #ddd;
        }

        .level-dot.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        /* --- Why Choose Section --- */
        .why-choose-section {
            padding: 100px 0;
            background: white;
        }

        .benefit-card {
            text-align: center;
            padding: 40px 30px;
            border-radius: 15px;
            background: linear-gradient(135deg, #f5f7fa 0%, #fff 100%);
            transition: all 0.4s ease;
            height: 100%;
        }

        .benefit-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        .benefit-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .benefit-icon i {
            font-size: 2rem;
            color: white;
        }

        .benefit-card h4 {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--dark-color);
        }

        .benefit-card p {
            color: #666;
            line-height: 1.7;
        }

        /* --- Footer --- */
        footer {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #adb5bd;
            padding: 40px 0;
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
            .page-header h1 {
                font-size: 2.2rem;
            }

            .course-title {
                font-size: 1.3rem;
            }

            .course-footer {
                flex-direction: column;
                gap: 15px;
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
                        <a class="nav-link active" href="/courses">Courses</a>
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

    <!-- Page Header -->
    <header class="page-header">
        <div class="container text-center">
            <h1>Our Training Programs</h1>
            <p>Choose the perfect course to master your martial arts journey</p>
        </div>
    </header>

    <!-- Courses Section -->
    <section class="courses-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-4 fw-bold">Available Courses</h2>
                <p class="text-muted fs-5">From beginner to advanced - we have the right program for you</p>
            </div>

            <div class="row">
                <!-- Course 1: Beginner Program -->
                <div class="col-lg-4 col-md-6">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="https://images.unsplash.com/photo-1555597408-26bc8e548a46?w=800" alt="Beginner Course">
                            <div class="course-badge">BEGINNER</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot"></div>
                                <div class="level-dot"></div>
                            </div>
                            <h3 class="course-title">Fundamentals Program</h3>
                            <p class="course-description">
                                Perfect for complete beginners. Learn the basics of martial arts, proper stances, basic strikes, and self-defense techniques in a supportive environment.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 3 Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Basic techniques & forms</li>
                                <li><i class="fas fa-check-circle"></i> Flexibility training</li>
                                <li><i class="fas fa-check-circle"></i> Beginner-friendly atmosphere</li>
                            </ul>
                            <div class="course-footer">
                                <div class="course-price">
                                    ₹99<span>/month</span>
                                </div>
                                <a href="/register" class="btn-enroll">Enroll Now</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Course 2: Intermediate Program -->
                <div class="col-lg-4 col-md-6">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?w=800" alt="Intermediate Course">
                            <div class="course-badge">INTERMEDIATE</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot"></div>
                            </div>
                            <h3 class="course-title">Advanced Techniques</h3>
                            <p class="course-description">
                                Take your skills to the next level. Master complex combinations, sparring fundamentals, and advanced kata with personalized feedback.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 4 Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Sparring sessions</li>
                                <li><i class="fas fa-check-circle"></i> Advanced forms training</li>
                                <li><i class="fas fa-check-circle"></i> Competition preparation</li>
                            </ul>
                            <div class="course-footer">
                                <div class="course-price">
                                    ₹149<span>/month</span>
                                </div>
                                <a href="/register" class="btn-enroll">Enroll Now</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Course 3: Competition Training -->
                <div class="col-lg-4 col-md-6">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="https://images.unsplash.com/photo-1555597673-b21d5c935865?w=800" alt="Competition Training">
                            <div class="course-badge">ADVANCED</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                            </div>
                            <h3 class="course-title">Elite Competition</h3>
                            <p class="course-description">
                                For serious fighters. Intensive training focused on tournament success, advanced strategies, and peak performance conditioning.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 5+ Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Personal coaching</li>
                                <li><i class="fas fa-check-circle"></i> Tournament preparation</li>
                                <li><i class="fas fa-check-circle"></i> Video analysis</li>
                            </ul>
                            <div class="course-footer">
                                <div class="course-price">
                                    ₹199<span>/month</span>
                                </div>
                                <a href="/register" class="btn-enroll">Enroll Now</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Course 4: Kids Program -->
                <div class="col-lg-4 col-md-6">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?w=800" alt="Kids Program">
                            <div class="course-badge">KIDS 6-12</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot"></div>
                                <div class="level-dot"></div>
                            </div>
                            <h3 class="course-title">Young Warriors</h3>
                            <p class="course-description">
                                Specially designed for children. Build confidence, discipline, and respect while learning martial arts in a fun, safe environment.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> Age-appropriate training</li>
                                <li><i class="fas fa-check-circle"></i> Character development</li>
                                <li><i class="fas fa-check-circle"></i> Anti-bullying skills</li>
                                <li><i class="fas fa-check-circle"></i> Fun activities & games</li>
                            </ul>
                            <div class="course-footer">
                                <div class="course-price">
                                    ₹89<span>/month</span>
                                </div>
                                <a href="/register" class="btn-enroll">Enroll Now</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Course 5: Women's Self-Defense -->
                <div class="col-lg-4 col-md-6">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800" alt="Women's Self-Defense">
                            <div class="course-badge">SPECIALIZED</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot"></div>
                            </div>
                            <h3 class="course-title">Women's Self-Defense</h3>
                            <p class="course-description">
                                Empowering program focused on practical self-defense techniques, awareness training, and building confidence in all situations.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> Women-only classes</li>
                                <li><i class="fas fa-check-circle"></i> Practical defense techniques</li>
                                <li><i class="fas fa-check-circle"></i> Situational awareness</li>
                                <li><i class="fas fa-check-circle"></i> Confidence building</li>
                            </ul>
                            <div class="course-footer">
                                <div class="course-price">
                                    ₹119<span>/month</span>
                                </div>
                                <a href="/register" class="btn-enroll">Enroll Now</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Course 6: Private Training -->
                <div class="col-lg-4 col-md-6">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800" alt="Private Training">
                            <div class="course-badge">1-ON-1</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                            </div>
                            <h3 class="course-title">Personal Training</h3>
                            <p class="course-description">
                                Get individualized attention with one-on-one sessions. Customized training plans designed specifically for your goals and schedule.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> Personalized curriculum</li>
                                <li><i class="fas fa-check-circle"></i> Flexible scheduling</li>
                                <li><i class="fas fa-check-circle"></i> Rapid progression</li>
                                <li><i class="fas fa-check-circle"></i> Custom goal setting</li>
                            </ul>
                            <div class="course-footer">
                                <div class="course-price">
                                    ₹80<span>/session</span>
                                </div>
                                <a href="/register" class="btn-enroll">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Choose Section -->
    <section class="why-choose-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-4 fw-bold">Why Train With Us?</h2>
                <p class="text-muted fs-5">Experience the difference at our academy</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="benefit-card fade-in">
                        <div class="benefit-icon">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <h4>Expert Instructors</h4>
                        <p>Learn from certified masters with decades of combined experience and proven teaching methods.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card fade-in">
                        <div class="benefit-icon">
                            <i class="fas fa-medal"></i>
                        </div>
                        <h4>Proven Results</h4>
                        <p>Our students consistently achieve their goals, from belt promotions to championship victories.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card fade-in">
                        <div class="benefit-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <h4>Modern Facilities</h4>
                        <p>Train in our state-of-the-art dojo equipped with professional mats, equipment, and amenities.</p>
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