<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>음악 상세 정보</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .album-card {
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80, 40, 120, 0.13);
            background: #fff;
        }
        .album-img {
            border-radius: 1.5rem;
            box-shadow: 0 4px 24px 0 rgba(80, 40, 120, 0.10);
            background: #fff;
            max-width: 85%;
        }
        .music-badge {
            font-size: 1.07rem;
            padding: 0.5em 1.1em;
            border-radius: 1em;
        }
        .music-title {
            font-size: 2.1rem;
            font-weight: 700;
            color: #8f5cf7;
        }
        .music-artist {
            font-size: 1.25rem;
            color: #666;
        }
        .music-price {
            font-size: 2rem;
            font-weight: 700;
            color: #f59e42;
        }
        .music-info-list .list-group-item {
            background: transparent;
            border: none;
            font-size: 1.08rem;
            padding-left: 0;
            padding-right: 0;
        }
        .music-info-list .bi {
            color: #8f5cf7;
            margin-right: 0.5em;
        }
        .music-action-btn {
            font-size: 1.15rem;
            font-weight: 600;
            border-radius: 1.2rem;
            padding: 0.85em 2.2em;
            transition: 0.15s;
        }
        .music-action-btn.btn-info {
            background: linear-gradient(90deg, #8f5cf7 0%, #f59e42 100%);
            color: #fff;
            border: none;
        }
        .music-action-btn.btn-info:hover {
            background: linear-gradient(90deg, #f59e42 0%, #8f5cf7 100%);
            color: #fff;
        }
        .music-action-btn.btn-warning {
            color: #fff;
            background: #f59e42;
            border: none;
        }
        .music-action-btn.btn-warning:hover {
            background: #ff9800;
            color: #fff;
        }
        .music-action-btn.btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        @media (max-width: 991px) {
            .music-title { font-size: 1.5rem; }
            .music-price { font-size: 1.4rem; }
        }
    </style>
</head>
<body>
<script type="text/javascript">
function addToCart() {
    if (confirm("음악을 장바구니에 추가하시겠습니까?")) {
        document.addForm.submit();
    } else {
        document.addForm.reset();
    }
}
</script>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <div class="py-5 mb-4" style="background: linear-gradient(90deg,#ff416c,#c1b6f7); border-radius:2rem;">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2"><i class="bi bi-music-note-beamed me-2"></i>음악 상세정보</h1>
            <p class="fs-4 mb-0">Music Detail</p>
        </div>
    </div>
    <%
        String id = request.getParameter("id");
        MusicRepository dao = MusicRepository.getInstance();
        Music music = dao.getMusicById(id);
        
        if (music == null) {
            response.sendRedirect("exceptionNoMusicId.jsp");
            return;
        }

        // 장바구니 세션 관리
        ArrayList<Music> cart = (ArrayList<Music>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<Music>();
            session.setAttribute("cart", cart);
        }

        // 장바구니에 추가 요청 처리
        String addCart = request.getParameter("addCart");
        if ("true".equals(addCart) && music != null) {
            boolean exists = false;
            for (Music m : cart) {
                if (m.getMusicId().equals(music.getMusicId())) {
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                cart.add(music);
            }
    %>
            <div class="alert alert-success mt-3" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                장바구니에 음악이 추가되었습니다! <a href="cart.jsp" class="alert-link">장바구니로 이동</a>
            </div>
    <%
        }
    %>
    <div class="row align-items-center justify-content-center">
        <div class="col-lg-5 mb-4 mb-lg-0 text-center">
            <div class="album-card p-4">
                <img src="./resources/assets/<%=music.getFilename()%>" class="img-fluid album-img" alt="음악 이미지">
            </div>
        </div>
        <div class="col-lg-7">
            <div class="album-card p-4 shadow-sm">
                <div class="d-flex align-items-center mb-2">
                    <span class="badge bg-gradient bg-primary-subtle text-primary music-badge me-2">
                        <i class="bi bi-music-note-beamed me-1"></i><%=music.getGenre() %>
                    </span>
                    <% if (music.getDiscountCheck() != null && music.getDiscountCheck()) { %>
                        <span class="badge bg-success music-badge"><i class="bi bi-percent"></i> 할인 적용</span>
                    <% } %>
                </div>
                <h2 class="music-title mb-1"><%=music.getMusicTitle() %></h2>
                <div class="music-artist mb-3"><i class="bi bi-person-fill me-1"></i><%=music.getMusicSinger() %></div>
                <ul class="list-group list-group-flush mb-3 music-info-list">
                    <li class="list-group-item"><i class="bi bi-upc-scan"></i><b>음악코드 :</b> <span class="badge bg-danger"><%=music.getMusicId() %></span></li>
                    <li class="list-group-item"><i class="bi bi-calendar-event"></i><b> 출시일 :</b> <%=music.getReleaseDate() %></li>
                    <li class="list-group-item"><i class="bi bi-disc"></i><b> 포맷 :</b> <%=music.getFormat() %></li>
                    <li class="list-group-item"><i class="bi bi-card-text"></i><b> 설명 :</b> <%=music.getDescription() %></li>
                </ul>
                <div class="mb-4">
                    <span class="music-price"><i class="bi bi-cash-coin me-2"></i><%=music.getUnitPrice() %>원</span>
                </div>
                <form name="addForm" action="musicDetail.jsp?id=<%=music.getMusicId()%>&addCart=true" method="post" class="d-inline">
                    <button type="button" class="btn music-action-btn btn-info me-2" onclick="addToCart()">
                        <i class="bi bi-bag-plus-fill me-1"></i>음악주문
                    </button>
                </form>
                <a href="cart.jsp" class="btn music-action-btn btn-warning me-2">
                    <i class="bi bi-cart-fill me-1"></i>장바구니
                </a>
                <a href="index.jsp" class="btn music-action-btn btn-secondary">
                    <i class="bi bi-arrow-left-circle me-1"></i>음악 목록
                </a>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
