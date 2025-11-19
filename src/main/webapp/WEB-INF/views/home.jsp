<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>프로젝트 홈</title>
    <jsp:include page="/WEB-INF/inc/top.jsp"/>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Roboto:wght@700&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Dokdo&family=Jua&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <!-- Swiper CSS/JS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<style>
/* 메인 비주얼 */
.main-visual { position: relative; height: 70vh; overflow: hidden; }
.main-visual img { width: 100%; height: 80%; object-fit: cover; object-position: center; }

/* 텍스트 */
.main-visual-title {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: #fff;
  text-shadow: 0 4px 10px rgba(0,0,0,0.5);
  animation: fadeInUp 1.5s ease;
  z-index: 10;
}
.main-visual-title .title { font-size: 2.5rem; font-weight: 700; }
.main-visual-title .description { font-size: 1.2rem; margin-top: 1rem; }

/* 텍스트 애니메이션 */
@keyframes fadeInUp { 0% { opacity: 0; transform: translate(-50%, -40%); } 100% { opacity: 1; transform: translate(-50%, -50%); } }

/* 카테고리 */
.category-item { display:flex; flex-direction: column; align-items: center; cursor: pointer; border-radius: 10px; padding: 5px; transition: transform 0.2s, box-shadow 0.2s; }
.category-item img { width: 400px; height: 250px; object-fit: cover; border-radius: 10px; border: 2px solid transparent; transition: border 0.2s, transform 0.2s; }
.category-item p { margin: 4px 0 0 0; font-size: 0.9rem; }
.category-item.selected img { border: 2px solid #007bff; transform: scale(1.1); box-shadow: 0 4px 8px rgba(0,0,0,0.2); }

/* 캐러셀 화살표 */
.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: brown;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    background-size: 100%, 100%;
}
.carousel-control-prev { left: -70px; }
.carousel-control-next { right: -70px; }

.main-visual-title .title {
    font-family: "Jua", sans-serif;
    font-weight: 700; /* 굵게 */
    letter-spacing: 1px; /* 글자 간격 */
    font-style: normal;
}

.navbar-brand {
    font-family: 'Poppins', sans-serif;
    font-weight: 700; /* 굵게 */
    letter-spacing: 1px; /* 글자 간격 살짝 넓히기 */
}

.jua-regular {
  font-family: "Jua", sans-serif;
  font-weight: 400;
  font-style: normal;
}

/* 강아지 부드럽게 움직이기 */
.floating-dog {
    max-height: 200px;
    height: 80%;
    width: 300px;
    object-fit: contain;
    animation: floatDog 6s ease-in-out infinite;
}

/* 좌우로 살짝 이동시키고 크기 조절 */
@keyframes floatDog {
    0%   { transform: translate(0, 0) scale(1); }
    25%  { transform: translate(-5px, -5px) scale(1.05); }
    50%  { transform: translate(5px, 5px) scale(1); }
    75%  { transform: translate(-5px, 5px) scale(1.05); }
    100% { transform: translate(0, 0) scale(1); }
}

/* 왼쪽/오른쪽 위치별 미세 조정 */
.left-dog { margin-right: 10px; }
.right-dog { margin-left: 10px; }


</style>
</head>
<body id="page-top" style="background-color: rgba(255, 255, 255, 0.85);">
<jsp:include page="/WEB-INF/inc/nav.jsp"/>

<c:set var="jejuImages" value="${[
  '/resources/assets/img/제주파더스가든티켓.jpg',
  '/resources/assets/img/제주레일바이크.jpg',
  '/resources/assets/img/제주마방목지.jpg',
  '/resources/assets/img/제주민속촌.jpg',
  '/resources/assets/img/제주선인장마을.jpg',
  '/resources/assets/img/제주스런서귀포점.jpg'
]}" />

