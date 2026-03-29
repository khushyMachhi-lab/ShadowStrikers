<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" 
          crossorigin="anonymous">

    <style>

        /* Custom Styles - Mostly unchanged, except for step display */
        body {
            background-image: url('${pageContext.request.contextPath}/bg-photos/fight-1.jpg'); 
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

        /* Blurred background effect */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('${pageContext.request.contextPath}/bg-photos/fight-1.jpg'); 
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            filter: blur(8px);
            z-index: -2; 
        }

        /* Dark overlay */
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            z-index: -1; 
        }
        
        .container {
            flex-grow: 1;
            z-index: 1;
            padding-top: 50px;
            padding-bottom: 50px;
        }

        /* Sequential Step Styles */
        .form-step {
            transition: opacity 0.4s ease-in-out, transform 0.4s ease-in-out;
            /* **KEY CHANGE:** Hide inactive steps */
            display: none; 
        }

        /* **KEY CHANGE:** Show the active step */
        .form-step-active {
            display: block; 
            animation: fadeIn 0.5s ease-out; /* Optional fade-in effect */
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-step .card {
            background-color: rgba(255, 255, 255, 0.85);
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
            border: 1px solid rgba(0, 0, 0, 0.05);
            /* Removed height: 100%; as it's not needed for sequential */
            margin-top: 30px;
            position: relative;
        }

        .form-step-active .card {
            background-color: #ffffff; 
            box-shadow: 0 1rem 3rem rgba(0,0,0,.175)!important;
            /* Removed transform: scale(1.02) as it's less necessary here */
            border: 2px solid #0d6efd;
        }

        .form-step-active .card .btn-primary {
            box-shadow: 0 0.5rem 1rem rgba(13, 110, 253, 0.3);
        }

        /* Step circle positioned at top of card */
        .step-circle-wrapper {
            position: absolute;
            top: -30px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 10;
        }

        .step-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #6c757d;
            color: white;
            font-weight: bold;
            font-size: 1.4rem;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            border: none;
            transition: all 0.3s ease;
        }

        .form-step-active .step-circle {
            background-color: #0d6efd;
            transform: none;
            box-shadow: 0 4px 8px rgba(13, 110, 253, 0.4);
        }

        .form-step .step-circle.completed {
            background-color: #198754;
        }
        
        /* Custom style for the round arrow button */
        .round-arrow-btn {
            width: 50px; /* Fixed width */
            height: 50px; /* Fixed height */
            padding: 0 !important;
            border-radius: 50% !important; /* Make it circular */
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2rem;
            font-weight: bold;
        }
        
        /* **NEW STYLE:** Wider button for the final submission */
        .round-submit-btn {
            height: 50px; 
            padding: 0 15px !important; /* Add horizontal padding */
            border-radius: 25px !important; /* Half of height for pill shape */
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.1rem;
            font-weight: bold;
            white-space: nowrap; /* Prevent wrapping */
        }

        .card-body {
            /* Ensure card body doesn't stretch too much for single button */
            position: relative;
        }

        .w-100-responsive {
            width: 100%;
        }

    </style>

