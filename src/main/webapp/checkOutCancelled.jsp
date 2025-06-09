<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 취소</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="p-5 mb-4 bg-light rounded-3 shadow-sm">
        <div class="container-fluid py-4">
            <h1 class="display-5 fw-bold text-danger">
                <i class="bi bi-x-octagon"></i> 주문 취소
            </h1>
            <p class="col-md-8 fs-4">Order Cancellation</p>
        </div>
    </div>

    <div class="row align-items-md-stretch justify-content-center">
        <div class="col-md-8">
            <div class="alert alert-danger text-center fs-5 mb-4">
                <i class="bi bi-emoji-frown"></i> 주문이 취소되었습니다.
            </div>
            <div class="text-center">
                <a href="./index.jsp" class="btn btn-secondary">
                    <i class="bi bi-music-note-list"></i> 음악 목록으로 돌아가기
                </a>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</div>
<!-- Bootstrap JS (CDN) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
