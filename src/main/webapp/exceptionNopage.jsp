<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>페이지 오류</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
    <%@ include file="menu.jsp" %>
    <header class="bg-danger py-5 mb-4">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h2 class="display-5 fw-bold">요청하신 페이지를 찾을 수 없습니다.</h2>
                <p class="lead fw-normal text-white-50 mb-0">The page you requested could not be found.</p>
            </div>
        </div>
    </header>
    <div class="container text-center">
        <div class="alert alert-danger mt-4">
            <strong>에러 URL:</strong> <span class="text-break"><%=request.getRequestURL() %></span>
        </div>
        <a href="index.jsp" class="btn btn-secondary btn-lg mt-3">
            <i class="bi bi-music-note-list"></i> 음악 목록 &raquo;
        </a>
    </div>
    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
