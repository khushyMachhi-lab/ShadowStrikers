<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
    
        :root { --primary-color: #922b3e; --primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);}
        
        body { 
            background: url('${pageContext.request.contextPath}/bg-photos/fight-2.jpg') no-repeat center center fixed; 
            background-size: cover; 
            min-height: 100vh; 
            display: flex; 
            align-items: center; 
            position: relative; 
            margin: 0; 
        }
        
        body::before { 
        	content: ""; 
        	position: fixed; 
        	top: 0; 
        	left: 0; 
        	width: 100%; 
        	height: 100%; 
        	background: rgba(0, 0, 0, 0.7); 
        	z-index: 0;
        }
        
        .card { z-index: 1; background: white; max-width: 450px; width: 100%; border-radius: 20px; overflow: hidden; box-shadow: 0 15px 35px rgba(0,0,0,0.5); border: none; margin: auto; }
        .header { background: var(--primary-gradient); color: white; padding: 30px; text-align: center; }
        .btn-reset { background: var(--primary-gradient); border: none; color: white !important; font-weight: 700; padding: 12px; border-radius: 30px; width: 100%; transition: 0.3s; }
        .btn-reset:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(146, 43, 62, 0.4); }
        
        /* Responsive */
    	@media (max-width: 576px) {
        	.card {border-radius: 15px;}
        	.header {padding: 20px 15px;}
        	.header i {font-size: 2.5rem;}
        	.header h2 {font-size: 1.5rem;}
        	.p-4.p-md-5 {padding: 1.5rem !important;}
        	.fs-4 {font-size: 1.25rem !important;}
        
    </style>
</head>
<body>
    <div class="card">
        <div class="header">
            <i class="fas fa-key fa-3x mb-3"></i>
            <h2 class="fw-bold mb-0">VERIFY OTP</h2>
            <p class="small mb-0 opacity-75">Code sent to: ${email}</p>
        </div>
        <div class="p-4 p-md-5">
            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2 small"><i class="fas fa-times-circle me-2"></i> ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/verify-and-reset" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">6-Digit OTP</label>
                    <input type="text" name="otp" class="form-control text-center fs-4 fw-bold" 
                           placeholder="000000" maxlength="6" pattern="\d{6}" required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">New Secure Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-lock text-muted"></i></span>
                        <input type="password" name="newPassword" class="form-control" 
                               placeholder="Min. 8 characters" 
                               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
            				<i class="fas fa-eye" id="eyeIcon"></i>
        				</button>
                    </div>
                    <div class="form-text mt-2" style="font-size: 0.7rem;">
                        Must include uppercase, lowercase, number, and special character.
                    </div>
                </div>

                <button type="submit" class="btn btn-reset">RESET PASSWORD</button>
            </form>
        </div>
    </div>
    
    <script>
    	const togglePassword = document.querySelector('#togglePassword');
    	const password = document.querySelector('#newPassword');
    	const eyeIcon = document.querySelector('#eyeIcon');

    	togglePassword.addEventListener('click', function (e) {

        	const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        	password.setAttribute('type', type);
        
        	eyeIcon.classList.toggle('fa-eye');
        	eyeIcon.classList.toggle('fa-eye-slash');
    	});
    	
  
        const urlParams = new URLSearchParams(window.location.search);
        
        if (urlParams.has('resetSuccess')) {
            Swal.fire({
                title: 'Success!',
                text: 'Your password has been reset successfully.',
                icon: 'success',
                showConfirmButton: false,
                timer: 3000, 
                timerProgressBar: true,
                background: '#ffffff',
                iconColor: '#922b3e', 
                willClose: () => {
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            });
        }
	</script>
</body>
</html>