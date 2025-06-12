<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">멜로캐치</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/index.jsp">홈</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">소개</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownShopping" href="#" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">쇼핑</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownShopping">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/index.jsp">전체 음악</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/popular.jsp">인기 음악</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/new.jsp">최신 음악</a></li>
                    </ul>
                </li>
                <!-- 음악 관리 드롭다운 메뉴 -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownManage" href="#" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">음악 관리</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownManage">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/addMusic.jsp">음악 업로드</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editMusic.jsp?edit=update">음악 수정</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editMusic.jsp?edit=delete">음악 삭제</a></li>
                    </ul>
                </li>
            </ul>

            <form class="d-flex" action="${pageContext.request.contextPath}/cart.jsp" method="get">
                <button class="btn btn-outline-dark" type="submit">
                    <i class="bi-cart-fill me-1"></i>
                    장바구니
                    <span class="badge bg-dark text-white ms-1 rounded-pill">
                        <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0 %>
                    </span>
                </button>
            </form>
        </div>
    </div>
</nav>
