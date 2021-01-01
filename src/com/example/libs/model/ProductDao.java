package com.example.libs.model;

import java.sql.Connection;

import java.sql.Date;
import java.sql.Statement;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleTypes;

public class ProductDao {

	//인기 검색 종목 물가
	public static ArrayList<ProductVO> popularlist() throws SQLException {
		Connection conn = DBConnection.getConnection(); // 2,3
		String sql = " SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price  "
				+ " FROM country, city, market, product  "
				+ " WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number AND check_status = 1  "
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
				+ "    WHERE P2.product_date>=TO_CHAR((SELECT MAX(product_date) FROM product)-14, 'YYYYMMDD') "
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


	public static ArrayList<ProductVO> selectProduct(String productname, String marketname) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = DBConnection.getConnection();
		String sql=	  "   SELECT   ROWNUM    AS    sequence ,   country_kr_name,   city_kr_name,    market_kr_name,    product_name,   product_price, product_date,    RPAD(SUBSTR(user_id,1,3), LENGTH(user_id),'*')   AS    user_id   "
				+ "      FROM  country   INNER JOIN   city  ON country.country_code = city.country_code  INNER JOIN market ON city.city_number  = market.city_number  INNER JOIN  product ON market.market_number = product.market_number   "
				+ "      WHERE  product.product_name = ?  AND  market.market_kr_name = ? ";
	    PreparedStatement  pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, productname);
	    pstmt.setString(2, marketname);
	    ResultSet rs = pstmt.executeQuery();
	    ArrayList<ProductVO> list = new ArrayList<ProductVO>();
	    if(rs.next()) {
	    	do {
	    		int sequence = rs.getInt("sequence");
		    	String country_kr_name = rs.getString("country_kr_name");
		    	String city_kr_name = rs.getString("city_kr_name");
		    	String market_kr_name = rs.getString("market_kr_name");
		    	String product_name = rs.getString("product_name");
		    	double product_price = rs.getDouble("product_price");
		    	Date product_date = rs.getDate("product_date");
		    	String user_id = rs.getString("user_id");
		    	System.out.println(sequence+country_kr_name+city_kr_name+ market_kr_name  +
			    			product_name+product_price+product_date+user_id);
//		    	int sequence = Integer.parseInt(rs.getString(1));
//		    	String country_kr_name = rs.getString(2);
//		    	String city_kr_name = rs.getString(3);
//		    	String market_kr_name = rs.getString(4);
//		    	String product_name = rs.getString(5);
//		    	double product_price = rs.getDouble(6);
//		    	Date product_date = rs.getDate(7);
//		    	String user_id = rs.getString(8);
		    	 ProductVO product = new ProductVO(sequence, country_kr_name, city_kr_name,  market_kr_name,
			    			product_name,  product_price, product_date, user_id);
		    	 list.add(product);
	    	}while(rs.next());
	    }else
	     {
	    	list = null;
	    }
	    DBClose.close(conn, pstmt);
		return list;
	}

	public static List<ProductVO> selectAllProduct() throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_product_selectAll(?) }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.registerOutParameter(1, OracleTypes.CURSOR);
		cstmt.execute();
		ResultSet rs = (ResultSet) cstmt.getObject(1);
		ArrayList<ProductVO> list = new ArrayList<ProductVO>();
		if (rs.next()) {
			do {
				ProductVO product = new ProductVO(rs.getInt("product_number"), rs.getString("check_status"), rs.getDate("product_date"), rs.getString("country_kr_name"), rs.getString("city_kr_name"),
						rs.getString("market_kr_name"), rs.getString("product_name"), rs.getInt("product_price"), rs.getString("product_img"), rs.getString("user_id"), rs.getInt("sequence"));
				list.add(product);
			} while (rs.next());
		} else {
			list = null;
		}
		DBClose.close(conn, cstmt, rs);
		return list;
	}
	//이미지가 있을 경우 이미지 코드까지 삽입
	public static int insertProduct(ProductVO product) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_product_insert(?, ?, ?, ?, ?, ?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);      //4
		cstmt.setString(1, product.getProduct_name());
		cstmt.setDouble(2, product.getProduct_price());
		cstmt.setString(3, product.getProduct_img());
		cstmt.setInt(4, product.getSequence());
		cstmt.setString(5, product.getCheck_status());
		cstmt.setString(6, product.getCity_kr_name());
		cstmt.setString(7, product.getMarket_kr_name());
		cstmt.setString(8, product.getUser_id());
		int row = cstmt.executeUpdate();                          //5
		DBClose.close(conn, cstmt);   //6
		return row;
	}
	//이미작 없을 경우 이미지 코드를 삽입하지 않아서 SQL에서 자동으로 default값이 삽입
	public static int insertProduct(ProductVO product, int image) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_product_insert_noimage(?, ?, ?, ?, ?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);      //4
		cstmt.setString(1, product.getProduct_name());
		cstmt.setDouble(2, product.getProduct_price());
		cstmt.setInt(3, product.getSequence());
		cstmt.setString(4, product.getCheck_status());
		cstmt.setString(5, product.getCity_kr_name());
		cstmt.setString(6, product.getMarket_kr_name());
		cstmt.setString(7, product.getUser_id());
		int row = cstmt.executeUpdate();                          //5
		DBClose.close(conn, cstmt);   //6
		return row;
	}
	
	public static ProductVO selectProduct(int product_number) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_product_select(?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setInt(1, product_number);
		cstmt.registerOutParameter(2, OracleTypes.CURSOR);
		cstmt.execute();
		ResultSet rs = (ResultSet) cstmt.getObject(2);
		rs.next();
		ProductVO product = new ProductVO(rs.getInt("product_number"), rs.getString("check_status"), rs.getDate("product_date"), rs.getString("country_kr_name"), 
						rs.getString("city_kr_name"), rs.getString("market_kr_name"), rs.getString("product_name"), rs.getInt("product_price"), 
						rs.getString("product_img"), rs.getString("user_id"), rs.getInt("sequence"));
		DBClose.close(conn, cstmt, rs);
		return product;
	}
	
	public static int updateProduct(ProductVO product) throws SQLException {
		Connection conn = DBConnection.getConnection();  //2,3
		System.out.println("이미지 있음\n" + product.getProduct_number());
		System.out.println(product.getCheck_status());
		System.out.println(product.getCountry_kr_name());
		System.out.println(product.getCity_kr_name());
		System.out.println(product.getMarket_kr_name());
		System.out.println(product.getProduct_name());
		System.out.println(product.getProduct_price());
		String sql = "{ call sp_product_update(?, ?, ?, ?, ?, ?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);    //4
		cstmt.setInt(1, product.getProduct_number());
		cstmt.setString(2, product.getCheck_status());
		cstmt.setString(3, product.getCountry_kr_name());
		cstmt.setString(4, product.getCity_kr_name());
		cstmt.setString(5, product.getMarket_kr_name());
		cstmt.setString(6, product.getProduct_name());
		cstmt.setInt(7, (int) product.getProduct_price());
		cstmt.setString(8, product.getProduct_img());
		int row = cstmt.executeUpdate();
		DBClose.close(conn, cstmt);   //6
		return row;
	}
	
	public static int updateProduct(ProductVO product, int image) throws SQLException {
		Connection conn = DBConnection.getConnection();  //2,3
		System.out.println("이미지 없음\n" + product.getProduct_number());
		System.out.println(product.getCheck_status());
		System.out.println(product.getCountry_kr_name());
		System.out.println(product.getCity_kr_name());
		System.out.println(product.getMarket_kr_name());
		System.out.println(product.getProduct_name());
		System.out.println(product.getProduct_price());
		String sql = "{ call sp_product_update_noimage(?, ?, ?, ?, ?, ?, ?) }";
		CallableStatement cstmt = conn.prepareCall(sql);    //4
		cstmt.setInt(1, product.getProduct_number());
		cstmt.setString(2, product.getCheck_status());
		cstmt.setString(3, product.getCountry_kr_name());
		cstmt.setString(4, product.getCity_kr_name());
		cstmt.setString(5, product.getMarket_kr_name());
		cstmt.setString(6, product.getProduct_name());
		cstmt.setInt(7, (int) product.getProduct_price());
		int row = cstmt.executeUpdate();
		DBClose.close(conn, cstmt);   //6
		return row;
	}
	
	
	
	public static int getTotalCount() throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = "{ call sp_product_selectCount(?) }"; 
		CallableStatement cstmt = conn.prepareCall(sql); 
		cstmt.registerOutParameter(1, OracleTypes.NUMBER);
		cstmt.execute(); 
		int count = cstmt.getInt(1);
		 
		DBClose.close(conn, cstmt);
		return count;
	}

	
	public static int deleteProduct(int product_number) throws SQLException {
		Connection conn = DBConnection.getConnection();
		String sql = " DELETE FROM product WHERE product_number = ? ";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, product_number);
		int row = pstmt.executeUpdate();                          //5
		DBClose.close(conn, pstmt);   //6
		return row;
	}
	
	//물가리스트 검색 결과
	public static List<ProductVO> productSearchResult(String beginDate, String endDate, String searchWithRegion,
			String regionKeyword, String searchWithProduct, String productKeyword) throws SQLException {
		Connection conn = DBConnection.getConnection();
		System.out.println(beginDate);
		System.out.println(endDate);
		System.out.println(searchWithRegion);
		System.out.println(regionKeyword);
		System.out.println(searchWithProduct);
		System.out.println(productKeyword);
		String where1 = "";
		
		if(beginDate == "" && endDate == "") {
			where1 = " ";
		}else if(beginDate == " " && endDate != " ") {
			where1 = "(product_date < '" + endDate + "' ) ";
		}else if(beginDate != " " && endDate == "") {
			where1 = "(product_date > '" + beginDate + "' ) ";
		}else {
			where1 = "(product_date BETWEEN '" + beginDate + "' AND '" + endDate + "' ) ";
		}
		System.out.println(where1);
		String where2 = " ";
		if(searchWithRegion.equals("all")){
				if(regionKeyword == " ") {where2 = " ";
				}else {where2 = "(country.country_kr_name LIKE CONCAT(CONCAT('%', '" + regionKeyword + "'), '%') OR " + 
						" city.city_kr_name LIKE CONCAT(CONCAT('%', '" + regionKeyword + "'), '%')  OR" + 
						" market.market_kr_name LIKE CONCAT(CONCAT('%', '" + regionKeyword + "'), '%') ) ";
				}
		}else if(searchWithRegion.equals("country_kr_name")) {
				if(regionKeyword == " ") where2 = "country.country_kr_name LIKE CONCAT(CONCAT('%', ''), '%')  "; 
				else where2 = "country.country_kr_name LIKE CONCAT(CONCAT('%', '" + regionKeyword + "'), '%')  ";
		}else if(searchWithRegion.equals("city_kr_name")) {
				if(regionKeyword == " ") where2 = "city.city_kr_name LIKE CONCAT(CONCAT('%', ''), '%')  ";
				else where2 = "city.city_kr_name LIKE CONCAT(CONCAT('%', '" + regionKeyword + "'), '%')  ";
		}else if(searchWithRegion.equals("market_kr_name")) {
				if(regionKeyword == " ") where2 = "market.market_kr_name LIKE CONCAT(CONCAT('%', ''), '%')  ";
				else where2 = "market.market_kr_name LIKE CONCAT(CONCAT('%', '" + regionKeyword + "'), '%')  ";
			}
		
		System.out.println(where2);
		String where3 = " ";
		switch (searchWithProduct) {
		case "all": {
			if(productKeyword == " ") {
				where3 = " ";
			}else {where3 = "product.status_check LIKE CONCAT(CONCAT('%', '" + productKeyword + "'), '%') OR " + 
						"product.product_name LIKE CONCAT(CONCAT('%', '" + productKeyword + "'), '%') OR " + 
						"product.user_id LIKE CONCAT(CONCAT('%', '" + productKeyword + "'), '%') ";
		}}
		case "status_check": {
			if(productKeyword == " ") where3 = "product.status_check LIKE CONCAT(CONCAT('%', ''), '%') ";
			else where3 = "product.status_check LIKE CONCAT(CONCAT('%', '" + productKeyword + "'), '%') ";
		}
		case "product_name": {
			if(productKeyword == " ") where3 = "product.product_name LIKE CONCAT(CONCAT('%', ''), '%') "; 
			else where3 = "product.product_name LIKE CONCAT(CONCAT('%', '" + productKeyword + "'), '%') ";
		}
		case "user_id": {
			if(productKeyword == " ") where3 = "product.user_id LIKE CONCAT(CONCAT('%', ''), '%') "; 
			else where3 = "product.user_id LIKE CONCAT(CONCAT('%', '" + productKeyword + "'), '%') ";
		}
		}
		System.out.println(where3);
		
		String where="";
		if (where1 == " ") {
			where = " WHERE " + where2 + " AND " + where3;
			if(where2 == " ") 
				where = " WHERE " + where3;
			else if(where3 == " ")
				where = " WHERE " + where2;
		}else if(where2 == " ") {
			where = " WHERE " + where1 + " AND " + where3;
			if(where1 == " ") 
				where = " WHERE " + where3;
			else if(where3 == " ")
				where = " WHERE " + where1;
		}else if(where3 == " ") {
			where = " WHERE " + where1 + " AND " + where2;
			if(where1 == " ") 
				where = " WHERE " + where2;
			else if(where2 == " ")
				where = " WHERE " + where1;
		}else where="";
		
		
		String sql=	  "   SELECT check_status, country_kr_name, city_kr_name, market_kr_name, product_name, product_number, product_date, "
				+ "	product.product_price, product_img, sequence, user_id "
				+ "	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country "
				+ where;
		System.out.println(sql);
		Statement stmt = conn.createStatement(); // 4

		ResultSet rs = stmt.executeQuery(sql);
		ArrayList<ProductVO> list = new ArrayList<ProductVO>();
		if (rs.next()) {
			do {
				ProductVO product = new ProductVO(rs.getInt("product_number"), rs.getString("check_status"), rs.getDate("product_date"), rs.getString("country_kr_name"), rs.getString("city_kr_name"),
						rs.getString("market_kr_name"), rs.getString("product_name"), rs.getInt("product_price"), rs.getString("product_img"), rs.getString("user_id"), rs.getInt("sequence"));
				list.add(product);
			} while (rs.next());
		} else {
			list = null;
		}
		DBClose.close(conn, stmt, rs);
		return list;
	}
}
