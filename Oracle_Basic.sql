--개발자 입장의 SQL: CRUD
--Create(Insert) Read(Select) Update Delete

--실습테이블 구성
--Emp(사원 테이블)
--Dept(부서 테이블)
--Salegrade(급여등급 테이블)

/* 문법
select [distinct] {*, column [alias], ...}
from table_name
[where condition]
[order by {column, expression} [asc|desc]]
*/

select empno, ename, sal from emp;
select empno, ename, job, hiredate, deptno from emp;

--컬럼에 가명칭(alias) 부여하기
select empno 사번, ename 이름 from emp;
select empno "사   번" from emp;
--권장사항
--as 가명칭
select empno as "사 번", ename as "이 름" from emp;

--문자데이터 사용하기
--java: "홍길동", java: '동'
--java: 문자열 연결은 +

--오라클: '문자열'
--오라클 테이블에 대한 간단한 정보 보기
desc emp; --컬럼 이름, 타입보기
--오라클 +는 산술연산, 문자결합연산자 ||
--ms-sql은 +가 다 한다
select '사원의 이름은: '||ename as "사원이름" from emp;

--주의: 컬럼의 타입을 잘 생각해서 결합해야 한다
--근데 이게 된다 -> 내부적으로 형변환이 일어난다
select empno||ename as "결합" from emp;
--숫자||문자 -> 문자

-- +산술연산 ||연결연산
--오라클은 실행결과를 담을 수 있는 가상테이블(dual)을 만들어줘야 한다
select 100+100 from dual;
select 100||100 from dual;
select '100'+100 from dual; --문자형 숫자데이터
select '100A'+100 from dual; --에러

select empno+sal as "합계" from emp;
select empno+ename from emp; --에러
select empno||ename from emp; --이건 됨

--from 사장님
--우리 회사의 직종이 몇 개냐??
select distinct job from emp;

--오라클은 구문에서 대소문자는 구별하지 않는다
--오라클은 문자데이터를 엄격하게 구분
--오라클에서 SMITH, smith는 다른 문자, MS-SQL에서는 같은 문자

--앞에거에 대해 그룹핑, 중간거에 그룹핑, 뒤에걸로 distinct
--distinct를 많이 거는 것은 좋지 않다
select distinct deptno from emp;
select distinct deptno, job from emp order by deptno;

--오라클 연산자
--산술연산은 자바 연산자와 거의 비슷
--나머지 구하기: MOD

--사원의 급여를 100달러 인상하기
select * from emp;
select empno, ename, sal as "기본급여", sal+100 as "인상급여" from emp;

--비교연산자
-- < > <= >= =(같다) !=
--논리연산자
--AND OR NOT

--조건: where (조건에 맞는 row만 추출)
--급여가 3천달러 이상인 모든 사원의 정보 출력하기
select * from emp where sal>=3000;

--SQL 튜닝의 기본은 실행순서
--select  3 (젤 나중에 써도 됨)
--from    1
--where   2

--사번이 7788번인 사원의 사번, 이름, 직종, 입사일 출력하기
select empno, ename, job, hiredate from emp where empno=7788;

--사원의 이름이 king인 사원의 사번, 이름 출력하기
select empno, ename from emp where ename='KING';

--급여가 2000달러 이상이면서 직종이 manager인 사원의 모든 정보 출력
select * from emp where sal>=2000 and job='MANAGER';

--날짜 표현 '2016-12-12'의 형태
--오라클이 가지는 시간정보(서버시간)
select sysdate from dual;
select hiredate from emp;
--오라클의 시스템 설정 정보(언어, 시간포맷, 날짜)
select * from SYS.NLS_SESSION_PARAMETERS;
select * from SYS.NLS_SESSION_PARAMETERS where PARAMETER='NLS_DATE_FORMAT';

--날짜표기: '날짜' (문자와 같이 표기한다)
select * from emp where hiredate='80/12/17';
select * from emp where hiredate='1980-12-17';
select * from emp where hiredate='2080-12-17';

--현재접속자(세션 기준)
--접속이 끊어지면 원래대로 돌아간다
--RR/MM/DD -> YYYY-MM-DD
alter session set nls_date_format='YYYY-MM-DD HH24 MI:SS';
COMMIT;
select * from SYS.NLS_SESSION_PARAMETERS where PARAMETER='NLS_DATE_FORMAT';
select sysdate from dual;
select hiredate from emp;

--입사일이 1980년 12월 17일인 사원의 모든 데이터 출력하기
select * from emp where hiredate='1980-12-17';
select * from emp where hiredate='80-12-17'; --포맷 바꿔서 안나옴, 구분자/는 인정

--입사일이 1982년 1월 1일 이후인 모든 사원의 정보 출력하기
select * from emp where hiredate>'1982-1-1';

--오라클 서버시간 활용은 어디에서?
--게시판에 글 작성시 날짜표시
--insert into board(boaridid, title, writer, regdate)
--values(1,'제목','방가','홍길동',sysdate);
--ms-sql: select getdate();

--사원의 급여가 2000달러 이상 4천달러 이하인 모든 사원의 정보 출력하기
select * from emp where sal>=2000 and sal<=4000;
--코드 줄이기
--between A and B (=포함하니까 조심해서 써야 한다)
select * from emp where sal between 2000 and 4000; 

--부서번호가 10 or 20 or 30인 사원의 사번, 이름, 급여, 부서번호 출력하기
select empno, ename, sal, deptno
from emp
where deptno=10 or deptno=20 or deptno=30;
--in 연산자: 컬럼명 in(데이터, 데이터, ...) > orororor
select empno, ename, sal, deptno
from emp
where deptno in (10, 20, 30); --오라클에서는 실제로 or or로 해석한다

--부서번호가 10번이 아닌 모든 사원의 정보 출력하기
select *
from emp
where deptno!=10;

--부서번호가 10, 20번이 아닌 모든 사원의 정보 출력하기
select *
from emp
where deptno!=20 and deptno!=10;
select *
from emp
where deptno not in (10, 20); --and 연산

--DB에서 데이터가 없다 -> null 필요악
--ex)회원가입에서 필수/부가 입력
/*
create table member(
  uerid varchar2(20) not null, --필수입력
  name varchar2(20) not null, --필수입력
  hobby varchar2(50) --부가입력
)
널의 활용/제어가 필요하다
*/

select sal, comm from emp;
--수당을 받지 않는 모든 사원의 정보 출력하기
select * from emp where comm=null; --이럼 안나온다
--null에 대한 비교는 is null, is not null
select * from emp where comm is null;
--수당을 받는 모든 사원의 정보 출력하기
select * from emp where comm is not null;

--사원테이블에서 사번, 이름, 급여, 수당, 총급여 출력하기
select empno, ename, sal, comm, sal+comm as "총급여" from emp;
--null 때문에 제대로 나오지 않는다
--null과의 모든 연산의 결과는 null
--null을 처리하는 함수 필요가 가장 중요하다
--오라클: nvl(), mssql: Convert() -> null을 치환한다
--nvl(컬럼명, 치환값)
select empno, ename, sal, comm, sal+nvl(comm, 0) as "총급여" from emp;


--사원의 급여가 1000 이상이고 수당을 받지 않는 사원의 사번, 이름, 직종, 급여
--, 수당을 출력하기
select empno, ename, job, sal, comm from emp where sal>=1000 and comm is null;

--DQL: select
--DDL:
--create, alter, drop, ...

create table member(
  userid VARCHAR2(20) not null, --영문20자, 한글10자
  hobby VARCHAR2(20), --(default null)
  hp VARCHAR2(10) null
);

--DML
--insert, update, delete
insert into member (userid) values ('hong');
--rollback;
commit; --디스크에 실반영, rollback 불가능
select * from member;
insert into member (hobby) values ('농구'); --에러에러에러
insert into member(userid, hobby) values ('kglim', '축구');
select * from member;
commit;

--nvl은 숫자/문자 모두 가능
select userid, nvl(hobby,'취미없음')as "취미" from member;

--문자열 데이터 중
--검색 (like 패턴 검색)
--ex)우편번호 검색
--와일드카드 문자(%모든 것, _한문자)를 조합해서 패턴작성
--정규표현식
select ename from emp where ename like '%A%'; --A가 들어간 모든 사람
select ename from emp where ename like 'A%'; --A로 시작되는
select ename from emp where ename like '%S'; --S로 끝나는
select ename from emp where ename like '%LL%';
select ename from emp where ename like '%A%A%'; --A가 두번 들어가는 사람
select ename from emp where ename like '_A%'; --A가 두번째

--과제: 오라클의 정규표현식(regexp_like)
--조사 후 예제 3개 만들기
select * from emp where regexp_like (ename, '[A-C]');

--게시판 검색기능에서 사용

--데이터 정렬하기
--order by 컬럼명: 문자, 날짜, 숫자 가능
--오름차순, 내림차순
select * from emp order by sal; --default asc
select * from emp order by sal desc; --default asc

--입사일이 가능 늦은 순으로 정렬해서 사번, 이름 , 급여, 입사일 출력하기
select empno, ename, sal, hiredate from emp order by hiredate desc;
--문자데이터 정렬
select ename from emp order by ename;

--쿼리 실행 순서
--select  3
--from    1
--where   2
--order by  4

select empno, ename, sal, job, hiredate from emp where job='MANAGER' order by hiredate desc;

--문제
select job, deptno from emp order by job asc, deptno desc; --그룹 안에서 정렬
select deptno, job from emp order by deptno desc, job; --그룹 안에서 정렬
--order by 순서와 컬럼 순서를 맞추면 보기 좋다



--합집합 UNION
--테이블과 테이블 합치기, 중복값 배제
--UNION ALL 중복값 허용해서 합치기

create table UTA(name VARCHAR2(20));
insert into UTA(name) values('AAA');
insert into UTA(name) values('BBB');
insert into UTA(name) values('CCC');
insert into UTA(name) values('DDD');
commit;
select * from UTA;

create table UT(name VARCHAR2(20));
insert into UT(name) values('AAA');
insert into UT(name) values('BBB');
insert into UT(name) values('CCC');
commit;
select * from UT;

select * from ut union select * from uta; --앞 테이블 데이터 아래에 뒷테이블 데이터를 붙인다
select * from ut union all select * from uta; --조인과는 다르다 조인과는!

--합집합에서 중요한 것
--대응되는 컬럼의 타입은 동일해야 한다
select empno, ename from emp
union
select deptno, dname from dept;

--이건 에러
select empno, ename from emp 
union
select dname, deptno from dept;

--대응되는 컬럼의 수가 일치해야 한다
--수가 안맞는 경우 null을 이용한 컬럼을 만들어 붙임
select empno, ename, job from emp
union
select deptno, dname, null from dept;

-------------------------------------------------------------
--문자열 합수
--대소문자변환
select initcap('the super man') from dual;
select lower('the super man') from dual;
select upper('the super man') from dual;
select ename, lower(ename) as "ename" from emp;
select * from emp where lower(ename)='king';

--문자개수
select length('abc') from dual;
select length('홍길동') from dual;
select length('홍 길 동') from dual;

--결합연산자 || 이게 성능이 좋다
select 'aaa'||'bbbb' from dual;
--결합함수
select concat('aaa', 'bbbb') from dual;
select concat(ename, job) from emp;
select ename||' '||job||'입니다' from emp;

