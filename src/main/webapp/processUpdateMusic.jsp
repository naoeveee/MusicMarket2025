<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String realFolder = request.getServletContext().getRealPath("/resources/assets");
String encType = "UTF-8";
int maxSize = 5 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

String musicId = multi.getParameter("musicId");
String musicTitle = multi.getParameter("musicTitle");
String unitPrice = multi.getParameter("unitPrice");
String musicSinger = multi.getParameter("musicSinger");
String releaseDate = multi.getParameter("releaseDate");
String description = multi.getParameter("description");
String genre = multi.getParameter("genre");
String format = multi.getParameter("format");
String discountCheck = multi.getParameter("discountCheck"); // "on" or null

Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);

int price;
if (unitPrice == null || unitPrice.isEmpty())
    price = 0;
else
    price = Integer.valueOf(unitPrice);

Boolean discount = (discountCheck != null && discountCheck.equals("on")) ? true : false;

PreparedStatement pstmt = null;
ResultSet rs = null;

String sql = "SELECT * FROM music WHERE music_id = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, musicId);
rs = pstmt.executeQuery();

if (rs.next()) {
    if (fileName != null) {
        sql = "UPDATE music SET music_title=?, unit_price=?, music_singer=?, description=?, release_date=?, genre=?, format=?, discount_check=?, filename=? WHERE music_id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, musicTitle);
        pstmt.setInt(2, price);
        pstmt.setString(3, musicSinger);
        pstmt.setString(4, description);
        pstmt.setString(5, releaseDate);
        pstmt.setString(6, genre);
        pstmt.setString(7, format);
        pstmt.setBoolean(8, discount);
        pstmt.setString(9, fileName);
        pstmt.setString(10, musicId);
        pstmt.executeUpdate();
    } else {
        sql = "UPDATE music SET music_title=?, unit_price=?, music_singer=?, description=?, release_date=?, genre=?, format=?, discount_check=? WHERE music_id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, musicTitle);
        pstmt.setInt(2, price);
        pstmt.setString(3, musicSinger);
        pstmt.setString(4, description);
        pstmt.setString(5, releaseDate);
        pstmt.setString(6, genre);
        pstmt.setString(7, format);
        pstmt.setBoolean(8, discount);
        pstmt.setString(9, musicId);
        pstmt.executeUpdate();
    }
}
if (pstmt != null) pstmt.close();
if (conn != null) conn.close();

response.sendRedirect("editMusic.jsp?edit=update");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>음악 수정 처리</title>
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- 부트스트랩 적용, 별도 메시지 없이 바로 리다이렉트됨 -->
</body>
</html>
