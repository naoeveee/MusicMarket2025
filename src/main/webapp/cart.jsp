
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>

<%@ page contentType="text/html; charset=UTF-8" %>
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
    <!-- Bootstrap CSS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .cart-table th, .cart-table td { vertical-align: middle; text-align: center; }
        .cart-actions { margin-bottom: 1.5rem; }
        .cart-summary { background: #f8f9fa; border-radius: 0.5rem; padding: 1rem; margin-top: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04);}
        @media (max-width: 768px) { .cart-table th, .cart-table td { font-size: 0.95rem; } }
    </style>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="p-5 mb-4 bg-light rounded-3 shadow-sm">
        <div class="container-fluid py-3">
            <h1 class="display-6 fw-bold mb-2">장바구니</h1>
            <p class="fs-5 text-secondary mb-0">내가 담은 음악을 한눈에 확인하고 주문하세요.</p>
        </div>
    </div>

    <div class="cart-actions d-flex justify-content-between align-items-center flex-wrap">
        <a href="./deleteCart.jsp" class="btn btn-danger mb-2 mb-md-0">
            <i class="bi bi-trash"></i> 전체 비우기
        </a>
        <a href="./shippingInfo.jsp" class="btn btn-success">
            <i class="bi bi-bag-check"></i> 주문하기
        </a>
    </div>

    <div class="table-responsive">
        <table class="table table-hover cart-table align-middle shadow-sm">
            <thead class="table-primary">
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
                        장바구니에 담긴 음악이 없습니다.<br>
                        <a href="index.jsp" class="btn btn-outline-primary mt-3">음악 쇼핑하러 가기</a>
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
                <tr class="cart-summary">
                    <td colspan="3"></td>
                    <th class="text-end">총액</th>
                    <th class="text-primary fs-5"><%=sum%>원</th>
                    <td></td>
                </tr>
            </tfoot>
            <% } %>
        </table>
    </div>
    
    <div class="text-end mt-3">
        <a href="index.jsp" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
    </div>
    <jsp:include page="footer.jsp" />
</div>
<!-- Bootstrap JS (CDN) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
