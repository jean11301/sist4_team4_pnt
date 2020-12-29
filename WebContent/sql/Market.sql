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
    VALUES ((SELECT (MAX(market_number) + 1) FROM market), v_market_kr_name, v_market_en_name, v_latitude, v_longitude, v_market_info, 
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

--전체 게시글 수 불러오기
create or replace NONEDITIONABLE PROCEDURE sp_market_selectCount
(
    selectCount    OUT   NUMBER
)
AS
BEGIN
    SELECT COUNT(market_number) AS selectCount INTO selectCount
    FROM market;
END;
   

--상품 리스트 전부 가져오기
create or replace NONEDITIONABLE PROCEDURE sp_product_selectAll
(
    product_record    OUT   SYS_REFCURSOR
)
AS
BEGIN
    OPEN product_record FOR
    SELECT check_status, country_kr_name, city_kr_name, market_kr_name, product_name, product_number, product_date,
	product.product_price, product_img, sequence, user_id
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country
	ORDER BY product_date DESC;
END;

--전체 상품 수 불러오기
create or replace NONEDITIONABLE PROCEDURE sp_product_selectCount
(
    selectCount    OUT   NUMBER
)
AS
BEGIN
    SELECT COUNT(product_number) AS selectCount INTO selectCount
    FROM product;
END;

--새 상품 입력하기
create or replace NONEDITIONABLE PROCEDURE sp_product_insert
(
	v_product_name           IN     product.product_name%TYPE,
	v_product_price          IN     product.product_price%TYPE,
	v_product_img            IN     product.product_img%TYPE,
	v_sequence               IN     product.sequence%TYPE,
	v_check_status           IN     product.check_status%TYPE,
	v_city_kr_name           IN     city.city_kr_name%TYPE,
	v_market_kr_name         IN     market.market_kr_name%TYPE,
	v_user_id                IN     product.user_id%TYPE
)
IS
BEGIN
    INSERT INTO PRODUCT (product_number, product_name, product_price, product_img, product_date, sequence,
                            check_status, city_number, market_number, user_id  ) 
    VALUES ((SELECT (MAX(product_number) + 1) FROM product), v_product_name, v_product_price,v_product_img, (SELECT SYSDATE FROM DUAL), v_sequence, v_check_status, 
        (SELECT city_number FROM city WHERE city_kr_name = v_city_kr_name), (SELECT market_number FROM market WHERE market_kr_name = v_market_kr_name), v_user_id);
    COMMIT;
END;

--새 상품 입력하기(이미지 없음)
create or replace NONEDITIONABLE PROCEDURE sp_product_insert_noimage
(
	v_product_name           IN     product.product_name%TYPE,
	v_product_price          IN     product.product_price%TYPE,
	v_sequence               IN     product.sequence%TYPE,
	v_check_status           IN     product.check_status%TYPE,
	v_city_kr_name           IN     city.city_kr_name%TYPE,
	v_market_kr_name         IN     market.market_kr_name%TYPE,
	v_user_id                IN     product.user_id%TYPE
)
IS
    
BEGIN
    
    INSERT INTO PRODUCT (product_number, product_name, product_price, product_date, sequence,
                            check_status, city_number, market_number, user_id  ) 
    VALUES ((SELECT (MAX(product_number) + 1) FROM product), v_product_name, v_product_price, (SELECT SYSDATE FROM DUAL), v_sequence, v_check_status, 
        (SELECT city_number FROM city WHERE city_kr_name = v_city_kr_name), (SELECT market_number FROM market WHERE market_kr_name = v_market_kr_name), v_user_id);
    COMMIT;
END;

--상품 번호로 상품 정보 가져오기
create or replace NONEDITIONABLE PROCEDURE sp_product_select
(
    v_product_number  IN    product.product_number%TYPE,
    product_record    OUT   SYS_REFCURSOR
)
AS
BEGIN
    OPEN product_record FOR
    SELECT  product.product_number, product.check_status, product.product_date, country.country_kr_name, city.city_kr_name, market.market_kr_name, 
            product.product_name, product.product_price, product.product_img, product.user_id, product.sequence
    FROM product NATURAL JOIN market NATURAL JOIN city NATURAL JOIN country
    WHERE product.product_number = v_product_number;
END;

--상품 수정하기
create or replace NONEDITIONABLE PROCEDURE sp_product_update
(   
    v_product_number      IN      product.product_number%TYPE,
    v_check_status        IN      product.check_status%TYPE,
    v_user_id              IN     product.user_id%TYPE,
    v_sequence             IN     product.sequence%TYPE,
    v_country_kr_name       IN      country.country_kr_name%TYPE,
    v_city_kr_name          IN      city.city_kr_name%TYPE,
    v_market_kr_name       IN      market.market_kr_name%TYPE,
    v_product_name         IN      product.product_name%TYPE,
    v_product_price        IN      product.product_price%TYPE,
    v_product_img             IN      product.product_img%TYPE
)
IS
BEGIN
    UPDATE PRODUCT 
    SET 
    check_status = v_check_status,
    user_id = v_user_id,
    sequence = v_sequence,
    city_number = (SELECT city_number FROM city INNER JOIN country ON (country.country_code = city.country_code) 
        WHERE country_kr_name= v_country_kr_name AND city_kr_name = v_city_kr_name),
    market_number = (SELECT market_number FROM market NATURAL JOIN city WHERE city_kr_name = v_city_kr_name AND market_kr_name = v_market_kr_name),
    product_name = v_product_name,
    product_price = v_product_price,
    product_img = v_product_img
    WHERE product_number = v_product_number;

END;

--상품 수정하기(이미지 없음)
create or replace NONEDITIONABLE PROCEDURE sp_product_update_noimage
(   
    v_product_number      IN      product.product_number%TYPE,
    v_check_status        IN      product.check_status%TYPE,
    v_country_kr_name       IN      country.country_kr_name%TYPE,
    v_city_kr_name          IN      city.city_kr_name%TYPE,
    v_market_kr_name       IN      market.market_kr_name%TYPE,
    v_product_name         IN      product.product_name%TYPE,
    v_product_price        IN      product.product_price%TYPE
)
IS
BEGIN
    UPDATE PRODUCT 
    SET 
    check_status = v_check_status,
    city_number = (SELECT city_number FROM city INNER JOIN country ON (country.country_code = city.country_code) WHERE country_kr_name= v_country_kr_name AND city_kr_name = v_city_kr_name),
    market_number = (SELECT market_number FROM market NATURAL JOIN city WHERE city_kr_name = v_city_kr_name AND market_kr_name = v_market_kr_name),
    product_name = v_product_name,
    product_price = v_product_price
    WHERE product_number = v_product_number;
    COMMIT;
END;