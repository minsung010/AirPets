package com.future.my;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.future.my.place.service.PlaceService;
import com.future.my.place.vo.PlaceVO;

@Controller
public class HomeController {

    @Autowired
    private PlaceService placeService;

    @RequestMapping("/")
    public String home(Locale locale, Model model) {

        // 1. 전체 추천 장소 (기본 추천)
        List<PlaceVO> recommendedPlaces = placeService.getRecommendedPlaces(6);

        // 2. 제주 여행지 추천 6개
        List<PlaceVO> jejuTravelPlaces = placeService.getJejuTravelPlaces(6);

        model.addAttribute("recommendedPlaces", recommendedPlaces);
        model.addAttribute("jejuTravelPlaces", jejuTravelPlaces);

        return "home";
    }
}
