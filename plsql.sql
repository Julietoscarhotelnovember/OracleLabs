select * from emp;

--PL/SQL �̶� ?
--PL/SQL �� Oracle's Procedural Language extension to SQL. �� ���� �Դϴ�.
--SQL���忡�� ��������, ����ó��(IF), �ݺ�ó��(LOOP, WHILE, FOR)���� �����ϸ�,
--����Ŭ ��ü�� ����Ǿ� �ִ� Procedure Language�Դϴ�
--DECLARE���� �̿��Ͽ� ���ǵǸ�, ������ ����� ���� �����Դϴ�.
--PL/SQL ���� ��� ������ �Ǿ� �ְ� PL/SQL �ڽ��� ������ ������ ������ �ֽ��ϴ�.

--��� �ڿ��� db�� �ִ�
--����-DBMS��� �� �̿��ؾ� ����� ���δ�
--system.out.printlnó�� ����� Ȯ���ؾ� �Ѵ�
--1.�� ��������
BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;

--PLSQL
--�����(����)
--�����(������ �Ҵ�, �����)
--���ܺ�(EXECPTION ó��)

DECLARE
  VNO NUMBER(4);
  VNAME VARCHAR2(20);
BEGIN
  VNO := 100; --�Ҵ�
  VNAME := 'KGLIM';
  DBMS_OUTPUT.PUT_LINE(VNO);
  DBMS_OUTPUT.PUT_LINE(VNAME||'�Դϴ�');
END;

--����������
DECLARE
V_JOB VARCHAR2(10);
V_COUNT NUMBER := 10; --�ʱⰪ ����
V_DATE DATE := SYSDATE+7;
V_VALID BOOLEAN NOT NULL := 10;
--------------------------------------------------------------------------------
DECLARE
  VNO NUMBER(4);
  VNAME VARCHAR2(20);
BEGIN
SELECT ENPNO, ENAME
  INTO VNO, VNAME --PLSQL���� �ִ� ����
FROM EMP WHERE EMPNO=&EMPNO; --�ڹٿ��� ��ĳ�� ����
DBMS_OUTPUT.PUT_LINE('������: '||VNO||'/'||VNAME);
END;

--�ǽ����̺� �����
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

--���� �����ϱ�
--1Ÿ��: V_EMPNO NUMBER(10)
--2Ÿ��: V_EMPNO EMP.EMPNO%TYPE (EMP���̺��� EMPNO �÷��� Ÿ���� �״�� ������ ����)
--3Ÿ��: V_ROW EMP%ROWTYPE (EMP���̺��� ��� �÷��� Ÿ���� �� ������ ����)

--����
--�ΰ��� ������ �Է¹޾� �� ���� ����ϱ�
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
  VALUES(V_EMPNO,'ȫ�浿');
  
  COMMIT;
END;
SELECT * FROM EMPDML;
--------------------------------------------------------------------------------
--���
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
  
  --���
  IF(VDEPTNO=10) THEN VNAME := 'ACC';
  ELSIF(VDEPTNO=20) THEN VNAME :='IT'; --���� �̻��Ѱ�
  ELSIF(VDEPTNO=30) THEN VNAME :='SALES';
  END IF;
  DBMS_OUTPUT.PUT_LINE('��� ����: '||VNAME);
END;

--IF() THEN ���๮
--ELSIF() THEN ���๮
--ELSE ���๮

--����� 7788���� ����� ���, �̸�, �޿��� ������ ���
--������ ��� �޿��� 2000�̻��̸� ����� �޿��� BIG���� ���
--�׷��� ������ ����� �޿��� SMALL�� ǥ��
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
  
  --���
  IF(VSAL>2000) THEN VSIZE := 'BIG';
  ELSE VSIZE := 'SMALL';
  END IF;
  DBMS_OUTPUT.PUT_LINE('��� �޿�: '||VSIZE);
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
  DBMS_OUTPUT.PUT_LINE('��� �μ�: '||V_NAME);
END;
--------------------------------------------------------------------------------
--�ݺ���

--LOOP
/*
LOOP 
  ������;
  EXIT WHEN (���ǽ�)
END LOOP
*/
DECLARE
  N NUMBER := 0;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE('N��: ' || N);
    N := N+1;
    EXIT WHEN N>5;
  END LOOP;
