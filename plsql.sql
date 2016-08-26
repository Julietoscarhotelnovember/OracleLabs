select * from emp;

--PL/SQL 이란 ?
--PL/SQL 은 Oracle's Procedural Language extension to SQL. 의 약자 입니다.
--SQL문장에서 변수정의, 조건처리(IF), 반복처리(LOOP, WHILE, FOR)등을 지원하며,
--오라클 자체에 내장되어 있는 Procedure Language입니다
--DECLARE문을 이용하여 정의되며, 선언문의 사용은 선택 사항입니다.
--PL/SQL 문은 블록 구조로 되어 있고 PL/SQL 자신이 컴파일 엔진을 가지고 있습니다.

--모든 자원이 db에 있다
--보기-DBMS출력 을 이용해야 결과가 보인다
--system.out.println처럼 결과를 확인해야 한다
--1.블럭 단위실행
BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;

--PLSQL
--선언부(변수)
--실행부(변수값 할당, 제어구문)
--예외부(EXECPTION 처리)

DECLARE
  VNO NUMBER(4);
  VNAME VARCHAR2(20);
BEGIN
  VNO := 100; --할당
  VNAME := 'KGLIM';
  DBMS_OUTPUT.PUT_LINE(VNO);
  DBMS_OUTPUT.PUT_LINE(VNAME||'입니다');
END;

--변수선언방법
DECLARE
V_JOB VARCHAR2(10);
V_COUNT NUMBER := 10; --초기값 설정
V_DATE DATE := SYSDATE+7;
V_VALID BOOLEAN NOT NULL := 10;
--------------------------------------------------------------------------------
DECLARE
  VNO NUMBER(4);
  VNAME VARCHAR2(20);
BEGIN
SELECT ENPNO, ENAME
  INTO VNO, VNAME --PLSQL에만 있는 구문
FROM EMP WHERE EMPNO=&EMPNO; --자바에서 스캐너 역할
DBMS_OUTPUT.PUT_LINE('변수값: '||VNO||'/'||VNAME);
END;