<c:set var="recImages" value="${[
  '/resources/assets/img/1004.jpg',
  '/resources/assets/img/부산.jpg',
  '/resources/assets/img/부산동물병원.jpg',
  '/resources/assets/img/부산동물메디컬센터.jpg',
  '/resources/assets/img/부산대학교박물관.jpg',
  '/resources/assets/img/부산근대역사관.jpg'
]}" />

<!-- 배너 섹션 -->
<section class="main-visual">
  <div class="swiper main-visual-slide">
    <div class="swiper-wrapper">
      <div class="swiper-slide"><img src="/resources/assets/img/홈1.jpg" alt="배너1" /></div>
      <div class="swiper-slide"><img src="/resources/assets/img/홈2.jpg" alt="배너2" /></div>
      <div class="swiper-slide"><img src="/resources/assets/img/홈3.jpg" alt="배너3" /></div>
    </div>
    <div class="swiper-pagination"></div>
  </div>
  <hgroup class="main-visual-title text-center">
    <h2 class="title">오늘은 반려동물과 어디로 갈까?</h2>
    <p class="description">날씨를 확인하고 추천 장소를 확인하세요</p>
  </hgroup>
</section>

<section class="container mt-5 pt-5">

<div class="search-section text-center mb-5">
    <h3 class="mb-3 title jua-regular" style="font-size:6.1rem; font-weight:580;">반려동물과 동반 가능한 장소<br> 찾아보기🐾</h3>

    <div class="d-flex justify-content-center align-items-center flex-wrap gap-3">

        <!-- 좌측 강아지 이미지 -->
        <img src="/resources/assets/img/왼쪽강아지.jpg" 
     alt="강아지" 
     class="d-none d-md-block floating-dog left-dog" />
        <!-- 검색창 + 버튼 -->
        <form action="${pageContext.request.contextPath}/placeList" method="get" 
              class="d-flex align-items-center gap-2 flex-wrap" style="max-width:600px; width:100%;">

            <select name="category" class="form-select rounded-pill shadow-sm" 
                    style="width:180px; padding:10px 20px; border:1px solid #ccc;">
                <option value="">전체</option>
                <option value="미용">미용</option>
                <option value="반려동물용품">반려동물용품</option>
                <option value="위탁관리">위탁관리</option>
                <option value="식당">식당</option>
                <option value="카페">카페</option>
                <option value="문예회관">문예회관</option>
                <option value="미술관">미술관</option>
                <option value="박물관">박물관</option>
                <option value="여행지">여행지</option>
                <option value="펜션">펜션</option>
                <option value="호텔">호텔</option>
                <option value="동물병원">동물병원</option>
                <option value="동물약국">동물약국</option>
            </select>

            <input type="text" name="keyword" placeholder="검색어를 입력하세요" 
                   class="form-control rounded-pill shadow-sm" 
                   style="flex:1; min-width:150px; padding:10px 20px; border:1px solid #ccc;" />
                   
            <button type="submit" 
                    class="btn rounded-pill shadow-sm" 
                    style="background-color:#a52a2a; color:white; padding:10px 25px; border:none;">
                검색
            </button>
        </form>

        <!-- 우측 강아지 이미지 -->
        <img src="/resources/assets/img/오른쪽강아지.jpg" 
     alt="강아지" 
     class="d-none d-md-block floating-dog right-dog" />
    </div>
</div>




<!-- 기존 배너 이미지 -->
<div class="banner-image mt-4 mb-4" 
     style="position: relative; height: 300px; margin-top: 100px; border-radius: 15px; overflow: hidden;">
    <img src="https://support.visitkorea.or.kr/img/call?cmd=VIEW&id=48dc9ce1-2399-48b7-b820-06f8f7da989b" 
         alt="배너 이미지" 
         style="width:100%; height:100%; object-fit:cover;" />
</div>

