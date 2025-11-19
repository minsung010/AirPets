<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="reviewList">
    <c:forEach var="r" items="${reviews}">
        <div class="review-card border rounded p-3 mb-3" data-id="${r.reviewId}">
            <strong>아이디: ${r.memId}</strong> | 작성시간: ${r.createDt} <br>
            <span class="review-content">${r.content}</span> <br>

            <button class="like-btn btn btn-sm btn-light" data-id="${r.reviewId}">👍 ${r.likes}</button>
            <button class="dislike-btn btn btn-sm btn-light" data-id="${r.reviewId}">👎 ${r.dislikes}</button>

            <!-- 작성자만 수정/삭제 버튼 표시 -->
            <c:if test="${not empty loginId && loginId eq r.memId}">
                <button class="edit-btn btn btn-sm btn-warning" data-id="${r.reviewId}">수정</button>
                <button class="delete-btn btn btn-sm btn-danger" data-id="${r.reviewId}">삭제</button>
            </c:if>
        </div>
    </c:forEach>
</div>