--실습테이블 만들기
CREATE TABLE PL_TEST (
NO NUMBER, NAME VARCHAR2(20), ADDR(VARCHAR2(50));
DECLARE
V_NO, NUMBER:='&NO';
V_NAME VARCHAR2(50) := '&NAME';
V_ADDR VARCHAR2(50) := '&NAME';
BEGIN
  INSERT INTO PL_TEST(NO, NAME, ADDR) VALUES(V_NO, V_NAME, V_ADDR);
  COMMIT;
END;
SELECT * FROM PL_TEST;

--변수 제어하기
--1타입: V_EMPNO NUMBER(10)
--2타입: V_EMPNO EMP.EMPNO%TYPE (EMP테이블의 EMPNO 컬럼의 타입을 그대로 가져와 쓰기)
--3타입: V_ROW EMP%ROWTYPE (EMP테이블의 모든 컬럼의 타입을 다 가져와 쓰기)

--퀴즈
--두개의 정수를 입력받아 그 합을 출력하기
DECLARE
  AA NUMBER := '&NO1';
  BB NUMBER := '&NO2';
  RESULT NUMBER;
BEGIN
  RESULT := AA+BB;
  DBMS_OUTPUT.PUT_LINE('RESULT: '||RESULT);
END;
--------------------------------------------------------------------------------
DECLARE
 V_EMPROW EMP%ROWTYPE;
BEGIN
  SELECT *
  INTO V_EMPROW
  FROM EMP
  WHERE EMPNO=7788;
  DBMS_OUTPUT.PUT_LINE(V_EMPROW.EMPNO || '-' || V_EMPROW.ENAME);
END;
--------------------------------------------------------------------------------
CREATE SEQUENCE EMPNO_SEQ
INCREMENT BY 1
START WITH 8000
MAXVALUE 9999
NOCYCLE
NOCACHE;

DECLARE
  V_EMPNO EMP.EMPNO%TYPE;
BEGIN
  SELECT EMPNO_SEQ.NEXTVAL
  INTO V_EMPNO
  FROM DUAL;
  
  INSERT INTO EMPDML(EMPNO, ENAME)
  VALUES(V_EMPNO,'홍길동');
  
  COMMIT;
END;
SELECT * FROM EMPDML;
--------------------------------------------------------------------------------
--제어문
DECLARE
  VEMPNO EMP.EMPNO%TYPE;
  VENAME EMP.ENAME%TYPE;
  VDEPTNO EMP.DEPTNO%TYPE;
  VNAME VARCHAR2(20):= NULL;
BEGIN
  SELECT EMPNO, ENAME, DEPTNO
  INTO VEMPNO, VENAME, VDEPTNO
  FROM EMP
  WHERE EMPNO=7788;
  
  --제어문
  IF(VDEPTNO=10) THEN VNAME := 'ACC';
  ELSIF(VDEPTNO=20) THEN VNAME :='IT'; --여기 이상한곳
  ELSIF(VDEPTNO=30) THEN VNAME :='SALES';
  END IF;
  DBMS_OUTPUT.PUT_LINE('당신 직종: '||VNAME);
END;

--IF() THEN 실행문
--ELSIF() THEN 실행문
--ELSE 실행문

--사번이 7788번인 사원의 사번, 이름, 급여를 변수에 담고
--변수에 담긴 급여가 2000이상이면 당산의 급여는 BIG으로 출력
--그렇지 않으면 당신의 급여는 SMALL로 표현
DECLARE
  VEMPNO EMP.EMPNO%TYPE;
  VENAME EMP.ENAME%TYPE;
  VSAL EMP.SAL%TYPE;
  VSIZE VARCHAR2(20):= NULL;
BEGIN
  SELECT EMPNO, ENAME, SAL
  INTO VEMPNO, VENAME, VSAL
  FROM EMP
  WHERE EMPNO=7788;
  
  --제어문
  IF(VSAL>2000) THEN VSIZE := 'BIG';
  ELSE VSIZE := 'SMALL';
  END IF;
  DBMS_OUTPUT.PUT_LINE('당신 급여: '||VSIZE);
END;
--------------------------------------------------------------------------------
--CASE
DECLARE
  VEMPNO EMP.EMPNO%TYPE;
  VENAME EMP.ENAME%TYPE;
  VDEPTNO EMP.DEPTNO%TYPE;
  V_NAME VARCHAR2(20);
BEGIN
  SELECT EMPNO, ENAME, DEPTNO
  INTO VEMPNO, VENAME, VDEPTNO
  FROM EMP
  WHERE EMPNO=7788;
  
  V_NAME := CASE VDEPTNO
            WHEN 10 THEN 'AA'
            WHEN 20 THEN 'BB'
            WHEN 30 THEN 'CC'
            WHEN 40 THEN 'DD'
            END;
            
  V_NAME := CASE
            WHEN VDEPTNO=10 THEN 'AA'
            WHEN VDEPTNO IN(20, 30) THEN 'BB'
            WHEN VDEPTNO=40 THEN 'CC'
            ELSE 'NOT'
            END;       
  DBMS_OUTPUT.PUT_LINE('당신 부서: '||V_NAME);
END;
--------------------------------------------------------------------------------
--반복문

--LOOP
/*
LOOP 
  무운장;
  EXIT WHEN (조건식)
END LOOP
*/
DECLARE
  N NUMBER := 0;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE('N값: ' || N);
    N := N+1;
    EXIT WHEN N>5;
  END LOOP;
END;

/*
WHILE(N<6)
LOOP
  실행문;
END LOOP;
*/
DECLARE
  NUM NUMBER := 0;
BEGIN
  WHILE(NUM<6)
  LOOP
    DBMS_OUTPUT.PUT_LINE('NUM값: ' || NUM);
    NUM := NUM+1;
  END LOOP; 
END;

--FOR문
--어 그거
BEGIN
  FOR I IN 0..10 LOOP
    DBMS_OUTPUT.PUT_LINE(I);
  END LOOP;
END;

--FOR문을 이용해 1~100까지 합을 구하기
DECLARE
  TOTAL NUMBER :=0;
BEGIN
  FOR I IN 1..100 LOOP
    TOTAL:=TOTAL+I;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(TOTAL);
END;

--CONTINUE
--11G 이후부터 사용 가능
DECLARE
  TOTAL NUMBER := 0;
BEGIN
  FOR I IN 1..100 LOOP
    DBMS_OUTPUT.PUT_LINE('변수: '||I);
    CONTINUE WHEN I > 5; --SKIP
    TOTAL := TOTAL + I;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('합계: '||TOTAL);
END;
--------------------------------------------------------------------------------
--활용
DECLARE
  VEMPNO EMP.EMPNO%TYPE;
  VENAME EMP.ENAME%TYPE :=UPPER('&NAME');
  VSAL EMP.SAL%TYPE;
  VJOB EMP.JOB%TYPE;
BEGIN
  SELECT EMPNO, JOB, SAL
  INTO VEMPNO, VJOB, VSAL
  FROM EMP
  WHERE ENAME=VENAME;
  
  IF VJOB IN('MANAGER', 'ANALYST')
  THEN VSAL := VSAL*1.5;
  ELSE VSAL := VSAL*1.2;
  END IF;
  
  UPDATE EMP
  SET SAL=VSAL
  WHERE EMPNO=VEMPNO;
  
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||'개 갱신'); --시스템변수, 반영된 행의 개수 확인
  
  --예외처리
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('그런 이름은 없습니다');
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('동명이인이 있습니다'); --하나밖에 처리를 못해서
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('원인을 알 수 없습니다');
END;
--------------------------------------------------------------------------------
--이제 커서, 프로시저, 펑션, 트리거 사용 가능하다
--지금까지는 집합 단위의 데이터 처리 (테이블의 전체 row를 대상으로)

