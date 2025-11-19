package com.future.my.review.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.review.mapper.IReviewMapper;
import com.future.my.review.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private IReviewMapper reviewMapper;

    @Override
    public void addReview(ReviewVO review) {
        reviewMapper.insertReview(review);
    }

    @Override
    public List<ReviewVO> getReviews(String placeApiId) {
        return reviewMapper.getReviewsByPlaceId(placeApiId);
    }

    @Override
    public void editReview(ReviewVO review) {
        reviewMapper.updateReview(review);
    }

    @Override
    public void removeReview(Long reviewId) {
        reviewMapper.deleteReview(reviewId);
    }

    @Override
    public int likeReview(Long reviewId) {
        Map<String,Object> params = new HashMap<String, Object>();
        params.put("reviewId", reviewId);
        params.put("type", "like");
        reviewMapper.updateLikeDislike(params);
        return reviewMapper.getLikes(reviewId);
    }

    @Override
    public int dislikeReview(Long reviewId) {
        Map<String,Object> params = new HashMap<String, Object>();
        params.put("reviewId", reviewId);
        params.put("type", "dislike");
        reviewMapper.updateLikeDislike(params);
        return reviewMapper.getDislikes(reviewId);
    }
}
