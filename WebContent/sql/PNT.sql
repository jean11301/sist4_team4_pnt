REM 1. 계정 생성하기
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE USER team4
IDENTIFIED BY team4
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp;

ALTER USER team4 DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON users;
GRANT resource, connect TO team4;


REM 2. 테이블 만들기
-- 2-1. 회원 테이블 생성하기
CREATE TABLE USERINFO
(
    user_id          VARCHAR2(45)    NOT NULL, 
    user_password    VARCHAR2(45)    NOT NULL, 
    user_name        VARCHAR2(45)    NULL, 
    user_email       VARCHAR2(45)    NULL, 
    user_point       NUMBER          NULL, 
    social_root      VARCHAR2(45)    NULL, 
    authority        CHAR(1)         default '0'  NOT NULL, 
    user_status      CHAR(1)         default '0'  NOT NULL, 
    CONSTRAINT USERINFO_PK PRIMARY KEY (user_id)
);

-- 2-2. 국가 테이블 생성하기
CREATE TABLE COUNTRY
(
    country_code        NUMBER(3)     NOT NULL,
    country_kr_name     VARCHAR2(45)    NOT NULL, 
    country_en_name     VARCHAR2(45)    NOT NULL, 
    country_flag_img    TIMESTAMP       NOT NULL, 
    CONSTRAINT COUNTRY_PK PRIMARY KEY (country_code)
);

-- 2-3. 도시 테이블 생성하기
CREATE TABLE CITY
(
    city_number     NUMBER(3) NOT NULL,
    city_kr_name    VARCHAR2(45)    NOT NULL, 
    city_en_name    VARCHAR2(45)    NOT NULL, 
    country_code    NUMBER(3)      NOT NULL, 
    CONSTRAINT CITY_PK PRIMARY KEY (city_number),
    CONSTRAINT FK_city_country_code_country_c FOREIGN KEY (country_code) REFERENCES country (country_code)
);

-- 2-4. 시장 테이블 생성하기
CREATE TABLE MARKET
(
    market_number     NUMBER(3)     NOT NULL,
    market_kr_name    VARCHAR2(45)      NOT NULL, 
    market_en_name    VARCHAR2(45)      NOT NULL, 
    latitude          NUMBER(12, 9)     NOT NULL, 
    longitude         NUMBER(12, 9)     NOT NULL, 
    market_info       LONG              NOT NULL, 
    city_number       NUMBER            NOT NULL, 
    CONSTRAINT MARKET_market_number_PK PRIMARY KEY (market_number),
    CONSTRAINT market_city_number_fk FOREIGN KEY (city_number) REFERENCES city (city_number)
)

-- 2-5. 물품 테이블 생성하기
CREATE TABLE PRODUCT
(
    product_number    NUMBER(3)     NOT NULL,
    product_name      VARCHAR2(45)    NOT NULL, 
    product_price     NUMBER          NOT NULL, 
    product_img       TIMESTAMP       NULL, 
    product_date      DATE            NOT NULL, 
    sequence          NUMBER(15)      DEFAULT 0 NOT NULL, 
    check_status      CHAR(1)         DEFAULT '0' NOT NULL, 
    city_number       NUMBER          NOT NULL, 
    market_number     NUMBER          NOT NULL, 
    user_id           VARCHAR2(45)    NOT NULL, 
    CONSTRAINT PRODUCT_product_number_PK PRIMARY KEY (product_number),
    CONSTRAINT product_user_id_fk FOREIGN KEY (user_id) REFERENCES userinfo (user_id),
    CONSTRAINT product_city_number_fk FOREIGN KEY (city_number) REFERENCES city (city_number),
    CONSTRAINT product_market_number_kf FOREIGN KEY (market_number) REFERENCES market (market_number)      
);