--java: substring > substr()
select substr('ABCDE', 2, 3) from dual;
select substr('ABCDE', 1, 1) from dual;
select substr('ABCDE', 3, 1) from dual;
select substr('ABCDE', 3) from dual;
select substr('ABCDE', -2, 1) from dual; --뒤에서 2번째부터 1개
select substr('ABCDE', -2, 2) from dual;

--문제
--사원테이블에서 ename 컬럼 데이터에 대해 첫글자는 소문자로
--나머지 문자는 대문자로 출력하되 하나의 컬럼으로 만들기(가명칭 fullname)
--조건: 첫글자와 나머지 문자 사이에 공백 하나 넣기
--ex) SMITH > s MITH
select lower(substr(ename,1,1))||' '||substr(ename,2) as "fullname" from emp;

--LPAD, RPAD (좌, 우 남는공간 채우기)
select lpad('ABC', 10, '*') from dual;
select rpad('ABC', 5, '@') from dual;
--사용
--사용자 입력: hong1008
--화면출력: ho******
select rpad(substr('hong1008', 1, 2), length('hong1008'), '*') as ID from dual;
select rpad(substr(ename, 1, 2), length(ename), '*') as ID from emp;

--퀴즈
create table member2(
  id number,
  jumin VARCHAR2(14)
);
insert into member2(id, jumin) values(100,'123456-1234567');
insert into member2(id, jumin) values(200,'234567-1234567');
commit;
select * from member2;
--출력결과가 100, 123456-******* 의 형태로 나오도록
--컬럼명 jumin
select id||', '||rpad(substr(jumin, 1, 7), length(jumin), '*') as "jumin" from MEMBER2;

--RTRIM, LTRIM (좌, 우측 특정 문자 삭제)
select rtrim('MILLER', 'ER') from dual;
select ltrim('MILLER', 'M') from dual;

--치환함수 replace
select replace('ABCDE', 'A', 'WOW') FROM DUAL;
SELECT ENAME, REPLACE(ENAME, 'A', 'KIM') FROM EMP;
-------------------------------------------------------------
--숫자함수
--ROUND() 반올림
SELECT ROUND(12.345, -1) AS "R" FROM DUAL;
SELECT ROUND(12.567, 0) AS "R" FROM DUAL;
SELECT ROUND(12.345, 1) AS "R" FROM DUAL;
--TRUNC() 절사
SELECT TRUNC(12.345, -1) AS "T" FROM DUAL;
SELECT TRUNC(12.567, 0) AS "T" FROM DUAL;
SELECT TRUNC(12.345, 1) AS "T" FROM DUAL;
--MOD() 나머지 구하는 함수, 연산자가 아니다
SELECT 12/10 FROM DUAL; --/가 모든 결과값이 나온다
SELECT MOD(12, 10) FROM DUAL;
SELECT MOD(0, 0) FROM DUAL; --0으로 인정해 준다

-------------------------------------------------------------
--날짜함수
SELECT * FROM SYS.NLS_SESSION_PARAMETERS;
SELECT SYSDATE FROM DUAL;

--날짜함수 사용 시 주의 사항
--날짜+-숫자 > 날짜(숫자는 일로 계산)
--날짜-날짜 > 숫자(일) > 총 근무일수 구하기

SELECT MONTHS_BETWEEN('2016-02-22', '2015-02-22') FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, '2010-01-01') FROM DUAL;

SELECT SYSDATE+100 FROM DUAL;

--퀴즈
--사원 테이블에서 사원들의 입사일에서 현재까지의 근속월수 구하기
--조건: 근속월수는 정수로
--한달이 31이라고 강제하고 근속월수를 구하기(정수 반올림 처리)
SELECT EMPNO, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE))AS "근속월수1",
ROUND((SYSDATE-HIREDATE)/31, 0) AS "근속월수2" FROM EMP;

-------------------------------------------------------------
--변환함수
--TO_CHAR() 날짜 > 숫자, 숫자 > 문자
--TO_DATE() 문자 > 날짜
--TO_NUMBER() 문자 > 숫자

--오라클 기본타입
--CREATE TABLE 테이블명(컬럼명 타입정보) = CLASS MEMBER {INT AGE, ...}

--문자타입
--CHAR(20) > 고정길이 > 내부 검색속도가 빠르다
--VARCHAR2(20) > 가변길이

--유니코드: 모든 것을 2바이트로 표현
--varchar2(20): 한글 영문 혼합
--nchar(20): 20자 > 40바이트
--nvarchar(20): 20자 > 40바이트

CREATE TABLE TEST(
  COL1 CHAR(20),
  COL2 VARCHAR2(20),
  COL3 NCHAR(20),
  COL4 NVARCHAR2(20),
  COL5 NUMBER,
  COL6 NUMBER(5),
  COL7 NUMBER(10, 3) --전체 10자리 중 소수 3자리
);
INSERT INTO TEST(COL3) VALUES('AAAAAAAAAAAAAAAAAA');
SELECT * FROM TEST;
INSERT INTO TEST(COL3) VALUES('가가가가가가가가가가가가가가가');

-------------------------------------------------------------
--TO_NUMBER()
SELECT 1+1 FROM DUAL;
SELECT 1+'1' FROM DUAL; --자동 형변환
SELECT '100'+'100' FROM DUAL; --TO_NUMBER('100')
-------------------------------------------------------------
--TO_CHAR()
--날짜 > 문자 변환시 표기형식이 적용된다
-- YYYY MM DD DAY DY(요일 약어)
SELECT SYSDATE||'일' FROM DUAL; --자동 형변환
SELECT TO_CHAR(SYSDATE)||'일' FROM DUAL; --이렇게 원칙적으로 하는 것이 좋다
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'YYYY')||'년' AS "YYYY",
       TO_CHAR(SYSDATE, 'YEAR'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

--퀴즈
--입사월이 12월인 사원의 사번, 이름, 입사일, 입사년도 입사월 출력하기
SELECT EMPNO, ENAME,
       TO_CHAR(HIREDATE, 'DD') AS "입사일",
       TO_CHAR(HIREDATE, 'YYYY') AS "입사년도"
FROM EMP
WHERE SUBSTR(HIREDATE, 6, 2)=12;
--주의 형식문자 안에서 일반 문자 결합은 ""안에 넣어서 처리
--EX) 'YYYY"년" MM"월"'

--주민번호 설계 시 스타일
--A는 VARCHAR2(14)
--B는 앞자리 NUMBER(6) 뒷자리 NUMBER(7)

--TO_CHAR(숫자, '형식')
--100,000은 문자
SELECT '>'||TO_CHAR(12345,'99999999')||'<' FROM DUAL; --9는 남는 자리수 빈공간으로 채우기
SELECT '>'||TO_CHAR(12345,'00000000')||'<' FROM DUAL; --0는 남는 자리수 0으로 채우기
SELECT '>'||TO_CHAR(12345,'$9999999')||'<' FROM DUAL; --문자표현
SELECT '>'||TO_CHAR(1234567,'$9,999,999')||'<' FROM DUAL; --문자표현
SELECT EMPNO, ENAME, TO_CHAR(SAL, '$999,999')
FROM EMP
WHERE DEPTNO=30
ORDER BY SAL DESC;
-------------------------------------------------------------
--HR계정에서 시작
SELECT * FROM EMPLOYEES;
--사원 테이블에서 사원이 이름은 (LAST NAME, FIRST NAME) 합쳐서 FULLNAME으로 출력
--입사일은 YYYY-MM-DD 형식으로 출력
--연봉을 구하고 연봉의 10% 인상분을 구한 값 1000단위 콤마처리
--2005년 이후 입사자들만 출력
SELECT LAST_NAME||' '||FIRST_NAME AS "FULLNAME",
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS "HIRE_DATE",
       SALARY,
       SALARY*12 AS "연봉",
       TO_CHAR(SALARY*12*1.1, '999,999') AS "인상분"
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY')>='2005'
ORDER BY "연봉" DESC;
-------------------------------------------------------------
--개발자로
--TO_DATE 문자 > 날짜
SELECT TO_DATE('2016-12-12', 'YYYY-MM-DD') FROM DUAL;
-------------------------------------------------------------
--문자 > 숫자 > 날짜 > 변환 > 일반

--일반함수
CREATE TABLE F_EMP(
  ID NUMBER(6),
  JOB VARCHAR2(20)
);
INSERT INTO F_EMP(ID, JOB) VALUES (100, 'IT');
INSERT INTO F_EMP(ID, JOB) VALUES (200, 'SALES');
INSERT INTO F_EMP(ID, JOB) VALUES (300, 'MGR');
INSERT INTO F_EMP(ID) VALUES (400);
COMMIT;

--NVL2() > NULL처리
SELECT ID, JOB, NVL2(JOB, 'AAA', 'BBB') FROM F_EMP;
--JOB의 NULL이 아닌 것은 처음값, NULL이면 뒷값
SELECT ID, JOB, NVL2(JOB, JOB, 'EMPTY') FROM F_EMP; --잘 안쓰긴 한다
SELECT ID, JOB, NVL(JOB, 'EMPTY') FROM F_EMP; --이거랑 결과 같음

--DECODE(표현식, 조건1, 결과1, 조건2, 결과2, ....) IF와 비슷
SELECT ID, JOB, DECODE(ID,
                        100, 'IT...',
                        200, 'SALES...',
                        300, 'MGR...',
                        'ETC'
                      ) AS "JOB"
FROM F_EMP;
SELECT DECODE(JOB, 'IT', 1) FROM F_EMP;
--GROUP + DECODE 함수 통계정보 추출
SELECT COUNT(DECODE(JOB, 'IT', 1)), COUNT(DECODE(JOB, 'SALES', 1))
FROM F_EMP
GROUP BY JOB;

--EMP 테이블에서 부서번호가 10이면 인사부, 20이면 관리부, 30이면 회계부
--나머지는 기타부서로 출력 (컬럼명 부서이름)
SELECT DEPTNO, DECODE(DEPTNO,
                      10, '인사부',
                      20, '관리부',
                      30, '회계부',
                      '기타부서'
             ) AS "부서이름"
FROM EMP
ORDER BY DEPTNO;

--퀴즈
CREATE TABLE F_EMP2(
  ID NUMBER(2),
  JUMIN CHAR(7)
);
INSERT INTO F_EMP2(ID, JUMIN) VALUES (1, '1234567');
INSERT INTO F_EMP2(ID, JUMIN) VALUES (2, '2234567');
INSERT INTO F_EMP2(ID, JUMIN) VALUES (3, '3234567');
INSERT INTO F_EMP2(ID, JUMIN) VALUES (4, '4234567');
COMMIT;
SELECT * FROM F_EMP2;
--F_EMP2에서 ID, JUMIN 출력하되 JUMIN의 앞자리가 1이면 남성, 2이면 여성, 3이면 중성, 그외는 기타로 출력
--컬럼명 GENDER로
SELECT ID, JUMIN, DECODE(SUBSTR(JUMIN,1,1),
        1, '남성',
        2, '여성',
        3, '중성',
        '기타'
        ) AS GENDER
FROM F_EMP2;

--퀴즈
--부서번호가 20번인 사원 중 이름이 SMITH면 HELLO 출력
--부서번호가 20번인 사원 중 이름이 SMITH가 아니면 WORLD 출력
--부서번호가 20번이 아니면 ETC 출력
SELECT ENAME, DEPTNO, DECODE(DEPTNO,
        20, DECODE(ENAME,
                  'SMITH', 'HELLO',
                  'WORLD'
                  ),
        'ETC'
        ) AS "판별"
FROM EMP;

