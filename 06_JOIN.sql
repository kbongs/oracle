/*
    <JOIN>
        두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문이다.
        무작정 데이터를 가져오는게 아니라 각 테이블 간에 공통된 컬럼으로 데이터를 합쳐서 하나의 결과(RESULT SET)로 조회한다.
        
        1. 등가 조인(EQUAL JOIN) / 내부 조인(INNER JOIN)
            연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회한다. (일치하는 값이 없는 행은 조회 X)
            
            1) 오라클 전용 구문
                [표현법]
                    SELECT 컬럼, 컬럼, 컬럼, ...
                    FROM 테이블1, 테이블2
                    WHERE 테이블1.컬럼명 = 테이블2.컬럼명;
                    
                    - FROM 절에 조회하고자 하는 테이블들을 콤마로(,) 구분하여 나열한다.
                    - WHERE 절에 매칭 시킬 컬럼명에 대한 조건을 제시한다.
                    
            2) ANSI 표준 구문
                [표현법]
                    SELECT 컬럼, 컬럼, 컬럼, ...
                    FROM 테이블1
                    [INNER] JOIN 테이블2 ON(테이블1.컬럼명 = 테이블2.컬럼명);
                    
                    - FROM 절에 기준이 되는 테이블을 기술한다.
                    - JOIN 절에 같이 조회하고자 하는 테이블을 기술 후 매칭 시킬 컬럼에 대한 조건을 기술한다.
                    - 연결에 사용하려는 컬럼명이 같은 경우 ON 구문 대신에 USING(컬럼명) 구문을 사용한다.
*/

-- 각 사원들의 사번, 사원명, 부서 코드, 부서명을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 각 사원들의 사번, 사원명, 부서 코드, 직급명을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

-- 오라클 구문
-- 1-1) 연결할 두 컬림이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 사번, 사원명, 부서 코드, 부서명을 조회
-- 일치하는 값이 없는 행은 조회에서 제외된다. (DEPT_CODE가 NULL인 사원, DEPT_ID D3, D4, D7인 사원)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- 1-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 사원명, 직급 코드 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법 2) 테이블의 별칭을 이용하는 방법
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- ANSI 구문
-- 2-1) 연결할 두 컬림이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 사번, 사원명, 부서 코드, 부서명을 조회
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, D.DEPT_TITLE
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

-- 2-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 사원명, 직급 코드 직급명을 조회
-- 방법 1) USING 구문을 이용하는 방법
SELECT E.EMP_ID, E.EMP_NAME, JOB_CODE, J.JOB_NAME
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE);   -- USING은 같은 컬럼이라고 인식해서 ambiguously 발생하지 않는다.

-- 방법 2) 테이블의 별칭을 이용하는 방법
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, J.JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

-- 방법 3) NATURAL JOIN을 이용하는 방법 (참고만)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의 사번, 사원명, 직급명, 급여를 조회
-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '대리';

-- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '대리';

-- 1. DEPARTMENT 테이블과 LOCATION 테이블의 조인하여 부서 코드, 부서명, 지역 코드, 지역명을 조회
-- 오라클 구문
SELECT D.DEPT_ID, D.DEPT_TITLE, D.LOCATION_ID, L.NATIONAL_CODE
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

-- ANSI 구문
SELECT D.DEPT_ID, D.DEPT_TITLE, D.LOCATION_ID, L.NATIONAL_CODE
FROM DEPARTMENT D
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE;

-- 2. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명을 조회
-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, E.BONUS, D.DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND BONUS IS NOT NULL;

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE BONUS IS NOT NULL;

-- 3. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 인사관리부가 아닌 사원들의 사원명, 부서명, 급여를 조회
-- 오라클 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE != '인사관리부';

-- ANSI 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE DEPT_TITLE != '인사관리부';

-- 4. EMPLOYEE 테이블, DEPARTMENT 테이블, LOCATION 테이블을 조인해서 사번, 사원명, 부서명, 지역명 조회
-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.NATIONAL_CODE
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

-- ANSI 구문 (다중 조인은 순서가 중요하다.)
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.NATIONAL_CODE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE;

-- 5. EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL 테이블에서 사번, 사원명, 부서명, 지역명, 국가명 조회
-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE;

-- 6. 사번, 사원명, 부서명, 지역명, 국가명, 급여 등급 조회 (NON EQUAL JOIN 후에 실습 진행)(EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL, SAL_GRADE)
-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME, S.SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE AND SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

