<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }

        .container1 {
            padding: 200px 20px 250px 40px; /* nav 아래 공간 + 목록 아래 여백 추가 */
            max-width: 1100px;
            margin: auto;
        }

        h1 { font-size: 32px; margin-bottom: 30px; }

        table { width: 100%; border-collapse: collapse; }
        th, td { border-bottom: 1px solid #ccc; padding: 12px; text-align: left; font-size: 16px; }
        th { background: #eee; font-size: 18px; }
        a.notice-link { color: #007bff; text-decoration: none; font-size: 16px; }
        a.notice-link:hover { text-decoration: underline; }

        .write-btn {
            margin-top: 20px;
            display: inline-block;
            padding: 8px 14px;
            background: #28a745;
            color: #fff;
            border-radius: 4px;
            text-decoration: none;
            font-size: 16px;
        }

        /* 푸터 높이 줄이기 */
        footer .text-center.py-3 {
            padding: 8px 0 !important; /* 기존보다 조금 줄임 */
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/inc/nav.jsp"/>

<div class="container1">
    <h1>공지사항</h1>

    <table>
        <tr>
            <th>ID</th>
            <th>제목</th>
            <th>등록일</th>
            <th>작성자</th>
        </tr>
        <c:forEach var="notice" items="${notices}">
            <tr>
                <td>${notice.id}</td>
                <td><a class="notice-link" href="${pageContext.request.contextPath}/notice/view/${notice.id}">${notice.title}</a></td>
                <td>${notice.regDate}</td>
                <td>${notice.writer}</td>
            </tr>
        </c:forEach>
    </table>

    <c:if test="${sessionScope.login != null && sessionScope.login.admin}">
        <a class="write-btn" href="${pageContext.request.contextPath}/notice/write">공지사항 작성</a>
    </c:if>
</div>

<jsp:include page="/WEB-INF/inc/footer.jsp"/>
</body>
</html>
