<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
        	border-radius: 25px; /* Matches your Enroll/CTA shape */
        	font-weight: 700 !important;
        	box-shadow: 0 8px 15px rgba(146, 43, 62, 0.4), inset 0 2px 4px rgba(255, 255, 255, 0.2);
        	transition: all 0.3s ease;
    	}
    	
    	.btn-nav-login:hover, .btn-primary:hover {
        	transform: translateY(-3px);
        	box-shadow: 0 12px 20px rgba(146, 43, 62, 0.6);
    	}

        /* Filter Tabs */
        .filter-tabs {padding: 60px 0 40px; background: white;}
        .filter-tabs .container .text-center {display: flex; overflow-x: auto; white-space: nowrap; padding-bottom: 10px; -webkit-overflow-scrolling: touch; justify-content: flex-start;}
        .filter-btn {background: transparent; border: 2px solid #ddd; color: #666; padding: 8px 18px; border-radius: 25px; margin: 5px; font-weight: 600; font-size: 0.85rem; flex: 0 0 auto; transition: all 0.3s ease; cursor: pointer;}
        .filter-btn:hover, .filter-btn.active {background: var(--primary-gradient) !important; border-color: transparent; color: white; transform: translateY(-3px); box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);}

        /* Gallery Section */
        .gallery-section {padding: 60px 0 100px; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);}
        .gallery-grid {display: grid; grid-template-columns: repeat(2, 1fr);; gap: 10px; padding: 0 10px;}
        .gallery-item {position: relative; overflow: hidden; border-radius: 15px; cursor: pointer; box-shadow: 0 10px 30px rgba(0,0,0,0.1); transition: all 0.4s ease; aspect-ratio: 1;}
        .gallery-item:hover {transform: translateY(-10px); box-shadow: 0 20px 50px rgba(102, 126, 234, 0.3);}
        .gallery-item img {width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease;}
        .gallery-item:hover img {transform: scale(1.1);}
        .gallery-overlay {position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0; transition: opacity 0.4s ease; display: flex; flex-direction: column; align-items: center; justify-content: center; color: white;}
        .gallery-item:hover .gallery-overlay {opacity: 1;}
        .gallery-overlay i {font-size: 3rem; margin-bottom: 15px; animation: zoomIn 0.5s ease;}

        @keyframes zoomIn {
            from {transform: scale(0);}
            to {transform: scale(1);}
        }

        .gallery-overlay h4 {font-size: 1.3rem; font-weight: 700; margin-bottom: 5px;}
        .gallery-overlay p {font-size: 0.9rem; opacity: 0.9;}

        /* Lightbox Modal */
        .lightbox-modal {display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.95); z-index: 9999; align-items: center; justify-content: center; animation: fadeIn 0.3s ease;}

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .lightbox-modal.active {display: flex;}
        .lightbox-content { position: relative; max-width: 90%; max-height: 90%; animation: scaleIn 0.3s ease;}

        @keyframes scaleIn {
            from {transform: scale(0.8); opacity: 0;}
            to {transform: scale(1); opacity: 1;}
        }

        .lightbox-content img {max-width: 100%; max-height: 90vh; border-radius: 10px; box-shadow: 0 20px 60px rgba(0,0,0,0.5);}
        .lightbox-close {position: absolute; top: 20px; right: 20px; background: white; color: #333; border: none; width: 40px; height: 40px; border-radius: 50%; font-size: 1.5rem; cursor: pointer; transition: all 0.3s ease;}
        .lightbox-close:hover {background: var(--primary-color); color: white; transform: rotate(90deg);}
        .lightbox-nav {position: absolute; top: 50%; transform: translateY(-50%); background: rgba(255,255,255,0.9); color: #333; border: none; width: 40px; height: 40px; border-radius: 50%; font-size: 1.2rem; cursor: pointer; transition: all 0.3s ease;}
        .lightbox-nav:hover {background: white; transform: translateY(-50%) scale(1.1);}
        .lightbox-prev {left: 10px;}
        .lightbox-next {right: 10px;}
        .lightbox-caption {position: absolute; bottom: 20px; left: 0; right: 0; text-align: center; color: white; font-size: 0.9rem; font-weight: 600;}
        
        /* FOOTER */
    	footer {background-color: var(--primary-color); color: white; padding: 40px 0;}
    	footer a { color: #f8d7da; text-decoration: none; transition: 0.3s; }
    	footer a:hover { color: white; }
    	  
        /* Responsive */
        @media (max-width: 768px) {
    		.page-header {padding: 120px 0 80px;}
    		.page-header h1 {font-size: 2.2rem;}
			.page-header p {font-size: 1.1rem; padding: 0 15px;}
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