--CASE문 > 자바의 SWITCH
--CASE 조건 WHEN 결과1 THEN 출력1
--         WHEN 결과2 THEN 출력2
--         WHEN 결과3 THEN 출력3
--         ELSE 출력4
--END "컬럼명"
CREATE TABLE T_ZIP(
  ZIPCODE NUMBER(10),
  REGION VARCHAR2(20)
);
INSERT INTO T_ZIP(ZIPCODE) VALUES(2);
INSERT INTO T_ZIP(ZIPCODE) VALUES(31);
INSERT INTO T_ZIP(ZIPCODE) VALUES(32);
INSERT INTO T_ZIP(ZIPCODE) VALUES(33);
INSERT INTO T_ZIP(ZIPCODE) VALUES(41);
COMMIT;
SELECT * FROM T_ZIP;
SELECT '0'||TO_CHAR(ZIPCODE),
CASE ZIPCODE WHEN 2 THEN '서울'
             WHEN 31 THEN '경기'
             WHEN 32 THEN '강원'
             WHEN 33 THEN '대전'
             ELSE '기타지역' END "REGIONNAME"
FROM T_ZIP;   

--퀴즈
--사원테이블에서 사원급여가 1000달러 이하면 4급
--1001~2000 3급
--2001~3000 2급
--3001~4000 1급
--4001 이상 특급
--사번, 이름, 급여, 급여등급
--이렇게도 쓸 수 있다
SELECT EMPNO, ENAME, SAL, CASE WHEN SAL<=1000 THEN '4급'
                               WHEN SAL BETWEEN 1001 AND 2000 THEN '3급'
                               WHEN SAL BETWEEN 2001 AND 3000 THEN '2급'
                               WHEN SAL BETWEEN 3001 AND 4000 THEN '1급'
                               WHEN SAL > 4000 THEN '특급'
                          END "급여등급"
FROM EMP;
-------------------------------------------------------------
--문자 > 숫자 > 날짜 > 변환 > 일반 > 집계
--COUNT, SUM, AVG, MAX, MIN
--집계함수는 무조껀 GROUP BY 절과 같이 사용된다
--모든 집계함수는 NULL을 무시한다
--SELECT절에 집계함수 외에 다른 컬럼이 오면 반드시 GROUP BY 절에 그 컬럼을 명시해야 한다

--COUNT(컬럼명): 컬럼의 데이터 건수
--COUNT(*): ROW 수 반환
SELECT COUNT(COMM) FROM EMP;
SELECT COUNT(NVL(COMM,0)) FROM EMP;
SELECT SUM(COMM) AS "SUM" FROM EMP;

--평균은 회사 정책에 따라 달라짐
SELECT AVG(COMM) AS"AVG" FROM EMP; --721
SELECT 4330/14 FROM DUAL; --309

--직계함수는 리턴되는 것이 하나의 ROW
SELECT MAX(SAL) FROM EMP;
SELECT COUNT(SAL), AVG(SAL), SUM(SAL), MAX(SAL), MIN(SAL) FROM EMP;
-------------------------------------------------------------
--EMPNO는 중복값이 없어서 그룹이 의미가 없다
SELECT EMPNO, SUM(SAL)
FROM EMP
GROUP BY EMPNO;

--직종별 평균급여 구하기
SELECT JOB, AVG(SAL), COUNT(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB;

--부서별, 직종별 급여의 합
SELECT DEPTNO, JOB, SUM(SAL), COUNT(SAL) --3
FROM EMP                --1
GROUP BY DEPTNO, JOB    --2
ORDER BY DEPTNO;        --4

--SELECT 4
--FROM 1
--WHERE 2
--GROUP BY 3
--ORDER BY 5
SELECT JOB, AVG(SAL) AS "AVGSAL"
FROM EMP
WHERE SAL>1000
GROUP BY JOB
ORDER BY "AVGSAL";

--직종별 평균급여가 3천달러 이상인 사원의 직종과 평균급여 구하기
--실행 순서 때문에 "직종별 평균급여" 구하기 불가능
--그래서 GROUP BY의 조건절인 HAVING절을 이용한다
SELECT JOB, AVG(SAL) AS "AVGSAL" --4
FROM EMP --1
GROUP BY JOB --2
HAVING AVG(SAL) >=3000; --3 순서상 ALIAS를 사용할 수 없다

--단일 테이블 대상 SELECT
--SELECT 5
--FROM 1
--WHERE 2
--GROUP BY 3 
--HAVING 4
--ORDER BY 6

--사원테이블에서 직종별 급여의 합을 출력하되,
--수당은 지급 받고 급여의 합이 5000이상인 사원들의 목록을 출력하되,
--급여의 합이 낮은 순으로 출력
SELECT JOB, SUM(SAL) AS "급여합"
FROM EMP
WHERE COMM IS NOT NULL
GROUP BY JOB
HAVING SUM(SAL) >=5000
ORDER BY "급여합";

--사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합 출력
SELECT DEPTNO, COUNT(SAL) AS "인원수", SUM(SAL) AS "급여합"
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(DEPTNO) >=4;

--사원테이블에서 직종별 급여의 합이 5000을 초과하는 직종과 급여의 합을 출력
--단, 판매직종(SALESMAN)은 제외하고 급여의 합으로 내림차순 정렬
SELECT JOB, SUM(SAL) AS "급여합"
FROM EMP
WHERE JOB!='SALESMAN'
GROUP BY JOB
HAVING SUM(SAL)>5000
ORDER BY "급여합" DESC;

-------------------------------------------------------------
--단일테이블 대상은 끝
--하나 이상의 테이블 > 조인
--사번, 이름, 부서번호, 부서명 출력

--ANSI 문법(조건절 WHERE가 명확하다)
SELECT EMP.EMPNO, EMP.ENAME, EMP.DEPTNO, DEPT.DNAME 
FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--오라클 조인(이건 이제 쓰지 말자, 조건절 WHERE가 명확하지 않다)
SELECT EMP.EMPNO, EMP.ENAME, EMP.DEPTNO, DEPT.DNAME
FROM EMP, DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO

--JOIN은 다중 테이블에서 데이터를 검색하는 방법
--종류

--1.등가조인(EQUI JOIN)
--원래 테이블과 대상 테이블 컬럼의 데이터를 1:1 매핑
--(INNER) JOIN ON 조건절
--ANSI 문법(SQL 표준문법)을 사용

--2.비등가조인(NON-EQUI JOIN) > 의미만 존재, 실제 문법은 등가조인과 같다
--원테이블과 대응되는 테이블에 있는 컬럼의 데이터가 1:1 매핑되지 않는 경우
--EX) SAL의 SALGRADE를 찾을 때

--3.OUTER JOIN(등가조인+NULL) > 등가조인은 NULL을 해석하지 못해서 만들었다
--두 개의 테이블에서 주종관계를 파악하는 것이 중요
--LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN

--4.SELF JOIN(자기참조) > 의미만 존재, 실제 문법은 등가조인과 같다
--EX) EMP 테이블에서 관리자 이름 찾기
--하나의 테이블 안에서 컬럼이 다른 컬럼을 참조하는 경우

create table M (M1 char(6) , M2 char(10));
create table S (S1 char(6) , S2 char(10));
create table X (X1 char(6) , X2 char(10));

insert into M values('A','1');
insert into M values('B','1');
insert into M values('C','3');
insert into M values(null,'3');
commit;

insert into S values('A','X');
insert into S values('B','Y');
insert into S values(null,'Z');
commit;

insert into X values('A','DATA');
commit;

select * from m;
select * from s;
select * from x;
----------------------------------------------
--오라클 문법(NOT GOOD)
SELECT M.M1, M.M2, S.S2
FROM M, S
WHERE M.M1=S.S1;

--ANSI 문법(GOOD!)
SELECT M.M1, M.M2, S.S2
FROM M INNER JOIN S
ON M.M1=S.S1; --JOIN의 조건절

SELECT S.S1, S.S2, X.X2
FROM S INNER JOIN X
ON S.S1=X.X1;

--여러 개의 테이블 조인
SELECT *
FROM M JOIN S
ON M.M1=S.S1
JOIN X
ON S.S1=X.X1;

--사번, 이름, 부서번호, 부서명 출력하기
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;
--테이블도 가명칭를 쓸 수 있다
----------------------------------------------
/*스터디 문제 2016. 8. 17
--조건: 수당을 받지 않는 사원들의 급여 합이 3000이상인 부서
--부서번호, 부서별 급여의 합, 부서별 인원 수 출력
--급여의 합은 "총급여"로, 인원 수는 "인원수"로 표시
--급여의 합을 내림차순 정렬
SELECT DEPTNO, SUM(SAL) AS "총급여", COUNT(*) AS "인원수"
FROM EMP
WHERE COMM IS NULL
GROUP BY DEPTNO
HAVING SUM(SAL)>=3000
ORDER BY "총급여" DESC;

SELECT * FROM EMP;
*/
/*
--[문제만들기] FROM 지율
-- 사원테이블에서 입사월이 4,5,6,7,11,12월인 데이터만
--직종별로 몇명인지 출력하세요.
--단, 예를들어 5명이라면, 5명^0^♥ 출력형식 지정해주세요.
--이후, 직종 알파벳 순으로 정렬하세요.
SELECT JOB, COUNT(*)||'명^0^♥' AS "인원수"
FROM EMP
WHERE (TO_CHAR(HIREDATE, 'MM') BETWEEN '04' AND '07')
      OR
      (TO_CHAR(HIREDATE, 'MM') BETWEEN '11' AND '12')
GROUP BY JOB
ORDER BY JOB;

--FROM 성준
--  사원 테이블에서 같은 부서별 가장 먼저 입사한 사람의 입사 날짜를 YY/MM/DD 형태로 만들고 평균 월급을 반올림해서 구하시오
--  DEPTNO의 10은 영업부 20은 사업부  30 인사부 기타는 기타 로 나타내시오
--  단 King을 제외하고 구하시오 
SELECT DECODE(DEPTNO, 10, '영업부', 20, '사업부', 30, '인사부', '기타') AS "부서", ROUND(AVG(SAL), 0) AS "평균 월급", TO_CHAR(MIN(HIREDATE), 'YY/MM/DD') AS "입사 날짜"
FROM EMP
WHERE ENAME!='KING'
GROUP BY DEPTNO;

--FROM 기윤
-- 직종별 급여가 가장 많은 사원의 직종과 급여를 구하세요.
-- 단, 가장 많은 급여를 내림차순으로 나열 하세요.
SELECT JOB AS "직종", MAX(SAL) AS "급여"
FROM EMP
GROUP BY JOB
ORDER BY MAX(SAL) DESC;

--FROM 한솔
--사원테이블에서 부서별 급여의 합이 2800이상인 사원의 이름과, 급여, 급여의합과 평균을 출력하고
--(평균은 반올림함수 사용하여정수형까지만 나타나도록 출력)
--(이름은 O가 들어간 사람만 출력하도록 한다)
--급여의 평균이 높은순으로 정렬
SELECT ENAME, SAL, SUM(SAL), ROUND(AVG(SAL), 0)
FROM EMP
WHERE ENAME LIKE '%O%'
GROUP BY DEPTNO, ENAME, SAL
HAVING SUM(SAL)>=2800
ORDER BY AVG(SAL) DESC;

--FROM 문수
--사원 중 직종이 salesman인 사원의 사번,사원명 , 근속년수 ,사원들의 월급을 구하시오
--사원 중 입사 한지 35년인 사원의 월급을 20% 인상하고 '고생하셨습니다' 출력
--35년이 아닌 사원에겐 '더 고생하세요' 출력  
SELECT EMPNO, ENAME, TRUNC((SYSDATE-HIREDATE)/365) AS "근속년수", SAL, DECODE(TRUNC((SYSDATE-HIREDATE)/365), 35, (SAL*1.2|| '로 월급인상 고생하셨습니다'), '더 고생하세요')
FROM EMP
WHERE JOB='SALESMAN';
*/
----------------------------------------------
--HR계정
select * from employees;
select * from DEPARTMENTS;
SELECT * FROM LOCATIONS;

