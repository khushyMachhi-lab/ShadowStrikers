<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" 
          crossorigin="anonymous">

    <style>
        body {
            background-color: #e9ecef; /* Light gray background */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .dashboard-card {
            max-width: 600px;
            padding: 30px;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .profile-picture {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #0d6efd;
            margin-bottom: 15px;
        }
    </style>

</head>
<body>

    <div class="container">
        <div class="dashboard-card mx-auto text-center">
        
            <%-- Check if the currentUser attribute exists in the session --%>
            <c:choose>
                <c:when test="${not empty currentUser}">
                
                    <h1 class="mb-4 text-primary">Welcome Back!</h1>
                    
                    <%-- Display Profile Picture if it exists --%>
                    <c:if test="${not empty currentUser.photo}">
                        <%-- Assuming your photos are accessible via /uploads --%>
                        <img src="${pageContext.request.contextPath}${currentUser.photosImagePath}" 
         					alt="${currentUser.firstName}'s Profile" 
         					class="profile-picture">
                    </c:if>

                    <h3 class="mb-3">
                        Hello, ${currentUser.firstName} ${currentUser.lastName}!
                    </h3>
                    
                    <p class="text-muted">You are successfully logged in as **${currentUser.userName}**.</p>
                    <hr>
                    
                    <div class="row text-start mt-4">
                        <div class="col-md-6">
                            <p><strong>Email:</strong> ${currentUser.email}</p>
                            <p><strong>Gender:</strong> ${currentUser.gender}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>City:</strong> ${currentUser.city}</p>
                            <p><strong>Country:</strong> ${currentUser.country}</p>
                        </div>
                    </div>

                    <%-- The logout button directs to a new controller mapping, /logout --%>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-lg w-100 mt-4">
                        Log Out
                    </a>

                </c:when>
                
                <c:otherwise>
                    <h1 class="text-danger">Access Denied</h1>
                    <p>You must be logged in to view this page.</p>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary mt-3">Go to Login</a>
                </c:otherwise>
            </c:choose>
            
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            crossorigin="anonymous"></script>
</body>
</html>