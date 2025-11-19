package com.future.my.air.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class AirService {
	/**
	 * 시/도별 실시간 측정소 데이터 조회
	 */
/*
    private final String SERVICE_KEY = "J/V9rdiKGfIi9Mri+oREXTpSjVuLijqpdxaTbcD5SAIB03ZoQvvxvVtY07tk4kacTK3pXxc5WgPezxoR8O7bDA==";
    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper mapper = new ObjectMapper();

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getSidoAirQualityList(String sidoName) {
        if (sidoName == null || sidoName.isEmpty()) sidoName = "대전";

        try {
            String url = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty" +
                    "?serviceKey=" + SERVICE_KEY +
                    "&sidoName=" + sidoName +
                    "&numOfRows=100&pageNo=1&returnType=json";

            String response = restTemplate.getForObject(url, String.class);

            // JSON 아닌 경우 예외 처리
            if (response == null || !response.trim().startsWith("{")) {
                System.out.println("API 오류 또는 JSON 아님: " + response);
                return Collections.emptyList();
            }

            Map<String, Object> jsonMap = mapper.readValue(response, Map.class);
            Map<String, Object> responseMap = (Map<String, Object>) jsonMap.get("response");
            if (responseMap == null) return Collections.emptyList();

            Map<String, Object> body = (Map<String, Object>) responseMap.get("body");
            if (body == null) return Collections.emptyList();

            Object items = body.get("items");
            if (items instanceof List) {
                return (List<Map<String, Object>>) items;
            } else if (items instanceof Map) {
                return Collections.singletonList((Map<String, Object>) items);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return Collections.emptyList();
    }
*/
}
