<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - Fight Club</title>
    
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

        /* --- Filter Tabs --- */
        .filter-tabs {
            padding: 60px 0 40px;
            background: white;
        }

        .filter-btn {
            background: transparent;
            border: 2px solid #ddd;
            color: #666;
            padding: 12px 30px;
            border-radius: 25px;
            margin: 5px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: transparent;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        /* --- Gallery Section --- */
        .gallery-section {
            padding: 60px 0 100px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 0;
        }

        .gallery-item {
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            cursor: pointer;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            aspect-ratio: 1;
        }

        .gallery-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(102, 126, 234, 0.3);
        }

        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .gallery-item:hover img {
            transform: scale(1.1);
        }

        .gallery-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9));
            opacity: 0;
            transition: opacity 0.4s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .gallery-item:hover .gallery-overlay {
            opacity: 1;
        }

        .gallery-overlay i {
            font-size: 3rem;
            margin-bottom: 15px;
            animation: zoomIn 0.5s ease;
        }

        @keyframes zoomIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        .gallery-overlay h4 {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .gallery-overlay p {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* --- Lightbox Modal --- */
        .lightbox-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.95);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .lightbox-modal.active {
            display: flex;
        }

        .lightbox-content {
            position: relative;
            max-width: 90%;
            max-height: 90%;
            animation: scaleIn 0.3s ease;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0.8);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .lightbox-content img {
            max-width: 100%;
            max-height: 90vh;
            border-radius: 10px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
        }

        .lightbox-close {
            position: absolute;
            top: -40px;
            right: 0;
            background: white;
            color: #333;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            font-size: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .lightbox-close:hover {
            background: var(--primary-color);
            color: white;
            transform: rotate(90deg);
        }

        .lightbox-nav {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255,255,255,0.9);
            color: #333;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            font-size: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .lightbox-nav:hover {
            background: white;
            transform: translateY(-50%) scale(1.1);
        }

        .lightbox-prev {
            left: 20px;
        }

        .lightbox-next {
            right: 20px;
        }

        .lightbox-caption {
            position: absolute;
            bottom: -60px;
            left: 0;
            right: 0;
            text-align: center;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
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

            .gallery-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 15px;
            }

            .lightbox-nav {
                width: 40px;
                height: 40px;
                font-size: 1.2rem;
            }

            .filter-btn {
                padding: 10px 20px;
                font-size: 0.9rem;
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
                        <a class="nav-link active" href="/gallery">Gallery</a>
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
            <h1>Our Gallery</h1>
            <p>Moments of excellence, discipline, and achievement</p>
        </div>
    </header>

    <!-- Filter Tabs -->
    <section class="filter-tabs">
        <div class="container">
            <div class="text-center">
                <button class="filter-btn active" data-filter="all">All</button>
                <button class="filter-btn" data-filter="training">Training</button>
                <button class="filter-btn" data-filter="competition">Competitions</button>
                <button class="filter-btn" data-filter="events">Events</button>
                <button class="filter-btn" data-filter="students">Students</button>
            </div>
        </div>
    </section>

    <!-- Gallery Section -->
    <section class="gallery-section">
        <div class="container">
            <div class="gallery-grid" id="galleryGrid">
                <!-- Gallery Item 1 -->
                <div class="gallery-item fade-in" data-category="training">
                    <img src="https://images.unsplash.com/photo-1555597673-b21d5c935865?w=600" alt="Training Session">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Training Session</h4>
                        <p>Intensive practice</p>
                    </div>
                </div>

                <!-- Gallery Item 2 -->
                <div class="gallery-item fade-in" data-category="competition">
                    <img src="https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?w=600" alt="Championship">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Championship</h4>
                        <p>Victory moment</p>
                    </div>
                </div>

                <!-- Gallery Item 3 -->
                <div class="gallery-item fade-in" data-category="training">
                    <img src="https://images.unsplash.com/photo-1555597408-26bc8e548a46?w=600" alt="Forms Practice">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Forms Practice</h4>
                        <p>Perfecting kata</p>
                    </div>
                </div>

                <!-- Gallery Item 4 -->
                <div class="gallery-item fade-in" data-category="students">
                    <img src="https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?w=600" alt="Young Warriors">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Young Warriors</h4>
                        <p>Kids training</p>
                    </div>
                </div>

                <!-- Gallery Item 5 -->
                <div class="gallery-item fade-in" data-category="events">
                    <img src="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=600" alt="Belt Ceremony">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Belt Ceremony</h4>
                        <p>Promotion day</p>
                    </div>
                </div>

                <!-- Gallery Item 6 -->
                <div class="gallery-item fade-in" data-category="training">
                    <img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600" alt="Sparring">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Sparring Session</h4>
                        <p>Combat training</p>
                    </div>
                </div>

                <!-- Gallery Item 7 -->
                <div class="gallery-item fade-in" data-category="competition">
                    <img src="https://images.unsplash.com/photo-1540384458889-65c1b2f79e9b?w=600" alt="Tournament">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Tournament</h4>
                        <p>Championship match</p>
                    </div>
                </div>

                <!-- Gallery Item 8 -->
                <div class="gallery-item fade-in" data-category="students">
                    <img src="https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=600" alt="Group Training">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Group Training</h4>
                        <p>Team practice</p>
                    </div>
                </div>

                <!-- Gallery Item 9 -->
                <div class="gallery-item fade-in" data-category="events">
                    <img src="https://images.unsplash.com/photo-1517438476312-10d79c077509?w=600" alt="Workshop">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Special Workshop</h4>
                        <p>Guest instructor</p>
                    </div>
                </div>

                <!-- Gallery Item 10 -->
                <div class="gallery-item fade-in" data-category="training">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=600" alt="Conditioning">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Conditioning</h4>
                        <p>Fitness training</p>
                    </div>
                </div>

                <!-- Gallery Item 11 -->
                <div class="gallery-item fade-in" data-category="competition">
                    <img src="https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=600" alt="Medal Ceremony">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Medal Ceremony</h4>
                        <p>Champions crowned</p>
                    </div>
                </div>

                <!-- Gallery Item 12 -->
                <div class="gallery-item fade-in" data-category="students">
                    <img src="https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=600" alt="Student Progress">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                        <h4>Student Progress</h4>
                        <p>Achievement unlocked</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Lightbox Modal -->
    <div class="lightbox-modal" id="lightboxModal">
        <div class="lightbox-content">
            <button class="lightbox-close" id="lightboxClose">×</button>
            <button class="lightbox-nav lightbox-prev" id="lightboxPrev">‹</button>
            <img src="" alt="" id="lightboxImage">
            <button class="lightbox-nav lightbox-next" id="lightboxNext">›</button>
            <div class="lightbox-caption" id="lightboxCaption"></div>
        </div>
    </div>

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

        // Gallery Filter
        const filterBtns = document.querySelectorAll('.filter-btn');
        const galleryItems = document.querySelectorAll('.gallery-item');

        filterBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                // Remove active class from all buttons
                filterBtns.forEach(b => b.classList.remove('active'));
                // Add active class to clicked button
                btn.classList.add('active');

                const filter = btn.getAttribute('data-filter');

                galleryItems.forEach(item => {
                    if (filter === 'all' || item.getAttribute('data-category') === filter) {
                        item.style.display = 'block';
                        setTimeout(() => {
                            item.style.opacity = '1';
                            item.style.transform = 'translateY(0)';
                        }, 10);
                    } else {
                        item.style.opacity = '0';
                        item.style.transform = 'translateY(30px)';
                        setTimeout(() => {
                            item.style.display = 'none';
                        }, 300);
                    }
                });
            });
        });

        // Lightbox functionality
        const lightboxModal = document.getElementById('lightboxModal');
        const lightboxImage = document.getElementById('lightboxImage');
        const lightboxCaption = document.getElementById('lightboxCaption');
        const lightboxClose = document.getElementById('lightboxClose');
        const lightboxPrev = document.getElementById('lightboxPrev');
        const lightboxNext = document.getElementById('lightboxNext');

        let currentImageIndex = 0;
        let visibleImages = [];

        function updateVisibleImages() {
            visibleImages = Array.from(document.querySelectorAll('.gallery-item'))
                .filter(item => item.style.display !== 'none');
        }

        function openLightbox(index) {
            updateVisibleImages();
            currentImageIndex = index;
            const item = visibleImages[currentImageIndex];
            const img = item.querySelector('img');
            const overlay = item.querySelector('.gallery-overlay');
            
            lightboxImage.src = img.src;
            lightboxCaption.textContent = overlay.querySelector('h4').textContent;
            lightboxModal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closeLightbox() {
            lightboxModal.classList.remove('active');
            document.body.style.overflow = 'auto';
        }

        function showPrevImage() {
            currentImageIndex = (currentImageIndex - 1 + visibleImages.length) % visibleImages.length;
            openLightbox(currentImageIndex);
        }

        function showNextImage() {
            currentImageIndex = (currentImageIndex + 1) % visibleImages.length;
            openLightbox(currentImageIndex);
        }

        // Add click events to gallery items
        galleryItems.forEach((item, index) => {
            item.addEventListener('click', () => {
                updateVisibleImages();
                const visibleIndex = visibleImages.indexOf(item);
                openLightbox(visibleIndex);
            });
        });

        // Lightbox controls
        lightboxClose.addEventListener('click', closeLightbox);
        lightboxPrev.addEventListener('click', showPrevImage);
        lightboxNext.addEventListener('click', showNextImage);

        // Close on background click
        lightboxModal.addEventListener('click', (e) => {
            if (e.target === lightboxModal) {
                closeLightbox();
            }
        });

        // Keyboard navigation
        document.addEventListener('keydown', (e) => {
            if (lightboxModal.classList.contains('active')) {
                if (e.key === 'Escape') closeLightbox();
                if (e.key === 'ArrowLeft') showPrevImage();
                if (e.key === 'ArrowRight') showNextImage();
            }
        });
    </script>
</body>
</html>