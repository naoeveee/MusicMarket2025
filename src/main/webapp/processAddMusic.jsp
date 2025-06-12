<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.Enumeration" %>
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

String realFolder = request.getServletContext().getRealPath("/resources/assets");
int maxSize = 5 * 1024 * 1024;
String encType = "UTF-8";

MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

String musicId = multi.getParameter("musicId");
String musicTitle = multi.getParameter("musicTitle");
String unitPrice = multi.getParameter("unitPrice");
String musicSinger = multi.getParameter("musicSinger");
String releaseDate = multi.getParameter("releaseDate");
String description = multi.getParameter("description");
String genre = multi.getParameter("genre");
String format = multi.getParameter("format");
String discountCheck = multi.getParameter("discountCheck"); // "on" 또는 null

Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);

int price;
if(unitPrice == null || unitPrice.isEmpty())
    price = 0;
else
    price = Integer.parseInt(unitPrice);

Boolean discount = (discountCheck != null && discountCheck.equals("on")) ? true : false;

PreparedStatement pstmt = null;

String sql = "INSERT INTO music (music_id, music_title, unit_price, music_singer, release_date, discount_check, filename, description, genre, format) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, musicId);
pstmt.setString(2, musicTitle);
pstmt.setInt(3, price);
pstmt.setString(4, musicSinger);
pstmt.setString(5, releaseDate);
pstmt.setBoolean(6, discount);
pstmt.setString(7, fileName);
pstmt.setString(8, description);
pstmt.setString(9, genre);
pstmt.setString(10, format);

pstmt.executeUpdate();

if (pstmt != null) pstmt.close();
if (conn != null) conn.close();

response.sendRedirect("index.jsp");
%>
</body>
</html>
