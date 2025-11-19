package com.future.my.review.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.future.my.review.service.ReviewService;
import com.future.my.review.vo.ReviewVO;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    // 리뷰 목록 (AJAX 또는 include)
    @GetMapping("/list/{placeApiId}")
    public String listReviews(@PathVariable String placeApiId, HttpSession session, Model model) {
        List<ReviewVO> reviews = reviewService.getReviews(placeApiId);
        model.addAttribute("reviews", reviews);

        // 로그인 ID JSP 전달
        String loginId = null;
        Object loginObj = session.getAttribute("login");
        if(loginObj != null) {
            loginId = (loginObj instanceof String)
                      ? (String) loginObj
                      : ((com.future.my.member.vo.MemberVO)loginObj).getMemId();
        }
        model.addAttribute("loginId", loginId); // ★ 꼭 추가
        return "review/reviewList";
    }


    // 리뷰 작성 (AJAX)
    @PostMapping("/add")
    @ResponseBody
    public Map<String,Object> addReview(@RequestParam String placeApiId,
                                        @RequestParam String content,
                                        HttpSession session) {
        Map<String,Object> result = new HashMap<String, Object>();
        Object loginObj = session.getAttribute("login");
        if(loginObj == null) {
            result.put("status","fail");
            result.put("message","로그인 후 작성해주세요.");
            return result;
        }

        String memId = (loginObj instanceof String)
                       ? (String) loginObj
                       : ((com.future.my.member.vo.MemberVO)loginObj).getMemId();

        ReviewVO review = new ReviewVO();
        review.setPlaceApiId(placeApiId);
        review.setMemId(memId);
        review.setContent(content);
        review.setLikes(0);
        review.setDislikes(0);

        reviewService.addReview(review);

        // JSON 응답
        Map<String,Object> reviewData = new HashMap<String, Object>();
        reviewData.put("reviewId", review.getReviewId());
        reviewData.put("memId", review.getMemId());
        reviewData.put("content", review.getContent());
        reviewData.put("createDt", "방금");
        reviewData.put("likes", review.getLikes());
        reviewData.put("dislikes", review.getDislikes());

        result.put("status","success");
        result.put("review", reviewData);

        return result;
    }
    
 // 리뷰 수정
    @PostMapping("/update")
    @ResponseBody
    public Map<String,Object> updateReview(@RequestParam Long reviewId,
                                           @RequestParam String content,
                                           HttpSession session) {
        Map<String,Object> result = new HashMap<String, Object>();
        Object loginObj = session.getAttribute("login");
        if(loginObj == null){
            result.put("status","fail");
            result.put("message","로그인 후 이용해주세요.");
            return result;
        }

        String memId = (loginObj instanceof String)
                       ? (String) loginObj
                       : ((com.future.my.member.vo.MemberVO)loginObj).getMemId();

        ReviewVO review = new ReviewVO();
        review.setReviewId(reviewId);
        review.setMemId(memId);
        review.setContent(content);

        reviewService.editReview(review);

        result.put("status","success");
        result.put("review", review);
        return result;
    }

    // 리뷰 삭제
    @PostMapping("/delete")
    @ResponseBody
    public Map<String,Object> deleteReview(@RequestParam Long reviewId, HttpSession session){
        Map<String,Object> result = new HashMap<String, Object>();
        Object loginObj = session.getAttribute("login");
        if(loginObj == null){
            result.put("status","fail");
            result.put("message","로그인 후 이용해주세요.");
            return result;
        }

        reviewService.removeReview(reviewId);
        result.put("status","success");
        return result;
    }

    // 좋아요
    @PostMapping("/like")
    @ResponseBody
    public Map<String,Object> likeReview(@RequestParam Long reviewId, HttpSession session){
        Map<String,Object> result = new HashMap<String, Object>();
        Object loginObj = session.getAttribute("login");
        if(loginObj == null){
            result.put("status","fail");
            result.put("message","로그인 후 이용해주세요.");
            return result;
        }
        int likes = reviewService.likeReview(reviewId);
        result.put("status","success");
        result.put("likes", likes);
        return result;
    }

    // 싫어요
    @PostMapping("/dislike")
    @ResponseBody
    public Map<String,Object> dislikeReview(@RequestParam Long reviewId, HttpSession session){
        Map<String,Object> result = new HashMap<String, Object>();
        Object loginObj = session.getAttribute("login");
        if(loginObj == null){
            result.put("status","fail");
            result.put("message","로그인 후 이용해주세요.");
            return result;
        }
        int dislikes = reviewService.dislikeReview(reviewId);
        result.put("status","success");
        result.put("dislikes", dislikes);
        return result;
    }
}