END;

/*
WHILE(N<6)
LOOP
  ���๮;
END LOOP;
*/
DECLARE
  NUM NUMBER := 0;
BEGIN
  WHILE(NUM<6)
  LOOP
    DBMS_OUTPUT.PUT_LINE('NUM��: ' || NUM);
    NUM := NUM+1;
  END LOOP; 
END;

--FOR��
--�� �װ�
BEGIN
  FOR I IN 0..10 LOOP
    DBMS_OUTPUT.PUT_LINE(I);
  END LOOP;
END;

--FOR���� �̿��� 1~100���� ���� ���ϱ�
DECLARE
  TOTAL NUMBER :=0;
BEGIN
  FOR I IN 1..100 LOOP
    TOTAL:=TOTAL+I;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(TOTAL);
END;

--CONTINUE
--11G ���ĺ��� ��� ����
DECLARE
  TOTAL NUMBER := 0;
BEGIN
  FOR I IN 1..100 LOOP
    DBMS_OUTPUT.PUT_LINE('����: '||I);
    CONTINUE WHEN I > 5; --SKIP
    TOTAL := TOTAL + I;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('�հ�: '||TOTAL);
END;
--------------------------------------------------------------------------------
--Ȱ��
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
  
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||'�� ����'); --�ý��ۺ���, �ݿ��� ���� ���� Ȯ��
  
  --����ó��
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('�׷� �̸��� �����ϴ�');
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('���������� �ֽ��ϴ�'); --�ϳ��ۿ� ó���� ���ؼ�
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('������ �� �� �����ϴ�');
END;
--------------------------------------------------------------------------------
--���� Ŀ��, ���ν���, ���, Ʈ���� ��� �����ϴ�
--���ݱ����� ���� ������ ������ ó�� (���̺��� ��ü row�� �������)

--[CURSOR]
--1.  [�����]�� �����͸� ó���ϴ� ����� ����
--2.  �������� �����͸� ó���ϴ� ó���ϴ� ����� ���� (�� ���̻���  row������ ���)
 
--����޿����̺�(�Ǽ�ȸ��)
--������ , �Ͽ��� ,�ð��� 

--��� , �̸� , ������ , ���� , �ð� , �ð��� , �Ĵ�
-- 10   ȫ�浿  ������   120   null   null   null
-- 11   ������  �ð���  null   10      100
-- 12   �̼���  �Ͽ���  null   null    120   10

--�� �྿ �����ؼ� ������ �������� �����
--�̷��� ������ �ִ� ���� �����ϴ�
--if ������ > ����
--elsif �ð��� > �ð�*�ð���(�ѱ޿�)
--elsif �Ͽ��� > �ð���+�Ĵ�(�ѱ޿�)
 
 
--SQL CURSOR �� �Ӽ��� ����Ͽ� SQL ������ ����� �׽�Ʈ�� �� �ִ�.
--[�� �� �� ��]
  --SQL%ROWCOUNT ���� �ֱ��� SQL ���忡 ���� ������ ���� ���� ��
  --SQL%FOUND ���� �ֱ��� SQL ������ �ϳ� �Ǵ� �� �̻��� �࿡ ������ ��ģ�ٸ� TRUE �� ���Ѵ�.
  --SQL%NOTFOUND ���� �ֱ��� SQL ������ � �࿡�� ������ ��ġ�� �ʾҴٸ� TRUE ��  ���Ѵ�.
  --SQL%ISOPEN PL/SQL �� ����� �Ŀ� ��� �Ͻ��� Ŀ���� �ݱ� ������ �׻� FALSE �� �򰡵ȴ�.
  
/*
   DECLARE
          CURSOR Ŀ���̸� IS ����(Ŀ���� ������ ����)
   BEGIN
         OPEN Ŀ���̸� (Ŀ���� ������ �ִ� ������ ����)
             
         FETCH Ŀ���̸� INTO �������...
          --Ŀ���� ���� �����͸� �о ���ϴ� ������ ����
         CLOSE Ŀ���̸� (Ŀ���ݱ�) 
   END


*/
DECLARE
  vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vsal   emp.sal%TYPE;
  CURSOR c1 
  IS select empno,ename,sal from emp where deptno=30; --�������� where������ 1���� ���� �ߴµ�
