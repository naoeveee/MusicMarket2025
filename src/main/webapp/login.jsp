<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
<div class="container py-4">

    <!-- 메뉴 include -->
    <%@ include file="menu.jsp" %>

    <!-- 로그인 헤더 -->
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">로그인</h1>
            <p class="col-md-8 fs-4">Login</p>
        </div>
    </div>

    <!-- 로그인 폼 -->
    <div class="row align-items-md-stretch text-center">
        <div class="row justify-content-center align-items-center">
            <div class="h-100 p-5 col-md-6">
                <h3>Please sign in</h3>

                <%-- 로그인 오류 표시 --%>
                <%
                    String error = request.getParameter("error");
                    if (error != null) {
                %>
                    <div class="alert alert-danger">
                        아이디와 비밀번호를 확인해 주세요.
                    </div>
                <%
                    }
                %>

                <form class="form-signin" action="j_security_check" method="post">
                    <div class="form-floating mb-3 row">
                        <input type="text" class="form-control" id="floatingInput" name="j_username" required autofocus>
                        <label for="floatingInput">ID</label>
                    </div>
                    <div class="form-floating mb-3 row">
                        <input type="password" class="form-control" id="floatingPassword" name="j_password" required>
                        <label for="floatingPassword">Password</label>
                    </div>
                    <button class="btn btn-lg btn-success w-100" type="submit">로그인</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 푸터 include -->
    <%@ include file="footer.jsp" %>

</div>

<!-- Bootstrap JS (필수) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>