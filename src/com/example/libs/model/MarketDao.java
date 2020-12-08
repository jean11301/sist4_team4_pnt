package com.example.libs.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleTypes;

public class MarketDao {
	public List<MarketVO> selectAll() throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name "
				+ "FROM country INNER JOIN city ON(country.country_code = city.country_code) "
				+ "    INNER JOIN market ON(city.city_number = market.city_number) "
				+ "ORDER BY country_kr_name, city_kr_name, market_kr_name; }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.registerOutParameter(1, OracleTypes.CURSOR);
		cstmt.execute();
		ResultSet rs = (ResultSet) cstmt.getObject(1);
		ArrayList<MarketVO> list = new ArrayList<MarketVO>();
		if (rs.next()) {
			do {
				MarketVO market = new MarketVO(rs.getString("country_kr_name"), rs.getString("city_kr_name"),
						rs.getString("market_kr_name"), rs.getString("market_en_name"));
				list.add(market);
			} while (rs.next());
		} else {
			list = null;
		}
		DBClose.close(conn, cstmt, rs);
		return list;
	}
}
