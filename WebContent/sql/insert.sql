--김태원
--userinfo
INSERT INTO userinfo VALUES(1,1,1,1,1,1,1,1);
--city 
INSERT INTO city VALUES(city_seq.NEXTVAL, '방콕', 'Bangkok',1);
INSERT INTO city VALUES(city_seq.NEXTVAL, '카오산', 'kaosan',1);
INSERT INTO city VALUES(city_seq.NEXTVAL, '담헤이', 'dam',1);
INSERT INTO city VALUES(city_seq.NEXTVAL, '호치민', 'hochi',2);
INSERT INTO city VALUES(city_seq.NEXTVAL, '달랏', 'dalot',2);
INSERT INTO city VALUES(city_seq.NEXTVAL, '하노이', 'Hanoi',2);
INSERT INTO city VALUES(city_seq.NEXTVAL, '아시아티크', 'asiateak',1);
--country
INSERT INTO country VALUES(1,'태국','tai',systimestamp);
INSERT INTO country VALUES(2,'베트남','bae',systimestamp);
--market
INSERT INTO market VALUES(1,'카오산로드','gwang',0.58,0.699,'info',2);
INSERT INTO market VALUES(2,'짝두짝시장','jjak',0.342,0.785,'info',1);
