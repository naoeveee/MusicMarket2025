<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>
<%@ page errorPage="exceptionNoMusicId.jsp" %>
<jsp:useBean id="musicDAO" class="dao.MusicRepository" scope="session" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>음악 목록 | Mello-Catch</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="menu.jsp" %>
    <header class="py-5 mb-4" style="background: linear-gradient(to right, #ff416c, #c1b6f7);">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">Mello-Catch</h1>
                <p class="lead fw-normal text-white-50 mb-0">다양한 장르의 음악을 한 곳에서 즐기세요</p>
            </div>
        </div>
    </header>

    <!-- 검색 폼 -->
    <div class="container mb-4">
        <form action="index.jsp" method="get" class="row g-2 justify-content-center">
            <div class="col-auto">
                <select name="searchField" class="form-select">
                    <option value="music_title"
                        <%= "music_title".equals(request.getParameter("searchField")) ? "selected" : "" %>>제목</option>
                    <option value="music_singer"
                        <%= "music_singer".equals(request.getParameter("searchField")) ? "selected" : "" %>>가수</option>
                    <option value="genre"
                        <%= "genre".equals(request.getParameter("searchField")) ? "selected" : "" %>>장르</option>
                </select>
            </div>
            <div class="col-auto">
                <input type="text" name="searchKeyword" class="form-control"
                       value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>"
                       placeholder="검색어 입력">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary">검색</button>
                <a href="index.jsp" class="btn btn-outline-secondary">전체보기</a>
            </div>
        </form>
    </div>

    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-4">
            <%
                String searchField = request.getParameter("searchField");
                String searchKeyword = request.getParameter("searchKeyword");
                ArrayList<Music> listOfMusics;

               

                boolean validField = "music_title".equals(searchField)
                                  || "music_singer".equals(searchField)
                                  || "genre".equals(searchField);

                if (validField && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                    listOfMusics = musicDAO.searchMusics(searchField, searchKeyword);
                } else {
                    listOfMusics = musicDAO.getAllMusics();
                }
            %>
            <div class="row gx-4 gx-lg-5 row-cols-1 row-cols-md-2 row-cols-xl-3 justify-content-center">
            <%
                if (listOfMusics.isEmpty()) {
            %>
                <div class="col-12 text-center">
                    <div class="alert alert-warning">검색 결과가 없습니다.</div>
                </div>
            <%
                } else {
                    for (Music music : listOfMusics) {
                        boolean alreadyLiked = false;
                        if (sessionId != null) {
                            alreadyLiked = MusicRepository.getInstance().hasLiked(sessionId, music.getMusicId());
                        }
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
                                <!-- 좋아요 토글 버튼 -->
                                <form action="likeMusic.jsp" method="post" style="display:inline;">
                                    <input type="hidden" name="musicId" value="<%=music.getMusicId()%>">
                                    <%
                                        if (sessionId == null) {
                                    %>
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-heart-fill"></i> 좋아요 (<%=music.getLikeCount()%>)
                                        </button>
                                    <%
                                        } else if (alreadyLiked) {
                                    %>
                                        <input type="hidden" name="action" value="unlike">
                                        <button type="submit" class="btn btn-secondary btn-sm">
                                            <i class="bi bi-heart-fill"></i> 좋아요 취소 (<%=music.getLikeCount()%>)
                                        </button>
                                    <%
                                        } else {
                                    %>
                                        <input type="hidden" name="action" value="like">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-heart-fill"></i> 좋아요 (<%=music.getLikeCount()%>)
                                        </button>
                                    <%
                                        }
                                    %>
                                </form>
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
                }
            %>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>	
</body>
</html>
