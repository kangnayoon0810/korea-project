<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="trainerfind" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/trainer.css" />

<section class="tfind-section">
	<div id="text"></div>
	<div class="find-box">
		<div class="trainer-find">
  <!-- 1. 상단 타이틀 -->
		  <section class="trainer-header">
		    <h2>나의 트레이너 찾기</h2>
		    <p>위치 기반 + 인기순으로 트레이너를 찾아보세요!</p>
		  </section>
		
		  <!-- 2. 카카오 지도 -->
		  <section class="trainer-map">
		    <!-- 지도를 표시할 div 입니다 -->
			<div id="map" style="width:100%;height:350px;"></div>
		  </section>
		
		  <!-- 3. 트레이너 리스트 -->
		  <section class="trainer-list">
		    <h3>추천 트레이너</h3>
		    <ul>
		      <li class="trainer-card">
<%-- 		        <img src="/usr/profile/image/${member.getProfileId() }" alt="트레이너" /> --%>
		        <div class="trainer-info">
		          <h4>홍길동 트레이너</h4>
		          <p>지역: 서울 강남구</p>
		          <p>즐겨찾기 ♥ 21</p>
		          <a href="#">프로필 보기</a>
		        </div>
		      </li>
		      <!-- 반복 -->
		    </ul>
		  </section>
		</div>
	</div>
</section>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6f6670ff91a7e0a774e330ceb23e51a"></script>
<script>
console.log('${lat}');
console.log('${lng}');
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(${lat}, ${lng}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 title 객체 배열입니다 
// var positions = [
//     {
//         title: '카카오', 
//         latlng: new kakao.maps.LatLng(33.450705, 126.570677)
//     },
//     {
//         title: '생태연못', 
//         latlng: new kakao.maps.LatLng(33.450936, 126.569477)
//     },
//     {
//         title: '텃밭', 
//         latlng: new kakao.maps.LatLng(33.450879, 126.569940)
//     },
//     {
//         title: '근린공원',
//         latlng: new kakao.maps.LatLng(33.451393, 126.570738)
//     }
// ];

// 마커 이미지의 이미지 주소입니다
// var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
// for (var i = 0; i < positions.length; i ++) {
    
//     // 마커 이미지의 이미지 크기 입니다
//     var imageSize = new kakao.maps.Size(24, 35); 
    
//     // 마커 이미지를 생성합니다    
//     var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
//     // 마커를 생성합니다
//     var marker = new kakao.maps.Marker({
//         map: map, // 마커를 표시할 지도
//         position: positions[i].latlng, // 마커를 표시할 위치
//         title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
//         image : markerImage // 마커 이미지 
//     });
// }
</script>



<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>