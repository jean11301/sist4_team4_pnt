package com.example.libs.model;

public class MarketVO {
	private String country_kr_name;
	private String city_kr_name;
	private String market_kr_name;
	private String market_en_name;
	
	public MarketVO(String country_kr_name, String city_kr_name, String market_kr_name, String market_en_name) {
		super();
		this.country_kr_name = country_kr_name;
		this.city_kr_name = city_kr_name;
		this.market_kr_name = market_kr_name;
		this.market_en_name = market_en_name;
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
	public String getMarket_en_name() {
		return market_en_name;
	}
	public void setMarket_en_name(String market_en_name) {
		this.market_en_name = market_en_name;
	}
	
	
}
