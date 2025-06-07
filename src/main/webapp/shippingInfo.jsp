<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>배송 정보</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
<div class="container py-4">

    <!-- 메뉴 include -->
    <%@ include file="menu.jsp" %>

   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">배송 정보</h1>
        <p class="col-md-8 fs-4">Shipping Info</p>      
      </div>
    </div>
  	
	 <div class="row align-items-md-stretch ">	 	 

	
	<form action="./processShippingInfo.jsp" method="post" >
		<input type="hidden" name="cartId" value="<%=request.getParameter("cartId")%>">
			
			<div class="mb-3 row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input type="text" name="name" class="form-control" >
				</div>
			</div>
			
			<div class="mb-3 row">
				<label class="col-sm-2">배송일</label>
				<div class="col-sm-3">
					<input type="text" name="shippingDate" class="form-control" >(yyyy/mm/dd)
				</div>
			</div>		
			
				<div class="mb-3 row">
				<label class="col-sm-2">국가명</label>
				<div class="col-sm-3">
					<input type="text" name="country" class="form-control" >
				</div>
			</div>
				<div class="mb-3 row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" name="zipCode" class="form-control" >
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-5">
					<input type="text" name="addressName" class="form-control" >
				</div>
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<a href="./cart.jsp?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button"> 이전 </a> 
					<input type="submit" class="btn btn-primary" value="등록" /> 
					<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
				</div>
			</div>

		</form>
	</div>
<!-- 푸터 include -->
    <%@ include file="footer.jsp" %>

</div>

<!-- Bootstrap JS (필수) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>