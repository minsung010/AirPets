<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>미세먼지 지도</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f4de4178bee8f55fed343e03f6d0d803"></script>
    <style>
        body, html { margin:0; padding:0; font-family: Arial; height:100vh; }
        #map { width:70%; height:100%; float:left; }
        #sidebar { width:30%; height:100%; float:right; padding:15px; border-left:1px solid #ccc; overflow-y:auto; box-sizing:border-box; }
        #sidebar h3 { margin-top:0; }

        .station-card {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 10px;
            background: #f9f9f9;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .station-card h4 {
            margin: 0 0 5px 0;
            font-size: 16px;
        }
        .air-level {
            position: relative;
            height: 20px;
            border-radius: 6px;
            background-color: #ddd;
            overflow: hidden;
            margin-top: 5px;
        }
        .air-bar {
            height: 100%;
            border-radius: 6px;
            text-align: right;
            padding-right: 5px;
            color: #fff;
            font-size: 12px;
            line-height: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div id="map"></div>

<div id="sidebar">
    <h3 id="regionTitle">지역 선택</h3>
    <div id="stationData">마커를 클릭하면 상세정보가 표시됩니다.</div>
</div>

<script>
var map = new kakao.maps.Map(document.getElementById('map'), { 
    center: new kakao.maps.LatLng(36.5, 127.8), level: 7
});

var regionCenters = {
  "서울": new kakao.maps.LatLng(37.5665, 126.9780),
  "부산": new kakao.maps.LatLng(35.1796, 129.0756),
  "대구": new kakao.maps.LatLng(35.8714, 128.6014),
  "인천": new kakao.maps.LatLng(37.4563, 126.7052),
  "광주": new kakao.maps.LatLng(35.1595, 126.8526),
  "대전": new kakao.maps.LatLng(36.3504, 127.3845),
  "울산": new kakao.maps.LatLng(35.5384, 129.3114),
  "경기": new kakao.maps.LatLng(37.4138, 127.5183),
  "강원": new kakao.maps.LatLng(37.8228, 128.1555),
  "충북": new kakao.maps.LatLng(36.6357, 127.4913),
  "충남": new kakao.maps.LatLng(36.5184, 126.8000),
  "전북": new kakao.maps.LatLng(35.7175, 127.1530),
  "전남": new kakao.maps.LatLng(34.8679, 126.9910),
  "경북": new kakao.maps.LatLng(36.4919, 128.8889),
  "경남": new kakao.maps.LatLng(35.4606, 128.2132),
  "제주": new kakao.maps.LatLng(33.4996, 126.5312),
  "세종": new kakao.maps.LatLng(36.4800, 127.2890)
};

// PM10/O3 색상 및 바 길이 계산
function getPM10Color(value){
    if(value === '-' || value === null) return '#2ecc71';
    value = parseInt(value);
    if(value <= 30) return '#2ecc71';
    else if(value <= 80) return '#f1c40f';
    else if(value <= 150) return '#e67e22';
    else return '#e74c3c';
}

function getO3Color(value){
    if(value === '-' || value === null) return '#3498db';
    value = parseFloat(value);
    if(value <= 0.03) return '#3498db';
    else if(value <= 0.09) return '#9b59b6';
    else if(value <= 0.15) return '#f39c12';
    else return '#c0392b';
}

function getPM10Width(value){
    if(value === '-' || value === null) return 10;
    value = parseInt(value);
    return Math.min(100, (value / 150) * 100); // 최대 150 µg/m³로 조절
}

function getO3Width(value){
    if(value === '-' || value === null) return 10;
    value = parseFloat(value);
    return Math.min(100, (value / 0.15) * 100); // 최대 0.15 ppm으로 조절
}


// 마커 생성
for (let region in regionCenters) {
    let marker = new kakao.maps.Marker({
        position: regionCenters[region],
        map: map
    });

    let infowindow = new kakao.maps.InfoWindow({
        content: "<div style='padding:5px'>" + region + "</div>"
    });

    kakao.maps.event.addListener(marker, 'mouseover', function() {
        infowindow.open(map, marker);
    });
    kakao.maps.event.addListener(marker, 'mouseout', function() {
        infowindow.close();
    });

    kakao.maps.event.addListener(marker, 'click', function() {
        document.getElementById("regionTitle").innerText = region;

        fetch("/air/" + region)
        .then(function(res){
            return res.json();
        })
        .then(function(data){
            if(!data || data.length === 0){
                document.getElementById("stationData").innerText = "데이터가 없습니다.";
                return;
            }

            var html = "";
            data.forEach(function(st){
                html += '<div class="station-card">';
                html += '<h4>' + st.stationName + '</h4>';
                html += '<div>PM10: ' + (st.pm10Value || '-') + ' µg/m³</div>';
                html += '<div class="air-level"><div class="air-bar" style="width:' + getPM10Width(st.pm10Value) + '%; background-color:' + getPM10Color(st.pm10Value) + ';">' + (st.pm10Value || '-') + '</div></div>';
                html += '<div>O3: ' + (st.o3Value || '-') + ' ppm</div>';
                html += '<div class="air-level"><div class="air-bar" style="width:' + getO3Width(st.o3Value) + '%; background-color:' + getO3Color(st.o3Value) + ';">' + (st.o3Value || '-') + '</div></div>';
                html += '</div>';
            });

            document.getElementById("stationData").innerHTML = html;
        })
        .catch(function(err){
            console.error(err);
            document.getElementById("stationData").innerText = "데이터 호출 중 오류 발생";
        });
    });

}
</script>

</body>
</html>