--[CURSOR]
--1.  [행단위]로 데이터를 처리하는 방법을 제공
--2.  여러건의 데이터를 처리하는 처리하는 방법을 제공 (한 건이상의  row가지고 놀기)
 
--사원급여테이블(건설회사)
--정규직 , 일용일 ,시간직 

--사번 , 이름 , 직종명 , 월급 , 시간 , 시간급 , 식대
-- 10   홍길동  정규직   120   null   null   null
-- 11   김유신  시간직  null   10      100
-- 12   이순신  일용일  null   null    120   10

--한 행씩 접근해서 직종을 기준으로 계산방법
--이러한 조건을 주는 것이 가능하다
--if 정규직 > 월급
--elsif 시간직 > 시간*시간급(총급여)
--elsif 일용직 > 시간급+식대(총급여)
 
 
--SQL CURSOR 의 속성을 사용하여 SQL 문장의 결과를 테스트할 수 있다.
--[종 류 설 명]
  --SQL%ROWCOUNT 가장 최근의 SQL 문장에 의해 영향을 받은 행의 수
  --SQL%FOUND 가장 최근의 SQL 문장이 하나 또는 그 이상의 행에 영향을 미친다면 TRUE 로 평가한다.
  --SQL%NOTFOUND 가장 최근의 SQL 문장이 어떤 행에도 영향을 미치지 않았다면 TRUE 로  평가한다.
  --SQL%ISOPEN PL/SQL 이 실행된 후에 즉시 암시적 커서를 닫기 때문에 항상 FALSE 로 평가된다.
  
