<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Success - ShadowStrikers</title>
    
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
            align-items: center;
            position: relative;
            margin: 0;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.7); 
            z-index: 0;
        }

        .dashboard-card {z-index: 1; max-width: 650px; width: 100%; background-color: #ffffff; border-radius: 20px; overflow: hidden; box-shadow: 0 20px 50px rgba(0,0,0,0.2); border: none;}
        .dashboard-header {background: var(--primary-gradient); padding: 60px 20px 80px 20px; color: white; text-align: center;}

        .profile-picture-container {text-align: center; margin-top: -60px; position: relative; z-index: 2;}
        .profile-picture {width: 140px; height: 140px; object-fit: cover; border-radius: 50%; border: 5px solid white; box-shadow: 0 10px 20px rgba(0,0,0,0.2); background: white;}

		.info-label {color: var(--primary-color); font-weight: 700; text-transform: uppercase; font-size: 0.8rem; margin-bottom: 2px; letter-spacing: 0.5px; text-align: left;}
		.info-value {font-size: 1.1rem; color: #333; margin-bottom: 20px; border-bottom: 1px solid #f0f0f0; padding-bottom: 5px; text-align: left;}

		.badge-athlete {background-color: var(--primary-color); color: white; padding: 8px 20px; border-radius: 30px; font-weight: 600; font-size: 0.85rem; display: inline-block;}

        /* Success Button */
        .btn-proceed {
            background: var(--primary-gradient);
            color: white;
            border-radius: 30px;
            padding: 15px;
            font-weight: 700;
            transition: 0.3s;
            border: none;
            width: 100%;
            text-decoration: none;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-proceed:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(146, 43, 62, 0.4);
            color: white;
        }
        
        /* Responsive */
		@media (max-width: 768px) {
    		.dashboard-card {margin: 20px; border-radius: 15px;}
			.dashboard-header {padding: 40px 15px;}
    		.dashboard-header h2 {font-size: 1.5rem;}
    		.profile-picture {width: 110px; height: 110px; margin-top: -55px;}
    		.p-4 {padding: 1.5rem !important;}
    		.info-value {font-size: 1rem; margin-bottom: 15px;}
		}

		@media (max-width: 480px) {
    		.row.px-lg-4 > div {width: 100%;}
		}
		
    </style>
</head>
<body>

<div class="container d-flex justify-content-center py-5">
    <div class="dashboard-card">
        <%-- We check for the 'user' object sent from the Registration Controller --%>
        <c:choose>
            <c:when test="${not empty user}">
                
                <div class="dashboard-header">
                    <i class="fas fa-check-circle fa-3x mb-3 text-success"></i>
                    <h2 class="fw-bold mb-1">Registration Successful!</h2> 
                </div>

                <div class="profile-picture-container">
                    <c:choose>
                        <c:when test="${not empty user.photo}">
                            <img src="${pageContext.request.contextPath}/user-photos/${user.photo}"
                                 class="profile-picture" alt="Profile Photo">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/150" class="profile-picture" alt="Default Photo">
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="p-4 pt-2">
                    <div class="text-center mb-4 mt-2">
                        <h3 class="fw-bold mb-1">${user.firstName} ${user.lastName}</h3>
                        <p class="mb-2 text-muted fw-bold">Welcome to the Club, ${user.firstName}!</p>
                        <span class="badge-athlete">ShadowStrike Verified Member</span>
                    </div>

                    <div class="row px-lg-4 mt-4 text-center">
                        <p class="text-muted">Your account has been created successfully. You are now part of the ShadowStrike Elite Team.</p>
                    </div>

                    <div class="row px-lg-4 mt-2">
                        <div class="col-md-6">
                            <div class="info-label">UserName</div>
                            <div class="info-value">${user.userName}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Email</div>
                            <div class="info-value">${user.email}</div>
                        </div>
                    </div>

                    <hr class="my-4">
                    
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-proceed">
                            PROCEED TO LOGIN <i class="fas fa-sign-in-alt ms-2"></i>
                        </a>
                    </div>
                </div>

            </c:when>
            
            <c:otherwise>
                <div class="p-5 text-center">
                    <i class="fas fa-exclamation-triangle fa-5x text-warning mb-4"></i>
                    <h1 class="text-dark fw-bold">No Data Found</h1>
                    <p class="text-muted">Please complete the registration form first.</p>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-proceed">
                        Back to Register
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>