--사번, 이름, 부서번호, 부서이름
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
ORDER BY E.DEPARTMENT_ID;

--사번, 이름, 부서번호, 부서명, 지역코드, 도시명
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.LOCATION_ID, L.CITY
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
INNER JOIN LOCATIONS L ON D.LOCATION_ID=L.LOCATION_ID
ORDER BY E.DEPARTMENT_ID;

----------------------------------------------
--개발자 계정
--비등가조인
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

--사번, 이름, 급여, 급여등급 출력
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL; --비등가
----------------------------------------------
--OUTER JOIN
--왜쓰냐? NULL이 INNER JOIN의 대상이 아니기 때문에
--LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN
--왼쪽, 오른쪽은 튜닝에서 속도문제 때문에 의미있을 뿐
--내부적으로는 등가조인을 먼저 실행하고 주종관계를 파악해서
--"주가 되는 테이블에 남아있는 데이터(NULL포함 데이터)"를 가지고 온다

SELECT *
FROM M JOIN S
ON M.M1=S.S1;

SELECT *
FROM M LEFT OUTER JOIN S
ON M.M1=S.S1; --M을 가져온다

SELECT *
FROM M RIGHT OUTER JOIN S
ON M.M1=S.S1; --S를 가져온다

SELECT *
FROM M FULL OUTER JOIN S
ON M.M1=S.S1; --LEFT/RIGHT OUTER JOIN의 UNION
----------------------------------------------
--HR계정
SELECT COUNT(*) FROM EMPLOYEES; --107명

SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
ORDER BY E.DEPARTMENT_ID; --106명 어딘가 널값

SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IS NULL
ORDER BY E.DEPARTMENT_ID;
----------------------------------------------
--SELF JOIN
--사원테이블에서 사번, 이름, 관리자사번, 관리자 이름 출력
--개발자
SELECT E.EMPNO, E.ENAME, F.EMPNO, F.ENAME
FROM EMP E LEFT OUTER JOIN EMP F --KING 때문에
ON E.MGR=F.EMPNO
ORDER BY E.EMPNO;
----------------------------------------------
--카페 실습문제
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
SELECT E.ENAME, E.EMPNO, D.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;
 
-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='DALLAS';
 
-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
SELECT E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.ENAME LIKE '%A%';

-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL>=3000;

-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
SELECT E.JOB, E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.JOB='SALESMAN';

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
--(비등가 ) 1 : 1 매핑 대는 컬럼이 없다
SELECT E.EMPNO AS "사원번호", E.ENAME AS "사원이름", E.SAL*12 AS "연봉", E.SAL*12+COMM AS "실급여", S.GRADE AS "급여등급"
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.COMM IS NOT NULL;

-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO=10;
 
-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로
-- 정렬하라.
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
--WHERE E.DEPTNO=10 OR E.DEPTNO=20 --IN연산자를 써라
WHERE E.DEPTNO IN(10, 20)
ORDER BY D.DEPTNO, E.SAL DESC;
 
-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
--SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)
SELECT E.EMPNO AS "사원번호", E.ENAME AS "사원이름", F.EMPNO AS "관리자번호", F.ENAME AS "관리자이름"
FROM EMP E LEFT OUTER JOIN EMP F
ON E.MGR=F.EMPNO;
----------------------------------------------
--SQL의 꽃 SUBQUERY!!
--사원테이블에서 평균월급보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 출력
--기존에는
SELECT AVG(SAL) FROM EMP;
SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL>2073;

--SUBQUERY 쿼리 안의 쿼리, ()안에
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

--서브쿼리의 종류(컬럼은 무조껀 1개)
--SINGLEROW SUBQUERY: 서브쿼리의 결과가 단일값(1개의 ROW, 단일 컬럼)를 갖는 경우
--MULTIROW SUBQUERY: 서브쿼리의 결과가 여러 값(1개 이상의 ROW, 단일 컬럼)를 갖는 경우
  --싱글과 연산자가 달라짐(IN, NOT IN, ALL, ANY 등)
  --ALL: SAL>1000 AND COMM >2000
  --ANY: SAL>1000 OR COMM >2000
  --WHERE SAL> ALL(SELECT SAL FROM ...) > 결국 가장 작은값이 나온다
  --WHERE SAL> ANY(SELECT SAL FROM ...) > 결국 가장 크은값이 나온다

--서브쿼리 문법
  --무조건 괄호 안에
  --단일컬럼으로 구성
  
--실행순서
  --서브쿼리 > 메인쿼리
  --서브쿼리의 결과를 가지고 메인쿼리가 돌아간다 > 서브쿼리는 단독으로 실행가능 해야 한다
  
--사원테이블에서 JONES보다 많은 급여를 받는 사원의 사번, 이름, 급여 출력하기
--사용되는 연산자는 단일값 비교하는 = < > 같은 것
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL >
(SELECT SAL
FROM EMP
WHERE ENAME='JONES');

SELECT EMPNO, ENAME, SAL
FROM EMP
--WHERE SAL > (SELECT SAL FROM EMP WHERE SAL > 2000); --안됨, 이럴땐 IN 같은것 쓰기
WHERE SAL IN (SELECT SAL FROM EMP WHERE SAL > 2000);
--풀어보면 SAL=2975 OR SAL=2850 OR ....
--WHERE SAL NOT IN (SELECT SAL FROM EMP WHERE SAL > 2000);
--풀어보면 SAL!=2975 AND SAL!=2850 AND ... > 주의!!! IN과 NOT IN

--부하직원이 있는 사원의 사번과 이름을 출력
SELECT EMPNO, ENAME
FROM EMP
WHERE EMPNO IN (SELECT MGR FROM EMP);

--부하직원이 없는 사원의 사번과 이름 출력
--NULL, AND > NULL > NVL로 해결
SELECT EMPNO, ENAME
FROM EMP
WHERE EMPNO NOT IN (SELECT NVL(MGR,0) FROM EMP);

--직속상관이 KING인 사원의 사번, 이름, 직종, 관리자사번 출력
SELECT EMPNO, ENAME, JOB, MGR
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');

--20번 부서의 사원 중에서 가장 많은 월급을 받는 사원보다
--더 많은 급여를 받는 사원의 사번, 이름, 급여, 부서번호 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--직종이 SALESMAN인 사원과 같은 부서에서 근무하고, 같은 월급을 받는 사원의
--사번, 이름, 직종, 급여 출력
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE JOB='SALESMAN')
     AND SAL IN (SELECT SAL FROM EMP WHERE JOB='SALESMAN');
     
--자기부서의 평균 월급보다 더 많은 월급을 받는 사원의 사번, 이름, 부서번호
--부서별 평균급여 출력
--서브쿼리에 가상테이블 넣기 (in line view), FROM절에 조건 넣기
--최후의 방법
SELECT E.EMPNO, E.ENAME, E.DEPTNO, E.SAL, S.AVGSAL
FROM EMP E JOIN (SELECT DEPTNO, AVG(SAL) AS AVGSAL FROM EMP GROUP BY DEPTNO) S
ON E.DEPTNO=S.DEPTNO
WHERE E.SAL > S.AVGSAL;
----------------------------------------------
--또 연습문제
--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME='SMITH');
 
--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (SELECT SAL FROM EMP WHERE DEPTNO=10);
 
--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME='BLAKE')
      AND ENAME!='BLAKE';

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY SAL DESC;
 
--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%');

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL > ALL (SELECT SAL FROM EMP WHERE DEPTNO=30);
  
--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS');

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
 
--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라
--king 이 사수인 사람 (mgr 데이터가 king 사번)
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');
 
--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%S%')
      AND SAL > (SELECT AVG(SAL) FROM EMP);

--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO
FROM EMP
WHERE COMM IS NOT NULL)
AND SAL IN
(SELECT SAL
FROM EMP 
WHERE COMM IS NOT NULL);

--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE SAL NOT IN (SELECT SAL FROM EMP WHERE DEPTNO=30)
AND COMM NOT IN (SELECT NVL(COMM,0) FROM EMP WHERE DEPTNO=30);
----------------------------------------------
--DDL: CREATE, ALTER, DROP, TRUNCATE
--DML: INSERT, UPDATE, DELETE
--DCL: GRANT(권한), REVOKE
--DQL(오라클은 따로 빼놨다): SELECT
--TCL: (트랜잭션) COMMIT, ROLLBACK, SAVEPOINT

--DML작업
--TCP: 오라클이 제공하는 SYSTEM 테이블
DESC EMP; --컬럼명, 타입, NULL여부 확인
SELECT * FROM TAB; --현재접속계정(세션)이 다룰 수 있는 테이블 목록
--MSSQL은 데이터베이스별로 사용자를 관리
--오라클은 사용자별로 데이터베이스 관리
SELECT * FROM TAB WHERE TNAME='M'; --대문자로 관리
SELECT * FROM COL; --테이블이 가지는 모든 컬럼 목록
SELECT * FROM COL WHERE TNAME='EMP';

SELECT * FROM USER_TABLES; --테이블에 대한 상세 정보
SELECT * FROM USER_TABLES WHERE TABLE_NAME='EMP';
----------------------------------------------
--DML 사전지식: TCL
--정의: 하나의 논리적 작업 단위
--EX)물건을 사는 과정에서 어느 하나라도 실패하면 처음 상태로 돌아가야 한다
--EX)A계좌에서 B계좌로 이체할 때까지 COMMIT OR ROLLBACK
--팬텀데이터: 메모리만 수정하고 COMMIT을 안했을 때 보이는 메모리값
--트랜잭션이 중요하다
----------------------------------------------

--INSERT INTO 테이블명(컬럼1, 컬럼2, ...) VALUSES(값1, 값2, ...);
CREATE TABLE TRANS(USERID NUMBER);
CREATE TABLE TEMP(
  ID NUMBER PRIMARY KEY, --중복불가, 널불가
  NAME VARCHAR2(20)
);
SELECT * FROM TEMP;
INSERT INTO TEMP(ID, NAME) VALUES(100, '홍길동');
COMMIT;

--컬럼리스트 생략 가능 > 그러면 모든 값을 다 넣어야 된다
INSERT INTO TEMP VALUES(200, '김유신');
--특정컬럼에만 데이터 삽입하기
INSERT INTO TEMP(ID) VALUES(300);

--PK 제약 때문에 에러
--INSERT INTO TEMP(NAME) VALUES('바보');
--INSERT INTO TEMP(ID, NAME) VALUES(100, '바보');

