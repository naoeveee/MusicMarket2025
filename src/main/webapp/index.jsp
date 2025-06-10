
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>
<jsp:useBean id="musicDAO" class="dao.MusicRepository" scope="session" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MusicMarket</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
    <!-- Navigation-->
    
    <%@ include file="menu.jsp" %>
    

    <!-- Header-->
    <header class="bg-dark py-5">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">Mello-Catch</h1>
                <p class="lead fw-normal text-white-50 mb-0">다양한 장르의 음악을 한 곳에서 즐기세요</p>
            </div>
        </div>
    </header>

    <!-- 음악 목록 가져오기 -->
    <%
        ArrayList<Music> listOfMusics = musicDAO.getAllMusics();
    %>
    
    <!-- Section-->
    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-5">
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                
    <%
        for (int i = 0; i < listOfMusics.size(); i++) {
            Music music = listOfMusics.get(i);
    %>
                <!-- 상품 카드 -->
                <div class="col mb-5">
                    <div class="card h-100">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/assets/<%=music.getFilename()%>" alt="음악 이미지" />
                        <div class="card-body p-4">
                            <div class="text-center">
                                <h5 class="fw-bolder"><%=music.getMusicTitle()%></h5>
                                <p><%=music.getMusicSinger()%></p>
                                ₩<%=music.getUnitPrice()%>
                            </div>
                        </div>
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="text-center">
                                <a class="btn btn-outline-dark mt-auto" href="#">장바구니에 추가</a>
                                <a class="btn btn-primary mt-auto ms-2"href="musicDetail.jsp?id=<%=music.getMusicId()%>">상세정보</a>
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

    <!-- Footer-->
    <%@ include file="footer.jsp" %>

    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
