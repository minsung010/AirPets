<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>지상관측소 지도</title>
    <jsp:include page="/WEB-INF/inc/top.jsp"/>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f4de4178bee8f55fed343e03f6d0d803&libraries=clusterer"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { margin:0; padding:0; font-family: Arial, sans-serif; }

        #contentWrapper {
            display: flex;
            gap: 20px;
            padding: 100px 40px 40px 40px; /* 위쪽 메뉴 공간 확보 */
        }

        #map { flex:2; height:90vh; border:1px solid #ccc; border-radius:8px; }
        #infoBox { flex:1; height:90vh; overflow-y:auto; padding:15px; background:#f7f7f7; border:1px solid #ccc; border-radius:8px; }

        .station-info { border-bottom:1px solid #ccc; padding:10px 0; margin-bottom:10px; }

        .gauge { margin:10px 0; }
        .gauge-label { font-weight:bold; margin-bottom:4px; }
        .gauge-bar { width:100%; height:20px; background:#e0e0e0; border-radius:10px; overflow:hidden; }
        .gauge-fill { height:100%; text-align:center; color:#fff; font-size:12px; line-height:20px; }
        .good { background:#4caf50; }
        .warn { background:#ff9800; }
        .bad  { background:#f44336; }

        .chart-container { margin-top:10px; } /* 그래프 위로 조금 올림 */

        .place-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 16px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            transition: background 0.3s;
        }
        .place-btn:hover {
            background-color: #0056b3;
        }
        
        .place-btn {
    display: inline-block;
    margin-top: 15px;
    padding: 8px 16px;
    background-color: #D9A873; /* 배경색 변경 */
    color: #fff;
    text-decoration: none;
    border-radius: 6px;
    border: none;
    transition: background 0.3s;
	}
	.place-btn:hover {
	    background-color: #8B4513; /* 마우스 오버 시 살짝 어둡게 */
	}
        
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/inc/nav.jsp"/>

<div id="contentWrapper">
    <div id="map"></div>
    <div id="infoBox">
        <h3>마커 클릭 시 상세정보 표시</h3>
    </div>
</div>

<script>
window.onload = function() {
    var map = new kakao.maps.Map(document.getElementById('map'), {
        center: new kakao.maps.LatLng(36.5, 127.5),
        level: 7
    });

    var clusterer = new kakao.maps.MarkerClusterer({ map: map, averageCenter: true, minLevel: 5 });

    fetch('<%=request.getContextPath()%>/air/stations')
        .then(res => res.json())
        .then(stations => {
            var markers = [];
            stations.forEach(st => {
                var marker = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(st.LAT, st.LON),
                    title: st.stationName
                });
                marker.stnId = st.STN_ID;

                kakao.maps.event.addListener(marker, 'click', function() {
                    fetch('<%=request.getContextPath()%>/air/station/' + st.STN_ID)
                        .then(res => res.json())
                        .then(data => showInfo(st, data));
                });

                markers.push(marker);
            });
            clusterer.addMarkers(markers);
        });

    function showInfo(station, data) {
        var container = document.getElementById('infoBox');
        container.innerHTML = '';
        var div = document.createElement('div'); 
        div.className = 'station-info';
        div.innerHTML = '<h3>'+station.stationName+' ('+station.STN_ID+')</h3>';

        function createGauge(label, value, min, max, goodRange, warnRange) {
            var gaugeDiv = document.createElement('div'); 
            gaugeDiv.className = 'gauge';
            var lbl = document.createElement('div'); 
            lbl.className = 'gauge-label';
            lbl.textContent = label + ': ' + (value!=null?value:'-'); 
            gaugeDiv.appendChild(lbl);

            var bar = document.createElement('div'); bar.className = 'gauge-bar';
            var fill = document.createElement('div'); fill.className = 'gauge-fill';
            var percent = (value!=null)?(value-min)/(max-min)*100:0; 
            percent=Math.max(0,Math.min(percent,100)); 
            fill.style.width=percent+'%';

            if(value===null){ fill.classList.add('bad'); fill.textContent='데이터 없음'; }
            else if(value>=goodRange[0] && value<=goodRange[1]) { fill.classList.add('good'); fill.textContent='좋음'; }
            else if(value>=warnRange[0] && value<=warnRange[1]) { fill.classList.add('warn'); fill.textContent='주의'; }
            else { fill.classList.add('bad'); fill.textContent='위험'; }

            bar.appendChild(fill); 
            gaugeDiv.appendChild(bar); 
            return gaugeDiv;
        }

        div.appendChild(createGauge("기온(°C)", parseFloat(data.TA), -10, 40, [10,25],[5,30]));
        div.appendChild(createGauge("습도(%)", parseFloat(data.HM), 0,100,[40,70],[20,80]));
        div.appendChild(createGauge("풍속(m/s)", parseFloat(data.WS), 0,20,[0,5],[5,10]));
        div.appendChild(createGauge("강수량(mm)", parseFloat(data.RN), 0,50,[0,0],[0,1]));
        div.appendChild(createGauge("미세먼지(PM10, 입자10㎛ 이하)", parseFloat(data.PM10),0,150,[0,30],[30,80]));
        div.appendChild(createGauge("초미세먼지(PM2.5, 입자2.5㎛ 이하)", parseFloat(data.PM2_5),0,100,[0,15],[15,35]));

        var advice = document.createElement('p'); 
        advice.innerHTML='<b>산책 정보: '+(data.walkAdvice||'판단 불가')+'</b>';
        div.appendChild(advice);

        var chartContainer = document.createElement('div');
        chartContainer.className = 'chart-container';
        chartContainer.innerHTML = '<canvas id="walkChart" width="300" height="150"></canvas>';
        div.appendChild(chartContainer);

        // 장소 검색 버튼 추가
        var placeBtn = document.createElement('a');
        placeBtn.href = '<%=request.getContextPath()%>/placeList';
        placeBtn.className = 'place-btn';
        placeBtn.textContent = '장소 검색 바로가기';
        div.appendChild(placeBtn);

        container.appendChild(div);

        var ctx = document.getElementById('walkChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['기온', '습도', '풍속', '강수', 'PM10', 'PM2.5'],
                datasets: [{
                    label: '산책 적합도',
                    data: [
                        Math.max(0, 100 - Math.abs(data.TA - 20) * 5),
                        Math.max(0, 100 - Math.abs(data.HM - 60) * 2),
                        Math.max(0, 100 - data.WS * 5),
                        data.RN === 0 ? 100 : 0,
                        Math.max(0, 100 - data.PM10),
                        Math.max(0, 100 - data.PM2_5 * 2)
                    ],
                    backgroundColor: 'rgba(75, 192, 192, 0.7)'
                }]
            },
            options: { scales: { y: { beginAtZero: true, max: 100 } } }
        });
    }
};
</script>
</body>
</html>
