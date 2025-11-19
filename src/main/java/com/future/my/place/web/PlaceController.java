package com.future.my.place.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.future.my.place.service.PlaceService;
import com.future.my.place.service.PlaceService.PlaceResult;
import com.future.my.place.vo.PlaceVO;
import com.future.my.review.service.ReviewService;
import com.future.my.review.vo.ReviewVO;

@Controller
public class PlaceController {

    private final PlaceService placeService;
    private final ReviewService reviewService; // 리뷰 서비스 주입

    // 생성자 주입
    public PlaceController(PlaceService placeService, ReviewService reviewService) {
        this.placeService = placeService;
        this.reviewService = reviewService;
    }

    // 장소 목록 페이지
    @GetMapping("/placeList")
    public String placeList(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String category,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {

        int pageSize = 15;       // 한 페이지당 보여줄 데이터 수
        int pageBlock = 5;       // 한 블록당 보여줄 페이지 수

        PlaceResult result = placeService.searchPlaces(keyword, category, page, pageSize);
        List<PlaceVO> places = result.getPlaces();
        int totalCount = result.getTotalCount();

        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 블록 계산
        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPages) endPage = totalPages;

        model.addAttribute("places", places);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("pageBlock", pageBlock);

        return "place/placeList";
    }

    // 장소 상세 페이지
    @GetMapping("/placeDetail")
    public String placeDetail(@RequestParam String title,
                              @RequestParam(required = false, defaultValue="") String keyword,
                              @RequestParam(required = false, defaultValue="") String category,
                              Model model) {
        PlaceVO place = placeService.getPlaceByTitle(title, keyword, category);

        if (place == null) {
            model.addAttribute("placeDetail", new PlaceVO());
            model.addAttribute("errorMessage", "해당 장소 정보를 찾을 수 없습니다.");
        } else {
            model.addAttribute("placeDetail", place);

            // 리뷰 불러오기 (title을 placeApiId처럼 사용)
            List<ReviewVO> reviews = reviewService.getReviews(place.getTitle());
            model.addAttribute("reviews", reviews);
        }

        return "place/placeDetailView";
    }

}
