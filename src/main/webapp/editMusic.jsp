<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

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
    <title>음악 편집</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .music-edit-card {
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            background: #fff;
            transition: transform 0.18s;
        }
        .music-edit-card:hover {
            transform: translateY(-6px) scale(1.025);
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .music-edit-card .card-img-top {
            border-top-left-radius: 2rem;
            border-top-right-radius: 2rem;
            height: 250px;
            object-fit: cover;
            background: #f8f9fa;
        }
        .music-edit-card .badge {
            font-size: 1rem;
        }
        .music-edit-card .btn-success {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
            font-weight: 600;
            border-radius: 1.1rem;
        }
        .music-edit-card .btn-success:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
        }
        .music-edit-card .btn-danger {
            background: linear-gradient(90deg,#ff416c,#f59e42);
            border: none;
            font-weight: 600;
            border-radius: 1.1rem;
        }
        .music-edit-card .btn-danger:hover {
            background: linear-gradient(90deg,#f59e42,#ff416c);
        }
        .music-edit-card .card-footer {
            background: #fff;
            border-bottom-left-radius: 2rem;
            border-bottom-right-radius: 2rem;
        }
        @media (max-width: 991px) {
            .music-edit-card .card-img-top { height: 180px; }
        }
    </style>
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
    <div class="edit-header py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2"><i class="bi bi-pencil-square me-2"></i>음악 편집</h1>
            <p class="fs-4 mb-0 text-white-50">Music Editing</p>
        </div>
    </div>
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
                    <div class="card h-100 music-edit-card">
                        <img class="card-img-top" src="./resources/assets/<%=rs.getString("filename")%>" alt="음악 이미지" />
                        <div class="card-body p-4 d-flex flex-column">
                            <div class="text-center mb-2">
                                <h5 class="fw-bold mb-1 text-truncate" title="<%=rs.getString("music_title")%>"><%=rs.getString("music_title") %></h5>
                                <p class="mb-1 text-muted small text-truncate" title="<%=rs.getString("music_singer")%>"><i class="bi bi-person-fill me-1"></i><%=rs.getString("music_singer") %></p>
                                <span class="badge bg-gradient bg-primary-subtle text-primary mb-2 px-3 py-1"><i class="bi bi-music-note-beamed me-1"></i><%=rs.getString("genre") %></span>
                                <div class="mb-2 text-danger fw-bold"><i class="bi bi-cash-coin me-1"></i><%=rs.getInt("unit_price") %>원</div>
                                <div class="mb-2 text-secondary small">
                                    <i class="bi bi-card-text me-1"></i>
                                    <%=rs.getString("description") != null && rs.getString("description").length() > 60 ? rs.getString("description").substring(0,60) + "..." : rs.getString("description") %>
                                </div>
                                <div class="mb-2"><span class="badge bg-light text-dark"><i class="bi bi-disc me-1"></i>포맷: <%=rs.getString("format") %></span></div>
                            </div>
                            <div class="d-flex justify-content-center gap-2 mt-auto">
                                <%
                                if ("update".equals(edit)) {
                                %>
                                    <a href="./updateMusic.jsp?id=<%=rs.getString("music_id")%>" class="btn btn-success px-4" role="button">
                                        <i class="bi bi-pencil-square"></i> 수정
                                    </a>
                                <%
                                } else if ("delete".equals(edit)) {
                                %>
                                    <a href="#" onclick="deleteConfirm('<%=rs.getString("music_id")%>')" class="btn btn-danger px-4" role="button">
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
