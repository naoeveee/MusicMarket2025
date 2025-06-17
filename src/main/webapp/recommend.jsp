<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="dao.MusicRepository" %>
<%@ page import="dto.Music" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>추천 음악</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .recommend-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #8f5cf7;
            margin-bottom: 2.5rem;
            text-align: center;
        }
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #f59e42;
            margin-bottom: 1.1rem;
            margin-top: 2.5rem;
            letter-spacing: 0.01em;
        }
        .music-card {
            border-radius: 1.5rem;
            box-shadow: 0 4px 18px 0 rgba(80, 40, 120, 0.10);
            background: #fff;
            margin-bottom: 2rem;
            transition: box-shadow 0.2s;
        }
        .music-card:hover {
            box-shadow: 0 8px 32px 0 rgba(80, 40, 120, 0.16);
        }
        .music-img {
            border-radius: 1.2rem 1.2rem 0 0;
            width: 100%;
            object-fit: cover;
            height: 210px;
        }
        .music-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #8f5cf7;
        }
        .music-artist {
            font-size: 1.05rem;
            color: #666;
        }
        .music-genre {
            font-size: 0.97rem;
            color: #f59e42;
        }
        .music-price {
            font-size: 1.13rem;
            font-weight: 700;
            color: #f59e42;
        }
        .music-card-btn {
            border-radius: 1.2rem;
            font-size: 1.02rem;
            font-weight: 600;
            padding: 0.6em 1.5em;
            background: linear-gradient(90deg, #8f5cf7 0%, #f59e42 100%);
            color: #fff;
            border: none;
            transition: background 0.15s;
        }
        .music-card-btn:hover {
            background: linear-gradient(90deg, #f59e42 0%, #8f5cf7 100%);
            color: #fff;
        }
        .no-recommend {
            font-size: 1.15rem;
            color: #888;
            margin-top: 2.5rem;
            text-align: center;
        }
        @media (max-width: 991px) {
            .music-title { font-size: 1.1rem; }
            .music-price { font-size: 1rem; }
            .music-img { height: 150px; }
        }
    </style>
</head>
<body>
<%@ include file="menu.jsp" %>
<div class="container py-5">
    <div class="recommend-title">
        <i class="bi bi-stars me-2"></i>당신을 위한 추천 음악
    </div>
    <%
        
        if (sessionId == null) {
            response.sendRedirect("member/loginMember.jsp");
            return;
        }
        List<Music> genreRecs = MusicRepository.getInstance().recommendForUser(sessionId);
        List<Music> collabRecs = MusicRepository.getInstance().recommendCollaborative(sessionId);
    %>
    <!-- 장르 기반 추천 -->
    <div class="section-title"><i class="bi bi-music-note-list me-1"></i>내가 좋아요한 장르 기반 추천</div>
    <div class="row justify-content-center">
        <%
            if (genreRecs != null && !genreRecs.isEmpty()) {
                for (Music m : genreRecs) {
        %>
        <div class="col-md-4 col-lg-3 d-flex align-items-stretch">
            <div class="music-card card mb-4 w-100">
                <img src="resources/assets/<%=m.getFilename()%>" class="music-img card-img-top" alt="앨범 이미지">
                <div class="card-body d-flex flex-column">
                    <div class="music-title mb-1"><%=m.getMusicTitle()%></div>
                    <div class="music-artist mb-2"><i class="bi bi-person-fill me-1"></i><%=m.getMusicSinger()%></div>
                    <div class="music-genre mb-2"><i class="bi bi-music-note-beamed me-1"></i><%=m.getGenre()%></div>
                    <div class="music-price mb-3"><i class="bi bi-cash-coin me-1"></i><%=m.getUnitPrice()%>원</div>
                    <a href="musicDetail.jsp?id=<%=m.getMusicId()%>" class="music-card-btn mt-auto">
                        <i class="bi bi-info-circle me-1"></i>상세보기
                    </a>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="no-recommend">
            <i class="bi bi-emoji-frown"></i> 추천할 음악이 없습니다.<br>
            <span style="font-size:1.05rem;">먼저 다양한 곡에 좋아요를 눌러보세요!</span>
        </div>
        <%
            }
        %>
    </div>
    <!-- 협업 필터링 기반 추천 -->
    <div class="section-title"><i class="bi bi-people-fill me-1"></i>비슷한 취향 유저 기반 추천</div>
    <div class="row justify-content-center">
        <%
            if (collabRecs != null && !collabRecs.isEmpty()) {
                for (Music m : collabRecs) {
        %>
        <div class="col-md-4 col-lg-3 d-flex align-items-stretch">
            <div class="music-card card mb-4 w-100">
                <img src="resources/assets/<%=m.getFilename()%>" class="music-img card-img-top" alt="앨범 이미지">
                <div class="card-body d-flex flex-column">
                    <div class="music-title mb-1"><%=m.getMusicTitle()%></div>
                    <div class="music-artist mb-2"><i class="bi bi-person-fill me-1"></i><%=m.getMusicSinger()%></div>
                    <div class="music-genre mb-2"><i class="bi bi-music-note-beamed me-1"></i><%=m.getGenre()%></div>
                    <div class="music-price mb-3"><i class="bi bi-cash-coin me-1"></i><%=m.getUnitPrice()%>원</div>
                    <a href="musicDetail.jsp?id=<%=m.getMusicId()%>" class="music-card-btn mt-auto">
                        <i class="bi bi-info-circle me-1"></i>상세보기
                    </a>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="no-recommend">
            <i class="bi bi-emoji-frown"></i> 추천할 음악이 없습니다.<br>
            <span style="font-size:1.05rem;">아직 비슷한 취향의 유저가 좋아요한 곡이 없습니다.</span>
        </div>
        <%
            }
        %>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
