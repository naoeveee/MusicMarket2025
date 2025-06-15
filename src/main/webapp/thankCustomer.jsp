<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 완료 | Mello-Catch</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .order-complete-header {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .order-complete-card {
            max-width: 540px;
            margin: 0 auto 2.5rem auto;
            background: #fff;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            padding: 2.5rem 2.2rem 2rem 2.2rem;
        }
        .order-complete-card .alert-success {
            font-size: 1.16rem;
        }
        .order-complete-card .btn-secondary {
            border-radius: 1.1rem;
            font-size: 1.08rem;
            font-weight: 600;
        }
        .order-complete-card .card {
            border-radius: 1.2rem;
        }
        .footer-music {
            margin-top: 3.5rem;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border-radius: 2rem 2rem 0 0;
        }
        @media (max-width: 576px) {
            .order-complete-card { padding: 1.2rem 0.6rem; }
            .footer-music { padding-top: 1.2rem; padding-bottom: 1.2rem; }
        }
    </style>
</head>
<body>
<%
    // 쿠키에서 배송일 정보만 추출
    String shipping_shippingDate = "";

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            Cookie thisCookie = cookies[i];
            String n = thisCookie.getName();
            if ("Shipping_shippingDate".equals(n))
                shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
        }
    }
%>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <!-- 주문 완료 헤더 -->
    <div class="order-complete-header py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2 text-success">
                <i class="bi bi-music-note-beamed"></i> 주문 완료
            </h1>
            <p class="fs-4 mb-0 text-white-50">Order Completed</p>
        </div>
    </div>

    <!-- 주문 완료 카드 -->
    <div class="order-complete-card">
        <div class="alert alert-success text-center mb-4">
            <i class="bi bi-emoji-smile"></i> 주문해주셔서 감사합니다.
        </div>
        <div class="card mb-4 shadow-sm">
            <div class="card-body text-center">
                <p class="mb-3">
                    <i class="bi bi-truck"></i>
                    <strong>주문하신 음악은 <span class="text-primary"><%=shipping_shippingDate%></span>에 배송될 예정입니다!</strong>
                </p>
            </div>
        </div>
        <div class="text-center">
            <a href="./index.jsp" class="btn btn-secondary">
                <i class="bi bi-music-note-list"></i> 음악 목록으로 돌아가기
            </a>
        </div>
    </div>

    <!-- 푸터: 컨셉에 맞는 여백/컬러/브랜드 강조 -->
    <footer class="footer-music mt-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-4 text-center text-md-start mb-3 mb-md-0">
                    <span class="fs-4 fw-bold text-white">
                        <i class="bi bi-music-note-beamed me-2"></i>Mello-Catch
                    </span>
                </div>
                <div class="col-md-4 text-center mb-3 mb-md-0">
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-twitter"></i></a>
                </div>
                <div class="col-md-4 text-center text-md-end">
                    <span class="text-white-50 small">
                        Copyright &copy; Mello-Catch 2025<br>
                        All music content &copy; respective owners.
                    </span>
                </div>
            </div>
        </div>
    </footer>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
<%
    // 배송 관련 쿠키만 삭제
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            Cookie thisCookie = cookies[i];
            String n = thisCookie.getName();
            if (
                "Shipping_cartId".equals(n) ||
                "Shipping_name".equals(n) ||
                "Shipping_shippingDate".equals(n) ||
                "Shipping_country".equals(n) ||
                "Shipping_zipCode".equals(n) ||
                "Shipping_addressName".equals(n)
            ) {
                thisCookie.setMaxAge(0);
                thisCookie.setPath("/"); // 쿠키 삭제를 위해 경로 명시
                response.addCookie(thisCookie);
            }
        }
    }
%>
</body>
</html>
