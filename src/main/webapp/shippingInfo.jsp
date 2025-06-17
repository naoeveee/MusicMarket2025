<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>배송 정보 | Mello-Catch</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .shipping-header-card {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .shipping-form-card {
            max-width: 540px;
            margin: 0 auto 2.5rem auto;
            background: #fff;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            padding: 2.5rem 2.2rem 2rem 2.2rem;
        }
        .shipping-form-card .form-label {
            font-weight: 600;
            color: #8f5cf7;
        }
        .shipping-form-card .form-control {
            border-radius: 1rem;
            font-size: 1.08rem;
            min-height: 2.7rem;
        }
        .shipping-form-card .btn-primary {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
            border-radius: 1.1rem;
            font-weight: 700;
            font-size: 1.1rem;
            transition: 0.18s;
        }
        .shipping-form-card .btn-primary:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
        }
        .shipping-form-card .btn-secondary {
            border-radius: 1.1rem;
            font-size: 1.05rem;
            font-weight: 600;
        }
        @media (max-width: 576px) {
            .shipping-form-card { padding: 1.2rem 0.6rem; }
        }
        .footer-music {
            margin-top: 3.5rem;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border-radius: 2rem 2rem 0 0;
        }
        @media (max-width: 576px) {
            .footer-music { padding-top: 1.2rem; padding-bottom: 1.2rem; }
        }
    </style>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <!-- 배송정보 헤더 -->
    <div class="shipping-header-card py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2"><i class="bi bi-truck me-2"></i>배송 정보</h1>
            <p class="fs-4 mb-0 text-white-50">Shipping Info</p>
        </div>
    </div>

    <!-- 배송정보 입력 폼 카드 -->
    <div class="shipping-form-card">
        <form action="./processShippingInfo.jsp" method="post">
            <input type="hidden" name="cartId" value="<%=request.getParameter("cartId")%>">
            <div class="mb-4">
                <label for="name" class="form-label"><i class="bi bi-person-fill me-1"></i>성명</label>
                <input type="text" name="name" id="name" class="form-control" required>
            </div>
            <div class="mb-4">
                <label for="shippingDate" class="form-label"><i class="bi bi-calendar-event me-1"></i>배송일</label>
                <input type="text" name="shippingDate" id="shippingDate" class="form-control" placeholder="yyyy/mm/dd" required>
            </div>
            <div class="mb-4">
                <label for="country" class="form-label"><i class="bi bi-geo-alt-fill me-1"></i>국가명</label>
                <input type="text" name="country" id="country" class="form-control" required>
            </div>
            <div class="mb-4">
                <label for="zipCode" class="form-label"><i class="bi bi-mailbox2 me-1"></i>우편번호</label>
                <input type="text" name="zipCode" id="zipCode" class="form-control" required>
            </div>
            <div class="mb-4">
                <label for="addressName" class="form-label"><i class="bi bi-house-door-fill me-1"></i>주소</label>
                <input type="text" name="addressName" id="addressName" class="form-control" required>
            </div>
            <div class="d-flex justify-content-between gap-2 mt-4">
                <a href="./cart.jsp?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button">
                    <i class="bi bi-arrow-left"></i> 이전
                </a>
                <input type="submit" class="btn btn-primary" value="등록" />
                <a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">
                    <i class="bi bi-x-circle"></i> 취소
                </a>
            </div>
        </form>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
