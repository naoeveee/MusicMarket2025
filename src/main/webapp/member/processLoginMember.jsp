<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");

    boolean loginSuccess = false;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MusicMarketDB", "root", "1234");

        String sql = "SELECT * FROM member WHERE id=? AND password=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, password);

        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            loginSuccess = true;
            session.setAttribute("sessionId", id);
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (loginSuccess) {
        String originalUrl = (String) session.getAttribute("originalUrl");
        if (originalUrl != null) {
            session.removeAttribute("originalUrl"); // 한번 사용하고 제거
            response.sendRedirect(originalUrl);
        } else {
            response.sendRedirect("resultMember.jsp?msg=2"); // 기본 페이지
        }
    } else {
        response.sendRedirect("loginMember.jsp?error=1");
    }

%>