/*
   DECLARE
          CURSOR 커서이름 IS 문자(커서가 실행할 쿼리)
   BEGIN
         OPEN 커서이름 (커서가 가지고 있는 쿼리를 실행)
             
         FETCH 커서이름 INTO 변수명들...
          --커서로 부터 데이터를 읽어서 원하는 변수에 저장
         CLOSE 커서이름 (커서닫기) 
   END


*/
DECLARE
  vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vsal   emp.sal%TYPE;
  CURSOR c1 
  IS select empno,ename,sal from emp where deptno=30; --기존에는 where조건이 1개만 가능 했는데
BEGIN
    OPEN c1; --커서가 가지고 있는 문장 실행
    LOOP
      --Memory
      /*
        7499 ALLEN 1600
        7521 WARD 1250
        7654 MARTIN 1250
        7698 BLAKE 2850
        7844 TURNER 1500
        7900 JAMES 950
      */
      FETCH c1 INTO vempno , vename, vsal;
      EXIT WHEN c1%NOTFOUND; --더이상 row 가 없으면 탈출
        DBMS_OUTPUT.PUT_LINE(vempno || '-' || vename || '-'|| vsal);
    END LOOP;
    CLOSE c1;
END;
-------------------------------------------------------
--위 표현을 좀 더 간단하게 쓰기
--java (for(emp e : emplist){}
DECLARE
  CURSOR emp_curr IS  select empno ,ename from emp;
BEGIN
  FOR emp_record IN emp_curr  --row 단위로 emp_record변수 할당
    LOOP
      EXIT WHEN  emp_curr%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(emp_record.empno || '-' || emp_record.ename);
    END LOOP;
    CLOSE emp_curr;
END;

---
DECLARE
  vemp emp%ROWTYPE;
  CURSOR emp_curr IS  select empno ,ename from emp;
BEGIN
  FOR vemp IN emp_curr  --row 단위로 emp_record변수 할당
    LOOP
      EXIT WHEN  emp_curr%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(vemp.empno || '-' || vemp.ename);
    END LOOP;
    CLOSE emp_curr;
END;
-------------------------------------------------
DECLARE
  v_sal_total NUMBER(10,2) := 0;
  CURSOR emp_cursor
  IS SELECT empno,ename,sal FROM emp
     WHERE deptno = 20 AND job = 'CLERK'
     ORDER BY empno;
BEGIN
  DBMS_OUTPUT.PUT_LINE('사번 이 름 급 여');
  DBMS_OUTPUT.PUT_LINE('---- ---------- ----------------');
  FOR emp_record IN emp_cursor 
  LOOP
      v_sal_total := v_sal_total + emp_record.sal;
      DBMS_OUTPUT.PUT_LINE(RPAD(emp_record.empno,6) || RPAD(emp_record.ename,12) ||
                           LPAD(TO_CHAR(emp_record.sal,'$99,999,990.00'),16));
  END LOOP;
      DBMS_OUTPUT.PUT_LINE('----------------------------------');
      DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(20),2) || '번 부서의 합 ' ||
      LPAD(TO_CHAR(v_sal_total,'$99,999,990.00'),16));
END;

--
create table cursor_table
as
  select * from emp where 1=2;

select* from cursor_table;  

alter table cursor_table
add totalsum number;

--문제
--emp 테이블에서 사원들의  사번 , 이름 , 급여를 가지고
--와서 cursor_table insert 를 하는데 부서번호20은 급여 + comm 통해서
--부서번호가 10인 사원은 totalsum에 급여 정보만 넣으세요
--데이터 처리
--
insert into CURSOR_TABLE(empno,ename,sal,totalsum)
select empno , ename , sal , sal+nvl(comm,0)
from emp where deptno=20;

select *  from CURSOR_TABLE;

