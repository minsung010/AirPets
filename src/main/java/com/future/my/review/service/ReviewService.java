package com.future.my.review.service;

import java.util.List;
import com.future.my.review.vo.ReviewVO;

public interface ReviewService {
    void addReview(ReviewVO review);
    List<ReviewVO> getReviews(String placeApiId);
    void editReview(ReviewVO review);
    void removeReview(Long reviewId);
    int likeReview(Long reviewId);
    int dislikeReview(Long reviewId);
}
