package com.example.libs.model;

public class MemberVO {
	private String user_id; //회원아이디
	private String user_password; //회원비밀번호
	private String user_name; //회원이름, null o
	private String user_email; //회원 이메일, null o
	private int user_point; //포인트, 기본:0
	private String social_root; //소셜연동 플랫폼, null o
	private String flag; //권한, 기본0, 관리자는 1
	private String user_status; //회원상태, 정상 0, 탈퇴 1, 정지 2
	
	
	public MemberVO() {
		this.user_name = "";
		this.user_email = "";
	}   //for Java Bean

	
	public MemberVO(String user_id, String user_password, String user_name, String user_email, int user_point,
			String social_root, String flag, String user_status) {
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_point = user_point;
		this.social_root = social_root;
		this.flag = flag;
		this.user_status = user_status;
	}

	public MemberVO(String user_id, String user_password, String user_name, String user_email, int user_point,
			String social_root, String user_status) {
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_point = user_point;
		this.social_root = social_root;
		this.user_status = user_status;
	}	

	public MemberVO(String user_id, String user_name, String user_email, int user_point,
			String social_root, String user_status) {
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_point = user_point;
		this.social_root = social_root;
		this.user_status = user_status;
	}
	
	public MemberVO(String user_id, String user_password, String user_name, String user_email) {
		this.user_id = user_id;
		this.user_password = user_password;
		this.user_name = user_name;
		this.user_email = user_email;
	}

	public MemberVO(String user_id, String user_name, String user_email) {
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_email = user_email;
	}
	
	public MemberVO(String user_id,  int user_point) {
		this.user_id = user_id;
		this.user_point = user_point;
	}
	

	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getUser_password() {
		return user_password;
	}


	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getUser_email() {
		return user_email;
	}


	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}


	public int getUser_point() {
		return user_point;
	}


	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}


	public String getSocial_root() {
		return social_root;
	}


	public void setSocial_root(String social_root) {
		this.social_root = social_root;
	}


	public String getFlag() {
		return flag;
	}


	public void setFlag(String flag) {
		this.flag = flag;
	}


	public String getUser_status() {
		return user_status;
	}


	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}


}
