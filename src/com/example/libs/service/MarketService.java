package com.example.libs.service;

import java.sql.SQLException;
import java.util.List;

import com.example.libs.model.MarketDao;
import com.example.libs.model.MarketVO;

public class MarketService {
	private MarketDao marketDao;
	
	public List<MarketVO> selectAll() throws SQLException {
		return this.marketDao.selectAll();
	}
}
