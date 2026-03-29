<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .profile-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #0d6efd;
        }
        
        /* --- Background Image & Blur Styles --- */
        body {
            /* FIXED: The background-image property should only contain the URL. */
            /* !!! REPLACE THIS URL WITH YOUR ACTUAL IMAGE PATH !!! */
            background-image: url('${pageContext.request.contextPath}/bg-photos/gunju.jpg');
            
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            /* Allow content to flow naturally, but center if short */
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
            
            /* !!! REPLACE THIS URL WITH YOUR ACTUAL IMAGE PATH !!! */
            background-image: url('${pageContext.request.contextPath}/bg-photos/gunju.jpg');
            
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            filter: blur(8px); /* The blur effect */
            z-index: -2; 
        }
        
        /* Dark overlay to improve text readability */
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
            z-index: 1; /* Ensure content is above background */
        }

        .card {
            /* Slightly transparent white background for the card */
            background-color: rgba(255, 255, 255, 0.95); 
            border: none;
        }
        
    </style>
</head>
<body class="bg-light">

<div class="container my-5">
    <div class="card shadow p-4">
        <h2 class="text-center mb-4 text-primary">
            <i class="fas fa-users"></i> Registered User List
        </h2>
        
        <p class="text-end">
            <a href="/register" class="btn btn-success">
                <i class="fas fa-plus-circle"></i> Add New User
            </a>
        </p>

        <c:choose>
            <c:when test="${not empty users}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-primary">
                            <tr>
                                <th>#</th>
                                <th>Photo</th>
                                <th>Full Name</th>
                                <th>UserName</th>
                                <th>Email</th>
                                <th>Country</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>
                                        <img src="${user.photosImagePath}"
                                             class="profile-thumb" 
                                             alt="Profile" 
                                             onerror="this.onerror=null; this.src='/images/default_user.png';" 
                                        />
                                    </td>
                                    <td>${user.firstName} ${user.lastName}</td>
                                    <td>${user.userName}</td>
                                    <td>${user.email}</td>
                                    <td>${user.country}</td>
                                    <td>
                                        <a href="/users/edit/${user.id}" class="btn btn-sm btn-info text-white me-2">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="/users/delete/${user.id}" class="btn btn-sm btn-danger" 
                                           onclick="return confirm('Are you sure you want to delete this user?');">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center" role="alert">
                    <i class="fas fa-exclamation-triangle"></i> No users registered yet!
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>