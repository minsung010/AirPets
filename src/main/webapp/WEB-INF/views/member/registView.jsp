<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- Font Awesome -->
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
  display: flex; justify-content: center; align-items: center;
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
  min-height: 800px;
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

form { display: flex; flex-direction: column; }

form input, form select {
  background: #eee;
  padding: 16px;
  margin: 8px 0;
  width: 100%;
  border: 0;
  outline: none;
  border-radius: 20px;
  box-shadow: inset 7px 2px 10px #babebc, inset -5px -5px 12px #fff;
}

button {
  border-radius: 20px;
  border: none; outline: none;
  font-size: 12px; font-weight: bold;
  padding: 15px 45px;
  margin: 14px 0;
  letter-spacing: 1px;
  text-transform: uppercase;
  cursor: pointer;
  box-shadow: -5px -5px 10px #fff, 5px 5px 8px #babebc;
}
button:active {
  box-shadow: inset 1px 1px 2px #babebc, inset -1px -1px 2px #fff;
}

h2 { text-align: center; margin-bottom: 20px; color: #000; }
p { text-align: center; font-size: 14px; }

.error { color: red; font-size: 0.9em; margin-top: -5px; margin-bottom: 8px; }
.alert-success { color: green; text-align: center; margin-bottom: 15px; }
.alert-danger { color: red; text-align: center; margin-bottom: 15px; }



/* 성별 선택 컨테이너 */
.radio-group {
  display: flex;
  gap: 20px;
  margin: 8px 0 12px 0;
  font-size: 14px;
  color: #333;
}

/* 기본 라디오 숨기기 */
.radio-group input[type="radio"] {
  appearance: none;
  -webkit-appearance: none;
  width: 18px;
  height: 18px;
  border: 1.5px solid #aaa;
  border-radius: 4px; /* 둥근 네모 */
  background-color: #fff;
  cursor: pointer;
  position: relative;
  transition: all 0.2s ease;
  vertical-align: middle;
}

/* 체크됐을 때 배경색 */
.radio-group input[type="radio"]:checked {
  background-color: #D9A873;
  border-color: #D9A873;
}

/* 체크 아이콘 (✔) */
.radio-group input[type="radio"]:checked::after {
  content: "";
  position: absolute;
  left: 9px;
  top: 2px;
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
    <h3 style="text-align: center;">Create your account to access personalized pet services and exclusive content tailored for you and your furry companion.</h3>
  </div>

  <!-- 오른쪽 회원가입 영역 -->
  <div class="container">
    <h2>회원가입</h2>

    <!-- 메시지 표시 -->
    <c:if test="${not empty message}">
      <div class="${message.success ? 'alert-success' : 'alert-danger'}">
        ${message.content}
      </div>
      <c:if test="${message.success}">
        <script>
          setTimeout(function() {
            window.location.href='${message.url}';
          }, 3000);
        </script>
      </c:if>
    </c:if>

    <!-- 회원가입 폼 -->
    <form:form modelAttribute="member" action="${pageContext.request.contextPath}/registDo" method="post">

      <label for="memId">아이디</label>
      <form:input path="memId" id="memId" cssClass="form-control" placeholder="아이디를 입력하세요..." />
      <form:errors path="memId" cssClass="error" />

      <label for="memPw">비밀번호</label>
      <form:password path="memPw" id="memPw" cssClass="form-control" placeholder="비밀번호를 입력하세요..." />
      <form:errors path="memPw" cssClass="error" />

      <label for="memNm">이름</label>
      <form:input path="memNm" id="memNm" cssClass="form-control" placeholder="이름을 입력하세요..." />
      <form:errors path="memNm" cssClass="error" />

      <label>성별</label>
		<div class="radio-group">
		  <label>
		    <form:radiobutton path="memGender" value="M" /> 남
		  </label>
		  <label>
		    <form:radiobutton path="memGender" value="F" /> 여
		  </label>
		</div>
		<form:errors path="memGender" cssClass="error" />


      <label for="memPhone">전화번호</label>
      <form:input path="memPhone" id="memPhone" cssClass="form-control" placeholder="전화번호를 입력하세요..." />
      <form:errors path="memPhone" cssClass="error" />

      <label for="memAddr">주소</label>
      <div style="display: flex; gap: 10px; margin-bottom: 8px;">
        <form:input path="memAddr" id="memAddr" cssClass="form-control" placeholder="주소를 입력하세요..." readonly="true" style="flex:3;" />
        <button type="button" id="addrBtn" style="flex: 1; padding: 10px; border-radius: 20px; font-size: 12px; background-color:#D9A873;">주소 찾기</button>
      </div>
      <form:errors path="memAddr" cssClass="error" />

      <button type="submit" style="background-color:#D9A873;" >가입하기</button>
    </form:form>

    <p>이미 계정이 있으신가요? <a href="<c:url value='/loginView'/>">로그인</a></p>
  </div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
document.getElementById('addrBtn').addEventListener('click', function() {
  new daum.Postcode({
    oncomplete: function(data) {
      document.getElementById('memAddr').value = data.address;
    }
  }).open();
});
</script>

</body>
</html>
