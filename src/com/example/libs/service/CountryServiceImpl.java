package com.example.libs.service;

import java.sql.SQLException;
import java.util.ArrayList;

import com.example.libs.dao.CountryDao;
import com.example.libs.model.CountryVO;

public class CountryServiceImpl  {

	public int create(CountryVO countryVO) {
		// TODO Auto-generated method stub
		int row =0;
		try {
			row = CountryDao.insert(countryVO);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return row;
	}


	public CountryVO read(String countryname) {
		// TODO Auto-generated method stub
		CountryVO country = null;
		country = CountryDao.select(countryname);
		
		return country;
	}


	public ArrayList<CountryVO> readAll(){
		// TODO Auto-generated method stub
		ArrayList<CountryVO> list = null;
		try {
			list = CountryDao.selectAll();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e);
		}
		return list;
	}


	public int update(CountryVO countryVO) {
		// TODO Auto-generated method stub
		int row = 0;
		try {
			row  = CountryDao.update(countryVO);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return row;
	}


	public int delete(int countrycode) {
		// TODO Auto-generated method stub
		int row = 0;
		try {
			row = CountryDao.delete(countrycode);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return row;
	}

}
