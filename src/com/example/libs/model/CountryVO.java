package com.example.libs.model;

import java.sql.Timestamp;

public class CountryVO {
	
		private int country_code;
		private String country_kr_name;
		private String country_en_name;
		private String country_flag_img;
		public CountryVO(int country_code, String country_kr_name, String country_en_name, String country_flag_img) {
			super();
			this.country_code = country_code;
			this.country_kr_name = country_kr_name;
			this.country_en_name = country_en_name;
			this.country_flag_img = country_flag_img;
		}
		public int getCountry_code() {
			return country_code;
		}
		public void setCountry_code(int country_code) {
			this.country_code = country_code;
		}
		public String getCountry_kr_name() {
			return country_kr_name;
		}
		public void setCountry_kr_name(String country_kr_name) {
			this.country_kr_name = country_kr_name;
		}
		public String getCountry_en_name() {
			return country_en_name;
		}
		public void setCountry_en_name(String country_en_name) {
			this.country_en_name = country_en_name;
		}
		public String getCountry_flag_img() {
			return country_flag_img;
		}
		public void setCountry_flag_img(String country_flag_img) {
			this.country_flag_img = country_flag_img;
		}
		
}
