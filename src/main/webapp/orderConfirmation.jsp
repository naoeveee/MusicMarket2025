<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="dto.Music"%>
<%@ page import="dao.MusicRepository" %>
<%
    request.setCharacterEncoding("UTF-8");

    String cartId = session.getId();

    String shipping_cartId = "";
    String shipping_name = "";
    String shipping_shippingDate = "";
    String shipping_country = "";
    String shipping_zipCode = "";
    String shipping_addressName = "";

    Cookie[] cookies = request.getCookies();

    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            Cookie thisCookie = cookies[i];
            String n = thisCookie.getName();
            if (n.equals("Shipping_cartId"))
                shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
            if (n.equals("Shipping_name"))
                shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
            if (n.equals("Shipping_shippingDate"))
                shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
            if (n.equals("Shipping_country"))
                shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
            if (n.equals("Shipping_zipCode"))
                shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
            if (n.equals("Shipping_addressName"))
                shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
        }
    }

    // ---- 주문 완료 시 '구매한 곡' 플레이리스트에 자동 추가 ----
    String userId = (String) session.getAttribute("sessionId");
    ArrayList<Music> cartList = (ArrayList<Music>) session.getAttribute("cart");
    if (userId != null && cartList != null && !cartList.isEmpty()) {
        try {
            // 1. '구매한 곡' 플레이리스트 ID 조회(없으면 생성)
            int playlistId = MusicRepository.getInstance().getOrCreatePurchasedPlaylistId(userId);

            // 2. 각 곡을 플레이리스트에 추가 (중복 방지)
            for (Music music : cartList) {
                MusicRepository.getInstance().addMusicToPlaylistIfNotExists(playlistId, music.getMusicId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // ---------------------------------------------------------
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 정보 | Mello-Catch</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .order-header-card {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .order-receipt-card {
            max-width: 700px;
            margin: 0 auto 2.5rem auto;
            background: #fff;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            padding: 2.5rem 2.2rem 2rem 2.2rem;
        }
        .order-receipt-card h1 {
            font-size: 2rem;
            font-weight: 700;
            color: #8f5cf7;
            margin-bottom: 1.5rem;
        }
        .order-info-label {
            font-weight: 600;
            color: #8f5cf7;
        }
        .order-address {
            font-size: 1.07rem;
            margin-bottom: 1rem;
            color: #222;
        }
        .order-date {
            font-size: 1.07rem;
            color: #666;
            margin-bottom: 1rem;
        }
        .order-table th, .order-table td {
            vertical-align: middle;
            text-align: center;
        }
        .order-table th {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            color: #fff;
            border: none;
        }
        .order-table td {
            background: #fff;
        }
        .order-table .text-danger {
            font-size: 1.15rem;
            font-weight: 700;
        }
        .order-actions {
            margin-top: 2.2rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }
        .order-actions .btn-primary {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
            border-radius: 1.1rem;
            font-weight: 700;
            font-size: 1.1rem;
            transition: 0.18s;
        }
        .order-actions .btn-primary:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
        }
        .order-actions .btn-success {
            border-radius: 1.1rem;
            font-size: 1.05rem;
            font-weight: 600;
        }
        .order-actions .btn-secondary {
            border-radius: 1.1rem;
            font-size: 1.05rem;
            font-weight: 600;
        }
        .footer-music {
            margin-top: 3.5rem;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border-radius: 2rem 2rem 0 0;
        }
        @media (max-width: 576px) {
            .order-receipt-card { padding: 1.2rem 0.6rem; }
            .footer-music { padding-top: 1.2rem; padding-bottom: 1.2rem; }
        }
    </style>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <!-- 주문정보 헤더 -->
    <div class="order-header-card py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2"><i class="bi bi-receipt-cutoff me-2"></i>주문 정보</h1>
            <p class="fs-4 mb-0 text-white-50">Order Info</p>
        </div>
    </div>
    <div class="order-receipt-card">
        <div class="text-center mb-4">
            <h1><i class="bi bi-receipt me-2"></i>영수증</h1>
        </div>
        <div class="row justify-content-between mb-3">
            <div class="col-md-6 order-address text-start">
                <span class="order-info-label"><i class="bi bi-geo-alt-fill me-1"></i>배송 주소</span><br>
                성명 : <% out.println(shipping_name); %><br>
                우편번호 : <% out.println(shipping_zipCode); %><br>
                주소 : <% out.println(shipping_addressName); %> (<% out.println(shipping_country); %>)
            </div>
            <div class="col-md-6 order-date text-end">
                <em><i class="bi bi-calendar-event me-1"></i>배송일: <% out.println(shipping_shippingDate); %></em>
            </div>
        </div>
        <div class="py-3">
            <table class="table table-hover order-table">
                <thead>
                    <tr>
                        <th>음악</th>
                        <th>#</th>
                        <th>가격</th>
                        <th>소계</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    int sum = 0;
                    if (cartList == null)
                        cartList = new ArrayList<Music>();
                    for (int i = 0; i < cartList.size(); i++) {
                        Music music = cartList.get(i);
                        int total = music.getUnitPrice() * music.getQuantity();
                        sum = sum + total;
                %>
                    <tr>
                        <td><em><%=music.getMusicTitle()%></em></td>
                        <td><%=music.getQuantity()%></td>
                        <td><%=music.getUnitPrice()%>원</td>
                        <td><%=total%>원</td>
                    </tr>
                <%
                    }
                %>
                <tr>
                    <td colspan="2"></td>
                    <td class="text-end"><strong>총액:</strong></td>
                    <td class="text-danger"><strong><%=sum%>원</strong></td>
                </tr>
                </tbody>
            </table>
            <div class="order-actions">
                <a href="./ShippingInfo.jsp?cartId=<%=shipping_cartId%>" class="btn btn-secondary" role="button">
                    <i class="bi bi-arrow-left"></i> 이전
                </a>
                <a href="./thankCustomer.jsp" class="btn btn-success" role="button">
                    <i class="bi bi-check-circle"></i> 주문 완료
                </a>
                <a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">
                    <i class="bi bi-x-circle"></i> 취소
                </a>
            </div>
        </div>
    </div>

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
            </div>
        </div>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
