CREATE SEQUENCE CALENDAR_NO_SEQ
    START WITH 1
    INCREMENT BY 1;
    
CREATE TABLE CALENDAR (
	CALENDAR_NO NUMBER	NOT NULL PRIMARY KEY,
	CALENDAR_TITLE	VARCHAR2(200)	NOT NULL,
	CALENDAR_MEMO	VARCHAR2(500),
	CALENDAR_START	DATE,
	CALENDAR_END	DATE
);

INSERT INTO CALENDAR VALUES (CALENDAR_NO_SEQ.NEXTVAL, '드디어', NULL, SYSDATE, SYSDATE);
INSERT INTO CALENDAR VALUES (CALENDAR_NO_SEQ.NEXTVAL, '되는건가', NULL, '22/01/15', '22/01/16');
INSERT INTO CALENDAR VALUES (CALENDAR_NO_SEQ.NEXTVAL, '잘', NULL, '22/01/17', '22/01/19');
INSERT INTO CALENDAR VALUES (CALENDAR_NO_SEQ.NEXTVAL, '하는거니', NULL, '22/01/20', '22/01/25');
INSERT INTO CALENDAR VALUES (CALENDAR_NO_SEQ.NEXTVAL, '테스트', '테스트 보느날', SYSDATE, SYSDATE);
INSERT INTO CALENDAR VALUES (CALENDAR_NO_SEQ.NEXTVAL, '등록만 가능', '문제찾는중', '22/03/07', '22/03/22');

commit;



create table calendartest( 
    id number primary key, 
    groupId NUMBER, 
    title varchar2(50), 
    writer varchar2(50), 
    content varchar2(1000), 
    start1 date, 
    end1 date, 
    allDay number(1), 
    textColor varchar(50), 
    backgroundColor varchar2(50), 
    borderColor varchar2(50) 
    );
    
create sequence cal_test_seq start with 1 increment by 1 minvalue 1 maxvalue 99999;

INSERT INTO calendar values(
    cal_test_seq.nextval,
    '',
    '할일title',
    'test', 
    '내용-content',
    to_date('2021/05/01','YYYY/MM/DD'),
    to_date('2021/05/03','YYYY/MM/DD'),
    1,
    'yellow',
    'navy',
    'navy');

--01. PROMOTION 테이블 생성 + 주석
CREATE TABLE PROMOTION (   
    PMT_NO NUMBER(10) PRIMARY KEY,
    PMT_TITLE VARCHAR2(100),
    PMT_IMG_PATH VARCHAR2(100),
    PMT_CONTENT VARCHAR2(2000),
    PMT_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(PMT_STATUS IN('Y', 'N')),
    START_DATE DATE,
    END_DATE DATE,
    READCOUNT NUMBER,
    C_NO NUMBER(20),
    HEART_HIT NUMBER

);

COMMENT ON COLUMN PROMOTION.PMT_NO IS '프로모션 번호';
COMMENT ON COLUMN PROMOTION.PMT_TITLE IS '프로모션 제목';
COMMENT ON COLUMN PROMOTION.PMT_IMG_PATH IS '이미지 경로';
COMMENT ON COLUMN PROMOTION.PMT_CONTENT IS '프로모션 설명';
COMMENT ON COLUMN PROMOTION.PMT_STATUS IS '프로모션 상태';
COMMENT ON COLUMN PROMOTION.START_DATE IS '시작일';
COMMENT ON COLUMN PROMOTION.END_DATE IS '종료일';
COMMENT ON COLUMN PROMOTION.READCOUNT IS '조회수';
COMMENT ON COLUMN PROMOTION.C_NO IS '카테고리번호';
COMMENT ON COLUMN PROMOTION.HEART_HIT IS '좋아요수';


--02. PROMOTION 시퀀스 생성
CREATE SEQUENCE SEQ_PROMOTION_NO;


--03. PROMOTION 테이블 삭제 쿼리
--DROP TABLE PROMOTION;


--04. PROMOTION 시퀀스 삭제 쿼리
-- DROP SEQUENCE SEQ_PROMOTION_NO;


--05. 프로모션 데이터 추가 쿼리
-- 리빙 --
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '농심 X 카카오프렌즈', '/resources/images/promotion/promotion', '자꾸만 손이 가는 단짠 콜라보 새우깡으로 변신한 라이언과 꿀꽈배기로 변신한 춘식이! <p> 국민 대표 스낵 새우깡으로 변신한 라이언과 스낵 꿀꽈배기로 변신한 춘식이를 만나보세요.', DEFAULT, to_date('22/01/20','RR/MM/DD'), NULL, NULL, 1, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '대구1988 × 천하장사', '/resources/images/promotion/promotion', '30년 이상의 전통을 가진 천하장사와 대구 1988이 만났습니다. <p> 건강하고 즐거운 잠을 위한 소시지 침구를 만나보세요', DEFAULT, to_date('22/02/21','RR/MM/DD'),to_date('22/03/07','RR/MM/DD'), NULL, 1, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '도프제이슨 X 렉슨', '/resources/images/promotion/promotion', '서로 다른 분야에서 인정받아온 도프제이슨과 렉슨의 만남을 통해 <p> 공간의 분위기를 색다르게 뒤바꿔줄 미나 머쉬룸 램프를 만나보세요', DEFAULT, to_date('22/01/27','RR/MM/DD'), NULL, NULL, 1, 0);

