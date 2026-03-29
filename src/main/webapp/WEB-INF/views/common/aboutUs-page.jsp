<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    
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
        	--font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        	--accent-color: #c62b3c;
    	}    
    	
    	* {margin: 0; padding: 0; box-sizing: border-box;}
    	body {font-family: var(--font-family); background-color: #f7f7f7; overflow-x: hidden;
    	}
		
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

    	/* ABOUT CONTENT & MISSION CARDS */
    	.about-section { padding: 100px 0; position: relative; }
    	.about-content {display: flex; align-items: center; gap: 60px; margin-bottom: 80px;}
        .about-image {flex: 1;position: relative;animation: fadeInLeft 1s ease-out;}
        
        @keyframes fadeInLeft {
            from {opacity: 0; transform: translateX(-50px);}
            to {opacity: 1; transform: translateX(0);}
        }

    	.about-image::before {content: ''; position: absolute; top: -20px; left: -20px; width: 100%; height: 100%; border: 3px solid var(--primary-color); border-radius: 15px; z-index: -1;}
        .about-image img {width: 100%; height: 450px; object-fit: cover; border-radius: 15px; box-shadow: 0 20px 60px rgba(0,0,0,0.2); transition: transform 0.5s ease; border: 3px solid #000000; padding: 0 !important; background-color: transparent !important;}
        .about-image:hover img {transform: scale(1.05);}
        .about-text {flex: 1; animation: fadeInRight 1s ease-out;}

        @keyframes fadeInRight {
            from {opacity: 0; transform: translateX(50px);}
            to {opacity: 1; transform: translateX(0);}
        }

        .about-text h2 {font-size: 2.8rem; font-weight: 800; color: var(--dark-color); margin-bottom: 25px; position: relative; display: inline-block;}
        .about-text h2::after {content: ''; position: absolute; bottom: -10px; left: 0; width: 60px; height: 4px; background: linear-gradient(90deg, var(--primary-color), var(--accent-color)); border-radius: 2px;}
        .about-text p {font-size: 1.15rem; line-height: 1.9; color: #555; margin-bottom: 20px;}
        
        /* Animated Mission & Vision Cards */
        .mission-vision-section {background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); padding: 100px 0; position: relative;}
    	.mv-card {background: white; border-radius: 20px; border-bottom: 4px solid transparent; padding: 50px; height: 100%; box-shadow: 0 10px 40px rgba(0,0,0,0.1); transition: all 0.3s ease; position: relative; overflow: hidden;}
		.mv-card:hover {transform: translateY(-10px); border-bottom: 4px solid var(--primary-color); box-shadow: 0 15px 35px rgba(0,0,0,0.1);}

    	/* Matches Icon Circle from Home Page */
    	.mv-card-icon {
        	width: 90px;
        	height: 90px;
        	background: var(--primary-color);
        	color: white;
        	border-radius: 50%;
        	display: flex;
        	align-items: center;
        	justify-content: center;
        	margin-bottom: 25px;
        	font-size: 2rem;
        	box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            transition: transform 0.3s ease;
    	}
    	
    	.mv-card:hover .mv-card-icon {transform: scale(1.1);}
	    .mv-card-icon i {font-size: 2.5rem; color: white;}
        .mv-card h3 {font-size: 2rem; font-weight: 800; margin-bottom: 20px; color: var(--dark-color);}
        .mv-card p {font-size: 1.1rem; line-height: 1.8; color: #666;}
        
        /* Dynamic Values Section */
        .values-section {padding: 100px 0; background: #fff;}
        .value-item {padding: 40px; border-radius: 15px; background: linear-gradient(135deg, #f5f7fa 0%, #fff 100%); margin-bottom: 25px; transition: all 0.4s ease; border-left: 5px solid transparent; position: relative; overflow: hidden;}
        .value-item::before {content: ''; position: absolute; top: 0; left: 0; width: 5px; height: 0; background: linear-gradient(180deg, var(--primary-color), var(--accent-color)); transition: height 0.4s ease;}
        .value-item:hover::before {height: 100%;}
        .value-item:hover {transform: translateX(10px); box-shadow: 0 10px 40px rgba(0,0,0,0.15); background: white; border-color: var(--primary-color);}
        .value-item h4 {font-weight: 800; color: var(--dark-color); margin-bottom: 12px; font-size: 1.4rem;}
        .value-item h4 i {color: var(--primary-color); margin-right: 10px;}
        .value-item p {color: #666; margin: 0; font-size: 1.05rem; line-height: 1.7;}

    	/* FOOTER */
    	footer {background-color: var(--primary-color); color: white; padding: 40px 0;}
    	footer a { color: #f8d7da; text-decoration: none; transition: 0.3s; }
    	footer a:hover { color: white; }

       	/* Responsive */  
		@media (max-width: 991px) {
    		.about-content {flex-direction: column;gap: 30px;}
    		.about-image img {height: 300px;}
		}

		@media (max-width: 768px) {
    		.page-header {padding: 140px 0 80px;}
    		.page-header h1 {font-size: 2.2rem;}
    		.page-header p {font-size: 1rem;}
    		.about-text h2 {font-size: 2rem;}
    		.mv-card {padding: 30px;}
    		.mv-card h3 {font-size: 1.6rem;}
		}

		@media (max-width: 480px) {
    		.navbar-brand span {font-size: 18px !important;}
    		.btn-nav-login {padding: 8px 15px; font-size: 14px;}
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
                    	<a class="nav-link active" href="/aboutUs">About Us</a>
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
            <h1>Our Legacy: ShadowStrikers Academy</h1>
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
                    <img src="${pageContext.request.contextPath}/admin-photo/image-2.jpeg" alt="Admin">
                </div>
                <div class="about-text">
                    <h2>Sensei Gunjesh Machhi</h2>
                    <div class="mb-3">
                        <span class="badge bg-primary fs-6 me-2">Your Instructor</span>
                        <span class="badge bg-danger fs-6">Dual Black Belt Holder</span>
                    </div>
                    <p class="lead text-dark fw-500">
        				Empowering lives through discipline, strength, and the art of self-defense.
    				</p>
    				<p>
        				Sensei Gunjesh Machhi is a highly skilled Martial Arts practitioner and educator with over <strong>6 years of professional coaching experience</strong>. As a dedicated <strong>Black Belt holder in both Karate and Taekwondo</strong>, he brings a versatile and rigorous approach to training students of all ages.
    				</p>
    				<p>
        				Beyond the dojo, Sensei Gunjesh is a proven athlete having competed as a <strong>National-level Thai-Boxing player</strong>. His teaching philosophy is rooted in the belief that martial arts is not just about combat, but about building character, resilience, and unwavering focus in every aspect of life.
    				</p>
    				
                    <div class="row mt-4">
        				<div class="col-md-6">
            				<h6 class="fw-bold text-uppercase small text-muted">Core Specializations</h6>
            					<ul class="list-unstyled">
                					<li><i class="fas fa-check-circle text-success me-2"></i> Professional Karate & Taekwondo</li>
                					<li><i class="fas fa-check-circle text-success me-2"></i> National Thai-Boxing Techniques</li>
                					<li><i class="fas fa-check-circle text-success me-2"></i> Advanced Self-Defense Systems</li>
                					<li><i class="fas fa-check-circle text-success me-2"></i> Physical & Mental Conditioning</li>
            					</ul>
        				</div>
        				<div class="col-md-6">
            				<h6 class="fw-bold text-uppercase small text-muted">Key Milestones</h6>
            					<ul class="list-unstyled">
                					<li><i class="fas fa-trophy text-warning me-2"></i> Gold Medalist [IWFI Karate]</li>
                					<li><i class="fas fa-medal text-warning me-2"></i> National Thai-Boxing Participant</li>
                					<li><i class="fas fa-certificate text-warning me-2"></i> Certified Martial Arts Trainer</li>
                					<li><i class="fas fa-user-shield text-warning me-2"></i> Professional Referee & Consultant</li>
            					</ul>
        				</div>
    				</div>
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