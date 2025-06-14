<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    String loginUser = (String) session.getAttribute("sessionId");
    if (loginUser == null || !loginUser.equals("admin")) {
%>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>접근 권한 없음</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container py-5">
            <div class="alert alert-danger text-center" role="alert">
                <h4 class="alert-heading">⚠ 접근 권한이 없습니다</h4>
                <p>이 페이지는 <strong>관리자(admin)</strong>만 접근할 수 있습니다.</p>
                <hr>
                <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary">메인으로 돌아가기</a>
            </div>
        </div>
    </body>
    </html>
<%
        return;
    }
%>

<%
String musicId = request.getParameter("id");
PreparedStatement pstmt = null;
ResultSet rs = null;

// 먼저 music 테이블에 해당 ID가 존재하는지 확인
String sql = "SELECT * FROM music WHERE music_id = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, musicId);
rs = pstmt.executeQuery();

if (rs.next()) {
    // 존재하면 삭제
    sql = "DELETE FROM music WHERE music_id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, musicId);
    pstmt.executeUpdate();
} else {
    out.println("일치하는 음악이 없습니다");
}

if (rs != null) rs.close();
if (pstmt != null) pstmt.close();
if (conn != null) conn.close();

response.sendRedirect("editMusic.jsp?edit=delete");
%>

<head>
    <meta charset="UTF-8">
    <title>음악 삭제 처리</title>
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- 부트스트랩 적용, 별도 메시지 없이 바로 리다이렉트됨 -->
</body>
</html>