BEGIN
    OPEN c1; --Ŀ���� ������ �ִ� ���� ����
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
      EXIT WHEN c1%NOTFOUND; --���̻� row �� ������ Ż��
        DBMS_OUTPUT.PUT_LINE(vempno || '-' || vename || '-'|| vsal);
    END LOOP;
    CLOSE c1;
END;
-------------------------------------------------------
--�� ǥ���� �� �� �����ϰ� ����
--java (for(emp e : emplist){}
DECLARE
  CURSOR emp_curr IS  select empno ,ename from emp;
BEGIN
  FOR emp_record IN emp_curr  --row ������ emp_record���� �Ҵ�
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
  FOR vemp IN emp_curr  --row ������ emp_record���� �Ҵ�
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
  DBMS_OUTPUT.PUT_LINE('��� �� �� �� ��');
  DBMS_OUTPUT.PUT_LINE('---- ---------- ----------------');
  FOR emp_record IN emp_cursor 
  LOOP
      v_sal_total := v_sal_total + emp_record.sal;
      DBMS_OUTPUT.PUT_LINE(RPAD(emp_record.empno,6) || RPAD(emp_record.ename,12) ||
                           LPAD(TO_CHAR(emp_record.sal,'$99,999,990.00'),16));
  END LOOP;
      DBMS_OUTPUT.PUT_LINE('----------------------------------');
      DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(20),2) || '�� �μ��� �� ' ||
      LPAD(TO_CHAR(v_sal_total,'$99,999,990.00'),16));
END;

--
create table cursor_table
as
  select * from emp where 1=2;

select* from cursor_table;  

alter table cursor_table
add totalsum number;

--����
--emp ���̺��� �������  ��� , �̸� , �޿��� ������
--�ͼ� cursor_table insert �� �ϴµ� �μ���ȣ20�� �޿� + comm ���ؼ�
--�μ���ȣ�� 10�� ����� totalsum�� �޿� ������ ��������
--������ ó��
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
    FOR vemp IN emp_curr   --row ������ emp_record ������ �Ҵ�
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


--PL-SQL Ʈ����� �� ���� ó���ϱ�
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
              DBMS_OUTPUT.PUT_LINE('���� ��ȣ : ' || TO_CHAR(v_err_code));
              DBMS_OUTPUT.PUT_LINE('���� ���� : ' || v_err_msg);
      END;
        
select * from emp where ename ='KING';
--------------------------------------------------------------------------------
--���ݱ����� ���� �۾��� ���������� ������� �ʾҴ�
--������ ���� Ŀ���� ���������� �����ϰ�ʹ�
--��ü ���·� �����س����� �� ������ �ڵ����� �ʰ� ����� �� �ִ�
--����Ŭ������ �̷����� subprogram, procedure��� �θ���
--ms�� procedure
--���� ���Ǵ� ������ ���ȭ�Ͽ� ��ü�� �����ϰ� �ʿ��� ������ �ҷ��� ����ϰٴ�

CREATE OR REPLACE PROCEDURE USP_EMPLIST
IS
BEGIN
  UPDATE EMP
  SET JOB='TTT'
  WHERE DEPTNO=30;
END;

--������
EXECUTE USP_EMPLIST;
SELECT * FROM EMP;
ROLLBACK;
--����
--����: ���� SQL������ ��Ʈ��ũ�� ���� DB�� ������ ����� �޴´�
--����: ���� EXECUTE�� ������ SQL�� �������� ����ȴ�
--��Ʈ��ũ Ʈ���� ����(�ð� ����)
--��Ʈ��ũ �� ���� ��� ��ȭ

--������Ʈ���� �����ٷ��� �ݵ�� �����ؼ� �� ���̴�

--�ĸ����� ó��
--INPUT, OUTPUT �Ķ����
CREATE OR REPLACE PROCEDURE USP_UPDATE_EMP
(VEMPNO EMP.EMPNO%TYPE)
IS 
  BEGIN
    UPDATE EMP
    SET SAL=0
    WHERE EMPNO=VEMPNO;
  END;
