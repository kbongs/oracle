SELECT S.NO, S.MEMBER_NO, S.SUBJECT, S.START_DATE, S.END_DATE, S.MEMO, S.COLOR 
FROM SCHEDULE S
JOIN MEMBER M ON (S.MEMBER_NO = M.MEMBER_NO)
WHERE S.MEMBER_NO = 2;


SELECT COUNT(*)
FROM MEMBER
WHERE MEMBER_GENDER = 'woman';




-- 팔로우중 성별 남자 수
SELECT COUNT(*)
FROM
(SELECT MEMBER_GENDER
FROM MEMBER
WHERE MEMBER_NO IN (
SELECT FROM_MEM_NO 
FROM FOLLOWER 
WHERE TO_MEM_NO = 5
))
WHERE MEMBER_GENDER = 'man';



-- 팔로우들 성별
SELECT MEMBER_GENDER
FROM MEMBER
WHERE MEMBER_NO IN (
SELECT FROM_MEM_NO 
FROM FOLLOWER 
WHERE TO_MEM_NO = 5
);


-- 팔로우들 나이
SELECT MEMBER_AGE
FROM MEMBER
WHERE MEMBER_NO IN (
SELECT FROM_MEM_NO 
FROM FOLLOWER 
WHERE TO_MEM_NO = 5
);


-- 팔로우중 그 외 인원 수
SELECT COUNT(*)
FROM
(SELECT MEMBER_AGE
FROM MEMBER
WHERE MEMBER_NO IN (
SELECT FROM_MEM_NO 
FROM FOLLOWER 
WHERE TO_MEM_NO = 5
))
WHERE MEMBER_AGE < 10 OR MEMBER_AGE >= 60;




-- 기업회원01(5)번을 팔로우 누른 개인회원들 
SELECT FROM_MEM_NO 
FROM FOLLOWER 
WHERE TO_MEM_NO = 5;

-- 기업회원01(6)번을 팔로우 누른 개인회원들 
SELECT FROM_MEM_NO 
FROM FOLLOWER 
WHERE TO_MEM_NO = 6;


--WHERE절 쿼리로(오류)
SELECT COUNT(*) FROM MEMBER
WHERE MEMBER_GENDER IN (SELECT FROM_MEM_NO 
                        FROM FOLLOWER 
                        WHERE TO_MEM_NO = 5);



--TO_MEM_NO 5번 의 하루 팔로우 추가 된 수
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE);

--TO_MEM_NO 5번 의 어제 팔로우 추가 된 수
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-1);

------------------------ 일일 팔로우 수 도전
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE);


-- 한 주의 월요일 날짜 찾는 쿼리
SELECT TRUNC(SYSDATE, 'IW') FROM DUAL;
-- 한 주의 일요일 날짜 찾는 쿼리
SELECT TRUNC(SYSDATE, 'DAY') FROM DUAL;

SELECT * FROM FOLLOWER
WHERE  FOLLOWER_CREATE_DATE BETWEEN TRUNC(SYSDATE, 'IW') AND TRUNC(SYSDATE, 'D');


----실패
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND FOLLOWER_CREATE_DATE IN (
                                SELECT TRUNC(SYSDATE, 'DAY') + LEVEL
                                FROM DUAL
                                CONNECT BY LEVEL <= 7);
-- 이번주 팔로우 토탈 수                   
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 
AND TO_CHAR(FOLLOWER_CREATE_DATE) BETWEEN TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'IW')), 'YY/MM/DD') AND TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'D')+7), 'YY/MM/DD') 
;

-- 저번주 팔로우 토탈 수
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 
AND TO_CHAR(FOLLOWER_CREATE_DATE) BETWEEN TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'IW')-7), 'YY/MM/DD') AND TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'D')), 'YY/MM/DD') 
;

-------------------------------------------
-- 이번달 팔로우 토탈 수
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 
AND TO_CHAR(FOLLOWER_CREATE_DATE) BETWEEN TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'MM')), 'YY/MM/DD') AND TO_CHAR(LAST_DAY(SYSDATE), 'YY/MM/DD') 
;

-- 지난달 팔로우 토탈 수
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 
AND TO_CHAR(FOLLOWER_CREATE_DATE) BETWEEN TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE, 'MM'),-1), 'YY/MM/DD') AND TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'MM')-1), 'YY/MM/DD') 
;
------------------------------

SELECT TO_CHAR(TO_DATE('20220315'),'YY-MM-DD') FROM DUAL;




--이번달 1일
SELECT TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'MM')), 'YY/MM/DD') FROM DUAL;
--이번달 마지막날
SELECT TO_CHAR(LAST_DAY(SYSDATE), 'YY/MM/DD') FROM DUAL;
--저번달 1일
SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE, 'MM'),-1), 'YY/MM/DD') FROM DUAL;
--저번달 마지막 날
SELECT TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'MM')-1), 'YY/MM/DD') FROM DUAL;





