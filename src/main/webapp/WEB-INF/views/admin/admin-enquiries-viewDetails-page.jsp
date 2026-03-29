<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enquiry Details - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {--maroon: #922b3e; --dark: #1a1a2e;}
        
        body {background-color: #f4f7f6; font-family: 'Inter', sans-serif;}
        .text-maroon {color: var(--maroon) !important; font-weight: 600;}
        .details-card {background: white; border-radius: 15px; border: none; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-top: 50px;}
        .card-header {background: var(--maroon); color: white; border-radius: 15px 15px 0 0 !important; padding: 20px; font-weight: 700;}
        .label { color: #888; font-size: 0.85rem; text-transform: uppercase; font-weight: 600; }
        .value { color: #333; font-size: 1.1rem; margin-bottom: 20px; font-weight: 500; }
        .message-box {background: #f8f9fa; padding: 20px; border-radius: 10px; border-left: 5px solid var(--maroon); min-height: 150px; white-space: pre-wrap; word-wrap: break-word;}
        .btn-back { background: var(--dark); color: white; border-radius: 8px; }
        .btn-back:hover { background: #000; color: white; }
        
    </style>
</head>
<body>
    <div class="container pb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card details-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span class="fs-5"><i class="fas fa-envelope-open-text me-2"></i> Enquiry #${enquiry.id}</span>
                        <a href="/admin/enquiries" class="btn btn-sm btn-light text-maroon shadow-sm">
                            <i class="fas fa-arrow-left me-1"></i> Back to List
                        </a>
                    </div>
                    <div class="card-body p-4">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="label">Full Name</p>
                                <p class="value">${enquiry.fullName}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="label">Email Address</p>
                                <p class="value"><i class="fas fa-envelope text-muted me-2"></i>${enquiry.email}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="label">Phone Number</p>
                                <p class="value"><i class="fas fa-phone text-muted me-2"></i>${enquiry.phone != null ? enquiry.phone : 'N/A'}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="label">Subject / Interest</p>
                                <p class="value"><span class="badge" style="background: var(--maroon)">${enquiry.subject}</span></p>
                            </div>
                        </div>
                        
                        <hr class="my-4 text-muted">
                        
                        <p class="label">Message Content</p>
                        <div class="message-box shadow-sm">
                            <c:out value="${enquiry.message}" default="No message provided." />
                        </div>
                        
                        <div class="mt-4 text-muted small d-flex align-items-center">
                            <i class="fas fa-calendar-alt me-2"></i> 
                            <span>Submitted on: ${enquiry.submittedAt != null ? enquiry.submittedAt : 'Date not available'}</span>
                        </div>
                    </div>
                    <div class="card-footer bg-light p-3 text-end">
                        <a href="mailto:${enquiry.email}" class="btn text-white px-4" style="background: var(--maroon)">
                            <i class="fas fa-reply me-2"></i> Reply via Email
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>