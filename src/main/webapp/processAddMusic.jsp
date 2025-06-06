<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("utf-8");

// 업로드 폴더 경로 (이미지 + mp3 공통)
String uploadPath = application.getRealPath("/resources/uploads");
int maxSize = 20 * 1024 * 1024;  // 최대 20MB
String encType = "utf-8";

String errorMessage = null;

try {
    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());

    // 파라미터 받기
    String title = multi.getParameter("title");
    String artist = multi.getParameter("artist");
    String releaseDate = multi.getParameter("releaseDate");
    String unitPrice = multi.getParameter("price");
    String description = multi.getParameter("description");
    String genre = multi.getParameter("genre");
    String format = multi.getParameter("format");

    // 파일명 받기
    String coverImageFile = multi.getFilesystemName("coverImage");  // 이미지
    String musicFile = multi.getFilesystemName("musicFile");        // MP3

    // 유효성 검사
    if (title == null || title.trim().isEmpty()) {
        errorMessage = "제목을 입력하세요.";
    } else if (artist == null || artist.trim().isEmpty()) {
        errorMessage = "아티스트를 입력하세요.";
    } else if (releaseDate == null || releaseDate.trim().isEmpty()) {
        errorMessage = "발매일을 입력하세요.";
    } else if (!releaseDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
        errorMessage = "발매일은 YYYY-MM-DD 형식이어야 합니다.";
    } else if (unitPrice == null || unitPrice.trim().isEmpty()) {
        errorMessage = "가격을 입력하세요.";
    } else {
        try {
            int priceCheck = Integer.parseInt(unitPrice);
            if (priceCheck < 0) {
                errorMessage = "가격은 0 이상이어야 합니다.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "가격은 숫자여야 합니다.";
        }
    }
    if (genre == null || genre.trim().isEmpty()) {
        errorMessage = "장르를 입력하세요.";
    }
    if (format == null || format.trim().isEmpty()) {
        errorMessage = "음원 형식을 입력하세요.";
    }
    if (coverImageFile == null || coverImageFile.trim().isEmpty()) {
        errorMessage = "커버 이미지를 업로드하세요.";
    }
    if (musicFile == null || musicFile.trim().isEmpty()) {
        errorMessage = "음악 파일(MP3)을 업로드하세요.";
    }

    if (errorMessage != null) {
%>
        <script>
            alert("<%=errorMessage%>");
            history.back();
        </script>
<%
        return;
    }

    // 형 변환
    int price = Integer.parseInt(unitPrice);

    // DB 저장
    PreparedStatement pstmt = null;
    String sql = "INSERT INTO music (title, artist, release_date, price, description, genre, format, cover_image, music_file) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, artist);
        pstmt.setString(3, releaseDate);
        pstmt.setInt(4, price);
        pstmt.setString(5, description);
        pstmt.setString(6, genre);
        pstmt.setString(7, format);
        pstmt.setString(8, coverImageFile);
        pstmt.setString(9, musicFile);

        pstmt.executeUpdate();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    // 등록 후 페이지 이동
    response.sendRedirect("musicList.jsp");

} catch (Exception e) {
%>
    <script>
        alert("등록 중 오류가 발생했습니다: <%=e.getMessage()%>");
        history.back();
    </script>
<%
}
%>
