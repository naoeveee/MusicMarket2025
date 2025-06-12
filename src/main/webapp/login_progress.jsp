<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // 폼에서 전달된 아이디와 비밀번호 받아오기
    String username = request.getParameter("username");
    String password = request.getParameter("password");

   
    // 여기서는 간단히 "admin"/"1234"로만 로그인 성공 처리
    boolean loginSuccess = false;

    if ("admin".equals(username) && "1234".equals(password)) {
        loginSuccess = true;
    }

    if (loginSuccess) {
        // 로그인 성공 시 세션에 사용자 정보 저장
        session.setAttribute("loginUser", username);

        // 원래 가려던 페이지가 있으면 그쪽으로, 없으면 index.jsp로 이동
        String originalUrl = (String) session.getAttribute("originalUrl");
        if (originalUrl != null) {
            session.removeAttribute("originalUrl");
            response.sendRedirect(originalUrl);
        } else {
            response.sendRedirect("index.jsp");
        }
    } else {
        // 로그인 실패 시 로그인 실패 페이지로 이동
        response.sendRedirect("login_failed.jsp");
    }
%>
