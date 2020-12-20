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
	
	public List<MarketVO> selectPagination(int from, int to) throws SQLException {
		return MarketDao.selectPagination(from, to);
	}
	
	public int deleteMarket(int market_number) throws SQLException{
		return MarketDao.deleteMarket(market_number);
	}
}
