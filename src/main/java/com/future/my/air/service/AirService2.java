package com.future.my.air.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class AirService2 {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Random rand = new Random();

    // DB에서 지상관측소 목록 가져오기
    public List<Map<String, Object>> getAllStations() {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(); // 제네릭 명시

        String sql = "SELECT STN_ID, STN_KO, LAT, LON FROM STATION_DATA";
        List<Map<String,Object>> rows = jdbcTemplate.queryForList(sql);

        for (Map<String, Object> row : rows) {
            Map<String, Object> station = new HashMap<String, Object>(); // 제네릭 명시
            station.put("STN_ID", row.get("STN_ID"));
            station.put("stationName", row.get("STN_KO"));
            station.put("LAT", row.get("LAT"));
            station.put("LON", row.get("LON"));
            list.add(station);
        }
        return list;
    }

    // DB에서 지점 상세 정보 가져오기 + 랜덤 기상 데이터 생성
    public Map<String, Object> getStationData(String stnId) {
        String sql = "SELECT STN_ID, STN_KO, LAT, LON, HT, HT_WD, LAU, STN_AD FROM STATION_DATA WHERE STN_ID = ?";
        Map<String,Object> data = jdbcTemplate.queryForMap(sql, new Object[]{stnId});

        double lat = data.get("LAT") != null ? ((Number)data.get("LAT")).doubleValue() : 36.5;
        double temp = generateTemperature(lat);
        data.put("TA", temp);
        data.put("HM", 40 + rand.nextInt(50));
        data.put("WS", rand.nextInt(15));
        data.put("RN", rand.nextInt(5));

        int pm10 = 20 + rand.nextInt(61);
        int pm25 = 10 + rand.nextInt(41);
        data.put("PM10", pm10);
        data.put("PM2_5", pm25);

        int hum = data.get("HM") != null ? ((Number)data.get("HM")).intValue() : 50;
        int wsVal = data.get("WS") != null ? ((Number)data.get("WS")).intValue() : 0;
        int rnVal = data.get("RN") != null ? ((Number)data.get("RN")).intValue() : 0;

        String walkAdvice = calculateWalkAdvice(temp, hum, wsVal, rnVal, pm10, pm25);
        data.put("walkAdvice", walkAdvice);

        return data;
    }

    private double generateTemperature(double lat) {
        double baseTemp = 22.0;
        if(lat > 37.5) baseTemp -= 2;
        if(lat < 35.5) baseTemp += 2;
        return Math.round((baseTemp + (rand.nextDouble() * 4 - 2)) * 10.0) / 10.0;
    }

    private String calculateWalkAdvice(double temp, int hum, int ws, int rn, int pm10, int pm25) {
        List<String> warnings = new ArrayList<String>();
        if(temp < 5 || temp > 30) warnings.add("기온 주의");
        if(hum < 30 || hum > 80) warnings.add("습도 주의");
        if(ws > 10) warnings.add("강풍 주의");
        if(rn > 0) warnings.add("비 주의");
        if(pm10 > 50 || pm25 > 25) warnings.add("미세먼지 주의");

        if(warnings.isEmpty()) return "산책 가능";
        return String.join(", ", warnings);
    }
}