----------------------------------------------------
/*
        2. 외부 조인(OUTER JOIN)
            테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회가 가능하다.
            단, 반드시 기준이 되는 테이블(컬럼)을 지정해야 한다. (LEFT/RIGHT/(+))
*/
-- OUTER JOIN과 비교할 INNER JOIN 구해놓기
-- 부서가 지정되지 않은 사원 2명에 대한 정보가 조회되지 않는다.
-- 부서가 지정되어 있어도 DEPARTMENT에 부서에 대한 정보가 없으면 조회되지 않는다.
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY, E.SALARY * 12
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

-- 1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행한다.
-- ANSI 구문
-- 부서 코드가 없던 사원(이오리, 하동운)의 정보가 나오게 된다.
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY, E.SALARY * 12
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

-- 오라클 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY, E.SALARY * 12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+);

-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행한다.
-- ANSI 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY, E.SALARY * 12
FROM EMPLOYEE E
RIGHT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

-- 오라클 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY, E.SALARY * 12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID;

-- 2) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있다. (단, 오라클 구문은 지원하지 않는다.)
-- ANSI 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY, E.SALARY * 12
FROM EMPLOYEE E
FULL OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID;

-- 오라클 구문(에러 발생)
SELECT E.EMP_NAME, D.DEPT_TITLE, E.SALARY, E.SALARY * 12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID(+);

----------------------------------------------------
/*
        3. 카테시안곱(CARTESIAN PRODUCT) / 교차 조인(CROSS JOIN)
            조인되는 모든 테이블의 각 행들의 서로서로 모두 매핑된 데이터가 검색된다. (곱집합)
            테이블의 행들이 모두 곱해진 행들의 조합이 출력 -> 방대한 데이터 출력 -> 과부하의 위험
*/
-- ANSI 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT
ORDER BY EMP_NAME; -- 23개 행(EMPLOYEE) * 9개 행(DEPARTMENT) -> 207

-- ORACLE 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
ORDER BY EMP_NAME;

----------------------------------------------------
/*
        4. 비등가 조인(NON EQUAL JOIN)
            조인 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
            지정한 컬럼 값이 일치하는 경우가 아닌, 값의 범위에 포함되는 행들을 연결하는 방식이다.
            (= 이외의 비교 연산자 >, <, >=, <=, BETWEEN AND, IN, NOT IN 등을 사용한다.)
            ANSI 구문으로는 JOIN ON 구문으로만 사용이 가능하다.(USING 사용 불가)
*/
-- EMPLOYEE 테이블과 SAL_GRADE 테이블을 비등가 조인하여 사원명, 급여, 급여 등급 조회
-- 오라클 구문
SELECT E.EMP_NAME, E.SALARY, S.SAL_LEVEL
FROM EMPLOYEE E, SAL_GRADE S
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI 구문
SELECT E.EMP_NAME, E.SALARY, S.SAL_LEVEL, S.MIN_SAL, S.MAX_SAL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

----------------------------------------------------
/*
        5. 자체 조인(SELF JOIN)
            같은 테이블을 다시 한번 조인하는 경우에 사용한다.
*/
-- EMPLOYEE 테이블을 SELF JOIN 하여 사번, 사원 이름, 부서 코드, 사수 번호, 사우 이름 조회
-- ORACLE
SELECT E1.EMP_ID, E1.EMP_NAME AS "사원 이름", E1.DEPT_CODE, E1.MANAGER_ID AS "사수 번호", E2.EMP_NAME AS "사수 이름"
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.MANAGER_ID = E2.EMP_ID(+);

-- ANSI
SELECT E1.EMP_ID, E1.EMP_NAME AS "사원 이름", E1.DEPT_CODE, E1.MANAGER_ID AS "사수 번호", E2.EMP_NAME AS "사수 이름"
FROM EMPLOYEE E1
LEFT JOIN EMPLOYEE E2 ON E1.MANAGER_ID = E2.EMP_ID;


--------------------------- 실습 문제 -----------------------------------
-- 1. 직급이 대리이면서 ASIA 지역에서 근무하는 직원들의 사번, 사원명, 직급명, 부서명, 근무지역, 급여를 조회하시오.(EMPLOYEE, JOB, DEPARTMENT, LOACTION)
-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME, E.SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE AND E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND JOB_NAME = '대리' AND LOCAL_NAME LIKE 'ASIA%';

-- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE JOB_NAME = '대리' AND LOCAL_NAME LIKE 'ASIA%';

-- 2. 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하세요.(EMPLOYEE, DEPARTMENT, JOB)
-- 오라클 구문
SELECT E.EMP_NAME, E.EMP_NO, D.DEPT_TITLE, J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE
      AND SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79
      AND SUBSTR(EMP_NO,8,1) = '2'
      AND EMP_NAME LIKE '전%';

-- ANSI 구문
SELECT E.EMP_NAME, E.EMP_NO, D.DEPT_TITLE, J.JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79
     AND SUBSTR(EMP_NO,8,1) = '2'
     AND EMP_NAME LIKE '전%';

