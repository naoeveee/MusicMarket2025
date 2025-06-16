<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    String sessionId = (String) session.getAttribute("sessionId");
%>
<sql:setDataSource var="dataSource"
    url="jdbc:mysql://localhost:3306/MusicMarketDB"
    driver="com.mysql.jdbc.Driver"
    user="root"
    password="1234" />

<sql:query dataSource="${dataSource}" var="resultSet">
    SELECT * FROM MEMBER WHERE ID=?
    <sql:param value="<%=sessionId%>" />
</sql:query>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 수정</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
       
        body { background-color: #f8f9fa; }
        .card { box-shadow: 0 2px 10px rgba(0,0,0,0.04); }
        .form-label { font-weight: 500; }
        .required { color: #dc3545; }
        .bg-gradient-custom {
            background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
        }
    </style>
</head>
<body onload="init()">
    <jsp:include page="/menu.jsp" />

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card bg-gradient-custom mb-4">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-3 fw-bold">회원 정보 수정</h2>
                        <p class="text-center text-muted mb-4">Membership Update</p>

                        <c:forEach var="row" items="${resultSet.rows}">
                            <c:set var="mail" value="${row.mail}" />
                            <c:set var="mail1" value="${mail.split('@')[0]}" />
                            <c:set var="mail2" value="${mail.split('@')[1]}" />

                            <c:set var="birth" value="${row.birth}" />
                            <c:set var="year" value="${birth.split('/')[0]}" />
                            <c:set var="month" value="${birth.split('/')[1]}" />
                            <c:set var="day" value="${birth.split('/')[2]}" />

                            <form name="newMember" action="processUpdateMember.jsp" method="post" onsubmit="return checkForm()">
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">아이디 <span class="required">*</span></label>
                                    <div class="col-sm-9">
                                        <input name="id" type="text" class="form-control" value="<c:out value='${row.id}'/>" readonly>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">비밀번호 <span class="required">*</span></label>
                                    <div class="col-sm-9">
                                        <input name="password" type="password" class="form-control" value="<c:out value='${row.password}'/>" autocomplete="new-password">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">비밀번호 확인 <span class="required">*</span></label>
                                    <div class="col-sm-9">
                                        <input name="password_confirm" type="password" class="form-control" autocomplete="new-password">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">성명 <span class="required">*</span></label>
                                    <div class="col-sm-9">
                                        <input name="name" type="text" class="form-control" value="<c:out value='${row.name}'/>">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">성별 <span class="required">*</span></label>
                                    <div class="col-sm-9 d-flex align-items-center gap-3">
                                        <input name="gender" type="radio" value="남" id="gender_m" <c:if test="${row.gender == '남'}">checked</c:if> >
                                        <label for="gender_m" class="mb-0">남</label>
                                        <input name="gender" type="radio" value="여" id="gender_f" <c:if test="${row.gender == '여'}">checked</c:if> >
                                        <label for="gender_f" class="mb-0">여</label>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">생일 <span class="required">*</span></label>
                                    <div class="col-sm-9">
                                        <div class="row g-2">
                                            <div class="col-md-4">
                                                <input type="text" name="birthyy" maxlength="4" class="form-control" placeholder="년(4자)" value="${year}">
                                            </div>
                                            <div class="col-md-4">
                                                <select name="birthmm" id="birthmm" class="form-select">
                                                    <option value="">월</option>
                                                    <c:forEach var="i" begin="1" end="12">
                                                        <c:set var="mm" value="${i lt 10 ? '0'+i : i}" />
                                                        <option value="${mm}">${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-4">
                                                <input type="text" name="birthdd" maxlength="2" class="form-control" placeholder="일" value="${day}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">이메일 <span class="required">*</span></label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="text" name="mail1" maxlength="50" value="${mail1}" class="form-control">
                                            <span class="input-group-text">@</span>
                                            <select name="mail2" id="mail2" class="form-select">
                                                <option>naver.com</option>
                                                <option>daum.net</option>
                                                <option>gmail.com</option>
                                                <option>nate.com</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">전화번호</label>
                                    <div class="col-sm-9">
                                        <input name="phone" type="text" class="form-control" value="<c:out value='${row.phone}'/>">
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-3 col-form-label">주소</label>
                                    <div class="col-sm-9">
                                        <input name="address" type="text" class="form-control" value="<c:out value='${row.address}'/>">
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between mt-4">
                                    <button type="submit" class="btn btn-primary px-4">회원수정</button>
                                    <a href="deleteMember.jsp" class="btn btn-outline-danger px-4">회원탈퇴</a>
                                </div>
                            </form>
                        </c:forEach>
                    </div>
                </div>
                <jsp:include page="/footer.jsp" />
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
    <script type="text/javascript">
        function init() {
            setComboMailValue("${mail2}");
            setComboBirthValue("${month}");
        }
        function setComboMailValue(val) {
            var selectMail = document.getElementById('mail2');
            for (var i = 0, j = selectMail.length; i < j; i++) {
                if (selectMail.options[i].value == val) {
                    selectMail.options[i].selected = true;
                    break;
                }
            }
        }
        function setComboBirthValue(val) {
            var selectBirth = document.getElementById('birthmm');
            for (var i = 0, j = selectBirth.length; i < j; i++){
                if (selectBirth.options[i].value == val){
                    selectBirth.options[i].selected = true;
                    break;
                }
            }
        }
        function checkForm() {
            if (!document.newMember.password.value) {
                alert("비밀번호를 입력하세요.");
                document.newMember.password.focus();
                return false;
            }
            if (document.newMember.password.value != document.newMember.password_confirm.value) {
                alert("비밀번호를 동일하게 입력하세요.");
                document.newMember.password_confirm.focus();
                return false;
            }
            if (!document.newMember.name.value) {
                alert("이름을 입력하세요.");
                document.newMember.name.focus();
                return false;
            }
            if (!document.newMember.gender.value) {
                alert("성별을 선택하세요.");
                return false;
            }
            if (!document.newMember.birthyy.value || !document.newMember.birthmm.value || !document.newMember.birthdd.value) {
                alert("생년월일을 모두 입력하세요.");
                return false;
            }
            if (!document.newMember.mail1.value || !document.newMember.mail2.value) {
                alert("이메일을 입력하세요.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