--PL-SQL: 프로그래밍적 성격을 띄는 SQL
--테스트용 데이터 생성할 때 유용하다
--블록 잡고 실행, ;주의
--옛날에 만들어졌음, 개선 안됨
/*
CREATE TABLE TEMP2(ID VARCHAR2(20));
BEGIN
  FOR I IN 1..1000 LOOP
    INSERT INTO TEMP2(ID) VALUES('A'||TO_CHAR(I));
  END LOOP;
END;
SELECT * FROM TEMP2;
COMMIT;
*/
----------------------------------------------
CREATE TABLE TEMP3(
  MEMBERID NUMBER(3) NOT NULL,
  NAME NVARCHAR2(10),
  REGDATE DATE DEFAULT SYSDATE --기본값 설정
                               --INSERT 명시적으로 하지 않으면 SYSDATE
);
--입력값 적용
INSERT INTO TEMP3(MEMBERID, NAME, REGDATE) VALUES(100, '홍길동', '2016-08-18');
--기본값 적용
INSERT INTO TEMP3(MEMBERID, NAME) VALUES(200, '김유신');
INSERT INTO TEMP3(NAME, REGDATE) VALUES('통나무', '2016-08-18');
INSERT INTO TEMP3(MEMBERID) VALUES(300);
COMMIT;
SELECT * FROM TEMP3;
----------------------------------------------
--옵션
--대량 INSERT 작업하기
CREATE TABLE TEMP4(ID NUMBER);
CREATE TABLE TEMP5(NUM NUMBER);

INSERT INTO TEMP4(ID) VALUES(1);
INSERT INTO TEMP4(ID) VALUES(2);
INSERT INTO TEMP4(ID) VALUES(3);
INSERT INTO TEMP4(ID) VALUES(4);
INSERT INTO TEMP4(ID) VALUES(5);
INSERT INTO TEMP4(ID) VALUES(6);
COMMIT;
SELECT * FROM TEMP4;
SELECT * FROM TEMP5;

--TEM4의 모든 데이터를 TEMP5에 넣기
--INSERT INTO 테이블명(컬럼리스트) SELECT 구문
INSERT INTO TEMP5(NUM) SELECT ID FROM TEMP4;
COMMIT;

--테이블이 없는 경우 테이블 생성 및 데이터 삽입까지 가능
--단, 제약정보는 복사되지 않음
--사용: 테이블 복사(테이블의 구조 복사)
CREATE TABLE COPYEMP
AS SELECT * FROM EMP;
SELECT * FROM COPYEMP;

CREATE TABLE COPYEMP2
AS SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO=20;
SELECT * FROM COPYEMP2;

--테이블의 제약정보 확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='COPYEMP';

--퀴즈
--EMP 테이블과 같은 구조의 EMP2 테이블 생성하기
--구조만 복사, 데이터는 복사 안함
CREATE TABLE EMP2
AS SELECT * FROM EMP WHERE 1=2; --모든 조건을 FALSE로 만드는 방법
SELECT * FROM EMP2;
--EMP2에 급여가 3000 이상인 모든 사원 INSERT
INSERT INTO EMP2 SELECT * FROM EMP WHERE SAL>=3000;
COMMIT;
----------------------------------------------
/*문제 내기
--EMP 테이블에서 최상위 상급자까지 표시하기
--EX)ADAMS의 상급자는 SCOTT, SCOTT의 상급자는 JONES, JONES의 상급자는 KING
--직종, 이름, 상급자1, 상급자2, 상급자3로 표시
SELECT E.JOB, E.ENAME, F.ENAME AS "상급자1", G.ENAME AS "상급자2", H.ENAME AS "상급자3"
FROM EMP E LEFT OUTER JOIN EMP F
ON E.MGR=F.EMPNO LEFT OUTER JOIN EMP G
ON F.MGR=G.EMPNO LEFT OUTER JOIN EMP H
ON G.MGR=H.EMPNO;
*/
--문제 