DECLARE
  result number := 0;
  CURSOR emp_curr 
  IS select empno, ename, sal,deptno,comm from emp;
  BEGIN
    FOR vemp IN emp_curr   --row 단위로 emp_record 변수에 할당
    LOOP
        EXIT WHEN emp_curr%NOTFOUND;
        IF(vemp.deptno = 20) THEN 
            result := vemp.sal+nvl(vemp.comm,0);
              insert into cursor_table(empno, ename, sal,deptno,comm,totalsum) 
              values (vemp.empno,vemp.ename, vemp.sal,vemp.deptno,vemp.comm,result);
        ELSIF(vemp.deptno = 10) THEN 
            result := vemp.sal;
              insert into cursor_table(empno, ename, sal,deptno,comm,totalsum) 
              values (vemp.empno,vemp.ename, vemp.sal,vemp.deptno,vemp.comm,result);
        ELSE
            DBMS_OUTPUT.PUT_LINE('ETC');
        END IF;
     END LOOP;   
  END;

--rollback;
--commit;
select * from cursor_table order by deptno;


--PL-SQL 트랜잭션 및 예외 처리하기
 DECLARE
    v_ename emp.ename%TYPE := '&p_ename';
    v_err_code NUMBER;
    v_err_msg VARCHAR2(255);
    BEGIN
       DELETE emp WHERE ename = v_ename;
          IF SQL%NOTFOUND THEN
              RAISE_APPLICATION_ERROR(-20002,'my no data found');
         END IF;
       EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
              v_err_code := SQLCODE;
              v_err_msg := SQLERRM;
              DBMS_OUTPUT.PUT_LINE('에러 번호 : ' || TO_CHAR(v_err_code));
              DBMS_OUTPUT.PUT_LINE('에러 내용 : ' || v_err_msg);
      END;
        
select * from emp where ename ='KING';
--------------------------------------------------------------------------------
--지금까지는 만든 작업이 영속적으로 저장되지 않았다
--위에서 만든 커서를 영속적으로 저장하고싶다
--객체 형태로 저장해놓으면 그 다음에 코딩하지 않고 사용할 수 있다
--오라클에서는 이런것을 subprogram, procedure라고 부른다
--ms는 procedure
--자주 사용되는 쿼리를 모듈화하여 객체로 저장하고 필요한 시점에 불러서 사용하겟다

CREATE OR REPLACE PROCEDURE USP_EMPLIST
IS
BEGIN
  UPDATE EMP
  SET JOB='TTT'
  WHERE DEPTNO=30;
END;

--실행방법
EXECUTE USP_EMPLIST;
SELECT * FROM EMP;
ROLLBACK;
--장점
--기존: 앱의 SQL구문을 네트워크를 통해 DB에 보내고 결과를 받는다
--현재: 앱의 EXECUTE만 보내고 SQL는 서버에서 실행된다
--네트워크 트래픽 감소(시간 단축)
--네트워크 상 보안 요소 강화

--프로젝트에서 스케줄러는 반드시 포함해서 할 것이다

--파리미터 처리
--INPUT, OUTPUT 파라미터
CREATE OR REPLACE PROCEDURE USP_UPDATE_EMP
(VEMPNO EMP.EMPNO%TYPE)
IS 
  BEGIN
    UPDATE EMP
    SET SAL=0
    WHERE EMPNO=VEMPNO;
  END;
--실행
EXEC USP_UPDATE_EMP(7788);
ROLLBACK;
SELECT * FROM EMP;
--------------------------------------------------------------------------------
CREATE OR REPALCE PROCEDURE USP_GETEMPLIST
(VEMPNO EMP.EMPNO%TYPE)
IS
  --프로시저 내부에서 사용하는 변수는 DECLARE를 하지 않고도 가능하다
  VNAME EMP.ENAME%TYPE;
  VSAL EMP.SAL%TYPE;
  BEGIN
    SELECT ENAME, SAL
    INTO VNAME, VSAL
    FROM EMP
    WHERE EMPNO=VEMPNO;
    DBMS_OUTPUT.PUT_LINE('이름: '||VNAME);
    DBMS_OUTPUT.PUT_LINE('급여: '||VSAL);
  END;
