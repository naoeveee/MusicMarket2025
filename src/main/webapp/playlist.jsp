<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="dao.MusicRepository" %>
<%@ page import="dto.Music" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 플레이리스트 | Mello-Catch</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .playlist-title {
            font-size: 2rem;
            font-weight: 700;
            color: #8f5cf7;
            margin-bottom: 2.2rem;
            text-align: center;
        }
        .playlist-table {
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 4px 18px 0 rgba(80, 40, 120, 0.10);
            overflow: hidden;
        }
        .playlist-table th, .playlist-table td {
            vertical-align: middle;
            text-align: center;
        }
        .playlist-table th {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            color: #fff;
            font-size: 1.05rem;
            border: none;
        }
        .playlist-table td {
            background: #fff;
            font-size: 1.01rem;
        }
        .playlist-album-img {
            width: 68px;
            height: 68px;
            object-fit: cover;
            border-radius: 1rem;
            box-shadow: 0 2px 8px 0 rgba(80,40,120,0.08);
        }
        .music-title {
            font-weight: 700;
            color: #8f5cf7;
        }
        .music-artist {
            color: #666;
        }
        .music-genre {
            color: #f59e42;
            font-size: 0.97rem;
        }
        .audio-bar {
            width: 140px;
            min-width: 90px;
            max-width: 180px;
        }
        .playlist-delete-btn {
            border-radius: 1.2rem;
            font-size: 0.98rem;
            font-weight: 600;
            padding: 0.4em 1.1em;
            background: linear-gradient(90deg, #ff416c 0%, #f59e42 100%);
            color: #fff;
            border: none;
            transition: background 0.15s;
        }
        .playlist-delete-btn:hover {
            background: linear-gradient(90deg, #f59e42 0%, #ff416c 100%);
            color: #fff;
        }
        .music-detail-link {
            font-size: 1.25rem;
            color: #8f5cf7;
            margin-left: 0.3em;
            vertical-align: middle;
        }
        .no-playlist {
            font-size: 1.15rem;
            color: #888;
            margin-top: 2.5rem;
            text-align: center;
        }
        @media (max-width: 991px) {
            .playlist-table th, .playlist-table td { font-size: 0.96rem; }
            .playlist-album-img { width: 48px; height: 48px; }
            .audio-bar { width: 80px; }
        }
        @media (max-width: 600px) {
            .playlist-table th, .playlist-table td { font-size: 0.89rem; }
            .playlist-album-img { width: 38px; height: 38px; }
            .audio-bar { width: 60px; }
        }
    </style>
</head>
<body>
<%@ include file="menu.jsp" %>
<div class="container py-5">
    <div class="playlist-title">
        <i class="bi bi-music-player me-2"></i>내 플레이리스트 (구매한 곡)
    </div>
    <%
        
        if (sessionId == null) {
            response.sendRedirect("member/loginMember.jsp");
            return;
        }
        int playlistId = MusicRepository.getInstance().getOrCreatePurchasedPlaylistId(sessionId);
        List<Music> playlistMusics = MusicRepository.getInstance().getPlaylistMusics(playlistId);
    %>
    <div class="row justify-content-center">
        <div class="col-12">
        <%
            if (playlistMusics != null && !playlistMusics.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="table playlist-table align-middle">
                <thead>
                    <tr>
                        <th>앨범</th>
                        <th>곡명</th>
                        <th>아티스트</th>
                        <th>장르</th>
                        <th>재생</th>
                        <th>상세</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Music m : playlistMusics) {
                %>
                    <tr>
                        <td>
                            <img src="resources/assets/<%=m.getFilename()%>" class="playlist-album-img" alt="앨범 이미지">
                        </td>
                        <td class="music-title"><%=m.getMusicTitle()%></td>
                        <td class="music-artist"><%=m.getMusicSinger()%></td>
                        <td class="music-genre"><%=m.getGenre()%></td>
                        <td>
                        <%
                            String audioFile = m.getAudioFilename();
                            if (audioFile != null && !audioFile.trim().isEmpty()) {
                        %>
                            <audio class="audio-bar" controls>
                                <source src="resources/audio/<%=audioFile%>" type="audio/mp3">
                                지원되지 않는 브라우저입니다.
                            </audio>
                        <% } %>
                        </td>
                        <td>
                            <a href="musicDetail.jsp?id=<%=m.getMusicId()%>" class="music-detail-link" title="상세보기">
                                <i class="bi bi-info-circle"></i>
                            </a>
                        </td>
                        <td>
                            <form action="removePlaylist.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="playlistId" value="<%=playlistId%>">
                                <input type="hidden" name="musicId" value="<%=m.getMusicId()%>">
                                <button type="submit" class="playlist-delete-btn" onclick="return confirm('정말 삭제하시겠습니까?');">
                                    <i class="bi bi-trash"></i> 삭제
                                </button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <%
            } else {
        %>
        <div class="no-playlist">
            <i class="bi bi-emoji-frown"></i> 아직 구매한 곡이 없습니다.<br>
            <span style="font-size:1.05rem;">음악을 구매하면 이곳에 자동으로 담깁니다!</span>
        </div>
        <%
            }
        %>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