--FROM 성준
--회원 테이블과 게시판테이블을 생성을 해야 한다.
--회원(member_test)테이블에는 숫자형(5) key , 문자열(20) id , 문자열(20) pass , 숫자형(11) phone ,날짜형 birthday 가 있다.
--게시판(board_test) 테이블에는 숫자형(5) key, 문자열(20) title(제목) ,  문자열(50) wording (게시글) 가 있다. 
--회원테이블에는 우리조원들이 들어 있다. 생일은 디폴트가 현재 시간이고 , id 는 이름으로 지정 한다. 비밀번호는 1234 로 통일 한다. key는  Primary Key이고 게시판과의 1:M 관계이다 
--게시판테이블에는 글이있는데 제목은 우리조 게시글에는 만만세 라는 글이 있다. (키값은 이성준의 키값으로 지정한다.)
--출력 select 에는 이성준 회원의 아이디와 핸드폰번호,생일 그리고 게시판제목 , 게시글이 나와야 한다.
CREATE TABLE MEMBER_TEST(
  KEY NUMBER(5) PRIMARY KEY, ID VARCHAR2(20), PASS VARCHAR2(20), PHONE NUMBER(11), BIRTHDAY DATE DEFAULT SYSDATE
);
INSERT INTO MEMBER_TEST VALUES (1, '이성준', '1234', 01026739821, '1992-09-21');
INSERT INTO MEMBER_TEST VALUES (2, '조한솔', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (3, '김기윤', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (4, '박문수', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (5, '김지율', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (6, '길한종', '1234', 01055556666, SYSDATE);

CREATE TABLE BOARD_TEST(
  KEY NUMBER(5) PRIMARY KEY, TITLE VARCHAR2(20), WORDING VARCHAR2(50)
);
INSERT INTO BOARD_TEST VALUES (1, '우리조','만만세');

SELECT M.ID, M.PHONE, M.BIRTHDAY, B.TITLE, B.WORDING
FROM MEMBER_TEST M JOIN BOARD_TEST B
ON M.KEY=B.KEY;

--FROM 한솔
--'CHICAGO'에서 근무하고 있으면서 수당을 받은 사원과 같은 부서에서 일하는 
--사원들의 사원번호, 이름, 부서번호, 수당을 출력
--(단, 수당이 0인사람은 제외하고출력)
SELECT E.EMPNO, E.ENAME, E.DEPTNO, E.COMM
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DEPTNO=(SELECT DEPTNO FROM DEPT WHERE LOC='CHICAGO')
AND COMM IS NOT NULL
AND COMM != 0;

--FROM 문수???
--사원테이블 복사하여 EMP_STUDY 테이블로 생성
--부서별 평균월급보다 더많은 월급을 받는
--사원의 사번,이름 ,관리자이름,월급출력(단, 수당을 받는 사원이라면 수당+월급으로 
--출력 , 관리자가 없는 사원도 출력)
CREATE TABLE EMP_STUDY
AS SELECT * FROM EMP;

SELECT E.EMPNO, E.ENAME, F.ENAME, E.SAL+NVL(E.COMM, 0)
FROM EMP_STUDY E 
JOIN EMP_STUDY F ON E.MGR=F.EMPNO
JOIN (SELECT DEPTNO, AVG(SAL) AS AVGSAL FROM EMP_STUDY GROUP BY DEPTNO) G ON E.DEPTNO=G.DEPTNO
WHERE E.SAL > G.AVGSAL;
--------------------------------------------------------------------------------
--UPDATE
--update 테이블 set 컬럼명1=값1, 컬럼명2=값2, ...
--where 조건절
--UPDATE EMP SET SAL=(SELECT MAX(SAL) FROM EMP)

Update COPYEMP
set Job='NOT'
WHERE DEPTNO=20;

UPDATE COPYEMP
SET SAL=(SELECT SUM(SAL) FROM COPYEMP);
ROLLBACK;

UPDATE COPYEMP
SET ENAME='아무개', JOB='IT', HIREDATE=SYSDATE
WHERE DEPTNO=10;
SELECT * FROM COPYEMP WHERE DEPTNO=10;
COMMIT;
--------------------------------------------------------------------------------
--DELETE
--DELETE * FROM COPYEMP; --이건 MS ACCESS 문법
DELETE FROM COPYEMP;
ROLLBACK;

DELETE FROM COPYEMP
WHERE DEPTNO=20;
SELECT * FROM COPYEMP WHERE DEPTNO=20;
COMMIT;
--------------------------------------------------------------------------------
--DDL: CREATE, ALTER, DROP
CREATE TABLE BOARD(
  BOARDID NUMBER,
  TITLE VARCHAR2(50),
  CONTENTS VARCHAR2(2000),
  REGDATE DATE
);

SELECT * FROM BOARD;
DESC BOARD; --간단한 테이블 정보 보기
SELECT * FROM USER_TABLES WHERE LOWER(TABLE_NAME)='BOARD'; --유저의 테이블 정보 보기
SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)='BOARD'; --제약조건 보기

--오라클11G부터 지원되는 기능: 가상컬럼(조합)
CREATE TABLE VTABLE(
  NO1 NUMBER,
  NO2 NUMBER,
  NO3 NUMBER GENERATED ALWAYS AS (NO1+NO2) VIRTUAL --알아서 계산되는 가상/조합/계산 컬럼
);
--NO1, NO2 컬럼에만 INSERT하면 자동으로 NO3 컬럼에 INSERT

INSERT INTO VTABLE(NO1, NO2) VALUES(100, 200);
SELECT * FROM VTABLE;
COMMIT;
--가상컬럼은 수동입력이 안된다
INSERT INTO VTABLE(NO1, NO2, NO3) VALUES(200, 200, 400);
--가상테이블 정보보기
SELECT COLUMN_NAME, DATA_TYPE, DATA_DEFAULT
FROM USER_TAB_COLUMNS WHERE TABLE_NAME='VTABLE';

--현업에서 사용되는 가상컬럼
CREATE TABLE VTABLE2(
  NO NUMBER,
  P_CODE CHAR(4),
  P_DATE CHAR(8), --20160819
  P_QTY NUMBER,
  P_BUNGI NUMBER(1) --4분기, 이걸 가상컬럼으로 하고싶다
    GENERATED ALWAYS AS (
      CASE WHEN SUBSTR(P_DATE, 5, 2) IN('01', '02', '03') THEN 1
           WHEN SUBSTR(P_DATE, 5, 2) IN('04', '05', '06') THEN 2
           WHEN SUBSTR(P_DATE, 5, 2) IN('07', '08', '09') THEN 3
           ELSE 4
      END
    ) VIRTUAL
);
SELECT COLUMN_NAME, DATA_TYPE, DATA_DEFAULT
FROM USER_TAB_COLUMNS WHERE TABLE_NAME='VTABLE2';
INSERT INTO VTABLE2(P_DATE) VALUES('20160101');
INSERT INTO VTABLE2(P_DATE) VALUES('20160520');
INSERT INTO VTABLE2(P_DATE) VALUES('20161212');
SELECT * FROM VTABLE2;
--------------------------------------------------------------------------------
--CREATE, ALTER, DROP

--CREATE
CREATE TABLE TEMP6(ID NUMBER);

--테이블 만들고 보니 컬럼을 하나 빼먹었다...
--기존 테이블에 컬럼 추가하기
ALTER TABLE TEMP6
ADD ENAME VARCHAR2(20);
DESC TEMP6;

--기존 컬럼의 이름을 잘못 썼다...
ALTER TABLE TEMP6
RENAME COLUMN ENAME TO USERNAME;
DESC TEMP6;

--기존 컬럼의 타입 수정하기 > MODIFY 키워드
ALTER TABLE TEMP6
MODIFY(USERNAME VARCHAR2(100));
DESC TEMP6;

--기존 테이블의 컬럼 삭제
ALTER TABLE TEMP6
DROP COLUMN USERNAME;

--데이터삭제
DELETE FROM TEMP6;
--초기 테이블 크기가 3M > 데이터추가로 용량 증가 (100M) > 데이터 삭제 > 용량은 유지됨
--이럴 때 데이터를 삭제하고 초기의 테이블 크기로 줄이는 것이 TRUNCATE

--테이블 삭제
DROP TABLE TEMP6;
--------------------------------------------------------------------------------
--트랜잭션을 일으키는 작업 INSERT, UPDATE, DELETE 등은 LOG에 기록한다
--LOG FULL이면 작업이 안됨

--제약조건(CONSTRAINT) > 무결성 보장
--데이터베이스에서 가장 중요한 것: 무결성
--확보시점: INSERT, UPDATE

--오라클 제약정보
--NOT NULL: 오라클에서는 제약조건 MS에서는 옵션
--UNIQUE: 유일값 보장, 중복X
--PRIMARY KEY: UNIQUE + NOT NULL > 주민번호
--             테이블 당 컬럼을 묶어서 1개만 가능
--FOREIGN KEY: 테이블 간의 관계 성립
--CHECK: 설정한 값만 입력 받을 수 있음

--제약정보 생성시점
--테이블 생성시
--테이블 변경시 추가
--필요없는 제약 삭제 가능
--ALTER TABLE 테이블명 DROP CONSTRAINT 제약이름
--오라클에서 CONSTRAINT_NAME에 자동으로 제약 이름을 임의로 만드는데, 수동으로 이름을 지정하는 편이 좋다

--제약정보 확인하기
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';

--제약 생성하기(풀네임 표기)
CREATE TABLE TEMP7(
  ID NUMBER CONSTRAINT PK_TEMP7_ID PRIMARY KEY, --관용적 제약조건 이름
  NAME VARCHAR2(20) NOT NULL,
  ADDR VARCHAR2(40)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP7';

INSERT INTO TEMP7 VALUES(100, 'HONGGILDONG', 'SEOUL GANGNAM');
--INSERT INTO TEMP7 VALUES(100, 'GIMYUSHIN', 'SEOUL GANGNAM'); ID 중복
--INSERT INTO TEMP7(ID, ADDR) VALUES(200, 'SEOUL GANGNAM'); 이름 NOT NULL
--INSERT INTO TEMP7(NAME, ADDR) VALUES('아무개', 'SEOUL GANGNAM'); ID NOT NULL
INSERT INTO TEMP7(ID, NAME) VALUES(300, '유관순');
SELECT * FROM TEMP7;
COMMIT;

CREATE TABLE TEMP8(
  ID NUMBER CONSTRAINT PK_TEMP8_ID PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  JUMIN CHAR(6) NOT NULL CONSTRAINT UK_TEMP8_JUMIN UNIQUE, --유니크는 널 때문에 고민좀 해봐야 한다
  ADDR VARCHAR2(20)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP8';

INSERT INTO TEMP8 VALUES(100,'홍길동', '123456', '서울시 강남구');
SELECT * FROM TEMP8;
--JUMIN: UNIQUE에 대해
INSERT INTO TEMP8(ID, NAME, ADDR) VALUES(200,'김유신', '서울시 강남구'); --유니크는 널 체크 못함
INSERT INTO TEMP8(ID, NAME, ADDR) VALUES(300,'김씨', '서울시 강남구'); --그래서 왠만하면 NOT NULL과 함께 사용한다

--테이블 생성 후 제약 걸기
CREATE TABLE TEMP9(ID NUMBER);
ALTER TABLE TEMP9
ADD CONSTRAINT PK_TEMP9_ID PRIMARY KEY(ID);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP9';

--퀴즈
--TEMP9에 ENAME VARCHAR2(20) 추가하기
ALTER TABLE TEMP9
ADD ENAME VARCHAR2(20);
--ENAME 컬럼에 NOT NULL 추가
--NULL은 이런 문법 안됨...
--ALTER TABLE TEMP9
--ADD CONSTRAINT N_TEMP9_ENAME NOT NULL(ENAME);
ALTER TABLE TEMP9
MODIFY(ENAME NOT NULL);
DESC TEMP9;

--CHECK
CREATE TABLE TEMP10(
  ID NUMBER CONSTRAINT PK_TEMP10_ID PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  JUMIN CHAR(6) NOT NULL CONSTRAINT UK_TEMP10_JUMIN UNIQUE,
  ADDR VARCHAR2(20),
  AGE NUMBER NOT NULL CONSTRAINT CK_TEMP10_AGE CHECK(AGE>=19)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP10';
INSERT INTO TEMP10 VALUES(100, '고길동', '123456', '서울시', 20);
INSERT INTO TEMP10 VALUES(200, '사춘기', '223456', '서울시', NULL); --CHECK도 NULL을 못잡음
COMMIT;
--------------------------------------------------------------------------------

--FOREIGN KEY(테이블간 관계 설정)
CREATE TABLE C_EMP
AS SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE 1=2;
CREATE TABLE C_DEPT
AS SELECT DEPTNO, DNAME FROM DEPT WHERE 1=2;

SELECT * FROM C_EMP;
SELECT * FROM C_DEPT;
--제약
--C_EMP 테이블의 DEPTNO 컬럼은 C_DEPT 테이블의 DEPTNO컬럼을 참조
--참조하는 쪽에 거는 제약이 외래키

ALTER TABLE C_DEPT
ADD CONSTRAINT PK_C_DEPT_DEPTNO PRIMARY KEY(DEPTNO); --이거 먼저
ALTER TABLE C_EMP --빌려가는 쪽에서 외래키 설정
ADD CONSTRAINT FK_C_EMP_DEPTNO FOREIGN KEY(DEPTNO) REFERENCES C_DEPT(DEPTNO); --다음에 외래키 설정 가능

INSERT INTO C_DEPT VALUES(100, '인사부');
INSERT INTO C_DEPT VALUES(200, '관리부');
INSERT INTO C_DEPT VALUES(300, '회계부');
COMMIT;

INSERT INTO C_EMP VALUES(1001, '홍길동', 300);
INSERT INTO C_EMP VALUES(1002, '김유신', 300);
INSERT INTO C_EMP VALUES(1003, '유관순', 100);
COMMIT;

INSERT INTO C_EMP VALUES(1004, '유관심', NULL); --신입사원의 경우 부서가 없을 수 있다
--반드시 부서지정이여야 한다면 테이블 설계시 DEPNO에 NOT NULL을 걸어야 한다

--참조관계는 마치 MASTER-DETAIL의 관계
--C_EMP와 C_DEPT는 DEPTNO 컬럼을 기준으로 C_DEPT (PK를 가진 쪽이 마스터, 부모)
--------------------------------------------------------------------------------

--참조제약에서 데이터가 참조되고 있으면 삭제가 불가능
DELETE FROM C_DEPT WHERE DEPTNO=100;
UPDATE C_DEPT SET DEPTNO=101 WHERE DEPTNO=100;

--연쇄 삭제(ON DELETE CASECADE)
--오라클은 DELETE CASECADE밖에 없다, MS는 둘다 가능
CREATE TABLE T1(
  COL1 NUMBER,
  CONSTRAINT PK_T1_COL1 PRIMARY KEY(COL1) --이렇게 제약조건을 나중에 쓰는 것도 가능
);
CREATE TABLE T2(
  COL1 NUMBER,
  COL2 VARCHAR2(10),
  CONSTRAINT FK_T2_COL1 FOREIGN KEY(COL1) REFERENCES T1(COL1) ON DELETE CASCADE
);
INSERT INTO T1 VALUES(1);
INSERT INTO T1 VALUES(2);
INSERT INTO T1 VALUES(3);
INSERT INTO T2 VALUES(1, 'A');
INSERT INTO T2 VALUES(2, 'B');
COMMIT;

--CASCADE 확인
DELETE FROM T1 WHERE COL1=1;
SELECT * FROM T2;
COMMIT;


--조별과제

--학과 테이블
CREATE TABLE DEPARTMENT(
  DNUM NUMBER CONSTRAINT PK_DEPARTMENT_DNUM PRIMARY KEY,
  DNAME VARCHAR2(20) NOT NULL
);

--학과 데이터 입력
INSERT INTO DEPARTMENT VALUES(100, '물리학과');
INSERT INTO DEPARTMENT VALUES(200, '영문학과');
INSERT INTO DEPARTMENT VALUES(300, '경제학과');

--성적 테이블
CREATE TABLE STUDENT(
  SNUM NUMBER CONSTRAINT PK_STUDENT_SNUM PRIMARY KEY,
  SNAME VARCHAR2(20) NOT NULL,
  KOREAN NUMBER NOT NULL,
  ENGLISH NUMBER NOT NULL,
  MATH NUMBER NOT NULL,
  TOTAL NUMBER GENERATED ALWAYS AS (KOREAN+ENGLISH+MATH) VIRTUAL,
  AVGTOTAL INTEGER GENERATED ALWAYS AS ((KOREAN+ENGLISH+MATH)/3) VIRTUAL,
  DNUM NUMBER NOT NULL,
  CONSTRAINT FK_STUDENT_DNUM FOREIGN KEY(DNUM) REFERENCES DEPARTMENT(DNUM)
  --바로 쓰려면 다음처럼, 외래키는 왠만하면 나중에 하는 것이 좋다
  --DNUM NUMBER NOT NULL CONSTRAINT FK_STUDENT_DNUM REFERENCES DEPARTMENT(DNUM)
);

--성적 데이터 입력
INSERT INTO STUDENT(SNUM, SNAME, KOREAN, ENGLISH, MATH, DNUM) VALUES(10, '이성준', 50, 80, 70, 200);
INSERT INTO STUDENT(SNUM, SNAME, KOREAN, ENGLISH, MATH, DNUM) VALUES(20, '길한종', 60, 50, 80, 200);
INSERT INTO STUDENT(SNUM, SNAME, KOREAN, ENGLISH, MATH, DNUM) VALUES(30, '김기윤', 70, 60, 70, 300);

--결과 출력
SELECT S.SNUM, S.SNAME, S.TOTAL, S.AVGTOTAL, S.DNUM, D.DNAME
FROM STUDENT S JOIN DEPARTMENT D
ON S.DNUM=D.DNUM;

--------------------------------------------------------------------------------
--평가문제

--1> 부서테이블의 모든 데이터를 출력하라.
SELECT * FROM EMP; --다낚임 DEPT
 
--2> EMP테이블에서 각 사원의 직업, 사원번호, 이름, 입사일을 출력하라.
//패스

--3> EMP테이블에서 직업을 출력하되, 각 항목(ROW)가 중복되지 않게
-- 출력하라.
SELECT JOB
FROM EMP
UNION
SELECT JOB
FROM EMP;
 
--4> 급여가 2850 이상인 사원의 이름 및 급여를 출력하라.
//패스

--5> 사원번호가 7566인 사원의 이름 및 부서번호를 출력하라.
 SELECT ENAME, DEPTNO
 FROM EMP
 WHERE EMPNO=7566;
 
--6> 급여가 1500이상 ~ 2850이하의 범위에 속하지 않는 모든 사원의 이름
-- 및 급여를 출력하라.
//패스

--7> 1981년 2월 20일 ~ 1981년 5월 1일에 입사한 사원의 이름,직업 및 
--입사일을 출력하라. 입사일을 기준으로 해서 오름차순으로 정렬하라.
SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN '1981-02-20' AND '1981-05-01'
ORDER BY HIREDATE;
 
--8> 10번 및 30번 부서에 속하는 모든 사원의 이름과 부서 번호를
-- 출력하되, 이름을 알파벳순으로 정렬하여 출력하라.
//패스
 
--9> 10번 및 30번 부서에 속하는 모든 사원 중 급여가 1500을 넘는
-- 사원의 이름 및 급여를 출력하라.
--(단 컬럼명을 각각 employee 및 Monthly Salary로 지정하시오)
SELECT ENAME AS "EMPLOYEE", SAL AS "MONTHLY SALARY"
FROM EMP
WHERE DEPTNO IN (10, 30)
AND SAL > 1500;
 
--10> 관리자가 없는 모든 사원의 이름 및 직위를 출력하라.
//패스

--11> 커미션을 받는 모든 사원의 이름, 급여 및 커미션을 출력하되, 
-- 급여를 기준으로 내림차순으로 정렬하여 출력하라.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM IS NOT NULL
ORDER BY SAL; --DESC추가
 
--12> 이름의 세 번째 문자가 A인 모든 사원의 이름을 출력하라.
//패스

--13> 이름에 L이 두 번 들어가며 부서 30에 속해있는 사원의 이름을 
--출력하라.
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%L%L%' AND DEPTNO=30;
 
--14> 직업이 Clerk 또는 Analyst 이면서 급여가 1000,3000,5000 이 
-- 아닌 모든 사원의 이름, 직업 및 급여를 출력하라.
//패스

--15> 사원번호, 이름, 급여 그리고 15%인상된 급여를 정수로 표시하되 
--컬럼명을 New Salary로 지정하여 출력하라.
SELECT EMPNO, ENAME, SAL, ROUND(SAL*1.15, 0) AS "NEW SALARY" 
FROM EMP;
 
--16> 15번 문제와 동일한 데이타에서 급여 인상분(새 급여에서 이전 
-- 급여를 뺀 값)을 추가해서 출력하라.(컬럼명은 Increase로 하라). 
//패스

--18> 모든 사원의 이름(첫 글자는 
-- 대문자로, 나머지 글자는 소문자로 표시) 및 이름 길이를 표시하는
-- 쿼리를 작성하고 컬럼 별칭은 적당히 넣어서 출력하라.
//패스

--19> 사원의 이름과 커미션을 출력하되, 커미션이 책정되지 않은 
-- 사원의 커미션은 'no commission'으로 출력하라.
SELECT ENAME, DECODE(COMM, NULL, 'NO COMMISSION', COMM)
FROM EMP;
 
--20> 모든 사원의 이름,부서번호,부서이름을 표시하는 질의를 작성하라.
//패스

--21> 30번 부서에 속한 사원의 이름과 부서번호 그리고 부서이름을 출력하라.
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30;
 
--22> 30번 부서에 속한 사원들의 모든 직업과 부서위치를 출력하라.
--(단, 직업 목록이 중복되지 않게 하라.)
SELECT E.JOB, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30
UNION
SELECT E.JOB, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30;
 
--23> 커미션이 책정되어 있는 모든 사원의 이름, 부서이름 및 위치를 출력하라.
SELECT E.ENAME, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE COMM IS NOT NULL;
 
--24> 이름에 A가 들어가는 모든 사원의 이름과 부서 이름을 출력하라.
//패스

--25> Dallas에서 근무하는 모든 사원의 이름, 직업, 부서번호 및 부서이름을 
-- 출력하라.
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='DALLAS';
 
--26> 사원이름 및 사원번호, 해당 관리자이름 및 관리자 번호를 출력하되,
-- 각 컬럼명을 employee,emp#,manager,mgr#으로 표시하여 출력하라.
//패스

--27> 모든 사원의 이름,직업,부서이름,급여 및 등급을 출력하라.
SELECT E.ENAME, E.JOB, E.DEPTNO, E.SAL, S.GRADE
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--28> Smith보다 늦게 입사한 사원의 이름 및 입사일을 출력하라.
//패스

--29> 자신의 관리자보다 먼저 입사한 모든 사원의 이름, 입사일, 
-- 관리자의 이름, 관리자의 입사일을 출력하되 각각 컬럼명을 
-- Employee,EmpHiredate, Manager,MgrHiredate로 표시하여 
-- 출력하라.
SELECT E.ENAME AS "EMPLOYEE", E.HIREDATE AS "EMPHIREDATE", F.ENAME AS "MANAGER", F.HIREDATE AS "MGRHIREDATE"
FROM EMP E JOIN EMP F
ON E.MGR=F.EMPNO
WHERE E.HIREDATE<F.HIREDATE;
 
--30> 모든 사원의 급여 최고액,최저액,총액 및 평균액을 출력하되 
-- 각 컬럼명을 Maximum,Minimum,Sum,Average로 지정하여 출력하라.
//패스

--31> 각 직업별로 급여 최저액.최고액,총액 및 평균액을 출력하라.
SELECT JOB, MIN(SAL) AS "급여 최저액", MAX(SAL) AS "급여 최고액", SUM(SAL) AS "총액", AVG(SAL) AS "평균액"
FROM EMP
GROUP BY JOB;

--32> 직업이 동일한 사람 수를 직업과 같이 출력하라.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB;
 
--33> 관리자의 수를 출력하되, 관리자 번호가 중복되지 않게하라.
-- 그리고, 컬럼명을 Number of Manager로 지정하여 출력하라.
SELECT COUNT(DISTINCT NVL(MGR, 0)) AS "NUMBER OF MANAGER"
FROM EMP; --COUNT(DISTINCT(MGR))

--34> 최고 급여와 최저 급여의 차액을 출력하라.
//패스

--35> 관리자 번호 및 해당 관리자에 속한 사원들의 최저 급여를 출력하라.
-- 단, 관리자가 없는 사원 및 최저 급여가 1000 미만인 그룹은 제외시키고 
-- 급여를 기준으로 출력 결과를 내림차순으로 정렬하라.
SELECT MGR, MIN(SAL)
FROM EMP
GROUP BY MGR
HAVING MGR IS NOT NULL AND MIN(SAL)>=1000
ORDER BY MIN(SAL) DESC;
 
--36> 부서별로 부서이름, 부서위치, 사원 수 및 평균 급여를 출력하라.
-- 그리고 각각의 컬럼명을 부서명,위치,사원의 수,평균급여로 표시하라.
//패스

--37> Smith와 동일한 부서에 속한 모든 사원의 이름 및 입사일을 출력하라.
-- 단, Smith는 제외하고 출력하시오
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='SMITH')
AND ENAME!='SMITH';
 
--38> 자신의 급여가 평균 급여보다 많은 모든 사원의 사원 번호, 이름, 급여를 
--    표시하는 질의를 작성하고 급여를 기준으로 결과를 내림차순으로 정렬하라.
//패스
 
--39> 이름에 T가 들어가는 사원의 속한 부서에서 근무하는 모든 사원의 사원번호
-- 및 이름을 출력하라.
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%' );
 
--40> 부서위치가 Dallas인 모든 사원의 이름,부서번호 및 직위를 출력하라.
//패스 
 
--41> KING에게 보고하는 모든 사원의 이름과 급여를 출력하라.
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');
 
--42> Sales 부서의 모든 사원에 대한 부서번호, 이름 및 직위를 출력하라.
//패스

--43> 자신의 급여가 평균 급여보다 많고 이름에 T가 들어가는 사원과 동일한
-- 부서에 근무하는 모든 사원의 사원 번호, 이름 및 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP 
WHERE SAL > (SELECT AVG(SAL) FROM EMP)
AND DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%');

--44> 커미션을 받는 사원과 급여가 일치하는 사원의 이름,부서번호,급여를 
-- 출력하라.
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL IN (SELECT SAL FROM EMP WHERE COMM IS NOT NULL);
 
--45> Dallas에서 근무하는 사원과 직업이 일치하는 사원의 이름,부서이름,
--     및 급여를 출력하시오
SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE JOB IN (SELECT E.JOB
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='DALLAS');
 
--46> Scott과 동일한 급여 및 커미션을 받는 모든 사원의 이름, 입사일 및 
-- 급여를 출력하시오
WHERE ENAME='SCOTT' AND COMM=(SELECT COMM FROM EMP WHERE ENAME='SCOTT')
SELECT * FROM EMP???
 
--47> 직업이 Clerk 인 사원들보다 더 많은 급여를 받는 사원의 사원번호,
-- 이름, 급여를 출력하되, 결과를 급여가 높은 순으로 정렬하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL)
FROM EMP
WHERE JOB='CLERK')
ORDER BY SAL DESC;

--48> 이름에 A가 들어가는 사원과 같은 직업을 가진 사원의 이름과
-- 월급, 부서번호를 출력하라.
//패스

--49> New  York 에서 근무하는 사원과 급여 및 커미션이 같은 사원의 
-- 사원이름과 부서명을 출력하라.
/*SELECT ENAME, DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE SAL IN (SELECT E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='NEW YORK')
AND COMM IN (SELECT E.COMM
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='NEW YORK' AND COMM IS NOT NULL);*/
SELECT ENAME, DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE SAL IN (SELECT E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='NEW YORK')
AND NVL(COMM,0) IN (SELECT NVL(E.COMM, 0)
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='NEW YORK');


--50> Dallas에서 근무하는 사원과 직업 및 관리자가 같은 사원의 사원번호,사원이름,
--    직업,월급,부서명,커미션을 출력하되 커미션이 책정되지 않은 사원은 NoCommission
--    으로 표시하고, 커미션의 컬럼명은 Comm으로 나오게 출력하시오.
--    단, 최고월급부터 출력되게 하시오
/////////

-- view 는 가상테이블인데, 마치 테이블처럼 사용할 수 있다
-- 뷰는 오라클에서 객체 (create로 생성해야 함)
-- 책 위에 도화지를 놓고 구멍을 뚫어서 보는 것 같은
-- CREATE VIEW 뷰이름 AS SELECT 구문
-- 테이블처럼 사용되지만, 실제 물리적 테이블은 아니다
-- 메모리 상에 만들어지는 가상테이블
-- 혹자들은 이렇게도 표현: SQL문장 덩어리
-- IN LINE VIWE의 FROM절에 서브쿼리로 들어가는 것도 뷰의 활용

-- 왜 쓰는지?
-- 1.개발자의 편의성
-- 2.보안: VIEW 객체의 사용자마다 권한처리
-- EX) 신입사원에게 급여, 호봉 테이블에서 VIEW를 만들어 제공
-- 3.사용방법은 테이블과 동일
-- VIEW를 통해서 SELECT, DML 작업 가능

--관리자계정 -> 시스템권한 -> CREATE VIEW 설정
CREATE VIEW V_001
AS SELECT EMPNO, ENAME FROM EMP; -- 실제로 실행은 이게 된다
SELECT * FROM V_001;
SELECT * FROM V_001 WHERE EMPNO=7902;
--VIEW가 볼 수 있는 영역에 대해서만 가능하다

-- 자주 조인을 하는 테이블 > 뷰로 만든다
CREATE VIEW V_002
AS SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;
SELECT * FROM V_002;

CREATE VIEW V_003
AS SELECT DEPTNO, AVG(SAL) AS "AVGSAL"
FROM EMP
GROUP BY DEPTNO; --문제가 원하지 않는 열의 데이터도 나온다 > VIEW로 만들어서 조인하면 쉽다
SELECT *
FROM V_003 V JOIN EMP E
ON V.DEPTNO=E.DEPTNO;

--VIEW는 수정시 덮어쓰기가 적용된다
--MS는 ALTER, 오라클은 덮어쓰기(REPLACE)

-- VIEW를 통한 DML도 가능하다 > 뷰에 정의되어 있으면 원본테이블의 데이터가 수정된다
SELECT * FROM C_EMP;
CREATE VIEW V_EMP
AS SELECT EMPNO, ENAME, DEPTNO
FROM C_EMP;
SELECT * FROM V_EMP;

UPDATE V_EMP
SET ENAME='QTQT';
SELECT *
FROM C_EMP; --V_EMP가 바라보는 C_EMP 테이블의 데이터가 변경되었다
ROLLBACK; --뷰는 가능하면 SELECT만 하고, DML은 안하는 것이 좋다

--WITH CHECK OPTION
--WITH READ ONLY
--등등의 옵션이 있다

CREATE OR REPLACE VIEW V_006
AS SELECT * FROM EMP WHERE DEPTNO=10;

CREATE TABLE EMPNAME
AS SELECT * FROM EMP;
CREATE OR REPLACE VIEW VIEW001
AS SELECT *
FROM EMPNAME;
UPDATE VIEW001
SET SAL=1111
WHERE DEPTNO=10;
COMMIT;

CREATE OR REPLACE VIEW VIEW002
AS SELECT *
FROM EMPNAME WHERE DEPTNO=20;
UPDATE VIEW002
SET SAL=0;
SELECT * FROM VIEW002;
UPDATE VIEW002
SET SAL=9999
WHERE DEPTNO=30;
COMMIT;

--view 연습문제
--1. 30번 부서 사원들의 직위, 이름, 월급을 담는 VIEW를 만들어라.
CREATE OR REPLACE VIEW DEPT30
AS SELECT JOB, ENAME, SAL
FROM EMP
WHERE DEPTNO=30;
 
--2. 30번 부서 사원들의  직위, 이름, 월급을 담는 VIEW를 만드는데,
-- 각각의 컬럼명을 직위, 사원이름, 월급으로 ALIAS를 주고 월급이
-- 300보다 많은 사원들만 추출하도록 하라.
CREATE OR REPLACE VIEW DEPT30("직위", "사원이름", "월급") --이렇게도 ALIAS를 줄 수 있다
AS SELECT JOB, ENAME, SAL
FROM EMP
WHERE DEPTNO=30 AND SAL>300;

--3. 부서별 최대월급, 최소월급, 평균월급을 담는 VIEW를 만들어라.
CREATE OR REPLACE VIEW DEPTDEPT
AS SELECT DEPTNO, MAX(SAL) AS "최대월급", MIN(SAL) AS "최소월급", AVG(SAL) AS "평균월급"
FROM EMP
GROUP BY DEPTNO;
       
--4. 부서별 평균월급을 담는 VIEW를 만들되, 평균월급이 2000 이상인
-- 부서만 출력하도록 하라.
CREATE OR REPLACE VIEW DEPTDEPT
AS SELECT DEPTNO, AVG(SAL) AS "평균월급"
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>2000;
 
--5. 직위별 총월급을 담는 VIEW를 만들되, 직위가 MANAGER인
-- 사원들은 제외하고 총월급이 3000이상인 직위만 출력하도록 하라.
CREATE OR REPLACE VIEW DEPTDEPT
AS SELECT JOB, SUM(SAL) AS "총월급"
FROM EMP
GROUP BY JOB
HAVING JOB!='MANAGER' AND SUM(SAL)>3000;
--------------------------------------------------------------------------------
--오라클 객체 중 개발자에게 필요한 것들
--SEQUENCE FROM 오라클 문서
--SEQUENCE 특징
--1) 자동적으로 유일 번호를 생성합니다.
--2) 공유 가능한 객체(여러개의 테이블에서 사용 가능)
--3) 주로 기본 키 값을 생성하기 위해 사용됩니다. (PRIMARY KEY 컬럼에 데이터 제공)
--4) 어플리케이션 코드를 대체합니다. (JAVA 등의 언어가 담당하는 부분을 조금 할 수 있다)
--5) 메모리에 CACHE되면(미리 순번을 생성해 두고, 바로 사용한다) SEQUENCE 값을 액세스 하는 효율성을 향상시킵니다.

