package com.future.my.member.vo;

import java.util.Date;

public class NoticeVO {
    private int id;
    private String title;
    private String content;
    private Date regDate;
    private String writer; // 작성자 추가

    // getter/setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getRegDate() { return regDate; }
    public void setRegDate(Date regDate) { this.regDate = regDate; }

    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }
}
