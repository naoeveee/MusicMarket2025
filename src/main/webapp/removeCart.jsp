
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>

<%
String id = request.getParameter("id");
if (id == null || id.trim().equals("")) {
    response.sendRedirect("cart.jsp");
    
    
    return;
}

ArrayList<Music> cart = (ArrayList<Music>) session.getAttribute("cart");
if (cart != null) {
    for (int i = 0; i < cart.size(); i++) {
        Music music = cart.get(i);
        if (music.getMusicId().equals(id)) {
            cart.remove(i);
            break;
        }
    }
}

response.sendRedirect("cart.jsp");
%>