/*
1.2 Syntax
CREATE SEQUENCE sequence_name
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}];
sequence_name SEQUENCE의 이름입니다.
INCREMENT BY n 정수 값인 n으로 SEQUENCE번호 사이의 간격을 지정.
이 절이 생략되면 SEQUENCE는 1씩 증가.
START WITH n 생성하기 위해 첫번째 SEQUENCE를 지정.
이 절이 생략되면 SEQUENCE는 1로 시작.
MAXVALUE n SEQUENCE를 생성할 수 있는 최대 값을 지정.
NOMAXVALUE 오름차순용 10^27 최대값과 내림차순용-1의 최소값을 지정.
MINVALUE n 최소 SEQUENCE값을 지정.
NOMINVALUE 오름차순용 1과 내림차순용-(10^26)의 최소값을 지정.
CYCLE | NOCYCLE 최대 또는 최소값에 도달한 후에 계속 값을 생성할 지의 여부를
지정. NOCYCLE이 디폴트.
CACHE | NOCACHE 얼마나 많은 값이 메모리에 오라클 서버가 미리 할당하고 유지
하는가를 지정. 디폴트로 오라클 서버는 20을 CACHE.
*/

--시퀀스
--채번(순번을 반들어주는 객체)
--CREATE TABLE BOARD(BOARDNUM NUMBER, TITLE VARCHAR2(50));
--BOARDNUM컬럼에 1, 2, 3 이런식으로 들어가도록
--INSERT INTO BOARD(BOARDNUM, TITLE) VALUES(1, '처음글');
CREATE TABLE KBOARD(BOARDNUM NUMBER, TITLE VARCHAR2(50));
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT COUNT(*) FROM KBOARD)+1, '제목제목');
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT COUNT(*) FROM KBOARD)+1, '제목제목2222');
COMMIT;

