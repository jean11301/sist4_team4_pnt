package com.example.libs.service;

import java.sql.SQLException;
import java.util.ArrayList;

import com.example.libs.dao.CityDao;
import com.example.libs.model.CityVO;

public class CityServiceImpl {

	public int create(CityVO cityVO) {
		// TODO Auto-generated method stub
		int row =0;
		try {
			row = CityDao.insert(cityVO);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return row;
	}


	public CityVO read(String cityname) {
		// TODO Auto-generated method stub
		CityVO city = null;
		city = CityDao.select(cityname);
		return city;
	}


	public ArrayList<CityVO> readAll()  {
		ArrayList<CityVO> list = null;
		try {
			list =  CityDao.selectAll();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}


	public int update(CityVO cityVO) {
		// TODO Auto-generated method stub
		int row = 0;
		try {
			row = CityDao.update(cityVO);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return row;
	}


	public int delete(int city_number) {
		// TODO Auto-generated method stub
		int row = 0;
		try {
			row = CityDao.delete(city_number);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return  row;
	}

}
