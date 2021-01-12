rem 1. 로그인 프로세스
CREATE OR REPLACE PROCEDURE sp_member_login
(
    v_userid     IN      USERINFO.user_id%TYPE,
    login_record     OUT      SYS_REFCURSOR
)
IS
BEGIN
    OPEN login_record FOR
    SELECT user_password FROM USERINFO
    WHERE user_id = v_userid;
    
END;



rem 2.user_id 가져오기
CREATE OR REPLACE PROCEDURE sp_member_select
(
    v_userid   IN    USERINFO.user_id%TYPE,
    member_record   OUT    SYS_REFCURSOR
)
AS
BEGIN
    OPEN member_record FOR
    SELECT user_name, user_email, user_point, social_root, authority, user_status
    FROM USERINFO
    WHERE user_id = v_userid;
END;



rem 3. 회원 가입
CREATE OR REPLACE PROCEDURE sp_member_insert
(
    v_userid     IN    USERINFO.user_id%TYPE,
    v_passwd     IN    USERINFO.user_password%TYPE,
    v_name     IN    USERINFO.user_name%TYPE,
    v_email     IN    USERINFO.user_email%TYPE
)
IS
BEGIN
    INSERT INTO USERINFO(user_id, user_password, user_name, user_email)
    VALUES(v_userid, v_passwd, v_name, v_email);
    COMMIT;
END;



rem. 4. 아이디 중복 체크
CREATE OR REPLACE PROCEDURE sp_member_idcheck
(
    v_userid   IN    USERINFO.user_id%TYPE,
    member_record   OUT   SYS_REFCURSOR
)
AS
BEGIN
    OPEN member_record FOR
    SELECT user_id FROM USERINFO
    WHERE user_id = v_userid;
    
END;