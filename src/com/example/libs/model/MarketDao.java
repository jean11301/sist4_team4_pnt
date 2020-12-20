package com.example.libs.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleTypes;

public class MarketDao {
	public static List<MarketVO> selectAllMarket() throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_market_selectAll(?) }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.registerOutParameter(1, OracleTypes.CURSOR);
		cstmt.execute();
		ResultSet rs = (ResultSet) cstmt.getObject(1);
		ArrayList<MarketVO> list = new ArrayList<MarketVO>();
		if (rs.next()) {
			do {
				MarketVO market = new MarketVO(rs.getInt("market_number"), rs.getString("country_kr_name"), rs.getString("city_kr_name"),
						rs.getString("market_kr_name"), rs.getString("market_en_name"), rs.getDouble("latitude"), rs.getDouble("longitude"), rs.getString("market_info"));
				list.add(market);
			} while (rs.next());
		} else {
			list = null;
		}
		DBClose.close(conn, cstmt, rs);
		return list;
	}

	public static MarketVO selectMarket(int market_number) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_market_select(?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setInt(1, market_number);
		cstmt.registerOutParameter(2, OracleTypes.CURSOR);
		cstmt.execute();
		ResultSet rs = (ResultSet) cstmt.getObject(2);
		rs.next();
		MarketVO market = new MarketVO(rs.getString("country_kr_name"), rs.getString("city_kr_name"), rs.getString("market_kr_name"), 
						rs.getString("market_en_name"), rs.getDouble("latitude"), rs.getDouble("longitude"), rs.getString("market_info"));
		DBClose.close(conn, cstmt, rs);
		return market;
	}
	
	public static int insertMarket(MarketVO market) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_market_insert(?, ?, ?, ?, ?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);      //4
		cstmt.setString(1, market.getMarket_kr_name());
		cstmt.setString(2, market.getMarket_en_name());
		cstmt.setDouble(3, market.getLatitude());
		cstmt.setDouble(4, market.getLongitude());
		cstmt.setString(5, market.getCountry_kr_name());
		cstmt.setString(6, market.getCity_kr_name());
		cstmt.setString(7, market.getMarket_info());
		int row = cstmt.executeUpdate();                          //5
		DBClose.close(conn, cstmt);   //6
		return row;
	}

	public static int updateMarket(MarketVO market) throws SQLException{
		Connection conn = DBConnection.getConnection();  //2,3
		String sql = "{ call sp_market_update(?, ?, ?, ?, ?, ?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);    //4
		cstmt.setString(1, market.getMarket_kr_name());
		cstmt.setString(2, market.getMarket_en_name());
		cstmt.setDouble(3, market.getLatitude());
		cstmt.setDouble(4, market.getLongitude());
		cstmt.setString(5, market.getCountry_kr_name());
		cstmt.setString(6, market.getCity_kr_name());
		cstmt.setString(7, market.getMarket_info());
		cstmt.setInt(8, market.getMarket_number());
		int row = cstmt.executeUpdate();
		DBClose.close(conn, cstmt);   //6
		return row;
	}

	public static List<MarketVO> selectPagination(int from, int to) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_market_selectOffset(?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setInt(1, from);
		cstmt.setInt(2, to);
		cstmt.registerOutParameter(3, OracleTypes.CURSOR);
		cstmt.execute();
		ResultSet rs = (ResultSet) cstmt.getObject(3);
		ArrayList<MarketVO> list = new ArrayList<MarketVO>();
		if (rs.next()) {
			do {
				MarketVO market = new MarketVO(rs.getInt("market_number"), rs.getString("country_kr_name"), rs.getString("city_kr_name"),
						rs.getString("market_kr_name"), rs.getString("market_en_name"), rs.getDouble("latitude"), rs.getDouble("longitude"), rs.getString("market_info"));
				list.add(market);
			} while (rs.next());
		} else {
			list = null;
		}
		DBClose.close(conn, cstmt, rs);
		return list;
	}

	public static int deleteMarket(int market_number) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = " DELETE FROM MARKET WHERE market_number = ? ";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, market_number);
		int row = pstmt.executeUpdate();                          //5
		DBClose.close(conn, pstmt);   //6
		return row;
	}
}
