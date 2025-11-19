package com.future.my.member.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.future.my.member.vo.NoticeVO;

@Mapper
public interface INoticeDAO {
    List<NoticeVO> getAllNotices();
    NoticeVO getNotice(int id);
    void insertNotice(NoticeVO notice);
    void updateNotice(NoticeVO notice);
    void deleteNotice(int id);
}
