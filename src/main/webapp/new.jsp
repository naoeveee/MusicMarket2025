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
    <title>최신 음악 | Mello-Catch</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .latest-header {
            background: linear-gradient(90deg,#f7c1e0,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
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
            min-height: 420px;
        }
        .music-card:hover {
            transform: translateY(-6px) scale(1.025);
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .music-card .card-img-top {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 1.2rem;
            box-shadow: 0 4px 16px 0 rgba(80,40,120,0.08);
            background: #f8f9fa;
            margin: 0 auto 1.2rem auto;
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
            .music-card .card-img-top {
                width: 90px; height: 90px;
            }
            .music-card .music-title { font-size: 1.05rem; }
            .music-card .music-artist { font-size: 0.95rem; }
            .music-card .music-price { font-size: 0.98rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <header class="latest-header py-5 mb-4">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder"><i class="bi bi-stars me-2"></i>최신 음악</h1>
                <p class="lead fw-normal text-white-50 mb-0">새롭게 발매된 음악을 확인해보세요!</p>
            </div>
        </div>
    </header>

    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-4">
            <div class="row gx-4 gx-lg-5 row-cols-1 row-cols-md-2 row-cols-xl-3 justify-content-center">
                <%
                    String sessionId = (String) session.getAttribute("sessionId");
                    for (Music music : listOfMusics) {
                        boolean alreadyLiked = false;
                        if (sessionId != null) {
                            alreadyLiked = MusicRepository.getInstance().hasLiked(sessionId, music.getMusicId());
                        }
                %>
                <div class="col mb-5">
                    <div class="music-card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/assets/<%=music.getFilename()%>" alt="음악 이미지" />
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
                %>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />
    <!-- Bootstrap JS (필수) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
