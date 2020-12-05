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

	
}