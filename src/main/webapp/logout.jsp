<%@ page contentType="text/html; charset=UTF-8" %>
<%
	session.invalidate();
	response.sendRedirect("index.jsp"); //추후 수정!!!!!
%>