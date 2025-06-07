<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 음악 장바구니(cart)만 세션에서 삭제
    session.removeAttribute("cart");
    response.sendRedirect("cart.jsp");
%>
