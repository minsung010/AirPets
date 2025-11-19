package com.future.my.place.service;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.w3c.dom.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import com.future.my.place.vo.PlaceVO;

@Service
public class PlaceService {

    private final String SERVICE_KEY = "8a5d31e2-e704-437c-a43f-706b241c3dbc";
    private final String BASE_URL = "https://api.kcisa.kr/openapi/API_TOU_050/request";

    // API 결과를 담을 클래스
    public static class PlaceResult {
        private List<PlaceVO> places;
        private int totalCount;

        public PlaceResult(List<PlaceVO> places, int totalCount) {
            this.places = places;
            this.totalCount = totalCount;
        }

        public List<PlaceVO> getPlaces() { return places; }
        public int getTotalCount() { return totalCount; }
    }

    // 검색 기능 (키워드 + 카테고리 + 페이지 + 페이지크기)
    public PlaceResult searchPlaces(String keyword, String category, int page, int pageSize) {
        List<PlaceVO> places = new ArrayList<PlaceVO>();
        int totalCount = 0;

        try {
            StringBuilder urlBuilder = new StringBuilder(BASE_URL)
                    .append("?serviceKey=").append(URLEncoder.encode(SERVICE_KEY, "UTF-8"))
                    .append("&numOfRows=").append(pageSize)
                    .append("&pageNo=").append(page);

            if (keyword != null && !keyword.isEmpty()) {
                urlBuilder.append("&keyword=").append(URLEncoder.encode(keyword, "UTF-8"));
            }
            if (category != null && !category.isEmpty()) {
                urlBuilder.append("&category=").append(URLEncoder.encode(category, "UTF-8"));
            }

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/xml");

            InputStream is = (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300)
                    ? conn.getInputStream()
                    : conn.getErrorStream();

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(is);
            doc.getDocumentElement().normalize();

            // totalCount 읽기
            NodeList totalCountNode = doc.getElementsByTagName("totalCount");
            if (totalCountNode.getLength() > 0) {
                totalCount = Integer.parseInt(totalCountNode.item(0).getTextContent());
            }

            NodeList itemList = doc.getElementsByTagName("item");
            for (int i = 0; i < itemList.getLength(); i++) {
                Node node = itemList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element elem = (Element) node;
                    PlaceVO place = new PlaceVO();

                    place.setTitle(getTagValue("title", elem));
                    place.setIssuedDate(getTagValue("issuedDate", elem));
                    place.setCategory1(getTagValue("category1", elem));
                    place.setCategory2(getTagValue("category2", elem));
                    place.setCategory3(getTagValue("category3", elem));
                    place.setDescription(getTagValue("description", elem));
                    place.setTel(getTagValue("tel", elem));
                    place.setUrl(getTagValue("url", elem));
                    place.setAddress(getTagValue("address", elem));
                    place.setCoordinates(getTagValue("coordinates", elem));
                    place.setCharge(getTagValue("charge", elem));

                    places.add(place);
                }
            }

            conn.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new PlaceResult(places, totalCount);
    }

    // XML에서 특정 태그 값 가져오기
    private String getTagValue(String tag, Element element) {
        NodeList nl = element.getElementsByTagName(tag);
        if (nl.getLength() > 0 && nl.item(0).getFirstChild() != null) {
            return nl.item(0).getFirstChild().getNodeValue();
        }
        return "";
    }

    // 상세보기 (제목으로 검색)
    public PlaceVO getPlaceByTitle(String title, String keyword, String category) {
        PlaceResult result = searchPlaces(title, category, 1, 1);
        List<PlaceVO> list = result.getPlaces();
        return (list.isEmpty()) ? null : list.get(0);
    }

    // 추천 장소 (첫 페이지에서 count개 가져오기)
    public List<PlaceVO> getRecommendedPlaces(int count) {
        PlaceResult result = searchPlaces("", "", 1, count);
        return result.getPlaces();
    }

    // 제주 여행지 추천 6개 가져오기
    public List<PlaceVO> getJejuTravelPlaces(int count) {
        PlaceResult result = searchPlaces("제주", "여행지", 1, count);
        return result.getPlaces();
    }
}