EXEC USP_GETEMPLIST(7902);
--------------------------------------------------------------------------------
--프로시저는 파리미터 종류 2가지
--INPUT: 사용시 반드시 입력 (IN, 디폴트)
--OUTPUT: 사용시 입력값을 받지 않음 (OUT)
CREATE OR REPLACE PROCEDURE APP_GET_EMPLIST
(
  VEMPNO IN EMP.EMPNO%TYPE,
  VENAME OUT EMP.ENAME%TYPE,
  VSAL OUT EMP.SAL%TYPE
)
IS
  BEGIN
    SELECT ENAME, SAL
    INTO VENAME, VSAL
    FROM EMP
    WHERE EMPNO=VEMPNO;
  END;
--오라클 실행 테스트 (OUT으로 던진걸 받아야 한다)
DECLARE
OUT_ENAME EMP.ENAME%TYPE;
OUT_SAL EMP.SAL%TYPE;
BEGIN
  APP_GET_EMPLIST(7902, OUT_ENAME, OUT_SAL); --여가 좀 이상하다고 한다
  DBMS_OUTPUT.PUT_LINE('출력값: '||OUT_ENAME||'-'||OUT_SAL);
END;

--------------------------------------------------------------------------------
/*
TO_CHAR(), SUM() 오라클에서 제공
사용자가 직접 필요한 함수를 만들어 사용가능
사용방법은 다른 함수와 동일
사용자 정의 함수, 파라미터 정의, 리턴값
*/
CREATE OR REPLACE FUNCTION F_MAX_SAL
(S_DEPTNO EMP.DEPTNO%TYPE)
RETURN NUMBER --public int요거 f_max_sal(int deptno) {return 10}
IS
  MAX_SAL EMP.SAL%TYPE
BEGIN
  SELECT MAX(SAL)
  INTO MAX_SAL
  FROM EMP
  WHERE DEPTNO=S_DEPTNO;
  RETURN MAX_SAL; --public int f_max_sal(int deptno) {return 10이거}
END;
select * from emp where sal=f_max_sal(10);
SELECT MAX(SAL), F_MAX_SAL(30) FROM EMP;

CREATE OR REPLACE FUNCTION F_CALLNAME
(VEMPNO EMP.EMPNO%TYPE)
RETURN VARCHAR2
IS
  V_NAME EMP.ENAME%TYPE;
BEGIN
  SELECT ENAME||'님'
  INTO V_NAME
  FROM EMP
  WHERE EMPNO=VEMPNO;
  RETURN V_NAME;
END;
SELECT F_CALLNAME(7788) FROM DUAL;
SELECT EMPNO, ENAME, F_CALLNAME(EMPNO), SAL
FROM EMP
WHERE EMPNO=7788;

--파리미터 사번을 입력받아서 사번에 해당되는 부서이름을 리턴하는 함수
CREATE OR REPLACE FUNCTION F_GET_DNAME
(VEMPNO EMP.EMPNO%TYPE)
RETURN VARCHAR
IS
 V_DNAME DEPT.DNAME%TYPE;
BEGIN
  SELECT DNAME
  INTO V_DNAME
  FROM DEPT
  WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE EMPNO=VEMPNO);
  RETURN V_DNAME;
END;
SELECT EMPNO, ENAME, F_GET_DNAME(EMPNO)
FROM EMP
WHERE EMPNO=7788;
--------------------------------------------------------------------------------
--[트리거 : Trigger]
--트리거(trigger)의 사전적인 의미는 방아쇠나 (방아쇠를) 쏘다, 발사하다,
--(사건을) 유발시키다라는 의미가 있다.
 
--입고    재고     출고
 
