package com.example.libs.model;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductDao {

	//인기 검색 종목 물가
	public static ArrayList<ProductVO> popularlist() throws SQLException {
		Connection conn = DBConnection.getConnection(); // 2,3
		String sql = " SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price  "
				+ " FROM country, city, market, product  "
				+ " WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number "
				+ " ORDER BY sequence DESC ";
		Statement stmt = conn.createStatement(); // 4

		ResultSet rs = stmt.executeQuery(sql);
		ArrayList<ProductVO> list = new ArrayList<ProductVO>();
		if (rs.next()) {
			do {
				String country_kr_name = rs.getString("country_kr_name");
				String city_kr_name = rs.getString("city_kr_name");
				String market_kr_name = rs.getString("market_kr_name");
				String product_name = rs.getString("product_name");
				double product_price = rs.getDouble("product_price");

				ProductVO popular = new ProductVO(country_kr_name, city_kr_name, market_kr_name, product_name,
						product_price);
				list.add(popular);
			} while (rs.next());
		} else {
			list = null;
		}
		DBClose.close(conn, stmt, rs);
		return list;
	}
}
