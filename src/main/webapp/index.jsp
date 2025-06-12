<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>
<%@ page errorPage="exceptionNoMusicId.jsp" %>
<jsp:useBean id="musicDAO" class="dao.MusicRepository" scope="session" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>음악 목록 | Mello-Catch</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="menu.jsp" %>
    

    <!-- Header-->
    <header class="py-5 mb-4" style="background: linear-gradient(to right, #ff416c, #c1b6f7);">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Mello-Catch</h1>
            <p class="lead fw-normal text-white-50 mb-0">다양한 장르의 음악을 한 곳에서 즐기세요</p>
        </div>
    </div>
</header>





    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-4">
            <div class="row gx-4 gx-lg-5 row-cols-1 row-cols-md-2 row-cols-xl-3 justify-content-center">
            <%
                ArrayList<Music> listOfMusics = musicDAO.getAllMusics();
                for (Music music : listOfMusics) {
            %>
                <div class="col mb-5">
                    <div class="card h-100 shadow-sm">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/assets/<%=music.getFilename()%>" alt="음악 이미지" style="height: 280px; object-fit: cover;" />
                        <div class="card-body p-4">
                            <div class="text-center">
                                <h5 class="fw-bolder"><%=music.getMusicTitle()%></h5>
                                <p class="mb-1 text-muted"><%=music.getMusicSinger()%></p>
                                <span class="badge bg-secondary mb-2"><%=music.getGenre()%></span>
                                <div class="mb-2">₩<%=music.getUnitPrice()%></div>
                                
                            </div>
                        </div>
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="d-flex justify-content-center gap-2">
                                <a class="btn btn-outline-dark mt-auto" href="addCart.jsp?id=<%=music.getMusicId()%>&redirect=cart">
                                    <i class="bi bi-cart-plus"></i> 장바구니에 추가
                                </a>
                                <a class="btn btn-primary mt-auto ms-2" href="musicDetail.jsp?id=<%=music.getMusicId()%>">
                                    <i class="bi bi-info-circle"></i> 상세보기
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                }
            %>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
