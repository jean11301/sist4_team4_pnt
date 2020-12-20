package com.example.libs.model;

public class MarketVO {
	private int market_number;
	private String country_kr_name;
	private String city_kr_name;
	private String market_kr_name;
	private String market_en_name;
	private double latitude;
	private double longitude;
	private String market_info;

	public MarketVO() {
	}
	
	
	//SelectAll
	public MarketVO(int market_number, String country_kr_name, String city_kr_name, String market_kr_name, String market_en_name, double latitude, double longitude, String market_info) {
		this.market_number = market_number;
		this.country_kr_name = country_kr_name;
		this.city_kr_name = city_kr_name;
		this.market_kr_name = market_kr_name;
		this.market_en_name = market_en_name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.market_info = market_info;
	}
	
	//SelectOne, Insert
	public MarketVO(String country_kr_name, String city_kr_name, String market_kr_name, String market_en_name, double latitude, double longitude, String market_info) {
		this.country_kr_name = country_kr_name;
		this.city_kr_name = city_kr_name;
		this.market_kr_name = market_kr_name;
		this.market_en_name = market_en_name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.market_info = market_info;
	}
	
	public int getMarket_number() {
		return market_number;
	}

	public void setMarket_number(int market_number) {
		this.market_number = market_number;
	}

	public String getMarket_info() {
		return market_info;
	}

	public void setMarket_info(String market_info) {
		this.market_info = market_info;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
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

	@Override
	public String toString() {
		return "MarketVO [country_kr_name=" + country_kr_name + ", city_kr_name=" + city_kr_name + ", market_kr_name="
				+ market_kr_name + ", market_en_name=" + market_en_name + ", latitude=" + latitude + ", longitude="
				+ longitude + ", market_info=" + market_info + "]";
	}
	
	
}
