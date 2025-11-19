package com.future.my.member.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.future.my.member.service.NoticeService;
import com.future.my.member.vo.MemberVO;
import com.future.my.member.vo.NoticeVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService service;

    // 목록 (모든 사용자 접근 가능)
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("notices", service.getAllNotices());
        return "notice/list";
    }

    // 상세보기
    @GetMapping("/view/{id}")
    public String view(@PathVariable int id, Model model) {
        model.addAttribute("notice", service.getNotice(id));
        return "notice/view";
    }

    // 글쓰기 페이지 (관리자만)
    @GetMapping("/write")
    public String write(HttpSession session) {
        MemberVO login = (MemberVO) session.getAttribute("login");
        if (login == null || !login.isAdmin()) return "redirect:/notice/list";
        return "notice/write"; // write.jsp 하나로 글쓰기/수정 처리
    }

    // 글쓰기 처리
    @PostMapping("/write")
    public String writeDo(NoticeVO notice, HttpSession session) {
        MemberVO login = (MemberVO) session.getAttribute("login");
        if (login == null || !login.isAdmin()) return "redirect:/notice/list";

        notice.setWriter(login.getMemNm()); // 작성자 설정
        service.insertNotice(notice);
        return "redirect:/notice/list";
    }


    // 글 수정 페이지 (관리자만)
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, HttpSession session, Model model) {
        MemberVO login = (MemberVO) session.getAttribute("login");
        if (login == null || !login.isAdmin()) return "redirect:/notice/list";

        model.addAttribute("notice", service.getNotice(id));
        return "notice/write"; // write.jsp 공유
    }

    // 글 수정 처리
    @PostMapping("/edit")
    public String editDo(NoticeVO notice, HttpSession session) {
        MemberVO login = (MemberVO) session.getAttribute("login");
        if (login == null || !login.isAdmin()) return "redirect:/notice/list";

        service.updateNotice(notice);
        return "redirect:/notice/list";
    }

    // 글 삭제 (관리자만)
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, HttpSession session) {
        MemberVO login = (MemberVO) session.getAttribute("login");
        if (login == null || !login.isAdmin()) return "redirect:/notice/list";

        service.deleteNotice(id);
        return "redirect:/notice/list";
    }
}
