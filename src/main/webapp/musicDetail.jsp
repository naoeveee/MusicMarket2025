<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>음악 상세 정보</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS (CDN 권장) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <div class="py-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="display-5 fw-bold">음악정보</h1>
            <p class="col-md-8 fs-4">MusicInfo</p>
        </div>
    </div>
    <%
        String id = request.getParameter("id");
        MusicRepository dao = MusicRepository.getInstance();
        Music music = dao.getMusicById(id);
    %>
    <div class="row align-items-center">
        <div class="col-md-5 text-center">
            <img src="./resources/assets/<%=music.getFilename()%>" class="img-fluid rounded shadow" alt="음악 이미지" style="max-width:70%;">
        </div>
        <div class="col-md-7">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title mb-3"><b><%=music.getMusicTitle() %></b></h3>
                    <ul class="list-group list-group-flush mb-3">
                        <li class="list-group-item"><b>가수 :</b> <%=music.getMusicSinger() %></li>
                        <li class="list-group-item"><b>음악코드 :</b> <span class="badge bg-danger"><%=music.getMusicId() %></span></li>
                        <li class="list-group-item"><b>출시일 :</b> <%=music.getReleaseDate() %></li>
                        <li class="list-group-item"><b>할인여부 :</b>
                            <%=music.getDiscountCheck() != null && music.getDiscountCheck() ? "할인 적용" : "할인 없음" %>
                        </li>
                    </ul>
                    <h4 class="mb-4 text-primary"><%=music.getUnitPrice() %>원</h4>
                    <form name="addForm" action="./addCart.jsp?id=<%=music.getMusicId()%>" method="post" class="d-inline">
                        <button type="button" class="btn btn-info me-2" onclick="addToCart()">음악주문 &raquo;</button>
                    </form>
                    <a href="./cart.jsp" class="btn btn-warning me-2">장바구니 &raquo;</a>
                    <a href="./index.jsp" class="btn btn-secondary">음악 목록 &raquo;</a>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<!-- Bootstrap JS (필요시) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
