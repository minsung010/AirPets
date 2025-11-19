package com.future.my.member.vo;

import com.future.my.member.valid.Regist;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class MemberVO {
	
	@NotEmpty(message="아이디 필수", groups= {Regist.class})
	private String memId;                   /*회원 아이디*/
	@Pattern(regexp="^\\w{4,10}$", message="패스워드는 영문 숫자 4 ~ 10",groups= {Regist.class})
    private String memPw;                   /*회원 비밀번호*/
	@Size(min=1, max=20, message="이름 20자 내외로!", groups= {Regist.class})
    private String memNm;                   /*회원 이름*/
    private String memGender;    			/*회원 성별 (M/F)*/
    private String memAddr;                 /*회원 주소*/
    private String memPhone;                /*회원 전화번호*/
    private String profileImg;              /*회원 프로필사진*/
    private boolean admin;
    
	public MemberVO() {
		
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemPw() {
		return memPw;
	}

	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}

	public String getMemNm() {
		return memNm;
	}

	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}

	public String getMemGender() {
		return memGender;
	}

	public void setMemGender(String memGender) {
		this.memGender = memGender;
	}

	public String getMemAddr() {
		return memAddr;
	}

	public void setMemAddr(String memAddr) {
		this.memAddr = memAddr;
	}

	public String getMemPhone() {
		return memPhone;
	}

	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	
	public boolean isAdmin() {
	    return "admin".equals(this.memId);
	}


    public void setAdmin(boolean admin) { this.admin = admin; }

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPw=" + memPw + ", memNm=" + memNm + ", memGender=" + memGender
				+ ", memAddr=" + memAddr + ", memPhone=" + memPhone + ", profileImg=" + profileImg + "]";
	}
	
    
	
	
}
