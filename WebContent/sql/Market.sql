--시장 리스트 전부 가져오기
create or replace NONEDITIONABLE PROCEDURE sp_market_selectAll
(
    market_record    OUT   SYS_REFCURSOR
)
AS
BEGIN
    OPEN market_record FOR
    SELECT market.market_number, country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name, market.latitude, market.longitude, market.market_info
    FROM country INNER JOIN city ON(country.country_code = city.country_code)
        INNER JOIN market ON(city.city_number = market.city_number) 
    ORDER BY country_kr_name, city_kr_name, market_kr_name;
END;

--시장 번호로 시장 정보 가져오기
create or replace NONEDITIONABLE PROCEDURE sp_market_select
(
    v_market_number  IN    market.market_number%TYPE,
    market_record    OUT   SYS_REFCURSOR
)
AS
BEGIN
    OPEN market_record FOR
    SELECT  country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name, market.latitude, market.longitude, market.market_info
    FROM country INNER JOIN city ON(country.country_code = city.country_code)
        INNER JOIN market ON(city.city_number = market.city_number) 
    WHERE market.market_number = v_market_number;
END;


--시장 입력하기
create or replace NONEDITIONABLE PROCEDURE sp_market_insert
(
    v_market_kr_name        IN      market.market_kr_name%TYPE,
    v_market_en_name        IN      market.market_en_name%TYPE,
    v_latitude              IN      market.latitude%TYPE,
    v_longitude             IN      market.longitude%TYPE,
    v_country_kr_name       IN      country.country_kr_name%TYPE,
    v_city_kr_name          IN      city.city_kr_name%TYPE,
    v_market_info            IN      market.market_info%TYPE
)
IS
BEGIN
    INSERT INTO MARKET (MARKET_NUMBER, MARKET_KR_NAME, MARKET_EN_NAME, LATITUDE,LONGITUDE, market_info, city_number) 
    VALUES ((SELECT (COUNT(*) + 1) FROM market), v_market_kr_name, v_market_en_name, v_latitude, v_longitude, v_market_info, 
    (SELECT MAX(city_number) FROM city INNER JOIN country ON (country.country_code = city.country_code) 
        WHERE country_kr_name= v_country_kr_name AND city_kr_name = v_city_kr_name));
    COMMIT;
END;

--시장 수정하기
create or replace NONEDITIONABLE PROCEDURE sp_market_update
(
    v_market_kr_name        IN      market.market_kr_name%TYPE,
    v_market_en_name        IN      market.market_en_name%TYPE,
    v_latitude              IN      market.latitude%TYPE,
    v_longitude             IN      market.longitude%TYPE,
    v_country_kr_name       IN      country.country_kr_name%TYPE,
    v_city_kr_name          IN      city.city_kr_name%TYPE,
    v_market_info            IN      market.market_info%TYPE,
    v_market_number         IN      market.market_number%TYPE
)
IS
BEGIN
    UPDATE MARKET 
    SET MARKET_KR_NAME = v_market_kr_name,
    MARKET_EN_NAME = v_market_en_name, 
    LATITUDE = v_latitude,
    LONGITUDE = v_longitude, 
    market_info = v_market_info, 
    city_number = (SELECT MAX(city_number) FROM city INNER JOIN country ON (country.country_code = city.country_code) 
        WHERE country_kr_name= v_country_kr_name AND city_kr_name = v_city_kr_name)
    WHERE market_number = v_market_number;
END;

--페이지네이션
create or replace NONEDITIONABLE PROCEDURE sp_market_selectOffset
(
    v_from           IN    NUMBER,
    v_to             IN    NUMBER,
    market_record    OUT   SYS_REFCURSOR
)
AS
BEGIN
    OPEN market_record FOR
    SELECT market.market_number, country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name, market.latitude, market.longitude, market.market_info
    FROM country INNER JOIN city ON(country.country_code = city.country_code)
        INNER JOIN market ON(city.city_number = market.city_number) 
    ORDER BY country_kr_name, city_kr_name, market_kr_name
    OFFSET v_from ROWS FETCH NEXT v_to ROWS ONLY;
END;
    