<!-- 제주도 추천 장소 -->
<div class="row mt-4 mb-5">
  <div class="col-12 text-center mb-3"><h2 style="margin-top: 100px;">제주도 추천 장소</h2></div>
    <c:choose>
        <c:when test="${not empty jejuTravelPlaces}">
            <div id="jejuCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="place" items="${jejuTravelPlaces}" varStatus="status">
                        <c:if test="${status.index % 3 == 0}">
                            <div class="carousel-item <c:if test='${status.index == 0}'>active</c:if>">
                                <div class="row">
                        </c:if>
                        <div class="col-md-4 mb-4">
                            <div class="card h-100 shadow-sm text-center p-3">
                                <img src="${jejuImages[status.index % jejuImages.size()]}" 
                                     class="card-img-top mb-2" 
                                     alt="${place.title}" 
                                     style="height:200px; margin-bottom: 50px;  object-fit:cover; border-radius:10px;">
                                <h5 class="card-title mt-2">${place.title}</h5>
                                <p class="card-text">${place.address}</p>
                            </div>
                        </div>
                        <c:if test="${(status.index + 1) % 3 == 0 || status.last}">
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- 제주도 화살표 -->
                <button class="carousel-control-prev" type="button" data-bs-target="#jejuCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#jejuCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </c:when>
        <c:otherwise>
            <p class="text-center">추천 장소가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<!-- 기존 배너 이미지 2 -->
<div class="banner-image mt-4 mb-4" 
     style="position: relative; height: 300px; border-radius: 15px; overflow: hidden;">
    <img src="/resources/assets/img/배너이미지2.jpg" 
         alt="배너 이미지" 
         style="width:100%; height:100%;  object-fit:cover;" />
    <div style="position: absolute; top:50%; left:50%; transform: translate(-50%, -50%);
                color:white; text-shadow: 1px 1px 4px rgba(0,0,0,0.7); font-size: 2rem; font-weight: bold;">
        추천 장소를 살펴보고 리뷰를 남겨주세요
    </div>
</div>


<!-- 일반 추천 장소 -->
<div class="row mt-5 mb-5">
    <div class="col-12 text-center mb-3"><h2 style="margin-top: 50px;">추천 장소</h2></div>
    <c:choose>
        <c:when test="${not empty recommendedPlaces}">
            <div id="placeCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="place" items="${recommendedPlaces}" varStatus="status">
                        <c:if test="${status.index % 3 == 0}">
                            <div class="carousel-item <c:if test='${status.index == 0}'>active</c:if>">
                                <div class="row">
                        </c:if>
                        <div class="col-md-4 mb-4">
                            <div class="card h-100 shadow-sm text-center p-3">
                                <!-- 이미지 추가 -->
                                <img src="${recImages[status.index % recImages.size()]}" 
                                     class="card-img-top mb-2" 
                                     alt="${place.title}" 
                                     style="height:200px; object-fit:cover; border-radius:10px;">
                                <h5 class="card-title mt-2">${place.title}</h5>
                                <p class="card-text">${place.address}</p>
                            </div>
                        </div>
                        <c:if test="${(status.index + 1) % 3 == 0 || status.last}">
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- 일반 추천 장소 화살표 -->
                <button class="carousel-control-prev" type="button" data-bs-target="#placeCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#placeCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </c:when>
        <c:otherwise>
            <p class="text-center">추천 장소가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

</section>
<jsp:include page="/WEB-INF/inc/footer.jsp"/>

<script>
$(document).ready(function(){
    var message = "${empty message ? '' : message.message }";
    if(message){
        $("#messageModal").modal('show');
    }
});

// 카테고리 선택
const categoryItems = document.querySelectorAll('.category-item');
const catInput = document.getElementById('cat1Input');
categoryItems.forEach(item => {
    item.addEventListener('click', function() {
        categoryItems.forEach(i => i.classList.remove('selected'));
        this.classList.add('selected');
        catInput.value = this.getAttribute('data-value');
    });
});

// Swiper 초기화
const swiper = new Swiper(".main-visual-slide", {
    effect: "fade",
    loop: true,
    autoplay: { delay: 4000, disableOnInteraction: false },
    pagination: { el: ".swiper-pagination", clickable: true }
});
</script>
</body>
</html>
