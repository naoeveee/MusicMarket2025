<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dao.MusicRepository" %>
<%
    String sessionId = (String)session.getAttribute("sessionId");
    String musicId = request.getParameter("musicId");
    String action = request.getParameter("action");

    if (sessionId == null) {
        session.setAttribute("originalUrl", "index.jsp");
        response.sendRedirect("login.jsp");
        return;
    }

    if ("unlike".equals(action)) {
        // 좋아요 취소
        MusicRepository.getInstance().decreaseLike(musicId);
        MusicRepository.getInstance().deleteMusicLike(sessionId, musicId);
    } else {
        // 기본: 좋아요 추가
        if (!MusicRepository.getInstance().hasLiked(sessionId, musicId)) {
            MusicRepository.getInstance().increaseLike(musicId);
            MusicRepository.getInstance().insertMusicLike(sessionId, musicId);
        }
    }
    response.sendRedirect("index.jsp");
%>