--입고 INSERT (내부적으로 트랜잭션이 동작)
--재고 INSERT
--편하긴 한데 LOCK을 걸어서 성능 저하가 일어남
 
 
--PL/SQL에서의 트리거 역시 방아쇠가 당겨지면 자동으로 총알이 발사되듯이
--어떠한 이벤트가 발생하면 그에 따라 다른 작업이 자동으로 처리되는 것을 의미한다.
--INSERT, DELETE, UPDATE
/*
트리거란 특정 테이블의 데이터에 변경이 가해졌을 때 자동으로 수행되는
[저장 프로시저]라고 할 수 있다.
앞서 배운 저장 프로시저는 필요할 때마다 사용자가 직접
 EXECUTE 명령어로 호출해야 했다.
하지만 트리거는 이와 달리 테이블의
데이터가 INSERT, UPDATE, DELETE 문에 의해 변경되어질 때
[ 자동으로 수행되므로 이 기능을 이용하며 여러 가지 작업 ] 을 할 수 있다.
이런 이유로 트리거를 사용자가 직접 실행시킬 수는 없다.
 
 
--BEFORE : 테이블에서 DML 실행되기 전에 트리거가 동작
--AFTER :  테이블에서 DML 실행후에 트리거 동작
 
Syntax
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER} triggering_event [OF column1, . . .] ON table_name
[FOR EACH ROW [WHEN trigger_condition]
trigger_body;
 
trigger_name TRIGGER 의 식별자
  BEFORE | AFTER DML 문장이 실행되기 전에 TRIGGER 를 실행할 것인지 실행된
  후에 TRIGGER 를 실행할 것인지를 정의
triggering_event 
TRIGGER 를 실행하는 DML(INSERT,UPDATE,DELETE)문을 기술한다.
 
OF column TRIGGER 가 실행되는 테이블에서 COLUMN 명을 기술한다.
 
table_name TRIGGER 가 실행되는 테이블 이름
 
FOR EACH ROW 이 옵션을 사용하면 
행 레벨 트리거가 되어 triggering 문장
에 의해 영향받은 행에 대해 각각 한번씩 실행하고 사용하지
않으면 문장 레벨 트리거가 되어 DML 문장 당 한번만 실행된다.
 
 
  TRIGGER 에서 OLD 와 NEW
    행 레벨 TRIGGER 에서만 사용할 수 있는 예약어로 트리거 내에서 현재 처리되고 있는 행
    을 액세스할 수 있다. 즉 두개의 의사 레코드를 통하여 이 작업을 수행할 수 있다. :OLD
    는 INSERT 문에 의해 정의되지 않고 :NEW 는 DELETE 에 대해 정의되지 않는다. 그러나
    UPDATE 는 :OLD 와 :NEW 를 모두 정의한다. 아래의 표는 OLD 와 NEW 값을 정의한 표이다. 
    문장 :OLD :NEW
    INSERT 모든 필드는 NULL 로 정의 문장이 완전할 때 삽입된 새로운 값
    UPDATE 갱신하기 전의 원래 값 문장이 완전할 때 갱신된 새로운 값
    DELETE 행이 삭제되기 전의 원래 값 모든 필드는 NULL 이다.
 
DROP TRIGGER 명령어로 트리거를 삭제할 수 있고 TRIGGER 를 잠시 disable 할 수 있다.
DROP TRIGGER trigger_name;
ALTER TRIGGER trigger_name {DISABLE | ENABLE};
TRIGGER 와 DATA DICTIONARY
TRIGGER 가 생성될 때 소스 코드는 데이터 사전 VIEW 인 user_triggers 에 저장된다. 이
VIEW 는 TRIGGER_BODY, WHERE 절, 트리거링 테이블, TRIGGER 타입을 포함 한다.
 
*/
CREATE TABLE TRI_EMP
AS
SELECT EMPNO, ENAME FROM EMP WHERE 1=2;

CREATE OR REPLACE TRIGGER TRI_01
AFTER INSERT ON TRI_EMP
BEGIN
  DBMS_OUTPUT.PUT_LINE('신입사원 입사');
END;
INSERT INTO TRI_EMP VALUES(100,'김유신');
INSERT INTO TRI_EMP VALUES(200,'홍길동');

CREATE OR REPLACE TRIGGER TRI_02
AFTER UPDATE ON TRI_EMP
BEGIN
  DBMS_OUTPUT.PUT_LINE('신입사원 수정');
