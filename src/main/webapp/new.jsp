<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>

<%
    MusicRepository musicDAO = MusicRepository.getInstance();
    ArrayList<Music> listOfMusics = musicDAO.getNewMusics();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>최신 음악</title>
     <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
    <jsp:include page="menu.jsp" />

    <header class="py-5 mb-4" style="background: linear-gradient(to right, #f7c1e0, #c1b6f7);">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">최신 음악</h1>
                <p class="lead fw-normal text-white-50 mb-0">새롭게 발매된 음악을 확인해보세요!</p>
            </div>
        </div>
    </header>

    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-4">
            <div class="row gx-4 gx-lg-5 row-cols-1 row-cols-md-2 row-cols-xl-3 justify-content-center">
                <%
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
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />
    <!-- Bootstrap JS (필수) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
