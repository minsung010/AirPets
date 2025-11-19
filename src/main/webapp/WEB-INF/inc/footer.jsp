<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<footer class="bg-light text-dark pt-5">
  <div class="container">
    <div class="row">

      <!-- 사이트 소개 -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold">AirPets</h5>
        <p>Your companion's best friend. Explore pet-friendly places, services, and more!</p>
      </div>

      <!-- 탐색 링크 -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold">Quick Links</h5>
        <ul class="list-unstyled">
          <li><a href="${pageContext.request.contextPath}/" class="text-dark text-decoration-none">Home</a></li>
          <li><a href="${pageContext.request.contextPath}/placeList" class="text-dark text-decoration-none">Places</a></li>
          <li><a href="${pageContext.request.contextPath}/notice/list" class="text-dark text-decoration-none">Notice</a></li>
          <li><a href="${pageContext.request.contextPath}/contact" class="text-dark text-decoration-none">Contact</a></li>
        </ul>
      </div>

      <!-- 연락처 + SNS -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold">Contact Us</h5>
        <p>Email: yuzx1989@naver.com</p>
        <p>Phone: +82 10-1234-5678</p>
        <div class="mt-2">
          <a class="btn btn-sm text-white m-1" style="background-color: #3b5998;" href="#"><i class="fab fa-facebook-f"></i></a>
          <a class="btn btn-sm text-white m-1" style="background-color: #55acee;" href="#"><i class="fab fa-twitter"></i></a>
          <a class="btn btn-sm text-white m-1" style="background-color: #ac2bac;" href="#"><i class="fab fa-instagram"></i></a>
          <a class="btn btn-sm text-white m-1" style="background-color: #333333;" href="#"><i class="fab fa-github"></i></a>
        </div>
      </div>

    </div>
    <hr>
    <!-- 저작권 -->
    <div class="text-center py-3" style="font-size:0.9rem; background-color: rgba(0,0,0,0.03);">
      © 2025 미래융합교육원
    </div>
  </div>
</footer>
