package com.example.libs.service;

import java.sql.SQLException;
import java.util.ArrayList;

import com.example.libs.model.MemberDao;
import com.example.libs.model.MemberVO;

public class MemberService {
	// SelectService
	public int loginMember(String user_id, String user_password) {
		int key = -2;
		try {
			key = MemberDao.login(user_id, user_password);
		} catch (SQLException e) {
			System.out.println(e);
		}
		return key;
	}

	public MemberVO selectMember(String user_id) {
		MemberVO member = null;
		try {
			member = MemberDao.select(user_id);
		} catch (SQLException e) {
			System.out.println(e);
		}
		return member;
	}

	public ArrayList<MemberVO> selectAll(){
		ArrayList<MemberVO> list = null;
		try {
			list = MemberDao.selectAll();
		} catch (SQLException e) {
			System.out.println(e);
		}
		return list;
	}
	

	
	//중복체크
	public boolean idCheck(String user_id) {
		boolean check = false;
		try {
			check = MemberDao.idCheck(user_id);
		} catch (SQLException e) {
			System.out.println(e);
		}
		return check;
	}

	// InsertService
	public int insertMember(MemberVO member) {
		int row = -1;
		try {
			row = MemberDao.register(member);
		} catch (SQLException e) {
			System.out.println(e);
		}
		return row;
	}
	
	
	//update
	public int updateMember(MemberVO member) {
		int row = -1;
		try {
			row = MemberDao.update(member);
		} catch (SQLException e) {
			System.out.println(e);
		}
		return row;
	}

	
	//delete
	public int deleteMember(String user_id) {
		int row = -1;
		try {
			row = MemberDao.delete(user_id);
		} catch (SQLException e) {
			System.out.println(e);
		}
		return row;
	}
}
