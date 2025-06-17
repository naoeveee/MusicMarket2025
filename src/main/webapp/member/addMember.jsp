<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 가입 | Mello-Catch</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #f8e8ff 0%, #e0f7fa 100%);
        }
        .join-header-card {
            background: linear-gradient(90deg,#ff416c,#c1b6f7);
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.13);
        }
        .join-form-card {
            max-width: 540px;
            margin: 0 auto 2.5rem auto;
            background: #fff;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(80,40,120,0.09);
            padding: 2.5rem 2.2rem 2rem 2.2rem;
        }
        .join-form-card .form-label {
            font-weight: 600;
            color: #8f5cf7;
        }
        .join-form-card .form-control, .join-form-card .form-select {
            border-radius: 1rem;
            font-size: 1.08rem;
            min-height: 2.7rem;
        }
        .join-form-card .btn-primary {
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border: none;
            border-radius: 1.1rem;
            font-weight: 700;
            font-size: 1.1rem;
            transition: 0.18s;
        }
        .join-form-card .btn-primary:hover {
            background: linear-gradient(90deg,#f59e42,#8f5cf7);
        }
        .join-form-card .btn-secondary {
            border-radius: 1.1rem;
            font-size: 1.05rem;
            font-weight: 600;
        }
        .join-form-card .form-check-label {
            font-weight: 500;
            font-size: 1.02rem;
        }
        .footer-music {
            margin-top: 3.5rem;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
            background: linear-gradient(90deg,#8f5cf7,#f59e42);
            border-radius: 2rem 2rem 0 0;
        }
        @media (max-width: 576px) {
            .join-form-card { padding: 1.2rem 0.6rem; }
            .footer-music { padding-top: 1.2rem; padding-bottom: 1.2rem; }
        }
    </style>
    <script type="text/javascript">
        function checkForm() {
            if (!document.newMember.id.value) {
                alert("아이디를 입력하세요.");
                return false;
            }
            if (!document.newMember.password.value) {
                alert("비밀번호를 입력하세요.");
                return false;
            }
            if (document.newMember.password.value != document.newMember.password_confirm.value) {
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }
        }
    </script>
</head>
<body>
<div class="container py-4">
    <jsp:include page="/menu.jsp" />

    <!-- 회원가입 헤더 -->
    <div class="join-header-card py-5 mb-4">
        <div class="container-fluid py-3 text-center text-white">
            <h1 class="display-5 fw-bold mb-2"><i class="bi bi-person-plus-fill me-2"></i>회원 가입</h1>
            <p class="fs-4 mb-0 text-white-50">Membership Joining</p>
        </div>
    </div>

    <!-- 회원가입 폼 카드 -->
    <div class="join-form-card">
        <form name="newMember" action="processAddMember.jsp" method="post" onsubmit="return checkForm()">
            <div class="mb-4">
                <label for="id" class="form-label"><i class="bi bi-person-fill me-1"></i>아이디</label>
                <input name="id" id="id" type="text" class="form-control" placeholder="id" required>
            </div>
            <div class="mb-4">
                <label for="password" class="form-label"><i class="bi bi-lock-fill me-1"></i>비밀번호</label>
                <input name="password" id="password" type="password" class="form-control" placeholder="password" required>
            </div>
            <div class="mb-4">
                <label for="password_confirm" class="form-label"><i class="bi bi-lock-fill me-1"></i>비밀번호 확인</label>
                <input name="password_confirm" id="password_confirm" type="password" class="form-control" placeholder="password confirm" required>
            </div>
            <div class="mb-4">
                <label for="name" class="form-label"><i class="bi bi-person-lines-fill me-1"></i>성명</label>
                <input name="name" id="name" type="text" class="form-control" placeholder="name" required>
            </div>
            <div class="mb-4">
                <label class="form-label"><i class="bi bi-gender-ambiguous me-1"></i>성별</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input name="gender" id="gender_male" type="radio" class="form-check-input" value="남">
                        <label class="form-check-label" for="gender_male">남</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input name="gender" id="gender_female" type="radio" class="form-check-input" value="여">
                        <label class="form-check-label" for="gender_female">여</label>
                    </div>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label"><i class="bi bi-calendar-event me-1"></i>생일</label>
                <div class="row g-2">
                    <div class="col-4">
                        <input type="text" name="birthyy" maxlength="4" class="form-control" placeholder="년(4자)" size="6">
                    </div>
                    <div class="col-4">
                        <select name="birthmm" class="form-select">
                            <option value="">월</option>
                            <option value="01">1</option>
                            <option value="02">2</option>
                            <option value="03">3</option>
                            <option value="04">4</option>
                            <option value="05">5</option>
                            <option value="06">6</option>
                            <option value="07">7</option>
                            <option value="08">8</option>
                            <option value="09">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select>
                    </div>
                    <div class="col-4">
                        <input type="text" name="birthdd" maxlength="2" class="form-control" placeholder="일" size="4">
                    </div>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label"><i class="bi bi-envelope-fill me-1"></i>이메일</label>
                <div class="row g-2">
                    <div class="col-6">
                        <input type="text" name="mail1" maxlength="50" class="form-control" placeholder="email">
                    </div>
                    <div class="col-auto align-self-center">@</div>
                    <div class="col-5">
                        <select name="mail2" class="form-select">
                            <option>naver.com</option>
                            <option>daum.net</option>
                            <option>gmail.com</option>
                            <option>nate.com</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="mb-4">
                <label for="phone" class="form-label"><i class="bi bi-telephone-fill me-1"></i>전화번호</label>
                <input name="phone" id="phone" type="text" class="form-control" placeholder="phone">
            </div>
            <div class="mb-4">
                <label for="address" class="form-label"><i class="bi bi-house-door-fill me-1"></i>주소</label>
                <input name="address" id="address" type="text" class="form-control" placeholder="address">
            </div>
            <div class="d-flex justify-content-between gap-2 mt-4">
                <input type="submit" class="btn btn-primary w-50" value="등록">
                <input type="reset" class="btn btn-secondary w-50" value="취소" onclick="reset()">
            </div>
        </form>
    </div>

  
    <footer class="footer-music mt-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-4 text-center text-md-start mb-3 mb-md-0">
                    <span class="fs-4 fw-bold text-white">
                        <i class="bi bi-music-note-beamed me-2"></i>Mello-Catch
                    </span>
                </div>
                <div class="col-md-4 text-center mb-3 mb-md-0">
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white mx-2 fs-5"><i class="bi bi-twitter"></i></a>
                </div>
                <div class="col-md-4 text-center text-md-end">
                    <span class="text-white-50 small">
                        Copyright &copy; Mello-Catch 2025<br>
                        All music content &copy; respective owners.
                    </span>
                </div>
            </div>
        </div>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
