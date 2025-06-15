<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>

<%
    String loginUser = (String) session.getAttribute("sessionId");

    if (loginUser == null) {
        // 로그인 안 된 경우, 현재 페이지의 주소를 originalUrl에 저장
        String currentUrl = request.getRequestURI();
        session.setAttribute("originalUrl", currentUrl);

        // 로그인 페이지로 리디렉션
        response.sendRedirect(request.getContextPath() + "/member/loginMember.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .cart-header-card {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .cart-table-card {
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            background: #fff;
            padding: 2rem 1.5rem 1.5rem 1.5rem;
        }
        .cart-table th, .cart-table td { 
            vertical-align: middle; 
            text-align: center;
            font-size: 1.07rem;
        }
        .cart-table th {
            background: linear-gradient(90deg,#8f5cf7 0%, #f59e42 100%);
            color: #fff;
            border: none;
        }
        .cart-table td {
            background: #fff;
        }
        .cart-actions .btn {
            border-radius: 1.1rem;
            font-size: 1.07rem;
            font-weight: 600;
        }
        .cart-actions .btn-danger {
            background: linear-gradient(90deg,#ff416c,#f59e42);
            border: none;
            color: #fff;
        }
        .cart-actions .btn-danger:hover {
            background: linear-gradient(90deg,#f59e42,#ff416c);
            color: #fff;
        }
        .cart-actions .btn-success {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
            color: #fff;
        }
        .cart-actions .btn-success:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
            color: #fff;
        }
        .cart-summary-row th, .cart-summary-row td {
            background: #f8e8ff !important;
            font-size: 1.2rem;
            border-top: 2px solid #f59e42;
        }
        .btn-outline-danger {
            border-radius: 1.1rem;
        }
        .btn-outline-primary {
            border-radius: 1.1rem;
        }
        @media (max-width: 768px) { 
            .cart-table th, .cart-table td { font-size: 0.95rem; }
            .cart-table-card { padding: 1rem 0.3rem; }
        }
    </style>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <!-- 헤더 카드 -->
    <div class="cart-header-card py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2"><i class="bi bi-cart-fill me-2"></i>장바구니</h1>
            <p class="fs-4 mb-0 text-white-50">내가 담은 음악을 한눈에 확인하고 주문하세요.</p>
        </div>
    </div>

    <!-- 액션 버튼 -->
    <div class="cart-actions d-flex justify-content-between align-items-center flex-wrap mb-4">
        <a href="./deleteCart.jsp" class="btn btn-danger mb-2 mb-md-0">
            <i class="bi bi-trash"></i> 전체 비우기
        </a>
        <a href="./shippingInfo.jsp" class="btn btn-success">
            <i class="bi bi-bag-check"></i> 주문하기
        </a>
    </div>

    <!-- 장바구니 테이블 카드 -->
    <div class="cart-table-card mb-4">
        <div class="table-responsive">
            <table class="table cart-table align-middle mb-0">
                <thead>
                    <tr>
                        <th>음악</th>
                        <th>가수</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>소계</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    int sum = 0;
                    ArrayList<Music> cart = (ArrayList<Music>) session.getAttribute("cart");
                    if (cart == null || cart.size() == 0) {
                %>
                    <tr>
                        <td colspan="6" class="text-center text-secondary py-4">
                            <i class="bi bi-emoji-frown fs-1 mb-2 d-block"></i>
                            장바구니에 담긴 음악이 없습니다.<br>
                            <a href="index.jsp" class="btn btn-outline-primary mt-3"><i class="bi bi-music-note-beamed me-1"></i>음악 쇼핑하러 가기</a>
                        </td>
                    </tr>
                <%
                    } else {
                        for (int i = 0; i < cart.size(); i++) {
                            Music music = cart.get(i);
                            int total = music.getUnitPrice() * music.getQuantity();
                            sum += total;
                %>
                    <tr>
                        <td>
                            <strong><%=music.getMusicTitle()%></strong><br>
                            <span class="text-muted small"><%=music.getMusicId()%></span>
                        </td>
                        <td><%=music.getMusicSinger()%></td>
                        <td><%=music.getUnitPrice()%>원</td>
                        <td><%=music.getQuantity()%></td>
                        <td><%=total%>원</td>
                        <td>
                            <a href="./removeCart.jsp?id=<%=music.getMusicId()%>" class="btn btn-outline-danger btn-sm">
                                <i class="bi bi-x-circle"></i> 삭제
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
                <% if (cart != null && cart.size() > 0) { %>
                <tfoot>
                    <tr class="cart-summary-row">
                        <td colspan="3"></td>
                        <th class="text-end">총액</th>
                        <th class="text-primary"><i class="bi bi-cash-coin me-1"></i><%=sum%>원</th>
                        <td></td>
                    </tr>
                </tfoot>
                <% } %>
            </table>
        </div>
    </div>
    
    <div class="text-end mt-3">
        <a href="index.jsp" class="btn btn-outline-primary btn-lg"><i class="bi bi-arrow-left-circle me-1"></i>쇼핑 계속하기</a>
    </div>
    <jsp:include page="footer.jsp" />
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
