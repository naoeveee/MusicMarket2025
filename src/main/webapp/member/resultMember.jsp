<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<title>회원 정보</title>
</head>
<body>

<div class="container py-4">
   <jsp:include page="/menu.jsp" />

 <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
      <%
			String msg = request.getParameter("msg");
      		if (msg.equals("0")||msg.equals("2")){
      %>
        <h1 class="display-5 fw-bold">회원 정보</h1>
        <p class="col-md-8 fs-4">Membership Info</p>    
        <% }
      		else if (msg.equals("1")){
        %>  
         <h1 class="display-5 fw-bold">회원 가입</h1>
        <p class="col-md-8 fs-4">Membership Joining</p>    
         <% }%>
      </div>
    </div>
	

	 <div class="row align-items-md-stretch   text-center">
		<%
			

			if (msg != null) {
				if (msg.equals("0"))
					out.println(" <h2 class='alert alert-danger'>회원정보가 수정되었습니다.</h2>");
				else if (msg.equals("1"))
					out.println(" <h2 class='alert alert-danger'>회원가입을 축하드립니다.</h2>");
				else if (msg.equals("2")) {
					String loginId = (String) session.getAttribute("sessionId");
					out.println(" <h2 class='alert alert-danger'>" + loginId + "님 환영합니다</h2>");
				}				
			} else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
	</div>	
</div>	
</body>
</html>