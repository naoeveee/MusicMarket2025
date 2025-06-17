<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String sessionId = (String) session.getAttribute("sessionId");
%>
<style>
/* 전체 메뉴 폰트 크기 및 패딩 줄이기 */
.navbar-nav .nav-link,
.navbar-nav .dropdown-item {
    font-size: 14px !important;
    padding-left: 10px !important;
    padding-right: 10px !important;
}
.navbar-brand {
    font-size: 1.5rem !important;
}
</style>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm py-2" style="border-bottom: 2px solid #f3f6fa;">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand fw-bold d-flex align-items-center text-gradient" href="${pageContext.request.contextPath}/index.jsp" style="background: linear-gradient(90deg,#8f5cf7,#f59e42); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
            <i class="bi bi-music-note-beamed me-2"></i>멜로캐치
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold" aria-current="page" href="${pageContext.request.contextPath}/index.jsp">
                        <i class="bi bi-house-door-fill me-1"></i>홈
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-semibold" id="navbarDropdownShopping" href="#" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-bag-fill me-1"></i>쇼핑</a>
                    <ul class="dropdown-menu rounded-3 shadow-sm">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/index.jsp">전체 음악</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recommend.jsp">추천 음악</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/new.jsp">최신 음악</a></li>
                    </ul>
                </li>
                <!-- 음악 관리 드롭다운 메뉴 -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-semibold" id="navbarDropdownManage" href="#" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-gear-fill me-1"></i>음악 관리</a>
                    <ul class="dropdown-menu rounded-3 shadow-sm">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/addMusic.jsp">음악 업로드</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editMusic.jsp?edit=update">음악 수정</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editMusic.jsp?edit=delete">음악 삭제</a></li>
                    </ul>
                </li>
                <!-- 로그인/회원 메뉴 -->
                <c:choose>
                    <c:when test="${empty sessionId}">
                        <li class="nav-item"><a class="nav-link fw-semibold" href="<c:url value='/member/loginMember.jsp'/>"><i class="bi bi-box-arrow-in-right me-1"></i>로그인</a></li>
                        <li class="nav-item"><a class="nav-link fw-semibold" href='<c:url value="/member/addMember.jsp"/>'><i class="bi bi-person-plus me-1"></i>회원 가입</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item d-flex align-items-center px-2 text-primary fw-bold" style="font-size:13px;">
                            <i class="bi bi-person-circle me-1"></i>[<%=sessionId%>님]
                        </li>
                        <!-- 플레이리스트 메뉴: 로그아웃 왼쪽에 위치 -->
                        <li class="nav-item">
                            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/playlist.jsp">
                                <i class="bi bi-music-player me-1"></i>플레이리스트
                            </a>
                        </li>
                        <li class="nav-item"><a class="nav-link fw-semibold" href="<c:url value='/member/logoutMember.jsp'/>"><i class="bi bi-box-arrow-right me-1"></i>로그아웃</a></li>
                        <li class="nav-item"><a class="nav-link fw-semibold" href="<c:url value='/member/updateMember.jsp'/>"><i class="bi bi-pencil-square me-1"></i>회원 수정</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <!-- 게시판 + 장바구니 버튼 함께 배치 -->
            <div class="d-flex align-items-center gap-2">
                <!-- 게시판 버튼 -->
                <form action="${pageContext.request.contextPath}/BoardListAction.do" method="get">
                    <input type="hidden" name="pageNum" value="1" />
                    <button class="btn btn-outline-primary rounded-pill px-3 fw-semibold" type="submit" style="border-width:2px; font-size:13px;">
                        <i class="bi bi-chat-dots me-1"></i>게시판
                    </button>
                </form>
                <!-- 장바구니 버튼 -->
                <form action="${pageContext.request.contextPath}/cart.jsp" method="get">
                    <button class="btn btn-gradient rounded-pill px-3 fw-semibold position-relative" type="submit"
                        style="background: linear-gradient(90deg,#8f5cf7,#f59e42); color:#fff; border:none; font-size:13px;">
                        <i class="bi bi-cart-fill me-1"></i>장바구니
                        <span class="badge bg-danger text-white ms-1 rounded-pill position-absolute top-0 start-100 translate-middle"
                              style="font-size:0.85em;">
                            <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0 %>
                        </span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</nav>
