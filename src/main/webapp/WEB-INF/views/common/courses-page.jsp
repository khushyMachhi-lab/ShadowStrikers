0<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
	<style>
    	
    	:root {
        	--primary-color: #922b3e;
        	--primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        	--text-gradient: linear-gradient(135deg, #7b2d39 0%, #b14555 100%);
        	--secondary-color: #ffffff;
        	--dark-color: #1a1a2e;
        	--accent-color: #c62b3c;
        	--font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    	}

    	* {margin: 0; padding: 0; box-sizing: border-box;}
    	body {font-family: var(--font-family); background-color: #f7f7f7; overflow-x: hidden;}
		
		/* Navigation Bar Styling */
    	.navbar {
        	position: fixed; /* Keep it at the top while scrolling */
    		top: 0;
    		width: 100%;
    		z-index: 1030; /* Ensure it stays above other content */
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
        	background: var(--primary-gradient) !important;
        	color: white !important;
        	border: none !important;
        	padding: 10px 25px;
        	border-radius: 25px; 
        	font-weight: 700 !important;
        	box-shadow: 0 8px 15px rgba(146, 43, 62, 0.4), inset 0 2px 4px rgba(255, 255, 255, 0.2);
        	transition: all 0.3s ease;
    	}

    	.btn-nav-login:hover, .btn-primary:hover {
        	transform: translateY(-3px);
        	box-shadow: 0 12px 20px rgba(146, 43, 62, 0.6);
        }

    	/* Course Cards */
    	.courses-section {padding: 100px 0; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); position: relative;}   
        .courses-section::before {content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 1px; background: linear-gradient(90deg, transparent, var(--primary-color), transparent); opacity: 0.3;}	
    	.course-card {background: #ffffff; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 30px rgba(146, 43, 62, 0.05); transition: all 0.4s ease; margin-bottom: 30px; height: 100%; display: flex; flex-direction: column; border: 1px solid rgba(146, 43, 62, 0.08);}
    	.course-card:hover {transform: translateY(-12px); box-shadow: 0 20px 40px rgba(146, 43, 62, 0.2); border-color: var(--primary-color);}	
    	.course-image {width: 100%; height: 250px; overflow: hidden; position: relative; background-color: #f8f9fa;}
        .course-image img {width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; object-position: center;} 
        .course-card:hover .course-image img {transform: scale(1.1);}
    	.course-badge {position: absolute; top: 15px; right: 15px; background: linear-gradient(135deg, #7b2d39 0%, #b14555 100%); color: white; padding: 8px 15px; border-radius: 20px; font-weight: 700; font-size: 0.85rem;}     
        .course-content {padding: 30px; flex-grow: 1; display: flex; flex-direction: column;}
        .course-title {font-size: 1.6rem; font-weight: 800; color: var(--dark-color); margin-bottom: 15px;}
        .course-description {color: #666; font-size: 1rem; line-height: 1.7; margin-bottom: 20px; flex-grow: 1;}
        .course-features {list-style: none; padding: 0; margin-bottom: 25px;}  
        .course-features li {padding: 8px 0; color: #555; font-size: 0.95rem;}
    	.course-features li i {color: var(--primary-color); margin-right: 10px;}
    	.course-footer {display: flex; justify-content: space-between; align-items: center; padding-top: 20px; border-top: 1px solid #eee; margin-top: auto;}
    	.course-price {font-size: 1.8rem; font-weight: 800; color: var(--primary-color);}
    	
    	/* Level Indicators */
        .level-indicator { display: flex; gap: 5px; margin-bottom: 10px; }
        .level-dot { width: 10px; height: 10px; border-radius: 50%; background: #ddd; }
        .level-dot.active { background: var(--primary-color); }

    	/* Why Choose Section Icons */
    	.why-choose-section {padding: 100px 0; background: white;}
        .benefit-card {text-align: center; padding: 40px 30px; border-radius: 15px; background: linear-gradient(135deg, #f5f7fa 0%, #fff 100%); transition: all 0.4s ease; height: 100%;}
        .benefit-card:hover {transform: translateY(-10px); box-shadow: 0 15px 40px rgba(0,0,0,0.1);} 
    	.benefit-icon {width: 80px; height: 80px; margin: 0 auto 20px; background: var(--primary-gradient); border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 10px 30px rgba(146, 43, 62, 0.4);}	
    	.benefit-icon i {font-size: 2rem; color: white;}
        .benefit-card h4 {font-size: 1.4rem; font-weight: 700; margin-bottom: 15px; color: var(--dark-color);}
        .benefit-card p { color: #666; line-height: 1.7;}

    	/* FOOTER */
    	footer {background-color: var(--primary-color); color: white; padding: 40px 0;}
    	footer a { color: #f8d7da; text-decoration: none; transition: 0.3s; }
    	footer a:hover { color: white; }
    
        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 120px 0 60px; }
            .navbar-brand span { font-size: 18px !important; }
            .courses-section { padding: 50px 0; }
            .course-image { height: 180px; }
            .nav-item { text-align: center; width: 100%; padding: 5px 0; }
            .btn-nav-login { width: 100%; margin-top: 10px; }
        }
          
        .fade-in {opacity: 0; transform: translateY(30px); transition: all 0.6s ease;}
        .fade-in.visible {opacity: 1; transform: translateY(0);}
        
    </style>
</head>
<body>

    <!-- Navigation Bar -->
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
                        <a href="/login" class="btn btn-primary btn-nav-login text-white">
                            Login
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

            <div class="row g-4">
                <!-- Course 1 -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/Kick-boxing.png" alt="kick-boxing">
                            <div class="course-badge">HYBRID</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot"></div>
                                <div class="level-dot"></div>
                            </div>
                            <h3 class="course-title">Kick-Boxing</h3>
                            <p class="course-description">
                                A high-energy mix of karate, boxing, and Thai. Build explosive power, stamina, and agility while burning calories.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 3 Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Striking & Footwork</li>
                                <li><i class="fas fa-check-circle"></i> Flexibility training</li>
                                <li><i class="fas fa-check-circle"></i> Beginner-friendly atmosphere</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Course 2 -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/MMA.png" alt="mma">
                            <div class="course-badge">OFFLINE ONLY</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot"></div>
                            </div>
                            <h3 class="course-title">Mixed Martial Arts (MMA)</h3>
                            <p class="course-description">
                                The ultimate combat sport. Master wrestling, jiu-jitsu, and striking in an all-in-one program designed for real-world fighting.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 4 Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Grappling & Wrestling</li>
                                <li><i class="fas fa-check-circle"></i> Advanced forms training</li>
                                <li><i class="fas fa-check-circle"></i> Competition preparation</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Course 3 -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/Self-defense.jpg" alt="self defense">
                            <div class="course-badge">HYBRID</div>
                        </div>
                        <div class="course-content">
                            <div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                            </div>
                            <h3 class="course-title">Self Defense</h3>
                            <p class="course-description">
                                Practical techniques for real-life situations. Learn situational awareness and how to neutralize threats effectively.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 5+ Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Personal coaching</li>
                                <li><i class="fas fa-check-circle"></i> Reality-Based Drills</li>
                                <li><i class="fas fa-check-circle"></i> Confidence Building</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Course 4 -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/Stick.png" alt="stick">
                            <div class="course-badge">WEAPONRY</div>
                        </div>
                        <div class="course-content">
                        	<div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                            </div>
                            <h3 class="course-title">Stick</h3>
                            <p class="course-description">
                                Learn the flow of weapons-based combat. Focuses on hand-eye coordination using single and double sticks.
                            </p>
                            <ul class="course-features">
                            	<li><i class="fas fa-check-circle"></i> 3 Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Coordination Drills</li>
                                <li><i class="fas fa-check-circle"></i> Weapon Maneuvers</li>
                                <li><i class="fas fa-check-circle"></i> Anti-bullying skills</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!-- Course 5 -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/Tonfa.png" alt="tonfa">
                            <div class="course-badge">ADVANCED</div>
                        </div>
                        <div class="course-content">
                        	<div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                            </div>
                            <h3 class="course-title">Tonfa</h3>
                            <p class="course-description">
                                Traditional Okinawan weapon training. Learn defensive blocks and offensive strikes using the handle-side weapon.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 3 Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Power Training</li>
                                <li><i class="fas fa-check-circle"></i> Spinning Techniques</li>
                                <li><i class="fas fa-check-circle"></i> Kata Proficiency</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!-- Course 6 -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/Baton.png" alt="baton">
                            <div class="course-badge">SPECIALIZED</div>
                        </div>
                        <div class="course-content">
                        	<div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                            </div>
                            <h3 class="course-title">Baton</h3>
                            <p class="course-description">
                                Specialized training in telescopic or solid batons. Ideal for security professionals and advanced defense enthusiasts.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> 3 Classes per week</li>
                                <li><i class="fas fa-check-circle"></i> Tactical Deployment</li>
                                <li><i class="fas fa-check-circle"></i> Impact Zones</li>
                                <li><i class="fas fa-check-circle"></i> Control Holds</li>
                            </ul>
                        </div>
                    </div>
                </div>                

                <!-- Course 7 -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/Women_Self-defense.png" alt="Women's Self-Defense">
                            <div class="course-badge">SPECIALIZED</div>
                        </div>
                        <div class="course-content">
                        	<div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
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
                        </div>
                    </div>
                </div>

                <!-- Course 8: Personal Training -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="course-card fade-in">
                        <div class="course-image">
                            <img src="${pageContext.request.contextPath}/courses-photos/1-to-1.jpg" alt="Personal Training">
                            <div class="course-badge">1-ON-1</div>
                        </div>
                        <div class="course-content">
                        	<div class="level-indicator">
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                                <div class="level-dot active"></div>
                            </div>
                            <h3 class="course-title">Personal Training (Any Technique)</h3>
                            <p class="course-description">
                                Get individualized attention with one-on-one sessions. Customized training plans designed specifically for your goals and schedule.
                            </p>
                            <ul class="course-features">
                                <li><i class="fas fa-check-circle"></i> Personalized curriculum</li>
                                <li><i class="fas fa-check-circle"></i> Flexible scheduling</li>
                                <li><i class="fas fa-check-circle"></i> Rapid progression</li>
                                <li><i class="fas fa-check-circle"></i> Custom goal setting</li>
                            </ul>
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
                <h2 class="display-4 fw-bold">The ShadowStrikers Advantage</h2>
                <p class="text-muted fs-5">Why our training model is superior</p>
            </div>
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <div class="benefit-card fade-in">
                        <div class="benefit-icon">
                            <i class="fas fa-laptop-house"></i>
                        </div>
                        <h4>Hybrid Flexibility</h4>
                        <p>Missed a class at the dojo? No problem. Access our live-streamed online sessions anytime, anywhere.</p>
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
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4>Progress Tracking</h4>
                        <p>Our custom student portal tracks your attendance, belt progress, and technique mastery through periodic assessments.</p>
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
 		// Scroll Animation
    	const observer = new IntersectionObserver((entries) => {
        	entries.forEach(entry => {
            	if (entry.isIntersecting) entry.target.classList.add('visible');
        	});
    	}, { threshold: 0.1 });
    	document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));	
    </script>
</body>
</html>