package com.example.libs.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.libs.model.MarketDao;
import com.example.libs.model.MarketVO;
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
	//검색한 product의 리스트
	public  ArrayList<ProductVO> selectOne(String productname){
		ArrayList<ProductVO> list = null;
		try {
			list = ProductDao.selectProduct(productname);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	//상품 리스트 모두 가져오기
	public List<ProductVO> selectAllProduct() throws SQLException {
		return ProductDao.selectAllProduct();
	}
	
	//상품 번호로 상품 검색하기
	public ProductVO selectProduct(int product_number) throws SQLException {
		return ProductDao.selectProduct(product_number);
	}
	
	public int insertProduct(ProductVO product) throws SQLException{
		if(product.getProduct_img() == null) {
			System.out.println("NULL입니다");
		}else {
			System.out.println("NULL이 아닙니다");
		}
		System.out.println(product.getProduct_img());
		if(product.getProduct_img() == null) {
			return ProductDao.insertProduct(product, 0);
		}else {
			return  ProductDao.insertProduct(product);
		}
	}
	
	public int updateProduct(ProductVO product) throws SQLException{
		return ProductDao.updateProduct(product);
	}
	
	public int getTotalCount() throws SQLException{
		return ProductDao.getTotalCount();
	}
//	public int getTotalCount(int i, String keyword) throws SQLException{
//		return ProductDao.getTotalCount(i, keyword);
//	}
	
	public int getTotalPage(int pageSize) throws SQLException {
		
		int count = ProductDao.getTotalCount();
		int totalPage = 0;
		if(count % pageSize == 0)
				totalPage = count / pageSize;
		else totalPage = count / pageSize + 1;
		
		return totalPage;
	}
	
//	public int getTotalPage(int pageSize, int i, String keyword) throws SQLException {
//		
//		int count = ProductDao.getTotalCount(i, keyword);
//		int totalPage = 0;
//		if(count % pageSize == 0)
//			totalPage = count / pageSize;
//		else totalPage = count / pageSize + 1;
//		
//		return totalPage;
//	}
	
	public int deleteProduct(int product_number) throws SQLException{
		return ProductDao.deleteProduct(product_number);
	}
	
}