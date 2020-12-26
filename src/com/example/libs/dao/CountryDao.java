package com.example.libs.dao;

import java.io.BufferedInputStream;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.example.libs.model.CountryVO;
import com.example.libs.model.DBClose;
import com.example.libs.model.DBConnection;


public class CountryDao {
	public static ArrayList<CountryVO> selectAll() throws SQLException{
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql= " 	SELECT  *    FROM   country ";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		 ArrayList<CountryVO> list = new ArrayList<CountryVO>();
		 if(rs.next()){
			do{
				int country_code = rs.getInt("country_code");
				String country_kr_name = rs.getString("country_kr_name");
				String country_en_name =  rs.getString("country_en_name");
				CountryVO country = new CountryVO(country_code, country_kr_name ,country_en_name);
				list.add(country);
			}while(rs.next());
		} else  {
			list = null;
		}
		DBClose.close(conn,stmt);
		return list;
	}

	public static CountryVO select(String countryname) {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql= " 	SELECT *  FROM country  WHERE country_kr_name = ? ";
		ResultSet rs = null;
		CountryVO country = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, countryname);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int country_number = rs.getInt("country_code");
				String country_kr_name = rs.getString("country_kr_name");
				String country_en_name = rs.getString("country_en_name");
				country = new CountryVO(country_number,country_kr_name,country_en_name);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose.close(conn);
		return country;
	}
	

	public static int update(CountryVO countryVO) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn =  DBConnection.getConnection();
		String sql = "  UPDATE  country  " +
							"  SET  country_kr_name = ? , country_en_name = ? "
							+ "   WHERE country_code = ? ";
		PreparedStatement  pstmt = conn.prepareStatement(sql);
		pstmt.setInt(3, countryVO.getCountry_code());
		pstmt.setString(1, countryVO.getCountry_kr_name());
		pstmt.setString(2, countryVO.getCountry_en_name());

		int row = pstmt.executeUpdate();
		DBClose.close(conn,pstmt);
		return row;
	}

	public static int delete(int country_code) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql = "DELETE   FROM    country" +
							"   WHERE   country_code = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, country_code);
		
		int row = pstmt.executeUpdate();
		DBClose.close(conn,pstmt);
		return row;
	}


	public static int insert(CountryVO countryVO) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql= " 	INSERT   INTO  country( country_code,country_kr_name,country_en_name,country_flag_img)"
							+    "  VALUES(?,?,?,null)  ";
		PreparedStatement  pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, countryVO.getCountry_code());
		pstmt.setString(2, countryVO.getCountry_kr_name());
		pstmt.setString(3, countryVO.getCountry_en_name());

		int row = pstmt.executeUpdate();
		DBClose.close(conn,pstmt);
		return row;
	}

}