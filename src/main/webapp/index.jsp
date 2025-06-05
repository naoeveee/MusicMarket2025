<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import ="dto.Music" %>
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
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container px-4 px-lg-5">
            <a class="navbar-brand" href="#">멜로캐치</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">홈</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">소개</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">쇼핑</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="#">전체 음악</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="#">인기 음악</a></li>
                            <li><a class="dropdown-item" href="#">최신 음악</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="d-flex">
                    <button class="btn btn-outline-dark" type="submit">
                        <i class="bi-cart-fill me-1"></i>
                        장바구니
                        <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                    </button>
                </form>
            </div>
        </div>
    </nav>

    <!-- Header-->
    <header class="bg-dark py-5">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">스타일리시한 쇼핑</h1>
                <p class="lead fw-normal text-white-50 mb-0">이 템플릿으로 쇼핑 홈페이지를 시작하세요</p>
            </div>
        </div>
    </header>

	<!-- 도서 목록 가져오기 -->
	<%
		ArrayList<Music> listOfMusics=musicDAO.getAllMusics();
	%>
	
    <!-- Section-->
    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-5">
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                
    <%
		for (int i=0;i<listOfMusics.size();i++){
			Music music=listOfMusics.get(i);
	%>
                
                
                <!-- 상품 카드 샘플 1 -->
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
                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니에 추가</a></div>
            </div>
        </div>
    </div>
	<% 
		} 
	%>
                

                <!-- 필요시 더 추가 가능 -->

            </div>
        </div>
    </section>

    <!-- Footer-->
    <footer class="py-5 bg-dark">
        <div class="container">
            <p class="m-0 text-center text-white">Copyright &copy; Your Website 2025</p>
        </div>
    </footer>

    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>

