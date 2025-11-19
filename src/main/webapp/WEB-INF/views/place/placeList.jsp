<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장소 목록</title>
    <jsp:include page="/WEB-INF/inc/top.jsp"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
/* 카드 등장 애니메이션 */
.place-card {
    opacity: 0;
    transform: translateY(20px);
    transition: all 0.5s ease;
}



.place-card.visible {
    opacity: 1;
    transform: translateY(0);
}

/* 카드 hover 효과 */
.place-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}
</style>

</head>



<body style="background-color:#f3f3f3;">
<jsp:include page="/WEB-INF/inc/nav.jsp"/>
<div class="container mt-5 pt-5">
    

<!-- 기존 배너 이미지 -->
<div class="banner-image mt-4 mb-4" 
     style="position: relative; height: 500px; border-radius: 15px; overflow: hidden;">
    <img src="/resources/assets/img/강아지.jpg" 
         alt="배너 이미지" 
         style="width:100%; border: none; height:80%; object-fit:cover;" />
</div>

    <form action="${pageContext.request.contextPath}/placeList" method="get" class="mb-4 d-flex gap-2">
        <select name="category" class="form-control">
            <option value="">전체</option>
            <option value="미용" <c:if test="${param.category=='미용'}">selected</c:if>>미용</option>
            <option value="반려동물용품" <c:if test="${param.category=='반려동물용품'}">selected</c:if>>반려동물용품</option>
            <option value="위탁관리" <c:if test="${param.category=='위탁관리'}">selected</c:if>>위탁관리</option>
            <option value="식당" <c:if test="${param.category=='식당'}">selected</c:if>>식당</option>
            <option value="카페" <c:if test="${param.category=='카페'}">selected</c:if>>카페</option>
            <option value="문예회관" <c:if test="${param.category=='문예회관'}">selected</c:if>>문예회관</option>
            <option value="미술관" <c:if test="${param.category=='미술관'}">selected</c:if>>미술관</option>
            <option value="박물관" <c:if test="${param.category=='박물관'}">selected</c:if>>박물관</option>
            <option value="여행지" <c:if test="${param.category=='여행지'}">selected</c:if>>여행지</option>
            <option value="펜션" <c:if test="${param.category=='펜션'}">selected</c:if>>펜션</option>
            <option value="호텔" <c:if test="${param.category=='호텔'}">selected</c:if>>호텔</option>
            <option value="동물병원" <c:if test="${param.category=='동물병원'}">selected</c:if>>동물병원</option>
            <option value="동물약국" <c:if test="${param.category=='동물약국'}">selected</c:if>>동물약국</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어" class="form-control" value="${param.keyword}">
        <button type="submit" style="background-color:#a52a2a; color:white;" class="btn btn-primary">검색</button>
    </form>

    <h3 class="mb-3" style="margin-top: 60px;">검색 결과</h3>
<c:choose>
    <c:when test="${not empty places}">
        <div class="row">
            <c:forEach var="place" items="${places}">
                <div class="col-md-6 col-lg-4 mb-4">
                    <a href="${pageContext.request.contextPath}/placeDetail?title=${place.title}" 
                       class="card h-100 text-decoration-none text-dark shadow-sm place-card">
                        <div class="card-body">
                            <h5 class="card-title">${place.title}</h5>
                            <p class="card-text mb-1">${place.address}</p>
                            <c:if test="${not empty place.tel}">
                                <p class="card-text">전화: ${place.tel}</p>
                            </c:if>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>

        <!-- 페이지네이션 -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center mt-3">
                    <!-- 이전 블록 -->
                    <c:if test="${startPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/placeList?keyword=${keyword}&category=${category}&page=${startPage - 1}">&laquo;</a>
                        </li>
                    </c:if>

                    <!-- 페이지 번호 -->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="page-item <c:if test='${i==currentPage}'>active</c:if>">
                            <a class="page-link" href="${pageContext.request.contextPath}/placeList?keyword=${keyword}&category=${category}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- 다음 블록 -->
                    <c:if test="${endPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/placeList?keyword=${keyword}&category=${category}&page=${endPage + 1}">&raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>

    </c:when>
    <c:otherwise>
        <p>검색 결과가 없습니다.</p>
    </c:otherwise>
</c:choose>

</div>
<jsp:include page="/WEB-INF/inc/footer.jsp"/>

<script>
window.addEventListener('DOMContentLoaded', () => {
    const cards = document.querySelectorAll('.place-card');
    cards.forEach((card, index) => {
        setTimeout(() => {
            card.classList.add('visible');
        }, index * 100); // 순차적으로 등장
    });
});
</script>
</body>

</html>
