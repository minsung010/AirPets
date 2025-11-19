<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성/수정</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
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
            padding: 200px 20px 20px 40px; /* nav 아래로 공간 확보 */
            max-width: 700px;
            margin: auto;
        }

        h1 { font-size: 28px; margin-bottom: 30px; }
        label { display: block; margin-top: 10px; font-weight: bold; }
        input[type=text], textarea {
            width: 100%; padding: 10px; margin-top: 4px;
            border-radius: 4px; border: 1px solid #ccc;
            font-size: 16px;
        }
        textarea { height: 200px; resize: vertical; }
        .btn {
            margin-top: 15px; padding: 8px 14px;
            background: #28a745; color: #fff;
            border-radius: 4px; border: none; cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/inc/nav.jsp"/>

<div class="container1">
    <h1>
        <c:choose>
            <c:when test="${notice != null}">공지사항 수정</c:when>
            <c:otherwise>공지사항 작성</c:otherwise>
        </c:choose>
    </h1>

    <c:choose>
        <c:when test="${notice != null}">
            <form action="${pageContext.request.contextPath}/notice/edit" method="post">
                <input type="hidden" name="id" value="${notice.id}">
        </c:when>
        <c:otherwise>
            <form action="${pageContext.request.contextPath}/notice/write" method="post">
        </c:otherwise>
    </c:choose>

        <label for="title">제목</label>
        <input type="text" id="title" name="title" value="${notice != null ? notice.title : ''}" required>

        <label for="content">내용</label>
        <textarea id="content" name="content" required>${notice != null ? notice.content : ''}</textarea>

        <button type="submit" class="btn">
            <c:choose>
                <c:when test="${notice != null}">수정</c:when>
                <c:otherwise>작성</c:otherwise>
            </c:choose>
        </button>
    </form>
</div>
</body>
</html>
