package com.example.libs.service;

import java.sql.SQLException;
import java.util.ArrayList;

import com.example.libs.model.ProductDao;
import com.example.libs.model.ProductVO;

public class PopularService {
	public ArrayList<ProductVO> populist(){
		ArrayList<ProductVO> list = null;
		try {
			list = ProductDao.popularlist();
		}catch(SQLException ex) {
			System.out.println(ex);
		}
		return list;
	}
	
	//급변동
	public ArrayList<ProductVO> variancelist(){
		ArrayList<ProductVO> list2 = null;
		try {
			list2 = ProductDao.variancelist();
		}catch(SQLException ex) {
			System.out.println(ex);
		}
		return list2;
	}
}