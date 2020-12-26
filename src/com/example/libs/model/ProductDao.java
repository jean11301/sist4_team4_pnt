package com.example.libs.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
	
	//급변동 리스트
	public static ArrayList<ProductVO> variancelist() throws SQLException {
		Connection conn = DBConnection.getConnection(); // 2,3
		String sql = " with "
				+ " P1 AS ( "
				+ "    select CO.COUNTRY_KR_NAME, P1.product_name, avg(P1.product_price) as P1Data "
				+ "    from product P1, city CI, country CO "
				+ "    WHERE p1.city_number = ci.city_number AND ci.COUNTRY_CODE = CO.COUNTRY_CODE "
				+ "    AND P1.CHECK_STATUS = '1' "
				+ "    group by CO.COUNTRY_KR_NAME, P1.product_name "
				+ " ), "
				+ " P2 AS ( "
				+ "    select CO.COUNTRY_KR_NAME, P2.product_name, AVG(P2.product_price) as P2Data "
				+ "    from product P2, city CI, country CO "
				+ "    WHERE P2.product_date>=TO_CHAR(SYSDATE-7, 'YYYYMMDD') "
				+ "    AND P2.CHECK_STATUS = '1' "
				+ "    AND p2.city_number = ci.city_number AND ci.COUNTRY_CODE = CO.COUNTRY_CODE "
				+ "    group by CO.COUNTRY_KR_NAME, P2.product_name "
				+ " ) "
				+ " select P1.COUNTRY_KR_NAME, P1.product_name, ROUND(P1Data,2) as P1Data, P2.product_name as product_name_1, ROUND(P2Data,2) as P2Data, ROUND((P2Data-P1Data),2) AS P3Data,  ROUND((P2Data/P1Data),2)*100 AS P4Data, ABS(ROUND((P1Data/P2Data)-(P2Data/P1Data),2)) AS P5DATA "
				+ " from P1, P2 "
				+ " where P1.product_name = P2.product_name "
				+ " AND p1.COUNTRY_KR_NAME = p2.COUNTRY_KR_NAME "
				+ " ORDER BY P5Data DESC ";
		Statement stmt = conn.createStatement(); // 4

		ResultSet rs = stmt.executeQuery(sql);
		ArrayList<ProductVO> list2 = new ArrayList<ProductVO>();
		if (rs.next()) {
			do {
				String country_kr_name = rs.getString("country_kr_name");
				String product_name = rs.getString("product_name");
				double product_price_P1Data = rs.getDouble("P1Data");
				String product_name2 = rs.getString("product_name_1");
				double product_price_P2Data = rs.getDouble("P2Data");
				double product_price_P3Data = rs.getDouble("P3Data");
				double product_price_P4Data = rs.getDouble("P4Data");
				double product_price_P5Data = rs.getDouble("P5Data");
				ProductVO popular = new ProductVO(
						country_kr_name, 
						product_name,
						product_price_P1Data, 
						product_name2,
						product_price_P2Data,
						product_price_P3Data,
						product_price_P4Data,
						product_price_P5Data);
				list2.add(popular);
			} while (rs.next());
		} else {
			list2 = null;
		}
		DBClose.close(conn, stmt, rs);
		return list2;
	}

	public static ArrayList<ProductVO> selectProduct(String productname) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql=	  "  SELECT   ROWNUM    AS    sequence ,   country_kr_name,   city_kr_name,    market_kr_name,    product_name,   product_price, product_date,    RPAD(SUBSTR(user_id,1,3), LENGTH(user_id),'*')   AS    user_id    "
							+"  	FROM  product p  INNER JOIN   market  m ON p.market_number = m.market_number  INNER JOIN city  c  ON  m.city_number  =  c.city_number   INNER JOIN country  t  ON  c.country_code = t.country_code   "
							+"     WHERE   product_name = ?  ";
	    PreparedStatement  pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, productname);
	    ResultSet rs = pstmt.executeQuery(sql);
	    ArrayList<ProductVO> list = new ArrayList<ProductVO>();
	    System.out.println(rs);
	    while(rs.next()) {
	    	int sequence = rs.getInt("sequence");
	    	String country_kr_name = rs.getString("country_kr_name");
	    	String city_kr_name = rs.getString("city_kr_name");
	    	String market_kr_name = rs.getString("market_kr_name");
	    	String product_name = rs.getString("product_name");
	    	double product_price = rs.getDouble("product_price");
	    	Date product_date = rs.getDate("product_date");
	    	String user_id = rs.getString("user_id");
//	    	int sequence = rs.getInt(1);
//	    	String country_kr_name = rs.getString(2);
//	    	String city_kr_name = rs.getString(3);
//	    	String market_kr_name = rs.getString(4);
//	    	String product_name = rs.getString(5);
//	    	double product_price = rs.getDouble(6);
//	    	Date product_date = rs.getDate(7);
//	    	String user_id = rs.getString(8);
	        ProductVO product = new ProductVO(sequence, country_kr_name, city_kr_name,  market_kr_name,
	    			product_name,  product_price, product_date, user_id);
	    	list.add(product);
	    	
	    }
	    DBClose.close(conn, pstmt);
		return list;
	}



}
