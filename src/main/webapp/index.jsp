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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .search-card {
            max-width: 700px;
            margin: 0 auto 2.5rem auto;
            border-radius: 1.5rem;
            box-shadow: 0 6px 28px 0 rgba(80, 40, 120, 0.08);
            background: #fff;
            padding: 1.3rem 1.5rem 1rem 1.5rem;
        }
        .search-card .form-select, .search-card .form-control {
            border-radius: 1rem;
            font-size: 1.05rem;
            min-height: 2.5rem;
        }
        .search-card .input-group-text {
            background: #f3f6fa;
            border: none;
            border-radius: 1rem 0 0 1rem;
            font-size: 1.1rem;
        }
        .search-card .btn {
            border-radius: 1rem;
            font-weight: 600;
            font-size: 1.02rem;
            transition: 0.18s;
        }
        .search-card .btn-primary {
            background: linear-gradient(90deg, #8f5cf7 0%, #f59e42 100%);
            border: none;
        }
        .search-card .btn-primary:hover {
            background: linear-gradient(90deg, #f59e42 0%, #8f5cf7 100%);
        }
        .search-card .btn-outline-secondary {
            border-color: #e0e0e0;
        }
        .music-card {
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            background: #fff;
            transition: transform 0.18s;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem 1.5rem 1.3rem 1.5rem;
            margin-bottom: 2rem;
            min-height: 420px;
        }
        .music-card:hover {
            transform: translateY(-6px) scale(1.025);
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .music-card .album-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 1.2rem;
            box-shadow: 0 4px 16px 0 rgba(80,40,120,0.08);
            background: #f8f9fa;
            margin-bottom: 1.2rem;
        }
        .music-card .music-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #8f5cf7;
            text-align: center;
            margin-bottom: 0.2rem;
            word-break: keep-all;
        }
        .music-card .music-artist {
            font-size: 1.08rem;
            color: #666;
            text-align: center;
            margin-bottom: 0.5rem;
            word-break: keep-all;
        }
        .music-card .badge {
            font-size: 0.97rem;
            padding: 0.4em 1em;
            border-radius: 1em;
            margin-bottom: 0.7rem;
        }
        .music-card .music-price {
            font-size: 1.15rem;
            font-weight: 700;
            color: #f59e42;
            margin-bottom: 1rem;
            text-align: center;
        }
        .music-card .music-actions {
            display: flex;
            gap: 0.7rem;
            justify-content: center;
            width: 100%;
        }
        .music-card .btn-outline-dark,
        .music-card .btn-primary,
        .music-card .btn-danger,
        .music-card .btn-secondary {
            border-radius: 1.1rem;
            font-weight: 600;
            font-size: 0.98rem;
            padding: 0.45em 1.2em;
        }
        .music-card .btn-primary {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
        }
        .music-card .btn-primary:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
        }
        .music-card .btn-danger {
            background: linear-gradient(90deg,#ff416c,#f59e42);
            border: none;
        }
        .music-card .btn-danger:hover {
            background: linear-gradient(90deg,#f59e42,#ff416c);
        }
        .music-card .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        @media (max-width: 991px) {
            .music-card {
                padding: 1.2rem 0.7rem 1rem 0.7rem;
                min-height: 320px;
            }
            .music-card .album-img {
                width: 90px; height: 90px;
            }
            .music-card .music-title { font-size: 1.05rem; }
            .music-card .music-artist { font-size: 0.95rem; }
            .music-card .music-price { font-size: 0.98rem; }
        }
    </style>
</head>
<body>
    <%@ include file="menu.jsp" %>
    <header class="py-5 mb-4" style="background: linear-gradient(90deg,#ff416c,#c1b6f7); border-radius:2rem;">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder"><i class="bi bi-music-note-beamed me-2"></i>Mello-Catch</h1>
                <p class="lead fw-normal text-white-50 mb-0">다양한 장르의 음악을 한 곳에서 즐기세요</p>
            </div>
        </div>
    </header>

    <!-- 검색 카드 -->
    <div class="search-card mb-4">
        <form action="index.jsp" method="get">
            <div class="row g-2 align-items-center">
                <div class="col-4 col-md-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-filter-square"></i></span>
                        <select name="searchField" class="form-select">
                            <option value="music_title"
                                <%= "music_title".equals(request.getParameter("searchField")) ? "selected" : "" %>>제목</option>
                            <option value="music_singer"
                                <%= "music_singer".equals(request.getParameter("searchField")) ? "selected" : "" %>>가수</option>
                            <option value="genre"
                                <%= "genre".equals(request.getParameter("searchField")) ? "selected" : "" %>>장르</option>
                        </select>
                    </div>
                </div>
                <div class="col-5 col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" name="searchKeyword" class="form-control"
                               value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>"
                               placeholder="검색어 입력">
                    </div>
                </div>
                <div class="col-3 col-md-3 d-flex gap-2">
                    <button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i></button>
                    <a href="index.jsp" class="btn btn-outline-secondary w-100"><i class="bi bi-x-circle"></i></a>
                </div>
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
                    <div class="alert alert-warning py-5">
                        <i class="bi bi-emoji-frown fs-1 mb-2 d-block"></i>
                        검색 결과가 없습니다.
                    </div>
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
                    <div class="music-card">
                        <img class="album-img" src="${pageContext.request.contextPath}/resources/assets/<%=music.getFilename()%>" alt="음악 이미지" />
                        <div class="music-title" title="<%=music.getMusicTitle()%>"><%=music.getMusicTitle()%></div>
                        <div class="music-artist" title="<%=music.getMusicSinger()%>"><i class="bi bi-person-fill me-1"></i><%=music.getMusicSinger()%></div>
                        <span class="badge bg-gradient bg-primary-subtle text-primary"><i class="bi bi-music-note-beamed me-1"></i><%=music.getGenre()%></span>
                        <div class="music-price"><i class="bi bi-cash-coin me-1"></i>₩<%=music.getUnitPrice()%></div>
                        <div class="music-actions">
                            <form action="likeMusic.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="musicId" value="<%=music.getMusicId()%>">
                                <%
                                    if (sessionId == null) {
                                %>
                                    <button type="submit" class="btn btn-danger btn-sm" title="좋아요">
                                        <i class="bi bi-heart-fill"></i> <%=music.getLikeCount()%>
                                    </button>
                                <%
                                    } else if (alreadyLiked) {
                                %>
                                    <input type="hidden" name="action" value="unlike">
                                    <button type="submit" class="btn btn-secondary btn-sm" title="좋아요 취소">
                                        <i class="bi bi-heart-fill"></i> <%=music.getLikeCount()%>
                                    </button>
                                <%
                                    } else {
                                %>
                                    <input type="hidden" name="action" value="like">
                                    <button type="submit" class="btn btn-danger btn-sm" title="좋아요">
                                        <i class="bi bi-heart-fill"></i> <%=music.getLikeCount()%>
                                    </button>
                                <%
                                    }
                                %>
                            </form>
                            <a class="btn btn-outline-dark btn-sm" href="addCart.jsp?id=<%=music.getMusicId()%>&redirect=cart" title="장바구니">
                                <i class="bi bi-cart-plus"></i>
                            </a>
                            <a class="btn btn-primary btn-sm" href="musicDetail.jsp?id=<%=music.getMusicId()%>" title="상세보기">
                                <i class="bi bi-info-circle"></i>
                            </a>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
