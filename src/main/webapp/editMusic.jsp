<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>음악 편집</title>
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript">
    function deleteConfirm(musicId) {
        if (confirm("정말로 이 음악을 삭제하시겠습니까?")) {
            location.href = "./deleteMusic.jsp?id=" + musicId;
        }
    }
    </script>
</head>
<%
String edit = request.getParameter("edit");
%>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <header class="bg-dark py-5 mb-4">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-white">
                <h1 class="display-4 fw-bolder">음악 편집</h1>
                <p class="lead fw-normal text-white-50 mb-0">Music Editing</p>
            </div>
        </div>
    </header>
    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-3">
            <div class="row gx-4 gx-lg-5 row-cols-1 row-cols-md-2 row-cols-xl-3 justify-content-center">
            <%
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String sql = "SELECT * FROM music";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            %>
                <div class="col mb-5">
                    <div class="card h-100 shadow-sm">
                        <img class="card-img-top" src="./resources/assets/<%=rs.getString("filename")%>" alt="음악 이미지" style="height: 280px; object-fit: cover;" />
                        <div class="card-body p-4">
                            <div class="text-center">
                                <h5 class="fw-bolder"><%=rs.getString("music_title") %></h5>
                                <p class="mb-1 text-muted"><%=rs.getString("music_singer") %></p>
                                <span class="badge bg-secondary mb-2"><%=rs.getString("genre") %></span>
                                <div class="mb-2"><%=rs.getInt("unit_price") %>원</div>
                                <div class="mb-2">
                                    <%=rs.getString("description") != null && rs.getString("description").length() > 60 ? rs.getString("description").substring(0,60) + "..." : rs.getString("description") %>
                                </div>
                                <div>포맷: <%=rs.getString("format") %></div>
                            </div>
                        </div>
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="d-flex justify-content-center gap-2">
                                <%
                                if ("update".equals(edit)) {
                                %>
                                    <a href="./updateMusic.jsp?id=<%=rs.getString("music_id")%>" class="btn btn-success" role="button">
                                        <i class="bi bi-pencil-square"></i> 수정
                                    </a>
                                <%
                                } else if ("delete".equals(edit)) {
                                %>
                                    <a href="#" onclick="deleteConfirm('<%=rs.getString("music_id")%>')" class="btn btn-danger" role="button">
                                        <i class="bi bi-trash"></i> 삭제
                                    </a>
                                <%
                                }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            <%
            }
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
            %>
            </div>
        </div>
    </section>
    <%@ include file="footer.jsp" %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
