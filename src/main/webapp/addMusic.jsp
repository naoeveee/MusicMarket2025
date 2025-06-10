<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="musicDAO" class="dao.MusicRepository" scope="session" />
<%
    String lang = request.getParameter("lang");
    if (lang != null) {
        session.setAttribute("lang", lang);
    } else if (session.getAttribute("lang") == null) {
        session.setAttribute("lang", "ko");
    }
%>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="utf-8">
    <title><fmt:message key="title"/></title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
    <!-- 메뉴 -->
    <%@ include file="menu.jsp" %>

    <!-- 언어 선택 -->
    <div style="text-align:right; margin:10px 20px 0 0;">
        <a href="?lang=ko">한국어</a> | <a href="?lang=en">English</a>
    </div>

    <!-- 상단 헤더 -->
    <header class="bg-dark py-5">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder"><fmt:message key="title"/></h1>
                <p class="lead fw-normal text-white-50 mb-0"><fmt:message key="subtitle"/></p>
            </div>
        </div>
    </header>

    <!-- 등록 폼 -->
    <section class="py-5">
        <div class="container px-4 px-lg-5">
            <form action="processAddMusic.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="title" class="form-label"><fmt:message key="form.title"/></label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="col-md-6">
                        <label for="artist" class="form-label"><fmt:message key="form.artist"/></label>
                        <input type="text" class="form-control" id="artist" name="artist" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="releaseDate" class="form-label"><fmt:message key="form.releaseDate"/></label>
                        <input type="date" class="form-control" id="releaseDate" name="releaseDate">
                    </div>
                    <div class="col-md-6">
                        <label for="price" class="form-label"><fmt:message key="form.price"/></label>
                        <input type="number" class="form-control" id="price" name="price" min="0" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label"><fmt:message key="form.description"/></label>
                    <textarea class="form-control" id="description" name="description" rows="3" placeholder="<fmt:message key='desc.placeholder'/>" required></textarea>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="genre" class="form-label"><fmt:message key="form.genre"/></label>
                        <input type="text" class="form-control" id="genre" name="genre">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label"><fmt:message key="form.format"/></label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="format" id="formatCD" value="CD" checked>
                            <label class="form-check-label" for="formatCD"><fmt:message key="format.cd"/></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="format" id="formatMP3" value="MP3">
                            <label class="form-check-label" for="formatMP3"><fmt:message key="format.mp3"/></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="format" id="formatStreaming" value="Streaming">
                            <label class="form-check-label" for="formatStreaming"><fmt:message key="format.streaming"/></label>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="coverImage" class="form-label"><fmt:message key="form.coverImage"/></label>
                    <input class="form-control" type="file" id="coverImage" name="coverImage" accept="image/*" required>
                </div>

                <div class="mb-4">
                    <label for="musicFile" class="form-label"><fmt:message key="form.musicFile"/></label>
                    <input class="form-control" type="file" id="musicFile" name="musicFile" accept=".mp3" required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary"><fmt:message key="form.submit"/></button>
                </div>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 유효성 검사 스크립트 (다국어 메시지 적용) -->
    <script>
        const alertDesc = "<fmt:message key='alert.desc'/>";
        const alertCover = "<fmt:message key='alert.cover'/>";
        const alertMp3 = "<fmt:message key='alert.mp3'/>";

        function validateForm() {
            const description = document.getElementById('description').value.trim();
            if (description.length < 10) {
                alert(alertDesc);
                return false;
            }

            const coverImage = document.getElementById('coverImage').value;
            if (!coverImage) {
                alert(alertCover);
                return false;
            }

            const musicFile = document.getElementById('musicFile').value;
            if (!musicFile.endsWith(".mp3")) {
                alert(alertMp3);
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
