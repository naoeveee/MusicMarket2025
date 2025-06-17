<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보 | Mello-Catch</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .member-header-card {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .member-msg-card {
            max-width: 520px;
            margin: 0 auto 2.5rem auto;
            background: #fff;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            padding: 2.5rem 2.2rem 2rem 2.2rem;
        }
        .member-msg-card h2 {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 0;
        }
        .footer-music {
            margin-top: 3.5rem;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border-radius: 2rem 2rem 0 0;
        }
        @media (max-width: 576px) {
            .member-msg-card { padding: 1.2rem 0.6rem; }
            .footer-music { padding-top: 1.2rem; padding-bottom: 1.2rem; }
        }
    </style>
</head>
<body>
<div class="container py-4">
    <jsp:include page="/menu.jsp" />

    <!-- 회원 정보/가입 헤더 -->
    <div class="member-header-card py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <%
                String msg = request.getParameter("msg");
                if ("0".equals(msg) || "2".equals(msg)) {
            %>
                <h1 class="display-5 fw-bold mb-2"><i class="bi bi-person-circle me-2"></i>회원 정보</h1>
                <p class="fs-4 mb-0 text-white-50">Membership Info</p>
            <%
                } else if ("1".equals(msg)) {
            %>
                <h1 class="display-5 fw-bold mb-2"><i class="bi bi-person-plus-fill me-2"></i>회원 가입</h1>
                <p class="fs-4 mb-0 text-white-50">Membership Joining</p>
            <%
                }
            %>
        </div>
    </div>

    <!-- 메시지 카드 -->
    <div class="member-msg-card text-center mb-4">
        <%
            if (msg != null) {
                if ("0".equals(msg)) {
        %>
            <h2 class="alert alert-success d-inline-block px-4">
                <i class="bi bi-check-circle-fill me-1"></i>회원정보가 수정되었습니다.
            </h2>
        <%
                } else if ("1".equals(msg)) {
        %>
            <h2 class="alert alert-success d-inline-block px-4">
                <i class="bi bi-emoji-smile me-1"></i>회원가입을 축하드립니다.
            </h2>
        <%
                } else if ("2".equals(msg)) {
                    String loginId = (String) session.getAttribute("sessionId");
        %>
            <h2 class="alert alert-success d-inline-block px-4">
                <i class="bi bi-person-heart me-1"></i><%=loginId %>님 환영합니다
            </h2>
        <%
                }
            } else {
        %>
            <h2 class="alert alert-danger d-inline-block px-4">
                <i class="bi bi-x-circle-fill me-1"></i>회원정보가 삭제되었습니다.
            </h2>
        <%
            }
        %>
    </div>

   
    <footer class="footer-music mt-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-4 text-center text-md-start mb-3 mb-md-0">
                    <span class="fs-4 fw-bold text-white">
                        <i class="bi bi-music-note-beamed me-2"></i>Mello-Catch
                    </span>
                </div>
                <div class="col-md-4 text-center mb-3 mb-md-0">
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-twitter"></i></a>
                </div>
                <div class="col-md-4 text-center text-md-end">
                    <span class="text-white-50 small">
                        Copyright &copy; Mello-Catch 2025<br>
                        All music content &copy; respective owners.
                    </span>
                </div>
            </div>
        </div>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
