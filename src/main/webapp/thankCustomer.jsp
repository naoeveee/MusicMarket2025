<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 완료</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
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

    <div class="p-5 mb-4 bg-light rounded-3 shadow-sm">
        <div class="container-fluid py-4">
            <h1 class="display-5 fw-bold text-success">
                <i class="bi bi-music-note-beamed"></i> 주문 완료
            </h1>
            <p class="col-md-8 fs-4">Order Completed</p>
        </div>
    </div>

    <div class="row align-items-md-stretch justify-content-center">
        <div class="col-md-8">
            <div class="alert alert-success text-center fs-5 mb-4">
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
    </div>
    <%@ include file="footer.jsp" %>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%
    // 세션 종료 및 배송 관련 쿠키 삭제
    session.invalidate();

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