-- 문화 -- 
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '카트라이더 X 피자헛', '/resources/images/promotion/promotion', '한국피자헛과 넥슨 모바일 레이싱 게임 카트라이더 러쉬플러스의 만남! <p> 한정판 아이템이 담긴 ‘카러플팩’을 통해 색다른 재미를 느껴보세요.', DEFAULT, to_date('22/01/25','RR/MM/DD'), to_date('22/02/27','RR/MM/DD'), NULL, 2, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '와디즈 X 메이플스토리', '/resources/images/promotion/promotion', '넥슨과 크라우드펀딩 플랫폼인 와디즈의 팬즈메이커(FANZ MAKER) 프로젝트. <p> 주요 캐릭터를 활용한 일상 제품부터 특별한 용도를 지닌 제품까지 모두 만나보세요.', DEFAULT, to_date('22/02/21','RR/MM/DD'), to_date('22/03/07','RR/MM/DD'), NULL, 2, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '노루페인트 X 테레사 프레이타스', '/resources/images/promotion/promotion', '노루페인트가 세계 최초 테레사 프레이타스 사진전에 스며들었습니다. <p> 노루페인트가 활용한 파스텔 톤의 페인트들을 통해 봄날의 감성을 느껴보세요. ', DEFAULT, to_date('22/01/29','RR/MM/DD'), to_date('22/04/24','RR/MM/DD'), NULL, 2, 0);

-- 식품 --
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '롯데제과 X 에스더버니', '/resources/images/promotion/promotion', '﻿롯데제과와 에스더버니 캐릭터의 만남! <p> 딸기를 주원료로한 분홍색 패키지의 사랑스러운 봄 시즌 제품을 만나보세요.', DEFAULT, to_date('22/02/14','RR/MM/DD'), NULL, NULL, 3, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '뚜레쥬르 X 디즈니', '/resources/images/promotion/promotion', '미키, 미니 캐릭터의 경쾌한 색감과 생동감 넘치는 표정으로 완성해 <p> 사랑스러운 비주얼이 돋보이는 뚜레쥬르의 밸런타인 시즌 제품을 만나보세요.', DEFAULT, to_date('22/02/07','RR/MM/DD'), NULL, NULL, 3, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '설빙 X 켈로그', '/resources/images/promotion/promotion', '코리안 디저트 카페 설빙과 글로벌 시리얼 브랜드 켈로그와의 두 번째 협업! <p> 한층 더 업그레이드된 콜라보 신메뉴를 만나보세요.', DEFAULT, to_date('22/02/23','RR/MM/DD'), NULL, NULL, 3, 0);

-- 테크 --
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '삼성 X 메종키츠네', '/resources/images/promotion/promotion', '메종 키츠네의 신비로운 상징, 여우가 자연스럽게 갤럭시 안으로 스며들었습니다. <p> 깔끔하며 미래지향적인 미학을 담고있는 갤럭시 워치4와 버즈2 메종 키츠네 에디션을 만나보세요.', DEFAULT, to_date('21/11/10','RR/MM/DD'), NULL, NULL, 4, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '소니 X 캐피탈 라디오 튠즈', '/resources/images/promotion/promotion', '21 F/W 시즌 키 아이템 헤드폰과 후드, 비니와 함께 매치하는 스타일 트렌드를 반영해 <p> 음악이라는 테마 아래 소니 x CRT 협업 한정판 어패럴을 만나보세요.', DEFAULT, to_date('21/10/13','RR/MM/DD'), NULL, NULL, 4, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '케이스티파이 X 피너츠', '/resources/images/promotion/promotion', '﻿Peanuts x CASETiFY 레트로 캔디샵으로 여러분을 초대합니다! <p> 일상을 더욱 달콤하게 만들어 줄 피너츠 패밀리 캐릭터들의 다채로운 디자인 컬렉션을 만나보세요.', DEFAULT, to_date('21/01/28','RR/MM/DD'), NULL, NULL, 4, 0);

-- 패션 --
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '스파오 X 짱구', '/resources/images/promotion/promotion', '스파오와 짱구의 22SS 봄 신상 꿀잠 파자마를 만나보세요.', DEFAULT, to_date('22/02/21','RR/MM/DD'), NULL, NULL, 5, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '예일 × 벌스데이수트', '/resources/images/promotion/promotion', '과거 예일의 신입생 복장 규정을 현대적으로 재해석하여 위트 있게 표현한 <p> 예일 × 벌스데이수트 22 S/S 협업 컬렉션을 만나보세요.', DEFAULT, to_date('22/02/18','RR/MM/DD'), to_date('22/02/25','RR/MM/DD'), NULL, 5, 0);
INSERT INTO PROMOTION VALUES(SEQ_PROMOTION_NO.NEXTVAL, '로이드 × 로캐론', '/resources/images/promotion/promotion', '패턴로캐론의 타탄 패턴이 로이드만의 감각적인 감성으로 담겼습니다. <p> 시그니처 시계, 웨어러블 스트랩 과 로캐론 패턴의 콜라보를 만나보세요.', DEFAULT, to_date('22/02/23','RR/MM/DD'), to_date('22/03/08','RR/MM/DD'), NULL, 5, 0);



DROP TABLE CALENDAR;

CREATE TABLE CALENDAR (
    subject varchar2(50),
    startDate varchar2(30),
    endDate varchar2(30),
    memo varchar2(1000),
    color varchar2(20)
);
    
CREATE TABLE CAL (
    subject varchar2(50),
    startDate varchar2(30),
    endDate varchar2(30),
    type varchar2(10),
    color varchar2(20),
    memo varchar2(1000)
);

SELECT DATE_ADD(endDate, INTERVAL 1 DAY) WHERE subject='안녕';
    
    
SELECT  TO_DATE(endDate, 'YYYY-MM-DD')+ INTERVAL '1' DAY 
FROM CALENDAR
WHERE SUBJECT='안녕';
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    