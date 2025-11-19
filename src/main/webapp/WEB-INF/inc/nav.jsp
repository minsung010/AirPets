<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/style.css">


<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top navbar-brand" style="background-color: rgba(255,255,255,0.8);">
    <div class="container">
        <a class="navbar-brand text-dark fw-bold" href="${pageContext.request.contextPath}/">AirPets</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <!-- 공지사항 목록 (모든 사용자) -->
                <li class="nav-item mx-1">
                    <a class="nav-link text-dark" href="${pageContext.request.contextPath}/notice/list">공지사항</a>
                </li>

                <!-- 관리자만 글쓰기 -->
                <c:if test="${sessionScope.login != null && sessionScope.login.admin}">
                    <li class="nav-item mx-1">
                        <a class="nav-link text-dark" href="${pageContext.request.contextPath}/notice/write">공지사항 작성</a>
                    </li>
                </c:if>

                <!-- 로그인 상태 -->
                <c:if test="${sessionScope.login == null}">
                    <li class="nav-item mx-1">
                        <a class="nav-link text-dark" href="${pageContext.request.contextPath}/loginView">로그인</a>
                    </li>
                </c:if>

                <!-- 로그인 후 사용자 -->
                <c:if test="${sessionScope.login != null}">
                    <li class="nav-item mx-1">
                        <span class="nav-link text-dark">${sessionScope.login.memNm}님</span>
                    </li>
                    <li class="nav-item mx-1">
                        <a class="nav-link text-dark" href="${pageContext.request.contextPath}/air">날씨</a>
                    </li>
                    <li class="nav-item mx-1">
                        <a class="nav-link text-dark" href="${pageContext.request.contextPath}/logoutDo">로그아웃</a>
                    </li>
                    
                </c:if>
            </ul>
        </div>
    </div>
</nav>

