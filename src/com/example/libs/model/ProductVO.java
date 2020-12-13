package com.example.libs.model;
import java.sql.Date;

public class ProductVO {
	private String product_name;
	private double product_price;
	private Date product_date;
	private int sequence;
	private String check_status;
	private String user_id;
	private String country_kr_name;
	private String city_kr_name;
	private String market_kr_name;

	private String product_name2;
	private double product_price_P1Data;
	private double product_price_P2Data;
	private double product_price_P3Data;
	private double product_price_P4Data;
	private double product_price_P5Data;
	
	public ProductVO() {}
	
	
	//인기 검색 종목 물가
	public ProductVO(String country_kr_name, String city_kr_name, String market_kr_name, String product_name,
			double product_price) {
		this.country_kr_name = country_kr_name;
		this.city_kr_name = city_kr_name;
		this.market_kr_name = market_kr_name;
		this.product_name = product_name;
		this.product_price = product_price;
	}

	//급변동 리스트
	public ProductVO(String country_kr_name, String product_name, double product_price_P1Data,  String product_name2, 
			double product_price_P2Data, double product_price_P3Data, double product_price_P4Data,
			double product_price_P5Data) {
		this.product_name = product_name;
		this.country_kr_name = country_kr_name;
		this.product_name2 = product_name2;
		this.product_price_P1Data = product_price_P1Data;
		this.product_price_P2Data = product_price_P2Data;
		this.product_price_P3Data = product_price_P3Data;
		this.product_price_P4Data = product_price_P4Data;
		this.product_price_P5Data = product_price_P5Data;
	}
	
	public String getProduct_name() {
		return product_name;
	}


	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}


	public double getProduct_price() {
		return product_price;
	}


	public void setProduct_price(double product_price) {
		this.product_price = product_price;
	}


	public Date getProduct_date() {
		return product_date;
	}


	public void setProduct_date(Date product_date) {
		this.product_date = product_date;
	}


	public int getSequence() {
		return sequence;
	}


	public void setSequence(int sequence) {
		this.sequence = sequence;
	}


	public String getCheck_status() {
		return check_status;
	}


	public void setCheck_status(String check_status) {
		this.check_status = check_status;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getCountry_kr_name() {
		return country_kr_name;
	}


	public void setCountry_kr_name(String country_kr_name) {
		this.country_kr_name = country_kr_name;
	}


	public String getCity_kr_name() {
		return city_kr_name;
	}


	public void setCity_kr_name(String city_kr_name) {
		this.city_kr_name = city_kr_name;
	}


	public String getMarket_kr_name() {
		return market_kr_name;
	}


	public void setMarket_kr_name(String market_kr_name) {
		this.market_kr_name = market_kr_name;
	}

	
	//급변동 get,set
	public String getProduct_name2() {
		return product_name2;
	}


	public void setProduct_name2(String product_name2) {
		this.product_name2 = product_name2;
	}


	public double getProduct_price_P1Data() {
		return product_price_P1Data;
	}


	public void setProduct_price_P1Data(double product_price_P1Data) {
		this.product_price_P1Data = product_price_P1Data;
	}


	public double getProduct_price_P2Data() {
		return product_price_P2Data;
	}


	public void setProduct_price_P2Data(double product_price_P2Data) {
		this.product_price_P2Data = product_price_P2Data;
	}


	public double getProduct_price_P3Data() {
		return product_price_P3Data;
	}


	public void setProduct_price_P3Data(double product_price_P3Data) {
		this.product_price_P3Data = product_price_P3Data;
	}


	public double getProduct_price_P4Data() {
		return product_price_P4Data;
	}


	public void setProduct_price_P4Data(double product_price_P4Data) {
		this.product_price_P4Data = product_price_P4Data;
	}


	public double getProduct_price_P5Data() {
		return product_price_P5Data;
	}


	public void setProduct_price_P5Data(double product_price_P5Data) {
		this.product_price_P5Data = product_price_P5Data;
	}

	

	
	
}