--����
EXEC USP_UPDATE_EMP(7788);
ROLLBACK;
SELECT * FROM EMP;
--------------------------------------------------------------------------------
CREATE OR REPALCE PROCEDURE USP_GETEMPLIST
(VEMPNO EMP.EMPNO%TYPE)
IS
  --���ν��� ���ο��� ����ϴ� ������ DECLARE�� ���� �ʰ� �����ϴ�
  VNAME EMP.ENAME%TYPE;
  VSAL EMP.SAL%TYPE;
  BEGIN
    SELECT ENAME, SAL
    INTO VNAME, VSAL
    FROM EMP
    WHERE EMPNO=VEMPNO;
    DBMS_OUTPUT.PUT_LINE('�̸�: '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�޿�: '||VSAL);
  END;
EXEC USP_GETEMPLIST(7902);
--------------------------------------------------------------------------------
--���ν����� �ĸ����� ���� 2����
--INPUT: ���� �ݵ�� �Է� (IN, ����Ʈ)
--OUTPUT: ���� �Է°��� ���� ���� (OUT)
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
--����Ŭ ���� �׽�Ʈ (OUT���� ������ �޾ƾ� �Ѵ�)
DECLARE
OUT_ENAME EMP.ENAME%TYPE;
OUT_SAL EMP.SAL%TYPE;
BEGIN
  APP_GET_EMPLIST(7902, OUT_ENAME, OUT_SAL); --���� �� �̻��ϴٰ� �Ѵ�
  DBMS_OUTPUT.PUT_LINE('��°�: '||OUT_ENAME||'-'||OUT_SAL);
END;

--------------------------------------------------------------------------------
/*
TO_CHAR(), SUM() ����Ŭ���� ����
����ڰ� ���� �ʿ��� �Լ��� ����� ��밡��
������� �ٸ� �Լ��� ����
����� ���� �Լ�, �Ķ���� ����, ���ϰ�
*/
CREATE OR REPLACE FUNCTION F_MAX_SAL
(S_DEPTNO EMP.DEPTNO%TYPE)
RETURN NUMBER --public int��� f_max_sal(int deptno) {return 10}
IS
  MAX_SAL EMP.SAL%TYPE
BEGIN
  SELECT MAX(SAL)
  INTO MAX_SAL
  FROM EMP
  WHERE DEPTNO=S_DEPTNO;
  RETURN MAX_SAL; --public int f_max_sal(int deptno) {return 10�̰�}
END;
select * from emp where sal=f_max_sal(10);
SELECT MAX(SAL), F_MAX_SAL(30) FROM EMP;

CREATE OR REPLACE FUNCTION F_CALLNAME
(VEMPNO EMP.EMPNO%TYPE)
RETURN VARCHAR2
IS
  V_NAME EMP.ENAME%TYPE;
BEGIN
  SELECT ENAME||'��'
  INTO V_NAME
  FROM EMP
  WHERE EMPNO=VEMPNO;
  RETURN V_NAME;
END;
SELECT F_CALLNAME(7788) FROM DUAL;
SELECT EMPNO, ENAME, F_CALLNAME(EMPNO), SAL
FROM EMP
WHERE EMPNO=7788;

--�ĸ����� ����� �Է¹޾Ƽ� ����� �ش�Ǵ� �μ��̸��� �����ϴ� �Լ�
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
--[Ʈ���� : Trigger]
--Ʈ����(trigger)�� �������� �ǹ̴� ��Ƽ質 (��Ƽ踦) ���, �߻��ϴ�,
--(�����) ���߽�Ű�ٶ�� �ǹ̰� �ִ�.
 
--�԰�    ���     ���
 
--�԰� INSERT (���������� Ʈ������� ����)
--��� INSERT
--���ϱ� �ѵ� LOCK�� �ɾ ���� ���ϰ� �Ͼ
 
 
--PL/SQL������ Ʈ���� ���� ��Ƽ谡 ������� �ڵ����� �Ѿ��� �߻�ǵ���
--��� �̺�Ʈ�� �߻��ϸ� �׿� ���� �ٸ� �۾��� �ڵ����� ó���Ǵ� ���� �ǹ��Ѵ�.
--INSERT, DELETE, UPDATE
/*
Ʈ���Ŷ� Ư�� ���̺��� �����Ϳ� ������ �������� �� �ڵ����� ����Ǵ�
[���� ���ν���]��� �� �� �ִ�.
�ռ� ��� ���� ���ν����� �ʿ��� ������ ����ڰ� ����
 EXECUTE ��ɾ�� ȣ���ؾ� �ߴ�.
������ Ʈ���Ŵ� �̿� �޸� ���̺���
�����Ͱ� INSERT, UPDATE, DELETE ���� ���� ����Ǿ��� ��
[ �ڵ����� ����ǹǷ� �� ����� �̿��ϸ� ���� ���� �۾� ] �� �� �� �ִ�.
�̷� ������ Ʈ���Ÿ� ����ڰ� ���� �����ų ���� ����.
 
 
--BEFORE : ���̺��� DML ����Ǳ� ���� Ʈ���Ű� ����
--AFTER :  ���̺��� DML �����Ŀ� Ʈ���� ����
 
Syntax
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER} triggering_event [OF column1, . . .] ON table_name
[FOR EACH ROW [WHEN trigger_condition]
trigger_body;
 
trigger_name TRIGGER �� �ĺ���
  BEFORE | AFTER DML ������ ����Ǳ� ���� TRIGGER �� ������ ������ �����
  �Ŀ� TRIGGER �� ������ �������� ����
triggering_event 
TRIGGER �� �����ϴ� DML(INSERT,UPDATE,DELETE)���� ����Ѵ�.
 
OF column TRIGGER �� ����Ǵ� ���̺��� COLUMN ���� ����Ѵ�.
 
table_name TRIGGER �� ����Ǵ� ���̺� �̸�
 
FOR EACH ROW �� �ɼ��� ����ϸ� 
�� ���� Ʈ���Ű� �Ǿ� triggering ����
�� ���� ������� �࿡ ���� ���� �ѹ��� �����ϰ� �������
������ ���� ���� Ʈ���Ű� �Ǿ� DML ���� �� �ѹ��� ����ȴ�.
 
 
  TRIGGER ���� OLD �� NEW
    �� ���� TRIGGER ������ ����� �� �ִ� ������ Ʈ���� ������ ���� ó���ǰ� �ִ� ��
    �� �׼����� �� �ִ�. �� �ΰ��� �ǻ� ���ڵ带 ���Ͽ� �� �۾��� ������ �� �ִ�. :OLD
    �� INSERT ���� ���� ���ǵ��� �ʰ� :NEW �� DELETE �� ���� ���ǵ��� �ʴ´�. �׷���
    UPDATE �� :OLD �� :NEW �� ��� �����Ѵ�. �Ʒ��� ǥ�� OLD �� NEW ���� ������ ǥ�̴�. 
    ���� :OLD :NEW
    INSERT ��� �ʵ�� NULL �� ���� ������ ������ �� ���Ե� ���ο� ��
    UPDATE �����ϱ� ���� ���� �� ������ ������ �� ���ŵ� ���ο� ��
    DELETE ���� �����Ǳ� ���� ���� �� ��� �ʵ�� NULL �̴�.
 
DROP TRIGGER ��ɾ�� Ʈ���Ÿ� ������ �� �ְ� TRIGGER �� ��� disable �� �� �ִ�.
DROP TRIGGER trigger_name;
ALTER TRIGGER trigger_name {DISABLE | ENABLE};
TRIGGER �� DATA DICTIONARY
TRIGGER �� ������ �� �ҽ� �ڵ�� ������ ���� VIEW �� user_triggers �� ����ȴ�. ��
VIEW �� TRIGGER_BODY, WHERE ��, Ʈ���Ÿ� ���̺�, TRIGGER Ÿ���� ���� �Ѵ�.
 
*/
CREATE TABLE TRI_EMP
AS
SELECT EMPNO, ENAME FROM EMP WHERE 1=2;

CREATE OR REPLACE TRIGGER TRI_01
AFTER INSERT ON TRI_EMP
BEGIN
  DBMS_OUTPUT.PUT_LINE('���Ի�� �Ի�');
END;
INSERT INTO TRI_EMP VALUES(100,'������');
INSERT INTO TRI_EMP VALUES(200,'ȫ�浿');

CREATE OR REPLACE TRIGGER TRI_02
AFTER UPDATE ON TRI_EMP
BEGIN
  DBMS_OUTPUT.PUT_LINE('���Ի�� ����');
END;

UPDATE TRI_EMP
SET ENAME='����'
WHERE EMPNO=100;

CREATE OR REPLACE TRIGGER TRI_03
AFTER DELETE ON TRI_EMP
BEGIN
  DBMS_OUTPUT.PUT_LINE('���Ի�� ����');
END;

DELETE FROM TRI_EMP
WHERE EMPNO=100;
--���̺��� Ʈ���� ���� Ȯ���ϱ�
SELECT * FROM USER_TRIGGERS;
--------------------------------------------------------------------------------
--Ʈ������ Ȱ��
CREATE TABLE TRI_ORDER (
  NO NUMBER,
  ORD_CODE VARCHAR2(10),
  ORD_DATE DATE
);

--BEFORE Ʈ����
CREATE OR REPLACE TRIGGER TRIGGER_ORDER
BEFORE INSERT ON TRI_ORDER
BEGIN
  IF(TO_CHAR(SYSDATE, 'HH24:MM') NOT BETWEEN '09:00' AND '16:00')
  THEN RAISE_APPLICATION_ERROR(-20000, '���ð� ����, ������');
  END IF;
END;

INSERT INTO TRI_ORDER VALUES(1, 'NOTEBOOK', SYSDATE);
COMMIT;
DROP TRIGGER TRIGGER_ORDER;

--POINT
--PL-SQL������ �ΰ��� �������̺��� ����
--:OLD > Ʈ���Ű� ó���� ���ڵ��� ���� ���� ����(MS�� DELETED �������̺�)
--:NEW > ������ ����(MS�� INSERTED �������̺�)

CREATE OR REPLACE TRIGGER TRI_ORDER2
BEFORE INSERT ON TRI_ORDER
FOR EACH ROW --���̺� �濬�ɶ�
BEGIN
  IF(:NEW.ORD_CODE) NOT IN('DESKTOP') THEN
  RAISE_APPLICATION_ERROR(-20002, '��ǰ�ڵ� ����');
  END IF;
END;
INSERT INTO TRI_ORDER VALUES(200,'NOTEBOOK', SYSDATE);
INSERT INTO TRI_ORDER VALUES(200,'DESKTOP', SYSDATE);
SELECT * FROM TRI_ORDER;
COMMIT;
--------------------------------------------------------------------------------
--�԰����̺�
CREATE TABLE T_01 (
NO NUMBER,
PNAME VARCHAR2(20)
);
--��� ���̺�
CREATE TABLE T_02 (
NO NUMBER,
PNAME VARCHAR2(20)
);
--�԰����Ͱ� ������ ���� �����͸� ���� �Է�
CREATE OR REPLACE TRIGGER INSERT_T_01
AFTER INSERT ON T_01
FOR EACH ROW
BEGIN
  INSERT INTO T_02(NO, PNAME) VALUES(:NEW.NO, :NEW.PNAME);
END;
--������ �Է�
INSERT INTO T_01 VALUES(1, 'NOTEBOOK');
SELECT * FROM T_01, T_02;
--�԰� ��ǰ�� ����(��� ����)
CREATE OR REPLACE TRIGGER UPDATE_T_01
AFTER UPDATE ON T_01
FOR EACH ROW
BEGIN
  UPDATE T_02
  SET PNAME=:NEW.PNAME
  WHERE NO=:OLD.NO;
END;
--������ ����
UPDATE T_01
SET PNAME='NOTEBOOK2'
WHERE NO=1;
SELECT * FROM T_01;
SELECT * FROM T_02;
--������ ���� Ʈ����
CREATE OR REPLACE TRIGGER DELETE_T_01
AFTER DELETE ON T_01
FOR EACH ROW
BEGIN
  DELETE FROM T_02
  WHERE NO=:OLD.NO;
END;
--������ ����
DELETE FROM T_01
WHERE NO=1;
SELECT * FROM T_01;
SELECT * FROM T_02;
COMMIT;