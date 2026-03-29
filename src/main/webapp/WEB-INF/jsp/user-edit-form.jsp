<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User Profile</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" 
          xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
          crossorigin="anonymous">
          
    <style>
        /* Shared CSS from registration-form.jsp */
        body {
        	/* Background image properties - using a sample landscape image */
            background-image: url('${pageContext.request.contextPath}/bg-photos/gunju.jpg'); 
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
        }
        
        /* Blurred background effect using a pseudo-element */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            /* Same image for blurring */
            background-image: url('${pageContext.request.contextPath}/bg-photos/gunju.jpg'); 
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            filter: blur(8px); /* The key to the blur effect */
            z-index: -2; 
        }
        
        /* Dark overlay to improve text readability over background */
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4); /* Dark semi-transparent overlay */
            z-index: -1; 
        }
        
        .container {
            flex-grow: 1;
            z-index: 1;
        }
        
        .card {
            z-index: 10;
            /* Slightly transparent card for a blended look */
            background-color: rgba(255, 255, 255, 0.95); 
        }

        /* --- Stepper Styles (For visual completeness) --- */
        .stepper-wrapper {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }
        .stepper-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            flex: 1;
        }
        .step-counter {
            width: 34px; height: 34px; font-size: 0.9rem; border-radius: 50%;
            background-color: #0d6efd; /* Active blue */
            color: white; font-weight: bold;
            display: flex; justify-content: center; align-items: center;
            margin-bottom: 6px; z-index: 2;
        }

        .step-name {
            text-align: center; font-size: 0.8rem; color: #0d6efd; font-weight: bold;
        }
        
        /* Hide all steps except the first one */
        .form-step { display: none; }
        .form-step-active { display: block; }
        
    </style>
