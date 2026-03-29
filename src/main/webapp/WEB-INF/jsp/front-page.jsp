<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fight Club</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Custom Styles*/
        :root {
            --primary-color: #0d6efd;
            --secondary-color: #6c757d;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* --- Navbar Styles --- */
        .navbar {
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
        }

        .nav-link {
            font-weight: 500;
            color: #333;
            transition: color 0.3s;
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
        
        /* --- Hero Section Styles with Animation --- */
        .hero-section {
            position: relative;
            height: 100vh;
            min-height: 600px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            overflow: hidden;
        }

        /* Background Image with Blur */
        .bg-video {
    		position: absolute;
    		top: 50%;
    		left: 50%;
    		width: 100%;
    		height: 100%;
    		object-fit: cover;
    		transform: translate(-50%, -50%);
    		z-index: 0;
    		/*filter: brightness(60%);*/
		}

        /* Dark Overlay with Wave Animation */
        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1;
        }

        .hero-overlay::before {
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

        .hero-content {
            position: relative;
            z-index: 2;
            padding: 20px;
            max-width: 800px;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            /*animation: slideInDown 0.8s ease-out;*/
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

        .hero-subtitle {
            font-size: 1.5rem;
            margin-bottom: 40px;
            font-weight: 300;
            opacity: 0.9;
            /*animation: slideInUp 0.8s ease-out;*/
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

        .btn-hero {
            padding: 15px 40px;
            font-size: 1.1rem;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin: 10px;
        }

        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
}

        /* --- Features Section --- */
        .features-section {
            padding: 80px 0;
            background-color: #fff;
        }

        .feature-card {
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            transition: transform 0.3s;
            height: 100%;
            background: #f8f9fa;
            border: 1px solid #eee;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        /* --- Footer --- */
        footer {
            background-color: #212529;
            color: #adb5bd;
            padding: 30px 0;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="/">
    			<img src="${pageContext.request.contextPath}/logo/logo_1.png" 
         			alt="logo" 
         			style="height:40px;" />
    			<span class="ms-2 fw-bold" style="font-size:20px; color:#0d6efd;">
        			ShadowStrike
    			</span>
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

    <!-- Hero Section with Wave Animation -->
    <header class="hero-section">
        <video autoplay loop muted playsinline class="bg-video">
    		<source src="${pageContext.request.contextPath}/bg-videos/7780187-uhd_4096_2160_25fps.mp4" type="video/mp4">
		</video>
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1 class="hero-title">Your Fight-Club</h1>
            <p class="hero-subtitle">
                A simple, secure, and powerful platform to learn Marital-Art.
            </p>
            <div class="d-flex justify-content-center flex-wrap">
                <a href="/register" class="btn btn-primary btn-hero">
                    <i class="fas fa-user-plus me-2"></i> Get Started
                </a>
            </div>
        </div>
    </header>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold">Why Choose Us?</h2>
                <p class="text-muted">Key features of our management system</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <h4>Secure Registration</h4>
                        <p class="text-secondary">
                            Robust data validation and secure storage for all user information including passwords and profile photos.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <h4>Fast Management</h4>
                        <p class="text-secondary">
                            Quickly list, edit, and update user profiles with our intuitive dashboard interface.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4>Mobile Friendly</h4>
                        <p class="text-secondary">
                            Fully responsive design ensures you can manage your users from any device, anywhere.
                        </p>
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
                    <p class="mb-0">&copy; 2025 ShadowStrike - Fight Club. All rights reserved.</p>
                    <div class="mt-2">
                        <a href="#" class="text-decoration-none text-secondary me-3"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="text-decoration-none text-secondary me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-decoration-none text-secondary"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Navbar Scroll Effect -->
    <script>
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('shadow-sm');
            } else {
                document.querySelector('.navbar').classList.remove('shadow-sm');
            }
        });
    </script>
</body>
</html>