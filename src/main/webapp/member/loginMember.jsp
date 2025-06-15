<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 | Mello-Catch</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .login-header-card {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .login-form-card {
            max-width: 420px;
            margin: 0 auto 2.5rem auto;
            background: #fff;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            padding: 2.5rem 2.2rem 2rem 2.2rem;
        }
        .login-form-card .form-label {
            font-weight: 600;
            color: #8f5cf7;
        }
        .login-form-card .form-control {
            border-radius: 1rem;
            font-size: 1.08rem;
            min-height: 2.7rem;
        }
        .login-form-card .btn-primary {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
            border-radius: 1.1rem;
            font-weight: 700;
            font-size: 1.15rem;
            transition: 0.18s;
        }
        .login-form-card .btn-primary:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
        }
        .login-form-card .form-floating > label {
            color: #adb5bd;
        }
        .login-form-card .form-signin-heading {
            font-size: 1.3rem;
            font-weight: 700;
            color: #8f5cf7;
            margin-bottom: 1.2rem;
        }
        /* Footer 여백 추가 */
        .footer-music {
            margin-top: 3.5rem;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border-radius: 2rem 2rem 0 0;
        }
        @media (max-width: 576px) {
            .login-form-card { padding: 1.2rem 0.6rem; }
            .footer-music { padding-top: 1.2rem; padding-bottom: 1.2rem; }
        }
    </style>
</head>
<body>
<div class="container py-4">
    <jsp:include page="../menu.jsp" />

    <!-- 로그인 헤더 -->
    <div class="login-header-card py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2"><i class="bi bi-person-circle me-2"></i>회원 로그인</h1>
            <p class="fs-4 mb-0 text-white-50">Membership Login</p>
        </div>
    </div>

    <!-- 로그인 폼 카드 -->
    <div class="login-form-card">
        <h3 class="form-signin-heading text-center mb-4">Please sign in</h3>
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="alert alert-danger text-center">
                <i class="bi bi-exclamation-triangle-fill me-1"></i>
                아이디와 비밀번호를 확인해 주세요
            </div>
        <%
            }
        %>
        <form class="form-signin" action="processLoginMember.jsp" method="post">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" name="id" id="floatingInput" placeholder="ID" required autofocus>
                <label for="floatingInput"><i class="bi bi-person-fill me-1"></i>ID</label>
            </div>
            <div class="form-floating mb-4">
                <input type="password" class="form-control" name="password" id="floatingPassword" placeholder="Password" required>
                <label for="floatingPassword"><i class="bi bi-lock-fill me-1"></i>Password</label>
            </div>
            <button class="btn btn-primary btn-lg w-100" type="submit">
                <i class="bi bi-box-arrow-in-right me-1"></i>로그인
            </button>
        </form>
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
                
            </div>
        </div>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
