<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>음악 수정</title>
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
<%@ include file="menu.jsp" %>
<div class="p-5 mb-4 bg-body-tertiary rounded-3">
    <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">음악 수정</h1>
        <p class="col-md-8 fs-4">Music Updating</p>
    </div>
</div>
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
<div class="row align-items-md-stretch">
    <div class="col-md-5">
        <img src="./resources/assets/<%=rs.getString("filename")%>" alt="음악 이미지" style="width: 100%; max-height:350px; object-fit:cover;" />
    </div>
    <div class="col-md-7">
        <form name="updateMusic" action="./processUpdateMusic.jsp" method="post" enctype="multipart/form-data">
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">ID</label>
                <div class="col-sm-5">
                    <input type="text" name="musicId" id="musicId" class="form-control" value='<%=rs.getString("music_id")%>' readonly>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">제목</label>
                <div class="col-sm-5">
                    <input type="text" name="musicTitle" id="musicTitle" class="form-control" value='<%=rs.getString("music_title")%>'>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">가수</label>
                <div class="col-sm-5">
                    <input type="text" name="musicSinger" id="musicSinger" class="form-control" value='<%=rs.getString("music_singer")%>'>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">가격</label>
                <div class="col-sm-5">
                    <input type="number" name="unitPrice" id="unitPrice" class="form-control" value='<%=rs.getString("unit_price")%>' min="0">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">발매일</label>
                <div class="col-sm-5">
                    <input type="date" name="releaseDate" id="releaseDate" class="form-control" value='<%=rs.getString("release_date")%>'>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">설명</label>
                <div class="col-sm-8">
                    <textarea name="description" id="description" cols="50" rows="2" class="form-control" placeholder="5자 이상 적어주세요"><%=rs.getString("description") %></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">장르</label>
                <div class="col-sm-5">
                    <input type="text" name="genre" id="genre" class="form-control" value='<%=rs.getString("genre")%>'>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">포맷</label>
                <div class="col-sm-5">
                    <input type="text" name="format" id="format" class="form-control" value='<%=rs.getString("format")%>'>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">할인</label>
                <div class="col-sm-5 d-flex align-items-center">
                    <input type="checkbox" name="discountCheck" id="discountCheck" value="on" <%=rs.getBoolean("discount_check") ? "checked" : ""%> >
                    <label for="discountCheck" class="ms-2">할인 적용</label>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label">이미지</label>
                <div class="col-sm-8">
                    <input type="file" name="musicImage" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="수정">
                </div>
            </div>
        </form>
    </div>
</div>
<%
}
if (rs != null) rs.close();
if (pstmt != null) pstmt.close();
if (conn != null) conn.close();
%>
<jsp:include page="footer.jsp" />
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
