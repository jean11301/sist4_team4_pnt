package com.example.libs.model;

public class CityVO {


	private int city_number;
	private String city_kr_name;
	private String city_en_name;
	private int country_code;
	public CityVO(int city_number, String city_kr_name, String city_en_name, int country_code) {
		super();
		this.city_number = city_number;
		this.city_kr_name = city_kr_name;
		this.city_en_name = city_en_name;
		this.country_code = country_code;
	}
	public int getCity_number() {
		return city_number;
	}
	public void setCity_number(int city_number) {
		this.city_number = city_number;
	}
	public String getCity_kr_name() {
		return city_kr_name;
	}
	public void setCity_kr_name(String city_kr_name) {
		this.city_kr_name = city_kr_name;
	}
	public String getCity_en_name() {
		return city_en_name;
	}
	public void setCity_en_name(String city_en_name) {
		this.city_en_name = city_en_name;
	}
	public int getCountry_code() {
		return country_code;
	}
	public void setCountry_code(int country_code) {
		this.country_code = country_code;
	}
	
}
