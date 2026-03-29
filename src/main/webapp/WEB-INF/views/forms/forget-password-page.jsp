<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - ShadowStrikers</title>
    
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 0;
        }

        .container { z-index: 1; display: flex; justify-content: center; width: 100%; }

        .card {background-color: rgba(255, 255, 255, 0.98); max-width: 450px; width: 100%; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); border: none; overflow: hidden; animation: fadeIn 0.5s ease-in-out;}

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header-section {background: var(--primary-gradient); color: white; padding: 40px 30px; text-align: center;}

        .form-label { font-weight: 600; color: #444; }

        .btn-submit {background: var(--primary-gradient); border: none; color: white !important; font-weight: 700; padding: 12px; border-radius: 30px; transition: 0.3s; text-transform: uppercase; letter-spacing: 1px;}
        .btn-submit:hover {transform: translateY(-2px); box-shadow: 0 8px 20px rgba(146, 43, 62, 0.4);}

        .input-group-text {background-color: #f8f9fa; border-right: none; color: var(--primary-color);}

        .form-control {border-left: none; padding: 12px;}
        .form-control:focus {border-color: #dee2e6; box-shadow: none;}

        .back-to-login {color: var(--primary-color); text-decoration: none; font-weight: 600; transition: 0.2s;}
        .back-to-login:hover {text-decoration: underline; color: #5a0f14;}

        /* Mobile Adjustments */
        @media (max-width: 576px) {
            .container { padding: 20px; }
            .header-section { padding: 30px 20px; }
        }
        
    </style>
</head>
<body>

    <div class="container">
        <div class="card">
            <div class="header-section">
                <i class="fas fa-user-shield fa-3x mb-3"></i>
                <h2 class="fw-bold mb-1">RESET PASSWORD</h2>
                <p class="small mb-0 opacity-75">Enter your email to receive a 6-digit OTP</p>
            </div>
            
            <div class="p-4 p-md-5">
                <%-- Error/Success Messages from Controller --%>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger small py-2">
                        <i class="fas fa-exclamation-circle me-2"></i> ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/send-otp" method="post" id="forgotForm">
                    <div class="mb-4">
                        <label for="email" class="form-label">Registered Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" id="email" name="email" class="form-control" 
                                   placeholder="e.g. alex@example.com" required>
                        </div>
                        <div id="emailHelp" class="form-text mt-2">
                            We'll never share your email with anyone else.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-submit w-100 mb-3" id="submitBtn">
                        <span class="btn-text">Send OTP</span>
                        <span class="spinner-border spinner-border-sm d-none" role="status"></span>
                    </button>
                </form>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/login" class="back-to-login">
                        <i class="fas fa-arrow-left me-2"></i>Back to Login
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('forgotForm').addEventListener('submit', function() {
            const btn = document.getElementById('submitBtn');
            const text = btn.querySelector('.btn-text');
            const spinner = btn.querySelector('.spinner-border');

            // Show loading state
            btn.disabled = true;
            text.innerText = "Sending...";
            spinner.classList.remove('d-none');
        });
    </script>
</body>
</html>