--문제점
--1번글 삭제
DELETE FROM KBOARD WHERE BOARDNUM=1;
--새로운글 추가
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT COUNT(*) FROM KBOARD)+1, '제목제목444');
SELECT * FROM KBOARD;

--새로운 방법(현업에서 많이 쓰는 형태)
DELETE FROM KBOARD;
COMMIT;
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT NVL(MAX(BOARDNUM), 0) FROM KBOARD)+1, '제목제목444');
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT NVL(MAX(BOARDNUM), 0) FROM KBOARD)+1, '제목제목5555');

--[1], [2], [3], [4], [5]
--2번글 삭제 후
--[1], [2], [3], [4]
--이렇게 바뀌게 하고 싶다
--이런거는 어플리케이션에서 처리 해라...

--오라클에서는 좀 편히 하도록 시퀀스를 만들어 놓음
CREATE SEQUENCE BOARD_NUM;
SELECT * FROM USER_SEQUENCES;

/*
1.4.1 NEXTVAL과 CURRVAL 의사열
가) 특징
1) NEXTVAL는 다음 사용 가능한 SEQUENCE 값을 반환 한다.
2) SEQUENCE가 참조될 때 마다, 다른 사용자에게 조차도 유일한 값을 반환한다.
3) CURRVAL은 현재 SEQUENCE값을 얻는다.
4) CURRVAL이 참조되기 전에 NEXTVAL이 사용되어야 한다.
*/
SELECT BOARD_NUM.NEXTVAL FROM DUAL; --롤백되지 않는 자원
SELECT BOARD_NUM.CURRVAL FROM DUAL;

CREATE TABLE TBOARD(
  NUB NUMBER CONSTRAINT PK_TBOARD_NUM PRIMARY KEY,
  TITLE VARCHAR2(20)
);
INSERT INTO TBOARD VALUES(BOARD_NUM.NEXTVAL, '글내용'); --롤백되지 않음
COMMIT;

--MS도 2012버전부터는 오라클처럼 시퀀스 지원
--이전 버전은 테이블 종속적으로 사용
--CREATE TABLE BOARD(BOARDNUM INT IDENTITY(1,1), TITLE);
--INSERT INTO BOARD(TITILE) VALUES('내용');

--MYSQL
--CREATE TABLE BOARD(BOARDNUM INT AUTO_INCREMENT, TITLE);

CREATE SEQUENCE SEQ_NUM
START WITH 10
INCREMENT BY 2;

SELECT SEQ_NUM.NEXTVAL FROM DUAL;
SELECT SEQ_NUM.CURRVAL FROM DUAL;
--------------------------------------------------------------------------------
--SEQUENCE는 공유객체
CREATE TABLE MYBOARD(ID NUMBER PRIMARY KEY, TITLE VARCHAR2(20));
CREATE TABLE YOURBOARD(NUM NUMBER PRIMARY KEY, TITLE VARCHAR2(20));
CREATE SEQUENCE COMM_SEQ;
INSERT INTO MYBOARD VALUES(COMM_SEQ.NEXTVAL,'마이보드 처음');
SELECT * FROM MYBOARD;
INSERT INTO YOURBOARD VALUES(COMM_SEQ.NEXTVAL,'니보드 처음');
SELECT * FROM YOURBOARD;
COMMIT;
--------------------------------------------------------------------------------
--의사컬럼(PSUEDO?): 실제 물리적으로 존재하지 않는 컬럼
--ROWNUM: 테이블에 존재하는 것은 아니지만, 존재하는 것 처럼 사용할 수 있다
--ROWID: 주소값(행이 실제로 저장되어 있는 내부 고유 주소값) > 인덱스

SELECT * FROM EMP;
SELECT ROWNUM AS "순번", EMPNO, ENAME FROM EMP; --셀렉트 이후에 순번을 만들어줌
--왜쓰니?
--TOP-N을 쓰기 위해(상위 몇개), 최하위 몇개
--MS: SELECT TOP 3 직관적
--오라클: ROWNUM

-- 급여를 많이 받는 상위 5명 구하기 > 쌩으로 구하기 > 게시판 페이징 처리의 원리
-- 개중요
SELECT ROWNUM, E.*
FROM (SELECT * FROM EMP ORDER BY SAL DESC) E
WHERE ROWNUM <= 5;

--급여를 적게 받는 상위 10명 구하기
SELECT ROWNUM, E.*
FROM (SELECT * FROM EMP ORDER BY SAL) E
WHERE ROWNUM <= 10;

--------------------------------------------------------------------------------
--게시판 페이징
--페이지 사이즈 정하기(한 페이지에서 볼 수 있는 데이터 건수 정의)
--100건 > pagesize=10, pagecount=10

--HR계정 전환
select * from employees; --107건의 데이터에 대해서
--41~50까지 뽑기 > ROWNUM을 두번 써서 1~50 찾고 다음에 1~40버리기
--웹에서 수시로 한다고 합니다.
--BETWEEN도 가능하다
SELECT S.NUM, S.EMPLOYEE_ID, S.LAST_NAME
FROM ((SELECT ROWNUM AS NUM, E.*
FROM (SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID) E
WHERE ROWNUM <=50)) S WHERE NUM>=40;

--------------------------------------------------------------------------------
--JDBC 실습용 테이블
CREATE TABLE EMPDML
AS SELECT * FROM EMP;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMPDML';
ALTER TABLE EMPDML
ADD CONSTRAINT PK_EMPDML_EMPNO PRIMARY KEY(EMPNO);


--------------------------------------------------------------------------------
 /*
 create table trans_A(
 	num number,
 	name varchar2(20)
 );
  
 create table trans_B(
 	num number primary key,
 	name varchar2(20)
 );
 
 App에서 트랜잭션 제어
 :jdbc api > dml > autocommit()
 commit, rollback 제어 가능
 */
 -------------------------------------------------------------------------------