</head>
<body class="bg-light">

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-xl-6 col-lg-8"> <div class="mb-5 text-center">
                     <h2 class="text-center text-white mb-5">New User Registration</h2>
                </div>

                <form:form id="registrationForm" action="register" method="post" modelAttribute="user" enctype="multipart/form-data">
                
                	<div class="text-danger mb-3">
        				<form:errors path="*" cssClass="alert alert-danger" />
    				</div>
                
                    <div id="steps-wrapper"> 
                    <div id="step1" class="form-step form-step-active">
                            <div class="card shadow-lg border-0 rounded-3">
                                <div class="step-circle-wrapper">
                                    <div class="step-circle step-1">1</div>
                                </div>
                                <div class="card-body p-4">
                                    <h5 class="text-primary mb-4 border-bottom pb-2 mt-3">Personal Details</h5>
                                    <div class="mb-3">
                                        <label for="firstName" class="form-label">First Name:</label>
                                        <form:input path="firstName" id="firstName" required="true" cssClass="form-control"/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="lastName" class="form-label">Last Name:</label>
                                        <form:input path="lastName" id="lastName" required="true" cssClass="form-control"/>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label d-block">Gender:</label>
                                        <div class="form-check form-check-inline">
                                            <form:radiobutton path="gender" value="Male" required="true" cssClass="form-check-input" id="genderMale"/>
                                            <label class="form-check-label" for="genderMale">Male</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <form:radiobutton path="gender" value="Female" cssClass="form-check-input" id="genderFemale"/>
                                            <label class="form-check-label" for="genderFemale">Female</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <form:radiobutton path="gender" value="Other" cssClass="form-check-input" id="genderOther"/>
                                            <label class="form-check-label" for="genderOther">Other</label>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="birthdate" class="form-label">BirthDate:</label>
                                        <form:input path="birthdate" id="birthdate" type="date" required="true" cssClass="form-control"/>
                                    </div>
                                    <div class="mt-4 d-flex justify-content-end"> 
                                    <button type="button" class="btn btn-primary round-arrow-btn next-step-btn">
                                        &#x2192; </button>
                                </div>
                                </div>
                            </div>
                        </div>


                        <div id="step2" class="form-step">
                            <div class="card shadow-lg border-0 rounded-3">
                                <div class="step-circle-wrapper">
                                    <div class="step-circle step-2">2</div>
                                </div>
                                <div class="card-body p-4">
                                    <h5 class="text-secondary mb-4 border-bottom pb-2 mt-3">Contact Information</h5>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email:</label>
                                        <form:input path="email" id="email" type="email" required="true" cssClass="form-control"/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address:</label>
                                        <form:input path="address" id="address" required="true" cssClass="form-control"/>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="city" class="form-label">City:</label>
                                                <form:input path="city" id="city" required="true" cssClass="form-control"/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="state" class="form-label">State:</label>
                                                <form:input path="state" id="state" required="true" cssClass="form-control"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="country" class="form-label">Country:</label>
                                        <form:input path="country" id="country" required="true" cssClass="form-control"/>
                                    </div>
                                    <div class="mt-4 d-flex gap-2 justify-content-between">
                                        <button type="button" class="btn btn-outline-secondary round-arrow-btn prev-step-btn">
                                            &#x2190; </button>
                                        <button type="button" class="btn btn-primary round-arrow-btn next-step-btn">
                                            &#x2192; </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="step3" class="form-step">
                            <div class="card shadow-lg border-0 rounded-3">
                                <div class="step-circle-wrapper">
                                    <div class="step-circle step-3">3</div>
                                </div>
                                <div class="card-body p-4">
                                    <h5 class="text-secondary mb-4 border-bottom pb-2 mt-3">Login & Photo</h5>
                                    <div class="mb-3">
                                        <label for="userName" class="form-label">UserName:</label>
                                        <form:input path="userName" id="userName" required="true" cssClass="form-control"/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password:</label>
                                        <form:password path="password" id="password" required="true" cssClass="form-control"/>
                                        <form:errors path="password" cssClass="text-danger"/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="image" class="form-label">Profile Picture:</label>
                                        <input type="file" id="image" name="image" class="form-control" accept="image/png, image/jpeg"/>
                                    </div>
                                    <div class="mt-4 d-flex justify-content-between align-items-center">
                                        <button type="button" class="btn btn-outline-secondary round-arrow-btn prev-step-btn">
                                            &#x2190; </button>
                                        
                                        <button type="submit" class="btn btn-success round-submit-btn">
                                            Register
                                        </button>
                                </div>
                            </div>
                        </div>
                      </div>
                    </div> 
                </form:form>
                <div class="text-center mt-4">
                    <a href="/users" class="btn btn-link text-white text-opacity-75">View All Users</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            crossorigin="anonymous">
    </script>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById("registrationForm");
        const steps = document.querySelectorAll(".form-step");
        const stepCircles = document.querySelectorAll(".step-circle");
        const nextBtns = document.querySelectorAll(".next-step-btn");
        const prevBtns = document.querySelectorAll(".prev-step-btn");
        let currentStep = 0;
        
        // --- NEW FUNCTION: Enable ALL inputs ---
        function enableAllInputs() {
            steps.forEach(step => {
                step.querySelectorAll('input, select, textarea').forEach(input => {
                    input.disabled = false;
                });
            });
        }
        
        // --- NEW FUNCTION: Disable ALL inputs based on currentStep ---
        // This is used for maintaining the disabled state of inactive steps.
        function disableInactiveInputs(stepIndex) {
            steps.forEach((step, index) => {
                step.querySelectorAll('input, select, textarea').forEach(input => {
                    // Disable input if it is NOT the active step index
                    input.disabled = (index !== stepIndex); 
                });
            });
        }

        function updateUI(stepIndex) {
            // 1. Manage Input Disabled State (CRUCIAL CHANGE)
            // Use the dedicated function to disable inputs on inactive steps.
            disableInactiveInputs(stepIndex);
            
            // 2. Update Step Content Class (Visual)
            steps.forEach((step, index) => {
                step.classList.remove("form-step-active");
                if (index === stepIndex) {
                    step.classList.add("form-step-active");
                    // Scroll to the top of the step for better UX
                    steps[stepIndex].scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });

            // 3. Update Step Circles (Visual)
            stepCircles.forEach((circle, index) => {
                circle.classList.remove("completed");

                if (index < stepIndex) {
                    circle.classList.add("completed");
                }
            });
        }

        function validateStep(stepIndex) {
            const currentStepElement = steps[stepIndex];
            // Only consider inputs that are part of the current step
            // Note: The :not(:disabled) selector is no longer strictly necessary 
            //       since disableInactiveInputs handles the disabling.
            const inputs = currentStepElement.querySelectorAll("input[required], select[required], textarea[required]");
            let isValid = true;

            for (const input of inputs) {
                if (!input.checkValidity()) {
                    input.classList.add('is-invalid');
                    isValid = false;
                    input.reportValidity(); 
                    break; 
                } else {
                    input.classList.remove('is-invalid');
                    input.classList.add('is-valid');
                }
            }

            // Temporary removal of validation state for cleaner look
            setTimeout(() => {
                inputs.forEach(input => {
                    input.classList.remove('is-valid');
                    input.classList.remove('is-invalid');
                });
            }, 2000);
            return isValid;
        }

        // Next button click handlers (Unchanged)
        nextBtns.forEach(btn => {
            btn.addEventListener("click", function() {
                if (validateStep(currentStep)) {
                    if (currentStep < steps.length - 1) {
                        currentStep++;
                        updateUI(currentStep);
                    }
                }
            });
        });

        // Previous button click handlers (Unchanged)
        prevBtns.forEach(btn => {
            btn.addEventListener("click", function() {
                if (currentStep > 0) {
                    currentStep--;
                    updateUI(currentStep);
                }
            });
        });
        
        // --- CRUCIAL ADDITION: Enable All Fields on Final Submission ---
        form.addEventListener("submit", function(event) {
            // Before the form is sent to the server, ensure ALL inputs from 
            // Steps 1, 2, and 3 are enabled so their values are included in the request payload.
            enableAllInputs();
            
            // Note: If you have client-side validation on the final step's submit button, 
            // you might want to run validateStep(currentStep) here and call 
            // event.preventDefault() if it fails, but for server-side validation 
            // troubleshooting, this is the main fix.
        });


        // Initial setup
        updateUI(currentStep);
    });
</script>
</body>
</html>