<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #922b3e;
            --primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        }

        body {
            background: url('${pageContext.request.contextPath}/bg-photos/fight-2.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            margin: 0;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }

        .container {z-index: 1; display: flex; justify-content: center;}
        .card {background-color: rgba(255, 255, 255, 0.98); max-width: 420px; width: 100%; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); border: none; padding-bottom: 10px 10px 30px 10px;}
        .card-body {padding: 1.5rem !important;}
        .login-header {background: var(--primary-gradient); color: white; padding: 30px; text-align: center;}
        .form-label { font-weight: 600; color: #444; margin-bottom: 8px;}
        .form-control:focus + .input-group-text, .input-group:focus-within .input-group-text {border-color: var(--primary-color); color: var(--primary-color) !important;}
        .form-text {line-height: 1.2;}
		.form-control:invalid:focus {border-color: #dc3545; box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.2);}

        .btn-login {
        	background: var(--primary-gradient); 
        	border: none; 
        	color: white; 
        	font-weight: 700; 
        	padding: 10px 20px; 
        	border-radius: 30px; 
        	transition: 0.3s; 
        	width: 80%; 
        	display: block; 
        	margin: 0 auto; 
        	margin-top: 5px;
        	margin-bottom: 35px;
        }
        
        .btn-login:hover {transform: translateY(-2px); box-shadow: 0 8px 20px rgba(146, 43, 62, 0.4); color: white;}

        .btn-outline-maroon {border: 2px solid var(--primary-color); color: var(--primary-color); font-weight: 700; border-radius: 30px; background: transparent; transition: 0.3s; display: block; width: 70%; padding: 10px 15px; text-align: center; text-decoration: none; margin: 0 auto;}
        .btn-outline-maroon:hover {background: var(--primary-color) !important; color: white !important; box-shadow: 0 4px 12px rgba(146, 43, 62, 0.3);}
        
        .forgot-link-container {margin-bottom: 10px !important;}
		.register-text-container {margin-top: 25px !important; margin-bottom: 20px !important;}
        
        /* Responsive */
		@media (max-width: 576px) {
    		.container {padding: 20px;}  
    		.card {max-width: 100%; border-radius: 15px;}
    		.login-header {padding: 20px;}
			.login-header h2 {font-size: 1.5rem;}
    		.btn-login, .btn-outline-maroon {padding: 10px; font-size: 0.9rem;}
		}
		
    </style>
</head>
<body>

    <div class="container">
        <div class="card">
            <div class="login-header">
                <h2 class="fw-bold mb-0">LOGIN-PORTAL</h2>
                <p class="small mb-0 mt-2 opacity-75">Admin & Student Access</p>
            </div>
            
            <div class="p-4">
            	<c:if test="${param.resetSuccess == 'true'}">
    				<div class="alert alert-success text-center">
        				 Password Reset Successfully!
    				</div>
				</c:if>
                <c:if test="${not empty loginError}">
                    <div class="alert alert-danger text-center" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> ${loginError}
                    </div>
                </c:if>

                <%-- Form points to your login controller --%>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="loginId" class="form-label">Email or Username</label>
        				<div class="input-group">
            				<span class="input-group-text bg-light border-end-0"><i class="fas fa-user text-muted"></i></span>
            				<input type="text" id="loginId" name="loginId" class="form-control border-start-0" placeholder="Admin Email or Student Username" required>
       	 				</div>
                    </div>

                    <div class="mb-3">
    					<label for="password" class="form-label d-flex justify-content-between">
        				    Password
    					</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-lock text-muted"></i></span>
                            <input type="password" id="password" name="password" 
                   				   class="form-control border-start-0" placeholder="••••••••" 
                   				   required> </div>                       
                    	</div>
    					<div class="text-end forgot-link-container">
        					<a href="${pageContext.request.contextPath}/forget-password" class="text-maroon small text-decoration-none">Forgot Password?</a>
    					</div>
					</div>

                    <button type="submit" class="btn btn-login shadow-sm">LOGIN IN</button>
                </form>

                <div class="text-center register-text-container mt-4">
                    <p class="text-muted small mb-3">Don't have an account?</p>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-maroon">REGISTER HERE</a>
                </div>
            </div>
        </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>