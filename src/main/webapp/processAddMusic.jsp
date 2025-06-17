<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음악 업로드</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

// 1. 파일 저장 경로 지정 (이미지/음원 구분)
String imageFolder = request.getServletContext().getRealPath("/resources/assets");
String audioFolder = request.getServletContext().getRealPath("/resources/audio");
int maxSize = 20 * 1024 * 1024; // 최대 20MB
String encType = "UTF-8";

// 2. MultipartRequest로 이미지와 mp3 모두 한 번에 업로드 (임시로 imageFolder에 저장)
MultipartRequest multi = new MultipartRequest(request, imageFolder, maxSize, encType, new DefaultFileRenamePolicy());

// 3. 음악 정보 추출
String musicId = multi.getParameter("musicId");
String musicTitle = multi.getParameter("musicTitle");
String unitPrice = multi.getParameter("unitPrice");
String musicSinger = multi.getParameter("musicSinger");
String releaseDate = multi.getParameter("releaseDate");
String description = multi.getParameter("description");
String genre = multi.getParameter("genre");
String format = multi.getParameter("format");
String discountCheck = multi.getParameter("discountCheck"); // "on" 또는 null

// 4. 이미지 파일명 추출
String imageFileName = null;
if (multi.getFile("musicImage") != null) {
    imageFileName = multi.getFilesystemName("musicImage");
}

// 5. mp3 파일명 추출 및 audio 폴더로 이동
String audioFileName = null;
if (multi.getFile("musicAudio") != null) {
    audioFileName = multi.getFilesystemName("musicAudio");
    // 파일을 audio 폴더로 이동
    java.io.File srcFile = new java.io.File(imageFolder, audioFileName);
    java.io.File destFile = new java.io.File(audioFolder, audioFileName);
    boolean moved = srcFile.renameTo(destFile);
    // moved가 false면 파일 이동 실패 (권한, 경로 문제 등)
}

// 6. 가격/할인 처리
int price = (unitPrice == null || unitPrice.isEmpty()) ? 0 : Integer.parseInt(unitPrice);
Boolean discount = (discountCheck != null && discountCheck.equals("on")) ? true : false;

// 7. DB 저장
PreparedStatement pstmt = null;
String sql = "INSERT INTO music (music_id, music_title, unit_price, music_singer, release_date, discount_check, filename, description, genre, format, audio_filename) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, musicId);
pstmt.setString(2, musicTitle);
pstmt.setInt(3, price);
pstmt.setString(4, musicSinger);
pstmt.setString(5, releaseDate);
pstmt.setBoolean(6, discount);
pstmt.setString(7, imageFileName);
pstmt.setString(8, description);
pstmt.setString(9, genre);
pstmt.setString(10, format);
pstmt.setString(11, audioFileName);

pstmt.executeUpdate();

if (pstmt != null) pstmt.close();
if (conn != null) conn.close();

response.sendRedirect("index.jsp");
%>
</body>
</html>
