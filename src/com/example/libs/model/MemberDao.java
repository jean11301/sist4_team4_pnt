package com.example.libs.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleTypes;

public class MemberDao {
	//회원가입
	public static int register(MemberVO member) throws SQLException {
		Connection conn = DBConnection.getConnection(); 
		String sql = "{ call sp_member_insert(?,?,?,?) }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setString(1, member.getUser_id());
		cstmt.setString(2, member.getUser_password());
		cstmt.setString(3, member.getUser_name());
		cstmt.setString(4, member.getUser_email());
		int row = cstmt.executeUpdate();
		DBClose.close(conn, cstmt);
		return row;
	}
	
	//로그인
	//-1 : 존재하지 않는 아이디이다.    0 : 아이디는 있으나 비밀번호가 일치하지 않는다.    1 : 모두 일치한다.
	public static int login(String user_id, String user_password) throws SQLException{
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_member_login(?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setString(1, user_id);
		cstmt.registerOutParameter(2, OracleTypes.CURSOR);
		cstmt.execute();
		Object obj = cstmt.getObject(2);
		ResultSet rs = (ResultSet)obj;
		int key = -2;
		if(rs.next()) {   //아이디에 맞는 비밀번호를 가져왔다면
			String db_passwd = rs.getString("user_password");
			if(db_passwd.trim().equals(user_password.trim())) {
				key = 1;   //모두 일치
			}else {
				key = 0;  //비밀번호 불일치
			}
		}else {   //아예 그런 아이디가 없다면
			key = -1;
		}
		DBClose.close(conn, cstmt);
		return key;
	}
	
	public static MemberVO select(String user_id) throws SQLException{
		Connection conn = DBConnection.getConnection();  //2,3 
		String sql = "{ call sp_member_select(?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);    //4
		cstmt.setString(1, user_id);
		cstmt.registerOutParameter(2, OracleTypes.CURSOR);
		cstmt.execute();   //5. 매우 주의하자.
		ResultSet rs = (ResultSet)cstmt.getObject(2);
		rs.next();             //6
		MemberVO member = new MemberVO(user_id, null, 
				  rs.getString("user_name"), rs.getString("user_email"), rs.getInt("user_point"),
				  rs.getString("social_root"), rs.getString("authority"), rs.getString("user_status"));
		DBClose.close(conn, cstmt, rs);  //7
		return member;
	}
	
	public static int delete(String user_id) throws SQLException{
		Connection conn = DBConnection.getConnection();  //2,3
		String sql = "{ call sp_member_delete(?) }";
		CallableStatement cstmt = conn.prepareCall(sql);    //4
		cstmt.setString(1, user_id);
		int row = cstmt.executeUpdate();
		DBClose.close(conn, cstmt);   //6
		return row;
	}
	
	public static int update(MemberVO member) throws SQLException{
		Connection conn = DBConnection.getConnection();  //2,3
		String sql = "{ call sp_member_update(?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);    //4
		cstmt.setString(1, member.getUser_id());
		cstmt.setString(2, member.getUser_name());
		cstmt.setString(3, member.getUser_email());
		int row = cstmt.executeUpdate();
		DBClose.close(conn, cstmt);   //6
		return row;
	}
	
	public static ArrayList<MemberVO> selectAll() throws SQLException{
		Connection conn = DBConnection.getConnection(); 
		String sql = "{ call sp_member_select_all(?) }";
		CallableStatement cstmt = conn.prepareCall(sql);   
		cstmt.registerOutParameter(1, OracleTypes.CURSOR);
		cstmt.execute(); 
		ResultSet rs = (ResultSet)cstmt.getObject(1);
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		while(rs.next()) {
			MemberVO member = 
					new MemberVO(rs.getString("user_id"), "", rs.getString("user_name"),rs.getString("user_email"), rs.getInt("user_point"), rs.getString("social_root"), rs.getString("user_status"));
			member.setUser_name(rs.getString("user_name"));
			member.setUser_email(rs.getString("user_email"));
			list.add(member);
		}
		DBClose.close(conn, cstmt, rs);   //7
		return list;
	}
	
	//아이디 중복 검사
	//이미 있는 계정이어서 사용할 수 없으면 false, 사용할 수 있는 계정이면 true
	public static boolean idCheck(String user_id) throws SQLException{
		Connection conn = DBConnection.getConnection();  //2,3 
		String sql = "{ call sp_member_idcheck(?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);    //4
		cstmt.setString(1, user_id);
		cstmt.registerOutParameter(2, OracleTypes.CURSOR);
		cstmt.execute();   //매우 주의하자.        //5
		ResultSet rs = (ResultSet)cstmt.getObject(2);     
		boolean check = false;
		if(rs.next()) check = false;   //사용할 수 없다는 뜻
		else check = true;   //사용할 수 있다는 뜻
		DBClose.close(conn, cstmt, rs);
		return check;
	}
	


	
}




