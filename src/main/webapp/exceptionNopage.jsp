<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>페이지 오류</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body>

    <!-- 메뉴 include -->
    <%@ include file="menu.jsp" %>
    
    <div class="jumbotron">
		<div class="container">
			<h2 class="alert alert-danger">요청하신 페이지를 찾을 수 없습니다.</h2>
		</div>
	</div>
	<div class="container">
	<p><%=request.getRequestURL() %></p>
	<p> <a href="books.jsp" class="btn btn-secondary"> 음악 목록&raquo;</a>
	</div>
</body>
</html>