</head>
<body class="bg-light">

    <div class="container my-5">
        <div class="row justify-content-center">
            <!-- Adjusted column sizes for smaller width: col-lg-5 and col-md-7 -->
            <div class="col-lg-5 col-md-7">
                
                <div class="card shadow-sm border-0 rounded-3">
                    <!-- Reduced padding: p-3 p-md-4 -->
                    <div class="card-body p-3 p-md-4">

                        <h2 class="text-center text-primary mb-4">Edit Profile (Restricted)</h2>
                        
                        <!-- Step Navigation Rounds (Stepper) -->
                        <div class="stepper-wrapper" id="stepperSteps">
                            <div class="stepper-item active" id="stepper1">
                                <div class="step-counter">1</div>
                                <div class="step-name">Personal Details</div>
                            </div>
                            <div class="stepper-item" id="stepper2">
                                <div class="step-counter">2</div>
                                <div class="step-name">Contact Information</div>
                            </div>
                            <div class="stepper-item" id="stepper3">
                                <div class="step-counter">3</div>
                                <div class="step-name">Login & Photo</div>
                            </div>
                        </div>

                        <form:form id="editForm" action="/users/update" method="post" modelAttribute="users" enctype="multipart/form-data">
                        
                            <!-- Hidden ID field for update logic (MANDATORY) -->
                            <form:hidden path="id" />
                            
                            <!-- Step 1: Personal Details -->
                            <div id="step1" class="form-step form-step-active">
                                <h5 class="text-secondary mb-3">1. Personal Details</h5>
                                
                                <!-- User ID (Read Only) - Added for context -->
                                <div class="mb-2">
                                    <label for="userIdDisplay" class="form-label text-secondary">User ID:</label>
                                    <input id="userIdDisplay" type="text" value="${user.id}" class="form-control" readonly />
                                </div>
                                
                                <!-- First Name (EDITABLE) -->
                                <div class="mb-2">
                                    <label for="firstName" class="form-label">First Name:</label>
                                    <form:input path="firstName" id="firstName" required="true" cssClass="form-control"/>
                                </div>
                                <!-- Last Name (EDITABLE) -->
                                <div class="mb-2">
                                    <label for="lastName" class="form-label">Last Name:</label>
                                    <form:input path="lastName" id="lastName" required="true" cssClass="form-control"/>
                                </div>
                                
                                <!-- Gender (Read Only - Disabled radio buttons) -->
                                <div class="mb-2">
                                    <label class="form-label d-block">Gender:</label>
                                    <div class="form-check form-check-inline">
                                        <form:radiobutton path="gender" value="Male" disabled="true" cssClass="form-check-input" id="genderMale"/>
                                        <label class="form-check-label" for="genderMale">Male</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <form:radiobutton path="gender" value="Female" disabled="true" cssClass="form-check-input" id="genderFemale"/>
                                        <label class="form-check-label" for="genderFemale">Female</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <form:radiobutton path="gender" value="Other" disabled="true" cssClass="form-check-input" id="genderOther"/>
                                        <label class="form-check-label" for="genderOther">Other</label>
                                    </div>
                                </div>
                                <!-- Birthdate (Read Only) -->
                                <div class="mb-2">
                                    <label for="birthdate" class="form-label">BirthDate:</label>
                                    <form:input path="birthdate" id="birthdate" type="date" readonly="true" cssClass="form-control"/>
                                </div>
                                
                                <div class="d-flex justify-content-end mt-3">
                                    <button type="button" id="nextBtn1" class="btn btn-primary">Next</button>
                                </div>
                            </div>
                            
                            <!-- Step 2: Contact Information -->
                            <div id="step2" class="form-step">
                                <h5 class="text-secondary mb-3">2. Contact Information</h5>
                                
                                <!-- EMAIL FIELD (Read Only) -->
                                <div class="mb-2">
                                    <label for="email" class="form-label">Email:</label>
                                    <form:input path="email" id="email" type="email" readonly="true" cssClass="form-control"/>
                                </div>
                                <!-- Address (Read Only) -->
                                <div class="mb-2">
                                    <label for="address" class="form-label">Address:</label>
                                    <form:input path="address" id="address" readonly="true" cssClass="form-control"/>
                                </div>
                                
                                <!-- City and State (Read Only, Two Columns) -->
                                <div class="row">
                                    <!-- City Column -->
                                    <div class="col-md-6">
                                        <div class="mb-2">
                                            <label for="city" class="form-label">City:</label>
                                            <form:input path="city" id="city" readonly="true" cssClass="form-control"/>
                                        </div>
                                    </div>
                                    <!-- State/Province Column -->
                                    <div class="col-md-6">
                                        <div class="mb-2">
                                            <label for="state" class="form-label">State:</label>
                                            <form:input path="state" id="state" readonly="true" cssClass="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Country (Read Only) -->
                                <div class="mb-2">
                                    <label for="country" class="form-label">Country:</label>
                                    <form:input path="country" id="country" readonly="true" cssClass="form-control"/>
                                </div>
                                
                                <div class="d-flex justify-content-between mt-3">
                                    <button type="button" id="prevBtn2" class="btn btn-outline-secondary">Previous</button>
                                    <button type="button" id="nextBtn2" class="btn btn-primary">Next</button>
                                </div>
                            </div>

                            <!-- Step 3: Login & Photo -->
                            <div id="step3" class="form-step">
                                <h5 class="text-secondary mb-3">3. Login & Photo</h5>
                                
                                <!-- UserName (Read Only) -->
                                <div class="mb-2">
                                    <label for="userName" class="form-label">UserName:</label>
                                    <form:input path="userName" id="userName" readonly="true" cssClass="form-control"/>
                                </div>
                                
                                <!-- Password (Read Only - Masked) -->
                                <div class="mb-2">
                                    <label for="passwordDisplay" class="form-label">Password:</label>
                                    <!-- Display a masked, read-only field for security -->
                                    <input type="text" id="passwordDisplay" value="********" class="form-control" readonly="true"/>
                                    <!-- Keep the original password value in a hidden field to ensure it is submitted back to the model -->
                                    <form:hidden path="password" /> 
                                </div>
                                
                                <!-- Profile Picture (EDITABLE) -->
                                <div class="mb-2">
                                    <label for="image" class="form-label">Profile Picture:</label>
                                    <input type="file" id="image" name="image" class="form-control" accept="image/png, image/jpeg"/>
                                    <div class="form-text mt-1">Leave blank to keep current photo.</div>
                                </div>
                                
                                <div class="d-flex justify-content-between mt-3">
                                    <button type="button" id="prevBtn3" class="btn btn-outline-secondary">Previous</button>
                                    <input type="submit" value="Update Profile" class="btn btn-primary btn-lg" />
                                </div>
                            </div>
                        
                        </form:form>
                        
                        <div class="text-center mt-4">
                            <a href="/users" class="btn btn-link">Cancel and View All Users</a>
                        </div>
                        
                    </div>
                </div>
                
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhyD9GkcIdslK1eN7N6jIeHz" 
            crossorigin="anonymous"></script>
            
    <!-- Custom JS for multi-step form navigation (simplified for edit mode) -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const steps = document.querySelectorAll(".form-step");
            const stepperItems = document.querySelectorAll(".stepper-item"); 
            let currentStep = 0;

            const nextBtn1 = document.getElementById("nextBtn1");
            const nextBtn2 = document.getElementById("nextBtn2");
            const prevBtn2 = document.getElementById("prevBtn2");
            const prevBtn3 = document.getElementById("prevBtn3");

            function showStep(stepIndex) {
                // 1. Hide/Show Step Content
                steps.forEach((step, index) => {
                    if (index === stepIndex) {
                        step.classList.add("form-step-active");
                    } else {
                        step.classList.remove("form-step-active");
                    }
                });
                
                // 2. Update Stepper Appearance (Rounds)
                stepperItems.forEach((item, index) => {
                    item.classList.remove("active", "completed");
                    
                    if (index === stepIndex) {
                        item.classList.add("active");
                    } else if (index < stepIndex) {
                        item.classList.add("completed"); // Mark previous steps as complete
                    }
                });
            }

            // --- Event Listeners for Buttons ---
            // NOTE: Validation is skipped since all non-editable fields are pre-filled
            
            if(nextBtn1) {
                nextBtn1.addEventListener("click", function() {
                    currentStep = 1;
                    showStep(currentStep);
                });
            }

            if(nextBtn2) {
                nextBtn2.addEventListener("click", function() {
                    currentStep = 2;
                    showStep(currentStep);
                });
            }

            if(prevBtn2) {
                prevBtn2.addEventListener("click", function() {
                    currentStep = 0;
                    showStep(currentStep);
                });
            }

            if(prevBtn3) {
                prevBtn3.addEventListener("click", function() {
                    currentStep = 1;
                    showStep(currentStep);
                });
            }

            // Show the first step initially
            showStep(currentStep);
        });
    </script>
</body>
</html>