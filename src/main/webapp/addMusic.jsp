<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>음악 등록</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/validation.js"></script>
</head>
<body>
<fmt:setLocale value="${param.language != null ? param.language : 'ko'}" />
<fmt:bundle basename="bundle.message">
<%@ include file="menu.jsp" %>
<header class="bg-dark py-5 mb-4">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder"><fmt:message key="musicAddTitle" /></h1>
            <p class="lead fw-normal text-white-50 mb-0"><fmt:message key="musicAddSubtitle" /></p>
        </div>
    </div>
</header>
<section class="py-5">
    <div class="container px-4 px-lg-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <form name="newMusic" action="processAddMusic.jsp" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="musicId" class="form-label"><fmt:message key="musicId" /></label>
                                <input type="text" class="form-control" id="musicId" name="musicId" required>
                            </div>
                            <div class="mb-3">
                                <label for="musicTitle" class="form-label"><fmt:message key="musicTitle" /></label>
                                <input type="text" class="form-control" id="musicTitle" name="musicTitle" required>
                            </div>
                            <div class="mb-3">
                                <label for="musicSinger" class="form-label"><fmt:message key="musicSinger" /></label>
                                <input type="text" class="form-control" id="musicSinger" name="musicSinger" required>
                            </div>
                            <div class="mb-3">
                                <label for="unitPrice" class="form-label"><fmt:message key="unitPrice" /></label>
                                <input type="number" class="form-control" id="unitPrice" name="unitPrice" min="0" required>
                            </div>
                            <div class="mb-3">
                                <label for="releaseDate" class="form-label"><fmt:message key="releaseDate" /></label>
                                <input type="date" class="form-control" id="releaseDate" name="releaseDate">
                            </div>
                            <div class="mb-3">
                                <label for="genre" class="form-label"><fmt:message key="genre" /></label>
                                <input type="text" class="form-control" id="genre" name="genre">
                            </div>
                            <div class="mb-3">
                                <label for="format" class="form-label"><fmt:message key="format" /></label>
                                <input type="text" class="form-control" id="format" name="format" placeholder="예: MP3, CD, Streaming">
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label"><fmt:message key="description" /></label>
                                <textarea class="form-control" id="description" name="description" rows="3" placeholder="<fmt:message key='descriptionPlaceholder'/>"></textarea>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="discountCheck" name="discountCheck" value="on">
                                <label class="form-check-label" for="discountCheck"><fmt:message key="discountCheck" /></label>
                            </div>
                            <div class="mb-3">
                                <label for="musicImage" class="form-label"><fmt:message key="musicImage" /></label>
                                <input class="form-control" type="file" id="musicImage" name="musicImage" accept="image/*">
                            </div>
                            <div class="d-grid gap-2">
                                <button type="button" class="btn btn-primary btn-lg" onclick="CheckAddMusic();"><fmt:message key="submitButton" /></button>
                                <button type="reset" class="btn btn-outline-secondary"><fmt:message key="resetButton" /></button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="text-end mt-3">
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
