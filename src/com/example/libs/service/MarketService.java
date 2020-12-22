package com.example.libs.service;

import java.sql.SQLException;
import java.util.List;

import com.example.libs.model.MarketDao;
import com.example.libs.model.MarketVO;

public class MarketService {
	
	public List<MarketVO> selectAllMarket() throws SQLException {
		
		return MarketDao.selectAllMarket();
	}
	
	public MarketVO selectMarket(int market_number) throws SQLException {
		return MarketDao.selectMarket(market_number);
	}
	
	public int insertMarket(MarketVO market) throws SQLException{
		return MarketDao.insertMarket(market);
	}
	
	public int updateMarket(MarketVO market) throws SQLException{
		return MarketDao.updateMarket(market);
	}
	
	public int getTotalCount() throws SQLException{
		return MarketDao.getTotalCount();
	}
	
	public int getTotalPage(int pageSize) throws SQLException {
		
		int count = MarketDao.getTotalCount();
		int totalPage = 0;
		if(count % pageSize == 0)
				totalPage = count / pageSize;
		else totalPage = count / pageSize + 1;
		
		return totalPage;
	}
	
	public int getTotalPage(int pageSize, int count) throws SQLException {
		
		int totalPage = 0;
		if(count % pageSize == 0)
			totalPage = count / pageSize;
		else totalPage = count / pageSize + 1;
		
		return totalPage;
	}
	
	public int deleteMarket(int market_number) throws SQLException{
		return MarketDao.deleteMarket(market_number);
	}
	
}
