package com.future.my.member.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.future.my.member.dao.IMemberDAO;
import com.future.my.member.vo.MemberVO;

@Service // 비즈니스 로직을 처리하는 계층
public class MemberService {

		@Autowired  // spring 의존성 주입 DI (dependency injection) 자동 처리
		IMemberDAO dao;
		
		public void registMember(MemberVO vo) throws Exception {
			int result = dao.registMember(vo);
			if(result ==0) {
				throw new Exception();
			}
		}
		
		public MemberVO loginMember(MemberVO vo) throws Exception {
			MemberVO result = dao.loginMember(vo);
			if(result == null) {
				throw new Exception();
			}
			return result;
		}
		
}
