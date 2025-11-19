package com.future.my.member.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.future.my.member.service.MemberService;
import com.future.my.member.valid.Regist;
import com.future.my.member.vo.MemberVO;

@Controller
public class MemberController {

    @Value("#{util['file.upload.path']}")
    private String CURR_IMAGE_PATH;

    @Value("#{util['file.download.path']}")
    private String WEB_PATH;

    @Autowired
    MemberService memService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    // 로그인 화면
    @RequestMapping("/loginView")
    public String loginView(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberVO());
        }
        return "member/loginView";
    }

    // 로그인 처리
    @RequestMapping("/loginDo")
    public String loginDo(@ModelAttribute("member") MemberVO vo,
                          HttpSession session,
                          @RequestParam(required = false) Boolean remember,
                          HttpServletResponse res,
                          Model model) {

        try {
            // 관리자 하드코딩 로그인
            if ("admin".equals(vo.getMemId()) && "admin".equals(vo.getMemPw())) {
                MemberVO adminUser = new MemberVO();
                adminUser.setMemId("admin");
                adminUser.setMemNm("관리자");
                adminUser.setAdmin(true); // 관리자 표시
                session.setAttribute("login", adminUser);
                return "redirect:/"; // 로그인 후 홈으로 이동
            }

            // 일반 회원 로그인
            MemberVO user = memService.loginMember(vo);
            if (user == null) {
                model.addAttribute("errorMsg", "아이디가 존재하지 않습니다.");
                model.addAttribute("member", vo);
                return "member/loginView";
            }

            // 비밀번호 확인
            if (!passwordEncoder.matches(vo.getMemPw(), user.getMemPw())) {
                model.addAttribute("errorMsg", "비밀번호가 틀렸습니다.");
                model.addAttribute("member", vo);
                return "member/loginView";
            }

            session.setAttribute("login", user);

            // 쿠키 처리
            if (remember != null && remember) {
                Cookie cookie = new Cookie("rememberId", user.getMemId());
                res.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("rememberId", "");
                cookie.setMaxAge(0);
                res.addCookie(cookie);
            }

            return "redirect:/"; // 로그인 후 홈으로 이동

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "시스템 오류");
            model.addAttribute("member", vo);
            return "member/loginView";
        }
    }

    // 로그아웃
    @RequestMapping("/logoutDo")
    public String logoutDo(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // 회원가입 화면
    @RequestMapping("/registView")
    public String registView(Model model) {
        model.addAttribute("member", new MemberVO());
        return "member/registView";
    }

    // 회원가입 처리
    @RequestMapping("/registDo")
    public String registDo(@Validated(Regist.class) @ModelAttribute("member") MemberVO member,
                           BindingResult result, Model model) {

        // 발리데이션 오류
        if (result.hasErrors()) {
            return "member/registView";
        }

        // 비밀번호 암호화
        member.setMemPw(passwordEncoder.encode(member.getMemPw()));

        try {
            memService.registMember(member);
            model.addAttribute("successMsg", "회원가입 성공! 로그인해주세요.");
            model.addAttribute("member", new MemberVO()); // 로그인 폼 초기화
            return "member/loginView";

        } catch (DuplicateKeyException e) {
            result.rejectValue("memId", "error.member", "이미 있는 아이디입니다.");
            return "member/registView";
        } catch (DataAccessException e) {
            result.rejectValue("memId", "error.member", "잘못된 입력입니다.");
            return "member/registView";
        } catch (Exception e) {
            result.rejectValue("memId", "error.member", "시스템에 문의하세요.");
            return "member/registView";
        }
    }

    // 마이페이지
    @RequestMapping("/mypageView")
    public String mypageView(HttpSession session) {
        if (session.getAttribute("login") == null) {
            return "redirect:/loginView";
        }
        return "member/mypageView";
    }
}