END;

UPDATE TRI_EMP
SET ENAME='아하'
WHERE EMPNO=100;

CREATE OR REPLACE TRIGGER TRI_03
AFTER DELETE ON TRI_EMP
BEGIN
  DBMS_OUTPUT.PUT_LINE('신입사원 삭제');
END;

DELETE FROM TRI_EMP
WHERE EMPNO=100;
--테이블에서 트리거 정보 확인하기
SELECT * FROM USER_TRIGGERS;
--------------------------------------------------------------------------------
--트리거의 활용
CREATE TABLE TRI_ORDER (
  NO NUMBER,
  ORD_CODE VARCHAR2(10),
  ORD_DATE DATE
);

--BEFORE 트리거
CREATE OR REPLACE TRIGGER TRIGGER_ORDER
BEFORE INSERT ON TRI_ORDER
BEGIN
  IF(TO_CHAR(SYSDATE, 'HH24:MM') NOT BETWEEN '09:00' AND '16:00')
  THEN RAISE_APPLICATION_ERROR(-20000, '허용시간 오류, 쉬세요');
  END IF;
END;

INSERT INTO TRI_ORDER VALUES(1, 'NOTEBOOK', SYSDATE);
COMMIT;
DROP TRIGGER TRIGGER_ORDER;

--POINT
--PL-SQL에서는 두개의 가상테이블을 제공
--:OLD > 트리거가 처리한 레코드의 원래 값을 저장(MS는 DELETED 가상테이블)
--:NEW > 새값을 포함(MS는 INSERTED 가방테이블)

CREATE OR REPLACE TRIGGER TRI_ORDER2
BEFORE INSERT ON TRI_ORDER
FOR EACH ROW --테이블에 방연될때
BEGIN
  IF(:NEW.ORD_CODE) NOT IN('DESKTOP') THEN
  RAISE_APPLICATION_ERROR(-20002, '제품코드 오류');
  END IF;
END;
INSERT INTO TRI_ORDER VALUES(200,'NOTEBOOK', SYSDATE);
INSERT INTO TRI_ORDER VALUES(200,'DESKTOP', SYSDATE);
SELECT * FROM TRI_ORDER;
COMMIT;
--------------------------------------------------------------------------------
--입고테이블
CREATE TABLE T_01 (
NO NUMBER,
PNAME VARCHAR2(20)
);
--재고 테이블
CREATE TABLE T_02 (
NO NUMBER,
PNAME VARCHAR2(20)
);
--입고데이터가 들어오면 같은 데에터를 재고로 입력
CREATE OR REPLACE TRIGGER INSERT_T_01
AFTER INSERT ON T_01
FOR EACH ROW
BEGIN
  INSERT INTO T_02(NO, PNAME) VALUES(:NEW.NO, :NEW.PNAME);
END;
--데이터 입력
INSERT INTO T_01 VALUES(1, 'NOTEBOOK');
SELECT * FROM T_01, T_02;
--입고 제품이 변경(재고 변경)
CREATE OR REPLACE TRIGGER UPDATE_T_01
AFTER UPDATE ON T_01
FOR EACH ROW
BEGIN
  UPDATE T_02
  SET PNAME=:NEW.PNAME
  WHERE NO=:OLD.NO;
END;
--데이터 변경
UPDATE T_01
SET PNAME='NOTEBOOK2'
WHERE NO=1;
SELECT * FROM T_01;
SELECT * FROM T_02;
--데이터 삭제 트리거
CREATE OR REPLACE TRIGGER DELETE_T_01
AFTER DELETE ON T_01
FOR EACH ROW
BEGIN
  DELETE FROM T_02
  WHERE NO=:OLD.NO;
END;
--데이터 삭제
DELETE FROM T_01
WHERE NO=1;
SELECT * FROM T_01;
SELECT * FROM T_02;
COMMIT;