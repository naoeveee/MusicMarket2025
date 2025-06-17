<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>음악 수정 | Mello-Catch</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .edit-header {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            margin-bottom: 2.5rem;
        }
        .edit-header .display-5 {
            color: #fff;
            text-shadow: 0 2px 12px rgba(80,40,120,0.15);
        }
        .edit-card {
            background: #fff;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            padding: 2.2rem 2.2rem 1.8rem 2.2rem;
            max-width: 950px;
            margin: 0 auto 2.5rem auto;
        }
        .edit-img-preview {
            width: 100%;
            max-height: 350px;
            object-fit: cover;
            border-radius: 1.2rem;
            box-shadow: 0 4px 16px 0 rgba(80,40,120,0.08);
            background: #f8f9fa;
            margin-bottom: 1.2rem;
        }
        .form-label {
            font-weight: 600;
            color: #8f5cf7;
        }
        .form-control, .form-select {
            border-radius: 1.1rem;
            font-size: 1.07rem;
            min-height: 2.3rem;
        }
        .form-check-input {
            border-radius: 0.7em;
        }
        .btn-primary {
            background: linear-gradient(90deg, #8f5cf7 0%, #f59e42 100%);
            border: none;
            font-weight: 600;
            border-radius: 1.2rem;
            padding: 0.55em 2.2em;
            font-size: 1.1rem;
            transition: 0.18s;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #f59e42 0%, #8f5cf7 100%);
        }
        @media (max-width: 991px) {
            .edit-card {
                padding: 1.2rem 0.7rem 1rem 0.7rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="menu.jsp" %>
<header class="edit-header py-5 mb-4">
    <div class="container px-4 px-lg-5 my-3">
        <div class="text-center text-white">
            <h1 class="display-5 fw-bolder mb-2"><i class="bi bi-pencil-square me-2"></i>음악 정보 수정</h1>
            <p class="lead fw-normal text-white-50 mb-0">Edit your music details with ease</p>
        </div>
    </div>
</header>
<%
String musicId = request.getParameter("id");
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = "SELECT * FROM music WHERE music_id = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, musicId);
rs = pstmt.executeQuery();
if (rs.next()) {
%>
<div class="edit-card">
    <div class="row g-4 align-items-center">
        <div class="col-md-5">
            <img src="./resources/assets/<%=rs.getString("filename")%>" alt="음악 이미지" class="edit-img-preview" />
        </div>
        <div class="col-md-7">
            <form name="updateMusic" action="./processUpdateMusic.jsp" method="post" enctype="multipart/form-data" autocomplete="off">
                <div class="mb-3">
                    <label class="form-label">ID</label>
                    <input type="text" name="musicId" id="musicId" class="form-control" value='<%=rs.getString("music_id")%>' readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label">제목</label>
                    <input type="text" name="musicTitle" id="musicTitle" class="form-control" value='<%=rs.getString("music_title")%>' required>
                </div>
                <div class="mb-3">
                    <label class="form-label">가수</label>
                    <input type="text" name="musicSinger" id="musicSinger" class="form-control" value='<%=rs.getString("music_singer")%>' required>
                </div>
                <div class="mb-3">
                    <label class="form-label">가격</label>
                    <input type="number" name="unitPrice" id="unitPrice" class="form-control" value='<%=rs.getString("unit_price")%>' min="0" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">발매일</label>
                    <input type="date" name="releaseDate" id="releaseDate" class="form-control" value='<%=rs.getString("release_date")%>' required>
                </div>
                <div class="mb-3">
                    <label class="form-label">설명</label>
                    <textarea name="description" id="description" cols="50" rows="2" class="form-control" placeholder="5자 이상 적어주세요" required><%=rs.getString("description") %></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">장르</label>
                    <input type="text" name="genre" id="genre" class="form-control" value='<%=rs.getString("genre")%>'>
                </div>
                <div class="mb-3">
                    <label class="form-label">포맷</label>
                    <input type="text" name="format" id="format" class="form-control" value='<%=rs.getString("format")%>'>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" name="discountCheck" id="discountCheck" class="form-check-input" value="on" <%=rs.getBoolean("discount_check") ? "checked" : ""%> >
                    <label for="discountCheck" class="form-check-label">할인 적용</label>
                </div>
                <div class="mb-3">
                    <label class="form-label">이미지 변경</label>
                    <input type="file" name="musicImage" class="form-control">
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg"><i class="bi bi-check-circle me-2"></i>수정 완료</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%
}
if (rs != null) rs.close();
if (pstmt != null) pstmt.close();
if (conn != null) conn.close();
%>
<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