SELECT  
COUNT(*)  
FROM dual
WHERE  
SUBSTR(REGDATE,0,8) BETWEEN (TO_CHAR(TRUNC(SYSDATE,'MM'),'YYYYMMDD') ) AND (LAST_DAY(SYSDATE));




SELECT TO_CHAR(FOLLOWER_CREATE_DATE, 'YYMMDD')
FROM FOLLOWER;

---------------
SELECT TRUNC(SYSDATE, 'DAY') + LEVEL
  FROM DUAL
CONNECT BY LEVEL <= 7;
---------------------

SELECT TRUNC(SYSDATE, 'IW') FROM DUAL;


SELECT TO_CHAR(TO_DATE(TRUNC(SYSDATE, 'IW')-7), 'YY/MM/DD') FROM DUAL;


SELECT * FROM FOLLOWER
WHERE TO_MEM_NO = 5 ORDER BY FOLLOWER_CREATE_DATE;



-- 팔로우 최대값
SELECT COUNT(*)
FROM FOLLOWER;

SELECT FOLLOWER_CREATE_DATE
FROM FOLLOWER
WHERE TO_MEM_NO = 5;

SELECT FOLLOWER_CREATE_DATE, MAX(FOLLOWERCHECK)
FROM FOLLOWER
GROUP BY FOLLOWER_CREATE_DATE;

SELECT TO_MEM_NO, SUM(FOLLOWERCHECK)
FROM FOLLOWER
GROUP BY TO_MEM_NO;

-- 누적합계
SELECT TO_MEM_NO, FOLLOWERCHECK, FOLLOWER_CREATE_DATE, SUM(FOLLOWERCHECK) OVER(PARTITION BY TO_MEM_NO ORDER BY TO_MEM_NO, FOLLOWER_CREATE_DATE) AS 합계
FROM FOLLOWER
WHERE TO_MEM_NO = 5
ORDER BY TO_MEM_NO, FOLLOWER_CREATE_DATE;


-- 최근 1주간 팔로우 증감량
SELECT SYSDATE FROM DUAL;
-- -7
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-7);
-- -6
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-6);
-- -5
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-5);
-- -4
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-4);
-- -3
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-3);
-- -2
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-2);
-- -1
SELECT COUNT(*)
FROM FOLLOWER
WHERE TO_MEM_NO = 5 AND TO_CHAR(FOLLOWER_CREATE_DATE) = TO_CHAR(SYSDATE-1);

SELECT TO_CHAR(SYSDATE-1) FROM DUAL;

-- 년월일 입력 
SELECT CONCAT('201902',LPAD(LEVEL, 2, '0')) AS GO_DAY 
FROM DUAL
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('2019' || '02' || '01', 'YYYYMMDD')), 'DD') ;

-- 년월 입력 
SELECT CONCAT('201902',LPAD(LEVEL, 2, '0')) AS GO_DAY 
FROM DUAL 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('2019' || '02', 'YYYYMM')), 'DD');




-- 더미유저 (89명)
-- 2/20 남 10대 1
INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member04', '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원04', 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '60', 'man');

-- 3/11 남 20대 17
BEGIN
    FOR N IN 1..17
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'||SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '20', 'man');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/12 남 20대 8
BEGIN
    FOR N IN 1..8
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '20', 'man');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/13 남 50대 7
BEGIN
    FOR N IN 1..7
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '50', 'man');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/13 여 30대 3
BEGIN
    FOR N IN 1..3
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '30', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/14 여 30대 10
BEGIN
    FOR N IN 1..10
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '30', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/15 여 30대 15
BEGIN
    FOR N IN 1..15
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '30', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/16 여 40대 8
BEGIN
    FOR N IN 1..8
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '40', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/17 여 30대 5
BEGIN
    FOR N IN 1..5
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '30', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/17 여 10대 10
BEGIN
    FOR N IN 1..10
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '10', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/18 X

-- 3/19 여 40대 10명
BEGIN
    FOR N IN 1..10
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '40', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;

-- 3/20 여 30대 5명
BEGIN
    FOR N IN 1..5
    LOOP
        INSERT INTO MEMBER VALUES(SEQ_MEM_MEMBER_NO.NEXTVAL, '개인', 'member'|| SEQ_MEM_MEMBER_NO.CURRVAL, '1111', 'member02@collaverse.co.kr', '01022222222', '개인회원'|| SEQ_MEM_MEMBER_NO.CURRVAL, 'profile_basic.png', NULL, NULL, DEFAULT, DEFAULT, DEFAULT, '30', 'woman');
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

COMMIT;



