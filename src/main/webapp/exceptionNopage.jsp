<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>페이지 오류 | Mello-Catch</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .error-header-card {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .error-alert {
            border-radius: 1.2rem;
            font-size: 1.13rem;
            box-shadow: 0 4px 16px 0 rgba(220,53,69,0.07);
            background: #fff0f3;
            color: #d32f2f;
            border: none;
            padding: 1.5rem 1.2rem;
            margin-bottom: 2rem;
            margin-top: 2.5rem;
        }
        .btn-music-back {
            border-radius: 1.1rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
            color: #fff;
            transition: 0.18s;
            padding: 0.85em 2.3em;
        }
        .btn-music-back:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
            color: #fff;
        }
        /* Footer 여백 */
        .footer-music {
            margin-top: 3.5rem;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border-radius: 2rem 2rem 0 0;
        }
        @media (max-width: 576px) {
            .error-header-card { padding: 2.2rem 0.7rem; }
            .error-alert { font-size: 0.98rem; padding: 1rem 0.7rem; }
            .btn-music-back { font-size: 1rem; padding: 0.7em 1.3em; }
            .footer-music { padding-top: 1.2rem; padding-bottom: 1.2rem; }
        }
    </style>
</head>
<body>
    <%@ include file="menu.jsp" %>
    <header class="error-header-card py-5 mb-4">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <i class="bi bi-exclamation-triangle-fill fs-1 mb-3"></i>
                <h2 class="display-5 fw-bold mb-2">요청하신 페이지를 찾을 수 없습니다.</h2>
                <p class="lead fw-normal text-white-50 mb-0">The page you requested could not be found.</p>
            </div>
        </div>
    </header>
    <div class="container text-center">
        <div class="error-alert d-inline-block">
            <i class="bi bi-link-45deg me-2"></i>
            <strong>에러 URL:</strong>
            <span class="text-break"><%=request.getRequestURL() %></span>
        </div>
        <br>
        <a href="index.jsp" class="btn btn-music-back btn-lg mt-2">
            <i class="bi bi-music-note-list"></i> 음악 목록 &raquo;
        </a>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
