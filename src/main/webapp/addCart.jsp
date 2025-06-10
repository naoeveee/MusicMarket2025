
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Music" %>
<%@ page import="dao.MusicRepository" %>


<%
String id = request.getParameter("id");
if (id == null || id.trim().equals("")) {
    response.sendRedirect("index.jsp");
    return;
}

MusicRepository dao = MusicRepository.getInstance();
Music music = dao.getMusicById(id);
if (music == null) {
    response.sendRedirect("exceptionNoMusicId.jsp");
    return;
}

ArrayList<Music> goodsList = dao.getAllMusics();
Music goods = new Music();
for (int i = 0; i < goodsList.size(); i++) {
    goods = goodsList.get(i);
    if (goods.getMusicId().equals(id)) {
        break;
    }
}

ArrayList<Music> cart = (ArrayList<Music>) session.getAttribute("cart");
if (cart == null) {
    cart = new ArrayList<Music>();
    session.setAttribute("cart", cart);
}

int cnt = 0;
Music goodsQnt = new Music();
for (int i = 0; i < cart.size(); i++) {
    goodsQnt = cart.get(i);
    if (goodsQnt.getMusicId().equals(id)) {
        cnt++;
        int orderQuantity = goodsQnt.getQuantity() + 1;
        goodsQnt.setQuantity(orderQuantity);
    }
}

if (cnt == 0) {
    goods.setQuantity(1);
    cart.add(goods);
}

response.sendRedirect("musicDetail.jsp?id=" + id);
%>
