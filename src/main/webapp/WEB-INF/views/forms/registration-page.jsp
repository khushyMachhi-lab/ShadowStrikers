<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - ShadowStrikers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
    
        :root {
            --primary-color: #922b3e; 
            --primary-gradient: linear-gradient(135deg, #5a0f14 0%, #c62b3c 50%, #7d0f18 100%);
        }

        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            background: url('${pageContext.request.contextPath}/bg-photos/fight-2.jpg') no-repeat center center fixed;
            background-size: cover;
            overflow-x: hidden;
        }

        /* Dark Overlay for better contrast */
        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }

        .container-fluid {position: relative; z-index: 1;}

        /* Horizontal Layout Styling */
        .registration-row {display: flex; align-items: stretch;}

        .form-step {position: relative; margin-top: 40px;}
        .card {background-color: rgba(255, 255, 255, 0.98); border-radius: 20px; border: 2px solid transparent; height: 100%; box-shadow: 0 10px 25px rgba(0,0,0,0.3); padding-top: 30px; transition: all 0.4s ease;}
        .form-step:hover .card {transform: translateY(-10px); border-color: rgba(146, 43, 62, 0.4); box-shadow: 0 20px 40px rgba(146, 43, 62, 0.4);}

        /* Step Circles */
        .step-circle-wrapper {position: absolute; top: -25px; left: 50%; transform: translateX(-50%); z-index: 10;}
        .step-circle {width: 55px; height: 55px; background: var(--primary-gradient); color: white; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-weight: 800; font-size: 1.3rem; box-shadow: 0 5px 15px rgba(146, 43, 62, 0.4);}
        
        .section-title {color: var(--primary-color); font-weight: 800; font-size: 1.3rem; text-align: center; margin-bottom: 25px; border-bottom: 2px solid #f8f9fa; padding-bottom: 10px;}

        .form-label { font-weight: 600; color: #444; }
        .form-control:focus {border-color: var(--primary-color); box-shadow: 0 0 0 0.25rem rgba(146, 43, 62, 0.2);}

        /* Register Button */
        .btn-register-main {
            background: var(--primary-gradient);
            color: white !important;
            text-decoration: none;
            padding: 15px 80px;
            border-radius: 50px;
            font-weight: 800;
            font-size: 1.2rem;
            border: none;
            box-shadow: 0 10px 20px rgba(146, 43, 62, 0.4);
            transition: 0.3s;
        }

        .btn-register-main:hover {
            transform: scale(1.05);
            box-shadow: 0 15px 30px rgba(146, 43, 62, 0.6);
            color: white;
        }
        
        /* Styling the modal to match your theme */
    	.modal-content {background-color: rgba(255, 255, 255, 0.98); border: none;}
    
   		/* Responsive */
		@media (max-width: 991px) {
    		.container-fluid {padding-left: 15px !important; padding-right: 15px !important; padding-top: 30px !important;}
    		.registration-row {display: block;}
    		.form-step {margin-top: 60px; margin-bottom: 20px;}
    		.card {padding: 25px 15px !important; border-radius: 15px; height: auto;}
			h1 {font-size: 1.6rem !important; letter-spacing: 1px !important; margin-bottom: 20px !important;}
    		.section-title {font-size: 1.1rem; margin-bottom: 20px;}
    		.form-label {font-size: 0.9rem;}
			.form-check-inline {display: flex; align-items: center; margin-bottom: 10px; background: #f8f9fa; padding: 10px; border-radius: 8px; width: 100%;}
			.btn-register-main {width: 100%; padding: 15px; font-size: 1.1rem; border-radius: 10px;}
    		.step-circle {width: 45px; height: 45px; font-size: 1.1rem;}
		}
    	
    </style>
</head>
<body>

<div class="container-fluid px-lg-5 py-5">
    <h1 class="text-center text-white mb-5 fw-bold" style="letter-spacing: 2px;">JOIN SHADOWSTRIKE</h1>

    <form:form id="registrationForm" action="register" method="post" modelAttribute="user" enctype="multipart/form-data">
        
        <div class="row registration-row g-4">
            
            <div class="col-lg-4 col-md-12 form-step">
                <div class="step-circle-wrapper"><div class="step-circle">1</div></div>
                <div class="card p-4">
                    <h4 class="section-title"><i class="fas fa-user-ninja me-2"></i> Personal Details</h4>
                    <div class="mb-3">
                        <label class="form-label">First Name</label>
                        <form:input path="firstName" class="form-control" required="true"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Last Name</label>
                        <form:input path="lastName" class="form-control" required="true"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label d-block">Gender</label>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="gender" value="Male" cssClass="form-check-input" id="gMale"/>
                            <label class="form-check-label" for="gMale">Male</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="gender" value="Female" cssClass="form-check-input" id="gFemale"/>
                            <label class="form-check-label" for="gFemale">Female</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="gender" value="Other" cssClass="form-check-input" id="gOther"/>
                            <label class="form-check-label" for="gOther">Other</label>
                        </div>
                    </div>                    
                    <div class="mb-3">
                        <label class="form-label">BirthDate</label>
                        <form:input path="birthdate" type="date" class="form-control" required="true"/>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-12 form-step">
                <div class="step-circle-wrapper"><div class="step-circle">2</div></div>
                <div class="card p-4">
                    <h4 class="section-title"><i class="fas fa-address-book me-2"></i> Contact Information</h4>
                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <form:input path="email" type="email" class="form-control" required="true"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <form:input path="address" class="form-control" required="true"/>
                    </div>
                    <div class="row">
                        <div class="col-6 mb-3">
                            <label class="form-label">City</label>
                            <form:input path="city" class="form-control" required="true"/>
                        </div>
                        <div class="col-6 mb-3">
                            <label class="form-label">State</label>
                            <form:input path="state" class="form-control" required="true"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Country</label>
                        <form:input path="country" class="form-control" required="true"/>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-12 form-step">
                <div class="step-circle-wrapper"><div class="step-circle">3</div></div>
                <div class="card p-4">
                    <h4 class="section-title"><i class="fas fa-shield-halved me-2"></i>Login & Photo</h4>
                    
                    <div class="mb-3">
                        <label class="form-label">UserName</label>
                        <form:input path="userName" class="form-control" required="true"/>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Password</label>
                        <form:password path="password" class="form-control" required="true" id="regPassword"/>
                        
                        <form:errors path="password" cssClass="text-danger d-block mt-1" style="font-size: 0.75rem; font-weight: 600;" />
                    </div>
                    <div class="mb-3 p-2 rounded" style="background: #fff5f6; border-left: 3px solid var(--primary-color);">
            			<p class="mb-1 fw-bold text-dark" style="font-size: 0.7rem;">PASSWORD REQUIREMENTS:</p>
            			<ul class="list-unstyled mb-0 text-muted" style="font-size: 0.65rem; line-height: 1.4;">
                			<li><i class="fas fa-check-circle me-1"></i> At least 8 characters long</li>
                			<li><i class="fas fa-check-circle me-1"></i> 1 Uppercase & 1 Lowercase (A, a)</li>
                			<li><i class="fas fa-check-circle me-1"></i> 1 Number (0-9)</li>
                			<li><i class="fas fa-check-circle me-1"></i> 1 Special character (!@#$%^&*)</li>
            			</ul>
        			</div>                 
                    <div class="mb-3">
                        <label class="form-label">Profile Image</label>
                        <input type="file" name="image" class="form-control" accept="image/*"/>
                        
                        <small class="text-muted d-block mt-1">
        					<i class="fas fa-info-circle me-1"></i>
        					Please upload a profile picture (Maximum file size: 20MB).
    					</small>
                    </div>
                </div>
            </div>

        </div> <div class="text-center mt-5">
            <button type="submit" class="btn-register-main">REGISTER NOW</button>
        </div>

    </form:form>
</div>

<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow-lg">
            <div class="modal-header border-0 pb-0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center p-5 pt-0">
                <div class="mb-4">
                    <i class="fas fa-check-circle fa-5x" style="color: var(--primary-color);"></i>
                </div>
                <h2 class="fw-bold mb-3" id="successModalLabel" style="color: #333;">Registration Successful!</h2>
                <p class="text-muted mb-4">
                    Welcome to **ShadowStrikers Academy**. Your account has been created. 
                    You can now access your dashboard and start training.
                </p>
                <div class="d-grid">
                    <button type="button" class="btn btn-register-main" data-bs-dismiss="modal">
                        GREAT, LET'S GO!
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 1. Get the success message from the JSP expression language
        // We use quotes so that it remains a valid string in JS
        const registrationSuccess = "${registrationSuccess}";

        // 2. If the message is not empty, show the modal
        if (registrationSuccess && registrationSuccess.trim() !== "") {
            // Check if Bootstrap is loaded (since it was being blocked earlier)
            if (typeof bootstrap !== 'undefined') {
                const successModalElement = document.getElementById('successModal');
                const modalInstance = new bootstrap.Modal(successModalElement);
                modalInstance.show();
            } else {
                // Fallback if Bootstrap JS is blocked by the browser
                alert("Registration Successful! Please log in.");
            }
        }
    });
</script>
</body>
</html>