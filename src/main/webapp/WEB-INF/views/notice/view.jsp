<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <style>
        body { margin: 0; font-family: 'Arial', sans-serif; background: #f2f2f2; }

        nav {
            background: #f8f9fa;
            padding: 10px 20px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        nav a { margin-right: 15px; text-decoration: none; color: #333; font-weight: bold; }

        .container1 {
            padding: 180px 20px 300px 20px; /* 아래 여백 증가 (60px -> 120px) */
            max-width: 900px;
            margin: auto;
        }

        .notice-card {
            background: #fff;
            border-radius: 12px;
            padding: 35px 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            position: relative;
        }

        .back-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #6c757d;
            color: #fff;
            padding: 6px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s;
        }
        .back-btn:hover {
            background: #5a6268;
        }

        .notice-title {
            font-size: 34px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
            text-align: center;
        }

        .title-underline {
            width: 80px;
            height: 3px;
            background: #007bff;
            margin: 0 auto 30px auto;
            border-radius: 2px;
        }

        .notice-info {
            color: #777;
            font-size: 14px;
            margin-bottom: 25px;
            text-align: center;
        }

        .notice-content {
            font-size: 16px;
            line-height: 1.8;
            white-space: pre-wrap;
            color: #444;
        }

        .btn-group {
            margin-top: 30px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            padding: 8px 18px;
            margin: 0 5px;
            background: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            transition: background 0.3s;
        }

        .btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/inc/nav.jsp"/>

<div class="container1">
    <div class="notice-card">
        <a href="${pageContext.request.contextPath}/notice/list" class="back-btn">공지사항 목록</a>

        <div class="notice-title">${notice.title}</div>
        <div class="title-underline"></div>

        <div class="notice-info">
            ID: ${notice.id} | 작성일: ${notice.regDate} | 작성자: ${notice.writer}
        </div>

        <div class="notice-content">${notice.content}</div>

        <c:if test="${sessionScope.login != null && sessionScope.login.admin}">
            <div class="btn-group">
                <a class="btn" href="${pageContext.request.contextPath}/notice/edit/${notice.id}">수정</a>
                <a class="btn" href="${pageContext.request.contextPath}/notice/delete/${notice.id}">삭제</a>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/inc/footer.jsp"/>
</body>
</html>
