package com.example.libs.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.example.libs.model.CityVO;
import com.example.libs.model.DBClose;
import com.example.libs.model.DBConnection;

public class CityDao  {

	public static ArrayList<CityVO> selectAll() throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql= " 	SELECT   *    FROM  city ";
		Statement stmt = conn.createStatement();
		ResultSet rs= stmt.executeQuery(sql);
		 ArrayList<CityVO> list = new ArrayList<CityVO>();
		if(rs.next()) {
			do{
				int city_number = rs.getInt("city_number");
				String city_kr_name = rs.getString("city_kr_name");
				String city_en_name = rs.getString("city_en_name");
				int country_code = rs.getInt("country_code");
				CityVO city = new CityVO(city_number,city_kr_name,city_en_name,country_code);
				list.add(city);
		}while(rs.next());
		}else {
			list = null;
		}
		DBClose.close(conn);
		return list;
	}


	public static CityVO select(String cityname) {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql= " 	SELECT    *     FROM   city     WHERE   city_kr_name  =  ? ";
		ResultSet rs = null;
		CityVO city = null;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cityname);
			System.out.println(cityname);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int city_number = rs.getInt("city_number");
				String city_kr_name = rs.getString("city_kr_name");
				String city_en_name = rs.getString("city_en_name");
				int country_code = rs.getInt("country_code");
				city = new CityVO(city_number,city_kr_name,city_en_name,country_code);
				System.out.println(city.toString());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose.close(conn,pstmt);
		return city;
	}


	public static int update(CityVO cityVO) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn =  DBConnection.getConnection();
		String sql = " UPDATE  city  " +
							"SET country_code = ? , city_kr_name = ? , city_en_name = ? "
							+ " WHERE city_number = ? ";
		PreparedStatement  pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, cityVO.getCountry_code());
		pstmt.setString(2, cityVO.getCity_kr_name());
		pstmt.setString(3, cityVO.getCity_en_name());
		pstmt.setInt(4, cityVO.getCity_number());
		
		int row = pstmt.executeUpdate();
		DBClose.close(conn,pstmt);
		return row;
	}


	public static int delete(int city_number) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql =	"   DELETE   FROM    city" 
							+ "   WHERE   city_number = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, city_number);
		
		int row = pstmt.executeUpdate();
		
		DBClose.close(conn,pstmt);

		return row;
	}



	public static int insert(CityVO cityVO) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql= " 	INSERT   INTO  city( city_number,city_kr_name,city_en_name,country_code)"
							+    "  VALUES(?,?,?,?)  ";
		PreparedStatement  pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, cityVO.getCity_number());
		pstmt.setString(2, cityVO.getCity_kr_name());
		pstmt.setString(3, cityVO.getCity_en_name());
		pstmt.setInt(4, cityVO.getCountry_code());
		
		int row = pstmt.executeUpdate();
		DBClose.close(conn,pstmt);
		return row;
	}

}
