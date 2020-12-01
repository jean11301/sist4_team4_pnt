--���¿�
--userinfo
INSERT INTO userinfo VALUES(1,1,1,1,1,1,1,1);
--city 
INSERT INTO city VALUES(city_seq.NEXTVAL, '����', 'Bangkok',1);
INSERT INTO city VALUES(city_seq.NEXTVAL, 'ī����', 'kaosan',1);
INSERT INTO city VALUES(city_seq.NEXTVAL, '������', 'dam',1);
INSERT INTO city VALUES(city_seq.NEXTVAL, 'ȣġ��', 'hochi',2);
INSERT INTO city VALUES(city_seq.NEXTVAL, '�޶�', 'dalot',2);
INSERT INTO city VALUES(city_seq.NEXTVAL, '�ϳ���', 'Hanoi',2);
INSERT INTO city VALUES(city_seq.NEXTVAL, '�ƽþ�Ƽũ', 'asiateak',1);
--country
INSERT INTO country VALUES(1,'�±�','tai',systimestamp);
INSERT INTO country VALUES(2,'��Ʈ��','bae',systimestamp);
--market
INSERT INTO market VALUES(1,'ī����ε�','gwang',0.58,0.699,'info',2);
INSERT INTO market VALUES(2,'¦��¦����','jjak',0.342,0.785,'info',1);





REM 베트남 임시데이터 insert
--USERINFO
INSERT INTO USERINFO (USER_ID, USER_PASSWORD, USER_NAME, AUTHORITY) VALUES ('admin', '12345', '관리자', '1');

--Country 데이터
INSERT INTO COUNTRY (COUNTRY_KR_NAME, COUNTRY_EN_NAME, COUNTRY_FLAG_IMG) VALUES ('베트남','VIETNAM',to_timestamp('2020-11-24:11:29:53', 'YYYY-MM-DD HH24:MI:SS'));

--CITY 데이터
INSERT INTO CITY (CITY_KR_NAME, CITY_EN_NAME, COUNTRY_CODE)VALUES ('호치민', 'Ho Chi Minh', 1);
INSERT INTO CITY (CITY_KR_NAME, CITY_EN_NAME, COUNTRY_CODE)VALUES ('달랏', 'Dalat', 1);
INSERT INTO CITY (CITY_KR_NAME, CITY_EN_NAME, COUNTRY_CODE)VALUES ('하노이', 'Hanoi', 1);

--MARKET 데이터
INSERT INTO MARKET (MARKET_KR_NAME, MARKET_EN_NAME, LATITUDE, LONGITUDE, market_info, city_number) VALUES ('벤탄','Ben Thanh',10.7919695,106.6250147, '여기는 벤탄시장입니다.', 1);
INSERT INTO MARKET (MARKET_KR_NAME, MARKET_EN_NAME, LATITUDE, LONGITUDE, market_info,city_number) VALUES ('달랏','Dalat',11.9428556,108.4346737, '여기는 달랏시장입니다.', 2);
INSERT INTO MARKET (MARKET_KR_NAME, MARKET_EN_NAME, LATITUDE, LONGITUDE, market_info,city_number) VALUES ('동쑤언','Dong Xuan',21.0345583,105.8484525, '여기는 동쑤언시장입니다.', 3);

--PRODUCT 데이터
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('바나나',2.01,to_date('2020-11-24', 'RRRR-MM-DD'),80,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('사과',0.5,to_date('2020-11-25', 'RRRR-MM-DD'),50,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('물',1.2,to_date('2020-11-26', 'RRRR-MM-DD'),10,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('망고',2.87,to_date('2020-11-27', 'RRRR-MM-DD'),9,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('라면',1.08,to_date('2020-11-28', 'RRRR-MM-DD'),1,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('커피포트',38.9,to_date('2020-11-29', 'RRRR-MM-DD'),8,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('우동',5,to_date('2020-11-30', 'RRRR-MM-DD'),15,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('커피',2.16,to_date('2020-12-01', 'RRRR-MM-DD'),152,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('요거트',0.22,to_date('2020-12-02', 'RRRR-MM-DD'),157,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('인형',10.1,to_date('2020-12-03', 'RRRR-MM-DD'),111,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('스타애플',0.08,to_date('2020-12-04', 'RRRR-MM-DD'),26,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('커스타드 애플',0.25,to_date('2020-12-05', 'RRRR-MM-DD'),258,1,1,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('바나나',1.81,to_date('2020-12-06', 'RRRR-MM-DD'),17,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('사과',0.3,to_date('2020-12-07', 'RRRR-MM-DD'),89,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('물',0.8,to_date('2020-12-08', 'RRRR-MM-DD'),69,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('반미',1.5,to_date('2020-12-09', 'RRRR-MM-DD'),92,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('볶음밥',1.32,to_date('2020-12-10', 'RRRR-MM-DD'),100,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('닭',4.5,to_date('2020-12-11', 'RRRR-MM-DD'),871,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('우렁이찜',7.11,to_date('2020-12-12', 'RRRR-MM-DD'),50,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('쌀국수',0.8,to_date('2020-12-13', 'RRRR-MM-DD'),33,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('인형',0.8,to_date('2020-12-14', 'RRRR-MM-DD'),120,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('망고주스',0.32,to_date('2020-12-15', 'RRRR-MM-DD'),77,2,2,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('바나나',0.8,to_date('2020-12-16', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('사과',0.45,to_date('2020-12-17', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('물',0.97,to_date('2020-12-18', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('쌀국수',1.21,to_date('2020-12-19', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('망고',1.8,to_date('2020-12-20', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('커스터드 애플',0.55,to_date('2020-12-21', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('당근',0.11,to_date('2020-12-22', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('코코넛',0.09,to_date('2020-12-23', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('코코넛 가루',0.25,to_date('2020-12-24', 'RRRR-MM-DD'),0,3,3,'admin');
INSERT INTO PRODUCT (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DATE, SEQUENCE, CITY_NUMBER, MARKET_NUMBER, USER_ID) VALUES ('말린 새우',6.52,to_date('2020-12-25', 'RRRR-MM-DD'),990,3,3,'admin');
