-- CREATE USER
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE USER team4
IDENTIFIED BY team4
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp;

ALTER USER team4 DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON users;
GRANT resource, connect TO team4;



--country
CREATE TABLE country
(
    country_code        NUMBER(3)      NOT NULL, 
    country_kr_name     VARCHAR2(45)    NOT NULL, 
    country_en_name     VARCHAR2(45)    NOT NULL, 
    country_flag_img    TIMESTAMP       NOT NULL, 
    CONSTRAINT COUNTRY_PK PRIMARY KEY (country_code)
)
--city
CREATE TABLE city
(
    city_number     NUMBER(3)     NOT NULL, 
    city_kr_name    VARCHAR2(45)    NOT NULL, 
    city_en_name    VARCHAR2(45)    NOT NULL, 
    country_code    NUMBER(3)      NOT NULL, 
    CONSTRAINT CITY_PK PRIMARY KEY (city_number)
)

CREATE SEQUENCE city_SEQ
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER city_AI_TRG
BEFORE INSERT ON city 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT city_SEQ.NEXTVAL
    INTO :NEW.city_number
    FROM DUAL;
END;

--DROP TRIGGER city_AI_TRG;

--DROP SEQUENCE city_SEQ;

ALTER TABLE city
    ADD CONSTRAINT FK_city_country_code_country_c FOREIGN KEY (country_code)
        REFERENCES country (country_code)

--market

CREATE TABLE market
(
    market_number     NUMBER(3)            NOT NULL, 
    market_kr_name    VARCHAR2(45)      NOT NULL, 
    marker_en_name    VARCHAR2(45)      NOT NULL, 
    latitude          NUMBER(10, 10)    NOT NULL, 
    longitude         NUMBER(10, 10)    NOT NULL, 
    market_info       LONG              NOT NULL, 
    city_number       NUMBER(3)             NOT NULL, 
    CONSTRAINT MARKET_PK PRIMARY KEY (market_number)
)

ALTER TABLE market
    ADD CONSTRAINT FK_market_city_number_city_cit FOREIGN KEY (city_number)
        REFERENCES city (city_number)

--userinfo
CREATE TABLE userinfo
(
    user_id          VARCHAR2(45)    NOT NULL, 
    user_password    VARCHAR2(45)    NOT NULL, 
    user_name        VARCHAR2(45)    NULL, 
    user_email       VARCHAR2(45)    NULL, 
    user_point       NUMBER          NULL, 
    social_root      VARCHAR2(45)    NULL, 
    authority        CHAR(1)         NOT NULL, 
    user_status      CHAR(1)         NOT NULL, 
    CONSTRAINT USERINFO_PK PRIMARY KEY (user_id)
)

--product
CREATE TABLE product
(
    product_number    NUMBER(3)       NOT NULL, 
    product_name      VARCHAR2(45)    NOT NULL, 
    product_price     NUMBER(3)       NOT NULL, 
    product_img       TIMESTAMP       NULL, 
    product_date      DATE            NOT NULL, 
    sequence          NUMBER          NOT NULL, 
    check_status      CHAR(1)         DEFAULT '0' NOT NULL, 
    city_number       NUMBER(3)       NOT NULL, 
    market_number     NUMBER(3)       NOT NULL, 
    user_id           VARCHAR2(45)    NOT NULL, 
    CONSTRAINT PRODUCT_PK PRIMARY KEY (product_number)
)
CREATE SEQUENCE product_SEQ
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER product_AI_TRG
BEFORE INSERT ON product 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT product_SEQ.NEXTVAL
    INTO :NEW.product_number
    FROM DUAL;
END;

--DROP TRIGGER product_AI_TRG;

--DROP SEQUENCE product_SEQ;

CREATE OR REPLACE TRIGGER product_AI_TRG
BEFORE INSERT ON product 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT product_SEQ.NEXTVAL
    INTO :NEW.sequence
    FROM DUAL;
END;

ALTER TABLE product
    ADD CONSTRAINT FK_product_user_id_userinfo_us FOREIGN KEY (user_id)
        REFERENCES userinfo (user_id)


ALTER TABLE product
    ADD CONSTRAINT FK_product_city_number_city_ci FOREIGN KEY (city_number)
        REFERENCES city (city_number)


ALTER TABLE product
    ADD CONSTRAINT FK_product_market_number_marke FOREIGN KEY (market_number)
        REFERENCES market (market_number)