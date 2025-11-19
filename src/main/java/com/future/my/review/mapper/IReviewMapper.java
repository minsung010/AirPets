package com.future.my.review.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.review.vo.ReviewVO;

@Mapper
public interface IReviewMapper {

    void insertReview(ReviewVO review);

    List<ReviewVO> getReviewsByPlaceId(String placeApiId);

    void updateReview(ReviewVO review);

    void deleteReview(Long reviewId);

    void updateLikeDislike(Map<String,Object> params);

    int getLikes(Long reviewId);

    int getDislikes(Long reviewId);
}



