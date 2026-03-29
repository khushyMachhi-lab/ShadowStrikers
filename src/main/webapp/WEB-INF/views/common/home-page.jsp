<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons (Required for the feature cards and footer) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
   
    <style>
    
        /* Define Custom Colors */
        :root {
            --primary-color: #922b3e; /* The maroon/dark red color from the image */
            --primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
            --secondary-color: #ffffff;
            --text-dark: #333;
            --font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {font-family: var(--font-family); background-color: #f7f7f7; overflow-x: hidden;}

        /* Navigation Bar Styling */
        .navbar {
            position: absolute; /* Absolute position over the hero */
            top: 0;
            left: 0;
            width: 100%;
            z-index: 100; /* Ensure it's above the image and overlay */
            background-color: transparent; /* Make it transparent */
            box-shadow: none; /* Remove shadow to blend into the image */
            padding-top: 1rem;
            padding-bottom: 1rem;
        }

        .navbar .navbar-brand {font-size: 1.8rem; text-shadow: 0 1px 3px rgba(0,0,0,0.5);}
        .navbar-brand:hover .gradient-text {filter: brightness(1.3);} /* Add a hover effect to the Logo */
        .navbar .nav-link {color: var(--secondary-color) !important; padding-left: 1rem !important; padding-right: 1rem !important; transition: color 0.3s ease; text-shadow: 0 1px 3px rgba(0,0,0,0.5);}
        .navbar .nav-link:not(.glass-nav-btn):hover {color: #f8d7da !important; text-shadow: none;}
        .navbar-toggler {border-color: rgba(255, 255, 255, 0.5) !important;}
        
        .gradient-text {
    		background: linear-gradient(135deg, #7b2d39 0%, #b14555 100%);
    		-webkit-background-clip: text;
    		-webkit-text-fill-color: transparent; /* Changed from solid to transparent */
    		font-weight: 900;
    		display: inline-block;
    		transition: filter 0.3s ease;
		}

        /* Hero Section Styling */
        .hero-section {position: relative; min-height: 80vh; background-size: cover; background-position: center; background-repeat: no-repeat; overflow: hidden; display: flex; z-index: 1; padding-top: 5rem;}
        .hero-overlay {position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 1;} /* Dark Overlay for better text contrast */
        .hero-section > .container-xl {z-index: 2;} /* Ensure content is above the overlay */
        .hero-section h1 {text-shadow: 0 2px 4px rgba(0,0,0,0.5);}

        /* CTA Buttons */
        .btn-primary, .btn-nav-login {
    		background: var(--primary-gradient);
    		color: white !important;
    		padding: 12px 30px;
    		border-radius: 25px;
    		border: none;
    		font-weight: 700;
    		transition: all 0.3s ease;
    		box-shadow: 0 8px 15px rgba(146, 43, 62, 0.4);
		}

        .btn-primary:hover {transform: translateY(-3px); box-shadow: 0 12px 20px rgba(146, 43, 62, 0.6); color: white;}

        /* Feature Cards Styling */
        .feature-cards-section {margin-top: -100px; z-index: 10; position: relative; padding-bottom: 50px;}
        .feature-card {border-radius: 12px; border: none; min-height: 180px; transition: transform 0.3s ease, box-shadow 0.3s ease; box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1); background-color: var(--secondary-color);}
        .feature-card:hover {transform: translateY(-8px); box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);}
        .icon-circle {width: 65px; height: 65px; background-color: var(--primary-color); color: var(--secondary-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);}
        
        /* CTA Banner Styling (Updated to be distinct and separate) */
        .cta-banner {background-color: var(--secondary-color); border-radius: 12px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); overflow: hidden; margin-top: 3rem; margin-bottom: 3rem; z-index: 15; position: relative;}
        .icon-block { background-color: var(--primary-color); color: var(--secondary-color); border-radius: 12px; padding: 1.5rem; min-width: 120px; display: flex; flex-direction: column; align-items: center; justify-content: center;} 
        .cta-content {padding: 1.5rem;} 
        .cta-content p {color: #6c757d;}

        /* Why Choose Section Icons */
    	.why-choose-section {padding: 100px 0; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); position: relative;}
        .benefit-card {text-align: center; padding: 40px 30px; border-radius: 15px; background: linear-gradient(135deg, #f5f7fa 0%, #fff 100%); box-shadow: 0 10px 30px rgba(146, 43, 62, 0.05); border: 1px solid rgba(146, 43, 62, 0.08); transition: all 0.4s ease; height: 100%; overflow: hidden;}
        .benefit-card:hover {transform: translateY(-10px); box-shadow: 0 15px 40px rgba(0,0,0,0.1);}     
    	.benefit-icon {width: 80px; height: 80px; margin: 0 auto 20px; background: linear-gradient(135deg, #7b2d39 0%, #b14555 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 10px 30px rgba(146, 43, 62, 0.4);}	
    	.benefit-icon i {font-size: 2rem; color: white;}
        .benefit-card h4 {font-size: 1.4rem; font-weight: 700; margin-bottom: 15px; color: var(--dark-color);}
        .benefit-card p {color: #666; line-height: 1.7;}
        
         /* Footer Styling */
        .footer {background-color: var(--primary-color);}
        .footer h5 {color: var(--secondary-color);}
        .footer .list-unstyled a {color: #f8d7da; font-size: 0.95rem; transition: color 0.3s ease;}
        .footer .list-unstyled a:hover {color: var(--secondary-color);}
        .social-links a {transition: color 0.3s ease;}
        .social-links a:hover {color: #f8d7da !important;}
        
        /* Responsive */
		@media (max-width: 768px) {
    		.hero-section h1 {font-size: 2.2rem;}
    		.cta-banner {flex-direction: column; text-align: center; padding: 20px !important;}
    		.icon-block {width: 100%; margin-bottom: 15px; border-radius: 12px !important;}
    		.feature-cards-section {margin-top: -40px;}
		}
        
    </style>
</head>
<body>

    <!-- 1. Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar">
        <div class="container-fluid container-xl">
            <a class="navbar-brand text-white fw-bold" href="${pageContext.request.contextPath}/">
    			<img src="${pageContext.request.contextPath}/logo/logo_2.png" alt="logo" style="height:40px;" />
    			<span class="ms-2 fw-bold gradient-text" style="font-size:22px;">ShadowStrikers</span>
			</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
    			<span class="navbar-toggler-icon" style="filter: invert(1);"></span> 
    		</button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/home">Home</a>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="/aboutUs">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="/courses">Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="/gallery">Gallery</a></li>
                    <li class="nav-item"><a class="nav-link" href="/events">Events</a></li>
                    <li class="nav-item"><a class="nav-link" href="/contactUs">Contact Us</a></li>
                    <li class="nav-item ms-lg-3">
                        <a href="/login" class="btn btn-primary btn-nav-login text-white">
                            Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 2. Hero Section -->
    <header class="hero-section text-center d-flex align-items-center justify-content-center text-white"
    	style="background-image: url('${pageContext.request.contextPath}/bg-photos/fight_1.jpeg');">
    	
        <div class="hero-overlay"></div> 
        <div class="container-xl position-relative p-4 p-md-5">
            <h1 class="display-3 fw-bold mb-3">Master Your Skills, Unleash Your Potential</h1>
            
            <!-- Call-to-Action (CTA) Buttons -->
            <div class="d-flex flex-column flex-sm-row justify-content-center gap-3 mb-5">
                <a href="/contactUs" class="btn btn-primary btn-lg px-4 py-2 text-uppercase fw-bold">Enquire Us</a>
            </div>
        </div>
    </header>

    <!-- 3. Feature Cards Section -->
    <section class="container-xl feature-cards-section">
        <div class="row g-4 justify-content-center">
            <!-- Card 1: Graduate Success -->
            <div class="col-lg-4 col-md-6">
                <div class="card feature-card text-center h-100">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <div class="icon-circle mb-3">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <h4 class="card-title fw-bold text-dark">Expert Black Belt Trainers</h4>
                    </div>
                </div>
            </div>

            <!-- Card 2: Student-Faculty Ratio -->
            <div class="col-lg-4 col-md-6">
                <div class="card feature-card text-center h-100">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <div class="icon-circle mb-3">
                            <i class="fas fa-users"></i>
                        </div>
                        <h4 class="card-title fw-bold text-dark">Personalized Combat Training</h4>
                    </div>
                </div>
            </div>

            <!-- Card 3: Global Community -->
            <div class="col-lg-4 col-md-6">
                <div class="card feature-card text-center h-100">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <div class="icon-circle mb-3">
                            <i class="fas fa-globe"></i>
                        </div>
                        <h4 class="card-title fw-bold text-dark">State-of-the-Art Dojo</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- 4. Campus Day CTA Banner -->
    <section class="container-xl">
        <div class="cta-banner d-flex flex-wrap align-items-center justify-content-between p-3 p-md-0 mx-auto">
            
            <!-- Left: Icon Block -->
            <div class="icon-block me-3 rounded-start-lg h-100 d-flex align-items-center justify-content-center">
            	<i class="fas fa-user-plus fa-3x text-white"></i>
        	</div>
            
            <!-- Middle: Content -->
            <div class="cta-content flex-grow-1">
                <h4 class="fw-bold mb-1 text-dark">Join Our Next Batch</h4>
                <p class="mb-0 small text-muted">Begin your journey towards discipline and strength. Limited slots available for new students!</p>
            </div>
            
            <!-- Right: Register Button -->
            <div class="p-3 p-md-4">
                <a href="/register" class="btn btn-primary px-4 py-2 text-uppercase fw-bold border-0">Register</a>
            </div>
        </div>
    </section>
  
    <!-- Why Choose Section -->
    <section class="why-choose-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-4 fw-bold">Why ShadowStrikers?</h2>
                <p class="text-muted fs-5">Experience the elite standard of martial arts training</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="benefit-card fade-in">
                        <div class="benefit-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <h4>Certified Masters</h4>
                        <p>Train under world-class black belt instructors dedicated to authentic techniques and student safety.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card fade-in">
                        <div class="benefit-icon">
                            <i class="fas fa-hand-fist"></i>
                        </div>
                        <h4>Discipline & Focus</h4>
                        <p>We don't just teach fighting; we build character, mental toughness, and unwavering self-confidence.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card fade-in">
                        <div class="benefit-icon">
                            <i class="fas fa-dumbbell"></i>
                        </div>
                        <h4>Premium Facilities</h4>
                        <p>Our state-of-the-art dojo features Olympic-grade safety mats and professional combat equipment.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 5. Footer Section -->
    <footer class="footer text-white pt-5 pb-3 mt-5">
        <div class="container-xl">
            <div class="row g-4">
                <!-- Column 1: Logo, Description, and Social Links -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <h5 class="fw-bold mb-3">ShadowStrikers</h5>
                    <p class="text-light opacity-75">"Dedicated to teaching authentic martial arts, building character, and empowering individuals through disciplined training."</p>
                    <div class="social-links mt-4">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-lg"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-linkedin-in fa-lg"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram fa-lg"></i></a>
                    </div>
                </div>

                <!-- Column 2: Contact Info -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <h5 class="fw-bold mb-3">Contact Information</h5>
                    <p class="text-light opacity-75"><i class="fas fa-map-marker-alt me-2"></i> Vallabh Vidyanagar, Anand-Gujrat, India.</p>
                    <p class="text-light opacity-75"><i class="fas fa-phone me-2"></i> +91 70415-51670</p>
                    <p class="text-light opacity-75"><i class="fas fa-envelope me-2"></i> shadowStrikers@gmail.com</p>
                </div>
                
                <!-- Column 3: Find Us / Map Placeholder -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <h5 class="fw-bold mb-3">Find Us</h5>
                    <div class="bg-white rounded overflow-hidden shadow-lg">
                        <img src="https://placehold.co/300x150/e9ecef/212529?text=Map+Placeholder" alt="Map Placeholder" class="img-fluid" onerror="this.onerror=null;this.src='https://placehold.co/300x150/e9ecef/212529?text=Map+Placeholder';">
                    </div>
                </div>
            </div>
            
            <hr class="mt-4 mb-3 border-light opacity-50">
            
            <!-- Copyright -->
            <div class="text-center">
                <p class="text-light opacity-75 mb-0">&copy; 2025 ShadowStrikers Academy. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    	const observer = new IntersectionObserver((entries) => {
        	entries.forEach(entry => {
            	if (entry.isIntersecting) entry.target.classList.add('visible');
        	});
    	}, { threshold: 0.1 });

    	document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));
	</script>
	
</body>
</html>