<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <style>
    	
    	:root {
        	--primary-color: #922b3e; /* Deep Maroon */
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
        .btn-nav-login, .btn-primary {
        	background: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
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
        
        /* Contact Section Styles */
        .contact-section {padding: 100px 0;}
        .contact-info-card {background-color: white; padding: 30px; border-radius: 15px; box-shadow: 0 5px 30px rgba(0,0,0,0.08); margin-bottom: 30px;}
        .contact-info-card h4 {font-weight: 800; color: var(--dark-color); margin-bottom: 20px;}
        .info-item {display: flex; align-items: center; margin-bottom: 25px;}
        .info-icon {color: white; background: linear-gradient(135deg, #7b2d39 0%, #b14555 100%); width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; flex-shrink: 0; margin-right: 15px;}
        .info-text strong {display: block; color: var(--dark-color); font-size: 1.1rem;}
        .info-text span {color: #666; font-size: 0.95rem;}
        .map-placeholder { height: 400px; background-color: #e9ecef; border-radius: 15px; display: flex; align-items: center; justify-content: center; color: #6c757d; font-size: 1.5rem; margin-top: 30px; border: 2px solid #ddd; overflow: hidden;}
        
        /* Contact Form Styling */
        .contact-form-card {background-color: white; padding: 40px; border-radius: 15px; box-shadow: 0 5px 30px rgba(0,0,0,0.08);}
        .form-control {border-radius: 8px; padding: 12px 15px; border: 1px solid #ddd; transition: border-color 0.3s;}
        .form-control:focus {border-color: var(--accent-color); box-shadow: 0 0 0 0.25rem rgba(255, 107, 53, 0.25);}
 
 		/* FOOTER */
    	footer {background-color: var(--primary-color); color: white; padding: 40px 0;}
    	footer a { color: #f8d7da; text-decoration: none; transition: 0.3s; }
    	footer a:hover { color: white; }
        
        /* Responsive */
        @media (max-width: 768px) {
    		.page-header {padding: 120px 0 60px;}
    		.page-header h1 {font-size: 2.2rem;}
    		.contact-section {padding: 50px 0;}
    		.contact-form-card {padding: 25px; margin-bottom: 30px;}
    		.map-placeholder {height: 250px;}
    		.info-icon {width: 40px; height: 40px; font-size: 1rem;}
    		.info-text strong {font-size: 1rem;}
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
                    	<a class="nav-link" href="/events">Events</a>
                    </li>
                    <li class="nav-item">	
                    	<a class="nav-link active" href="/contactUs">Contact Us</a>
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
                        
                        <form action="/sendEnquiry" method="POST" id="contactForm">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <input type="text" name="fullName" class="form-control" placeholder="Your Full Name" required>
                                </div>
                                <div class="col-md-6 mt-3 mt-md-0">
                                    <input type="email" name="email" class="form-control" placeholder="Your Email Address" required>
                                </div>
                            </div>
                            <div class="mb-3">
    							<label class="form-label fw-bold">Contact Number</label>
    							<div class="input-group">
        							<span class="input-group-text"><i class="fas fa-phone"></i></span>
        							<input type="tel" name="phone" class="form-control" placeholder="Enter contact number" pattern="[0-9]{10}" required>
    							</div>
    						</div>
                            <div class="mb-3">
    							<label class="form-label text-dark fw-bold">Reason for Contact</label>
    							<select name="subject" class="form-control" required>
        							<option value="" disabled selected>Select a Subject</option>
        							<option value="General Inquiry">General Inquiry</option>
        							<option value="Boxing Training">Boxing Training</option>
        							<option value="MMA Classes">MMA Classes</option>
        							<option value="Membership Question">Membership Question</option>
    							</select>
							</div>
                            <div class="mb-4">
                                <textarea name="message" class="form-control" rows="5" placeholder="Your Message..." required></textarea>
                            </div>
                            <button type="submit" id="submitBtn" class="btn btn-primary btn-lg px-4 w-100">
    							<span id="btnText">Send Inquiry <i class="fas fa-paper-plane ms-2"></i></span>
    							<span id="btnLoader" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
    							<span id="loadingText" class="d-none ms-2">Sending...</span>
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
                                <span>Vallabh Vidyanagar, Anand-Gujrat, India</span>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-phone"></i></div>
                            <div class="info-text">
                                <strong>Call Us</strong>
                                <span>+91 70415-51670</span>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-envelope"></i></div>
                            <div class="info-text">
                                <strong>Email Support</strong>
                                <span>shadowStrikers@gmail.com</span>
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
                                <span>8:00 AM - 4:00 PM</span>
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
        
        //fetch data and send dashboard
        document.getElementById('contactForm').addEventListener('submit', function(event) {
            event.preventDefault();
            
         	// બટન અને લોડરના એલિમેન્ટ્સ મેળવો
            const btn = document.getElementById('submitBtn');
            const btnText = document.getElementById('btnText');
            const btnLoader = document.getElementById('btnLoader');
            const loadingText = document.getElementById('loadingText');
            
            // ૧. બટનને લોડિંગ સ્ટેટમાં મૂકો
            btn.disabled = true;
            btnText.classList.add('d-none');
            btnLoader.classList.remove('d-none');
            loadingText.classList.remove('d-none');
            
            const formData = new FormData(this);
            const form = this;
            
            fetch('/sendEnquiry', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(response => {
                if(response.ok) {
                    showSuccessAlert(); 
                    this.reset();
                }
            })
            .catch(error => {
        		console.error('Error:', error);
        		alert("Something went wrong. Please try again.");
        	})
            .finally(() => {
                // ૨. પ્રોસેસ પૂરી થાય એટલે બટનને પાછું નોર્મલ કરો
                btn.disabled = false;
                btnText.classList.remove('d-none');
                btnLoader.classList.add('d-none');
                loadingText.classList.add('d-none');
            });
        });

        function showSuccessAlert() {
            // JQuery નો ઉપયોગ કરીને જૂના એલર્ટ કાઢવા
            $(".alert").remove();
            
            const alertHtml = `
                <div class="alert alert-success mt-3 alert-dismissible fade show">
                    <strong>Success!</strong> Your enquiry is now with our team.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>`;
            
            $(".contact-form-card").prepend(alertHtml);

            // ૧૦ સેકન્ડ પછી ઓટોમેટિકલી ગાયબ થશે
            setTimeout(function() {
                $(".alert").fadeOut('slow', function() {
                    $(this).remove();
                });
            }, 10000); 
        }
    </script>  
</body>
</html>