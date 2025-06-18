<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>음악 등록</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .music-form-card {
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80, 40, 120, 0.10);
            background: #fff;
        }
        .music-form-label {
            font-weight: 600;
            font-size: 1.08rem;
            color: #8f5cf7;
        }
        .input-group-text {
            background: #f3f6fa;
            border: none;
            border-radius: 1rem 0 0 1rem;
            font-size: 1.2rem;
        }
        .form-control, .form-select {
            border-radius: 1rem;
            font-size: 1.1rem;
            min-height: 2.8rem;
        }
        textarea.form-control {
            min-height: 6rem;
        }
        .btn-primary {
            background: linear-gradient(90deg, #8f5cf7 0%, #f59e42 100%);
            border: none;
            border-radius: 1.1rem;
            font-weight: 700;
            font-size: 1.15rem;
            transition: 0.18s;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #f59e42 0%, #8f5cf7 100%);
        }
        .btn-outline-secondary {
            border-radius: 1.1rem;
            font-size: 1.05rem;
        }
        .form-check-input:checked {
            background-color: #8f5cf7;
            border-color: #8f5cf7;
        }
        .form-check-label {
            font-size: 1.05rem;
            margin-left: 0.5rem;
        }
        .language-switch a {
            color: #8f5cf7;
            text-decoration: underline;
            margin: 0 0.7rem;
            font-size: 1.1rem;
        }
        .language-switch a:hover {
            color: #f59e42;
        }
        @media (max-width: 991px) {
            .music-form-card { padding: 2rem 1rem; }
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/validation.js"></script>
</head>
<body>
<fmt:setLocale value="${param.language != null ? param.language : 'ko'}" />
<fmt:bundle basename="bundle.message">
<%@ include file="menu.jsp" %>
<header class="py-5 mb-4" style="background: linear-gradient(90deg,#ff416c,#c1b6f7); border-radius:2rem;">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder"><i class="bi bi-music-note-beamed me-2"></i><fmt:message key="musicAddTitle" /></h1>
            <p class="lead fw-normal text-white-50 mb-0"><fmt:message key="musicAddSubtitle" /></p>
        </div>
    </div>
</header>
<section class="py-5">
    <div class="container px-4 px-lg-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="music-form-card p-5">
                    <!-- enctype="multipart/form-data" 반드시 유지 -->
                    <form name="newMusic" action="processAddMusic.jsp" method="post" enctype="multipart/form-data">
                        <!-- 기존 입력란들 ... -->
                        <div class="mb-4">
                            <label for="musicId" class="form-label music-form-label"><i class="bi bi-upc-scan me-1"></i><fmt:message key="musicId" /></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-hash"></i></span>
                                <input type="text" class="form-control" id="musicId" name="musicId" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="musicTitle" class="form-label music-form-label"><i class="bi bi-music-note me-1"></i><fmt:message key="musicTitle" /></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-music-note"></i></span>
                                <input type="text" class="form-control" id="musicTitle" name="musicTitle" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="musicSinger" class="form-label music-form-label"><i class="bi bi-person-fill me-1"></i><fmt:message key="musicSinger" /></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="musicSinger" name="musicSinger" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="unitPrice" class="form-label music-form-label"><i class="bi bi-cash-coin me-1"></i><fmt:message key="unitPrice" /></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-cash-coin"></i></span>
                                <input type="number" class="form-control" id="unitPrice" name="unitPrice" min="0" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="releaseDate" class="form-label music-form-label"><i class="bi bi-calendar-event me-1"></i><fmt:message key="releaseDate" /></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-calendar-event"></i></span>
                                <input type="date" class="form-control" id="releaseDate" name="releaseDate">
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="genre" class="form-label music-form-label"><i class="bi bi-music-note-beamed me-1"></i><fmt:message key="genre" /></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-tags"></i></span>
                                <input type="text" class="form-control" id="genre" name="genre">
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="format" class="form-label music-form-label"><i class="bi bi-disc me-1"></i><fmt:message key="format" /></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-disc"></i></span>
                                <input type="text" class="form-control" id="format" name="format" placeholder="예: MP3, CD, Streaming">
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="description" class="form-label music-form-label"><i class="bi bi-card-text me-1"></i><fmt:message key="description" /></label>
                            <textarea class="form-control" id="description" name="description" rows="3" placeholder="<fmt:message key='descriptionPlaceholder'/>"></textarea>
                        </div>
                        <div class="mb-4 form-check">
                            <input type="checkbox" class="form-check-input" id="discountCheck" name="discountCheck" value="on">
                            <label class="form-check-label" for="discountCheck"><i class="bi bi-percent me-1"></i><fmt:message key="discountCheck" /></label>
                        </div>
                        <div class="mb-4">
                            <label for="musicImage" class="form-label music-form-label"><i class="bi bi-image me-1"></i><fmt:message key="musicImage" /></label>
                            <input class="form-control" type="file" id="musicImage" name="musicImage" accept="image/*">
                        </div>
                        <!-- [추가] mp3 파일 업로드 필드 -->
                        <div class="mb-4">
                            <label for="musicAudio" class="form-label music-form-label">
                                <i class="bi bi-music-note-beamed me-1"></i>음원 파일 업로드 (MP3)
                            </label>
                            <input class="form-control" type="file" id="musicAudio" name="musicAudio" accept=".mp3,audio/mpeg" required>
                        </div>
                        <!-- // mp3 업로드 필드 끝 -->
                        <div class="d-grid gap-3">
                            <button type="button" class="btn btn-primary btn-lg" onclick="CheckAddMusic();"><i class="bi bi-upload me-1"></i><fmt:message key="submitButton" /></button>
                            <button type="reset" class="btn btn-outline-secondary btn-lg"><i class="bi bi-x-circle me-1"></i><fmt:message key="resetButton" /></button>
                        </div>
                    </form>
                </div>
                <div class="text-end mt-4 language-switch">
                    <a href="?language=ko">Korean</a> | <a href="?language=en">English</a>
                </div>
            </div>
        </div>
    </div>
</section>
<%@ include file="footer.jsp" %>
</fmt:bundle>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
