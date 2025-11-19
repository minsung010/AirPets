package com.future.my.review.vo;

import java.util.Date;

public class ReviewVO {

    private Long reviewId;      // Oracle NUMBER -> Long
    private String placeApiId;  // 장소 고유 ID
    private String memId;       // 작성자
    private String content;     // 리뷰 내용
    private int likes;
    private int dislikes;
    private Date createDt;
    private Date updateDt;

    // Getter & Setter
    public Long getReviewId() { return reviewId; }
    public void setReviewId(Long reviewId) { this.reviewId = reviewId; }

    public String getPlaceApiId() { return placeApiId; }
    public void setPlaceApiId(String placeApiId) { this.placeApiId = placeApiId; }

    public String getMemId() { return memId; }
    public void setMemId(String memId) { this.memId = memId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public int getDislikes() { return dislikes; }
    public void setDislikes(int dislikes) { this.dislikes = dislikes; }

    public Date getCreateDt() { return createDt; }
    public void setCreateDt(Date createDt) { this.createDt = createDt; }

    public Date getUpdateDt() { return updateDt; }
    public void setUpdateDt(Date updateDt) { this.updateDt = updateDt; }
	@Override
	public String toString() {
		return "ReviewVO [reviewId=" + reviewId + ", placeApiId=" + placeApiId + ", memId=" + memId + ", content="
				+ content + ", likes=" + likes + ", dislikes=" + dislikes + ", createDt=" + createDt + ", updateDt="
				+ updateDt + "]";
	}
    
    
}
