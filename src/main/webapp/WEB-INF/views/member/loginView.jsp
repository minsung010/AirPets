<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">

<style>
* { box-sizing: border-box; }
body {
  font-family: "Montserrat", sans-serif;
  margin: 0; padding: 0;
  height: 100vh;
  background:no-repeat center center;
  background-size: cover;
  background-attachment: fixed;
  display: flex;
  justify-content: center;
  align-items: center;
}

.wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  background: #ebecf0;
  border-radius: 10px;
  box-shadow: -5px -5px 10px #fff, 5px 5px 10px #babebc;
  overflow: hidden;
  width: 900px;
  max-width: 90%;
  min-height: 600px;
}

/* 왼쪽 영역 (갈색 배경) */
.left-image {
  flex: 1;
  background: #8B4513; /* 갈색 */
  display: flex;
  justify-content: center;
  align-items: center;
  color: #fff;
  font-size: 20px;
  font-weight: bold;
  min-height: 600px;
}
.left-image img { display: none; }

/* 오른쪽 폼 영역 */
.container {
  flex: 1;
  padding: 40px;
  min-width: 300px;
  max-width: 400px;
  background: #ebecf0;
}

form {
  display: flex;
  flex-direction: column;
}

form input {
  background: #eee;
  padding: 16px;
  margin: 8px 0;
  width: 100%;
  border: 0;
  outline: none;
  border-radius: 20px;
  box-shadow: inset 7px 2px 10px #babebc,
              inset -5px -5px 12px #fff;
}

button {
  border-radius: 20px;
  border: none;
  outline: none;
  font-size: 12px;
  font-weight: bold;
  padding: 15px 45px;
  margin: 14px 0;
  letter-spacing: 1px;
  text-transform: uppercase;
  cursor: pointer;
  box-shadow: -5px -5px 10px #fff, 5px 5px 8px #babebc;
}
button:active {
  box-shadow: inset 1px 1px 2px #babebc,
              inset -1px -1px 2px #fff;
}

h2 { text-align: center; margin-bottom: 20px; color: #000; }
p { text-align: center; font-size: 14px; }
.success { color: green; text-align: center; margin-bottom: 10px; font-weight: bold; }
.error { color: red; text-align: center; margin-bottom: 10px; font-weight: bold; }



/* 체크박스 라벨 */
.checkbox-container {
  display: flex;
  align-items: center;
  gap: 6px;
  margin: 12px 0;
  font-size: 14px;
  color: #333;
  cursor: pointer;
  user-select: none;
}

/* 기본 체크박스 숨기기 */
.checkbox-container input[type="checkbox"] {
  appearance: none;
  -webkit-appearance: none;
  width: 16px;
  height: 16px;
  border: 1.5px solid #aaa;
  border-radius: 3px;
  background-color: #fff;
  cursor: pointer;
  position: relative;
  transition: all 0.2s ease;
}

/* 체크됐을 때 */
.checkbox-container input[type="checkbox"]:checked {
  background-color: #D9A873; /* 로그인 버튼 색상과 맞춤 */
  border-color: #D9A873;
}

/* 체크 표시 */
.checkbox-container input[type="checkbox"]:checked::after {
  content: "";
  position: absolute;
  left: 9px;
  top: 0px;
  width: 10px;
  height: 20px;
  border: solid #fff;
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
}






</style>
</head>
<body>
<div class="wrapper">

  <!-- 왼쪽 갈색 영역 -->
  <div class="left-image">
    <h3 style="text-align: center;">Welcome back! Sign in to access your personalized pet dashboard and continue managing your furry companion’s activities.</h3>
  </div>

  <!-- 오른쪽 로그인 영역 -->
  <div class="container">
    <h2>로그인</h2>

    <!-- 회원가입 성공 메시지 -->
    <c:if test="${not empty successMsg}">
        <div class="success">${successMsg}</div>
    </c:if>

    <!-- 로그인 오류 메시지 -->
    <c:if test="${not empty errorMsg}">
        <div class="error">${errorMsg}</div>
    </c:if>

    <form:form modelAttribute="member" action="${pageContext.request.contextPath}/loginDo" method="post">
        <form:input path="memId" placeholder="아이디를 입력하세요..." />
        <form:errors path="memId" cssClass="error" />

        <form:password path="memPw" placeholder="비밀번호를 입력하세요..." />
        <form:errors path="memPw" cssClass="error" />

        <label class="checkbox-container">
  <input type="checkbox" name="remember" ${cookie.rememberId.value == null ? "" : "checked"} />
  아이디 기억하기
</label>


        <button type="submit" style="background-color:#D9A873;">로그인</button>
    </form:form>

    <p>회원이 아니신가요? <a href="<c:url value='/registView'/>">회원가입</a></p>
  </div>
</div>
</body>
</html>
