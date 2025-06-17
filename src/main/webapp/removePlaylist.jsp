<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dao.MusicRepository" %>
<%
    request.setCharacterEncoding("UTF-8");
    int playlistId = Integer.parseInt(request.getParameter("playlistId"));
    String musicId = request.getParameter("musicId");
    MusicRepository.getInstance().removeMusicFromPlaylist(playlistId, musicId);
    response.sendRedirect("playlist.jsp");
%>