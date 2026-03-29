<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" 
          crossorigin="anonymous">

    <style>

        /* Custom Styles - Background matching registration form */
        body {
            /* Assuming you have a background photo or similar styling */
            background-color: #f8f9fa; 
            background-image: url('${pageContext.request.contextPath}/bg-photos/gunju.jpg'); 
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

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
        
        .card {
            z-index: 1;
            background-color: rgba(255, 255, 255, 0.95);
            max-width: 400px; /* Limit width for focus */
        }
        
        .alert {
            font-size: 0.9rem;
        }

    </style>

</head>
<body>

    <div class="container">
        <div class="card shadow-lg border-0 rounded-3 p-4">
            <h2 class="text-center text-primary mb-4">User Login</h2>

            <%-- Message displayed after successful registration (from RedirectAttributes) --%>
            <c:if test="${not empty registrationSuccess}">
                <div class="alert alert-success text-center" role="alert">
                    ${registrationSuccess}
                </div>
            </c:if>

            <%-- Spring Security Login Error (if you integrate it later) --%>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger" role="alert">
                    Invalid userName or password.
                </div>
            </c:if>
            
            <%-- **NEW CHECK** for the error set by your UserController --%>
			<c:if test="${not empty loginError}">
    			<div class="alert alert-danger" role="alert">
        			${loginError}
    			</div>
			</c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                
                <div class="mb-3">
                    <label for="userName" class="form-label">UserName:</label>
                    <input type="text" id="userName" name="userName" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 mt-3">Log In</button>
            </form>

            <div class="mt-4 text-center">
                <p class="mb-1">Don't have an account?</p>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-secondary w-100">Register Here</a>
            </div>
            
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            crossorigin="anonymous"></script>
</body>
</html>