package com.future.my.member.dao;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.member.vo.MemberVO;

@Mapper
public interface IMemberDAO {
	
	public int registMember(MemberVO vo);
	
	public MemberVO loginMember(MemberVO vo);
	
}
