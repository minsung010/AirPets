package com.future.my.member.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.future.my.member.dao.INoticeDAO;
import com.future.my.member.vo.NoticeVO;

@Service
public class NoticeService {

    @Autowired
    private INoticeDAO dao;

    public List<NoticeVO> getAllNotices() {
        return dao.getAllNotices();
    }

    public NoticeVO getNotice(int id) {
        return dao.getNotice(id);
    }

    public void insertNotice(NoticeVO notice) {
        dao.insertNotice(notice);
    }

    public void updateNotice(NoticeVO notice) {
        dao.updateNotice(notice);
    }

    public void deleteNotice(int id) {
        dao.deleteNotice(id);
    }
}
