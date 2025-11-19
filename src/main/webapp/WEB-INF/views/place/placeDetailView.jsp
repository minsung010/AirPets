<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/inc/top.jsp"/>
<meta charset="UTF-8">
<title>${placeDetail.title}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    #map { width: 100%; height: 400px; margin-top: 20px; }
    .review-card { border: 1px solid #ddd; border-radius: 10px; padding: 10px; margin-bottom: 10px; }
    .review-card button { margin-right: 5px; }
    textarea { width: 100%; height: 80px; margin-bottom: 5px; }
</style>
</head>
<body class="mt-5 pt-5"> <!-- container 제거 -->

  <!-- 본문 내용만 container -->
  <div class="container">
    <jsp:include page="/WEB-INF/inc/nav.jsp"/>

    <h2>${placeDetail.title}</h2>
    <p><strong>주소:</strong> ${placeDetail.address}</p>
    <p><strong>전화:</strong> <c:if test="${not empty placeDetail.tel}">${placeDetail.tel}</c:if></p>
    <p><strong>설명:</strong> ${placeDetail.description}</p>
    <p><strong>카테고리:</strong> ${placeDetail.category1} / ${placeDetail.category2}</p>
    <p><strong>이용 요금:</strong> ${placeDetail.charge}</p>
    <p><strong>URL:</strong> <c:if test="${not empty placeDetail.url}">
        <a href="${placeDetail.url}" target="_blank">${placeDetail.url}</a>
    </c:if></p>

    <!-- 지도 -->
    <div id="map"></div>

    <a class="btn btn-secondary mt-3 mb-5" style="background-color:#D9A873; href="javascript:history.back()">← 검색 목록으로 돌아가기</a>

    <!-- 리뷰 작성 폼 -->
    <c:if test="${not empty sessionScope.login}">
        <div class="mb-4">
            <h4>리뷰 작성</h4>
            <form id="reviewForm" action="${pageContext.request.contextPath}/review/add" method="post">
                <input type="hidden" name="placeApiId" value="${placeDetail.title}" />
                <textarea name="content" placeholder="리뷰를 작성하세요." required></textarea>
                <button type="submit" class="btn btn-primary btn-sm">작성</button>
            </form>
        </div>
    </c:if>
    <c:if test="${empty sessionScope.login}">
        <p>로그인 후 리뷰 작성 가능. <a href="${pageContext.request.contextPath}/loginView">로그인</a></p>
    </c:if>

    <hr>

    <h4 class="mt-5 mb-3">리뷰</h4>
    <jsp:include page="/WEB-INF/views/review/reviewList.jsp" />
  </div> <!-- container 끝 -->

  <!-- 카카오 지도 -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f4de4178bee8f55fed343e03f6d0d803"></script>
  <script>
  <c:if test="${not empty placeDetail.coordinates}">
      var coords = "${placeDetail.coordinates}";
      var lat = parseFloat(coords.split(",")[0].replace("N","").trim());
      var lng = parseFloat(coords.split(",")[1].replace("E","").trim());

      var mapContainer = document.getElementById('map');
      var mapOption = { center: new kakao.maps.LatLng(lat, lng), level: 3 };
      var map = new kakao.maps.Map(mapContainer, mapOption);

      var marker = new kakao.maps.Marker({ position: new kakao.maps.LatLng(lat, lng), map: map });
      var infowindow = new kakao.maps.InfoWindow({
          content: '<div style="padding:5px;">${placeDetail.title}<br>${placeDetail.address}</div>'
      });
      infowindow.open(map, marker);
  </c:if>
  </script>

  <!-- AJAX 리뷰 작성/좋아요/싫어요 -->
  <script>
  $(function(){

      // 리뷰 작성
      $('#reviewForm').submit(function(e){
          e.preventDefault();
          var form = $(this);
          $.post(form.attr('action'), form.serialize(), function(res){
              if(res.status === 'success'){
                  alert("리뷰가 작성되었습니다!");
                  form.find('textarea').val('');

                  var review = res.review;
                  var html = '<div class="review-card border rounded p-3 mb-3" data-id="'+review.reviewId+'">'
                           + '<strong>'+review.memId+'</strong> | 방금<br>'
                           + '<span class="review-content">'+review.content+'</span><br>'
                           + '<button class="like-btn btn btn-sm btn-light" data-id="'+review.reviewId+'">👍 '+review.likes+'</button>'
                           + '<button class="dislike-btn btn btn-sm btn-light" data-id="'+review.reviewId+'">👎 '+review.dislikes+'</button>'
                           + '<c:if test="${not empty loginId && loginId == review.memId}">'
                           + '<button class="edit-btn btn btn-sm btn-warning" data-id="'+review.reviewId+'">수정</button>'
                           + '<button class="delete-btn btn btn-sm btn-danger" data-id="'+review.reviewId+'">삭제</button>'
                           + '</c:if>'
                           + '</div>';
                  $('#reviewList').prepend(html);
              } else {
                  alert(res.message);
              }
          }, 'json');
      });

      // 좋아요
      $(document).on('click','.like-btn',function(){
          var btn = $(this);
          $.post('${pageContext.request.contextPath}/review/like',{reviewId:btn.data('id')},function(res){
              if(res.status==='success') btn.text('👍 '+res.likes);
              else alert(res.message);
          },'json');
      });

      // 싫어요
      $(document).on('click','.dislike-btn',function(){
          var btn = $(this);
          $.post('${pageContext.request.contextPath}/review/dislike',{reviewId:btn.data('id')},function(res){
              if(res.status==='success') btn.text('👎 '+res.dislikes);
              else alert(res.message);
          },'json');
      });

      // 리뷰 수정
      $(document).on('click', '.edit-btn', function(){
          var card = $(this).closest('.review-card');
          var reviewId = $(this).data('id');
          var contentSpan = card.find('.review-content');
          var oldContent = contentSpan.text();

          contentSpan.replaceWith('<textarea class="edit-textarea">'+oldContent+'</textarea>');
          $(this).replaceWith('<button class="save-btn btn btn-sm btn-success" data-id="'+reviewId+'">저장</button>');
      });

      $(document).on('click', '.save-btn', function(){
          var btn = $(this);
          var card = btn.closest('.review-card');
          var reviewId = btn.data('id');
          var newContent = card.find('.edit-textarea').val();

          $.post('${pageContext.request.contextPath}/review/update', 
                 { reviewId: reviewId, content: newContent }, 
                 function(res){
              if(res.status === 'success'){
                  card.find('.edit-textarea').replaceWith('<span class="review-content">'+newContent+'</span>');
                  btn.replaceWith('<button class="edit-btn btn btn-sm btn-warning" data-id="'+reviewId+'">수정</button>');
              } else {
                  alert(res.message);
              }
          }, 'json');
      });

      // 리뷰 삭제
      $(document).on('click', '.delete-btn', function(){
          if(!confirm("정말 삭제하시겠습니까?")) return;

          var btn = $(this);
          var card = btn.closest('.review-card');
          var reviewId = btn.data('id');

          $.post('${pageContext.request.contextPath}/review/delete', 
                 { reviewId: reviewId }, 
                 function(res){
              if(res.status === 'success'){
                  card.remove();
              } else {
                  alert("삭제 실패: " + res.message);
              }
          }, 'json');
      });

  });
  </script>

  <!-- 푸터 -->
  <jsp:include page="/WEB-INF/inc/footer.jsp"/>
</body>
</html>