-- 3. 보너스를 받는 직원들의 사원명, 보너스, 연봉, 부서명, 근무지역을 조회하세요.(EMPLOYEE, DEPARTMENT, LOCATION)
--  단, 부서 코드가 없는 사원도 출력될 수 있게 OUTER JOIN 사용
-- 오라클 구문
SELECT E.EMP_NAME, NVL(E.BONUS,0), E.SALARY*12, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+) AND D.LOCATION_ID = L.LOCAL_CODE(+) AND BONUS IS NOT NULL;

-- ANSI 구문
SELECT E.EMP_NAME, E.BONUS, E.SALARY*12, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
LEFT OUTER JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE BONUS IS NOT NULL;

-- 4. 한국과 일본에서 근무하는 직원들의 사원명, 부서명, 근무지역, 근무 국가를 조회하세요.(EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL)
-- 오라클 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE AND (NATIONAL_NAME = '한국' OR NATIONAL_NAME = '일본');

-- ANSI 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
WHERE NATIONAL_NAME = '한국' OR NATIONAL_NAME = '일본';

-- 5. 각 부서별 평균 급여를 조회하여 부서명, 평균 급여(정수 처리)를 조회하세요.(DEPARTMENT, EMPLOYEE)
--  단, 부서 배치가 안된 사원들의 평균도 같이 나오게끔 해주세요.
-- 오라클 구문
SELECT D.DEPT_TITLE, FLOOR(AVG(E.SALARY))
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.DEPT_ID(+) = E.DEPT_CODE
GROUP BY DEPT_TITLE;

-- ANSI 구문
SELECT NVL(D.DEPT_TITLE, '부서없음'), FLOOR(AVG(E.SALARY))
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE
GROUP BY DEPT_TITLE
ORDER BY DEPT_TITLE;

-- 6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회하시오.
-- 오라클 구문
SELECT D.DEPT_TITLE, SUM(E.SALARY)
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.DEPT_ID = E.DEPT_CODE
GROUP BY DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000;

-- ANSI 구문
SELECT D.DEPT_TITLE, SUM(E.SALARY)
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE
GROUP BY DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000;

-- 7. 사번, 사원명, 직급명, 급여 등급, 구분을 조회 (NON EQUAL JOIN 후에 실습 진행)(EMPLOYEE, JOB, SAL_GRADE)
--  이때 구분에 해당하는 값은 아래와 같이 조회 되도록 하시오.
--  급여 등급이 S1,S2인 경우 '고급'
--  급여 등급이 S3,S4인 경우 '중급'
--  급여 등급이 S5,S6인 경우 '초급'
-- 오라클 구문
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       S.SAL_LEVEL,
       CASE WHEN SAL_LEVEL = 'S1' OR SAL_LEVEL = 'S2' THEN '고급'
            WHEN SAL_LEVEL = 'S3' OR SAL_LEVEL = 'S4' THEN '중급'
            ELSE '초급'
        END 구분
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE AND SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI 구문
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       S.SAL_LEVEL,
       CASE WHEN SAL_LEVEL = 'S1' OR SAL_LEVEL = 'S2' THEN '고급'
            WHEN SAL_LEVEL = 'S3' OR SAL_LEVEL = 'S4' THEN '중급'
            ELSE '초급'
        END 구분
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN SAL_GRADE S ON SALARY BETWEEN MIN_SAL AND MAX_SAL;


-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.(EMPLOYEE, JOB)
-- 오라클 구문
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND BONUS IS NULL AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');

-- ANSI 구문
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE BONUS IS NULL AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');

-- 9. 부서가 있는 직원들의 사원명, 직급명, 부서명, 근무 지역을 조회하시오.(EMPLOYEE, JOB, DEAPARTMENT, LOCATION)
-- 오라클 구문
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE AND E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND DEPT_CODE IS NOT NULL;

-- ANSI 구문
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE DEPT_CODE IS NOT NULL;

-- 10. 해외영업팀에 근무하는 직원들의 사원명, 직급명, 부서 코드, 부서명을 조회하시오.(EMPLOYEE, JOB, DEPARTMENT)
-- 오라클 구문
SELECT E.EMP_NAME, J.JOB_NAME, E.DEPT_CODE, D.DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE AND E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE LIKE '해외영업%';

-- ANSI 구문
SELECT E.EMP_NAME, J.JOB_NAME, E.DEPT_CODE, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE DEPT_TITLE LIKE '해외영업%';

-- 11. 이름에 '형'자가 들어있는 직원들의 사번, 사원명, 직급명을 조회하시오.(EMPLOYEE, JOB)
-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND EMP_NAME LIKE '%형%';

-- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE EMP_NAME LIKE '%형%';







