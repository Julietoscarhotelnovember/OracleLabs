--������ ������ SQL: CRUD
--Create(Insert) Read(Select) Update Delete

--�ǽ����̺� ����
--Emp(��� ���̺�)
--Dept(�μ� ���̺�)
--Salegrade(�޿���� ���̺�)

/* ����
select [distinct] {*, column [alias], ...}
from table_name
[where condition]
[order by {column, expression} [asc|desc]]
*/

select empno, ename, sal from emp;
select empno, ename, job, hiredate, deptno from emp;

--�÷��� ����Ī(alias) �ο��ϱ�
select empno ���, ename �̸� from emp;
select empno "��   ��" from emp;
--�������
--as ����Ī
select empno as "�� ��", ename as "�� ��" from emp;

--���ڵ����� ����ϱ�
--java: "ȫ�浿", java: '��'
--java: ���ڿ� ������ +

--����Ŭ: '���ڿ�'
--����Ŭ ���̺� ���� ������ ���� ����
desc emp; --�÷� �̸�, Ÿ�Ժ���
--����Ŭ +�� �������, ���ڰ��տ����� ||
--ms-sql�� +�� �� �Ѵ�
select '����� �̸���: '||ename as "����̸�" from emp;

--����: �÷��� Ÿ���� �� �����ؼ� �����ؾ� �Ѵ�
--�ٵ� �̰� �ȴ� -> ���������� ����ȯ�� �Ͼ��
select empno||ename as "����" from emp;
--����||���� -> ����

-- +������� ||���Ῥ��
--����Ŭ�� �������� ���� �� �ִ� �������̺�(dual)�� �������� �Ѵ�
select 100+100 from dual;
select 100||100 from dual;
select '100'+100 from dual; --������ ���ڵ�����
select '100A'+100 from dual; --����

select empno+sal as "�հ�" from emp;
select empno+ename from emp; --����
select empno||ename from emp; --�̰� ��

--from �����
--�츮 ȸ���� ������ �� ����??
select distinct job from emp;

--����Ŭ�� �������� ��ҹ��ڴ� �������� �ʴ´�
--����Ŭ�� ���ڵ����͸� �����ϰ� ����
--����Ŭ���� SMITH, smith�� �ٸ� ����, MS-SQL������ ���� ����

--�տ��ſ� ���� �׷���, �߰��ſ� �׷���, �ڿ��ɷ� distinct
--distinct�� ���� �Ŵ� ���� ���� �ʴ�
select distinct deptno from emp;
select distinct deptno, job from emp order by deptno;

--����Ŭ ������
--��������� �ڹ� �����ڿ� ���� ���
--������ ���ϱ�: MOD

--����� �޿��� 100�޷� �λ��ϱ�
select * from emp;
select empno, ename, sal as "�⺻�޿�", sal+100 as "�λ�޿�" from emp;

--�񱳿�����
-- < > <= >= =(����) !=
--��������
--AND OR NOT

--����: where (���ǿ� �´� row�� ����)
--�޿��� 3õ�޷� �̻��� ��� ����� ���� ����ϱ�
select * from emp where sal>=3000;

--SQL Ʃ���� �⺻�� �������
--select  3 (�� ���߿� �ᵵ ��)
--from    1
--where   2

--����� 7788���� ����� ���, �̸�, ����, �Ի��� ����ϱ�
select empno, ename, job, hiredate from emp where empno=7788;

--����� �̸��� king�� ����� ���, �̸� ����ϱ�
select empno, ename from emp where ename='KING';

--�޿��� 2000�޷� �̻��̸鼭 ������ manager�� ����� ��� ���� ���
select * from emp where sal>=2000 and job='MANAGER';

--��¥ ǥ�� '2016-12-12'�� ����
--����Ŭ�� ������ �ð�����(�����ð�)
select sysdate from dual;
select hiredate from emp;
--����Ŭ�� �ý��� ���� ����(���, �ð�����, ��¥)
select * from SYS.NLS_SESSION_PARAMETERS;
select * from SYS.NLS_SESSION_PARAMETERS where PARAMETER='NLS_DATE_FORMAT';

--��¥ǥ��: '��¥' (���ڿ� ���� ǥ���Ѵ�)
select * from emp where hiredate='80/12/17';
select * from emp where hiredate='1980-12-17';
select * from emp where hiredate='2080-12-17';

--����������(���� ����)
--������ �������� ������� ���ư���
--RR/MM/DD -> YYYY-MM-DD
alter session set nls_date_format='YYYY-MM-DD HH24 MI:SS';
COMMIT;
select * from SYS.NLS_SESSION_PARAMETERS where PARAMETER='NLS_DATE_FORMAT';
select sysdate from dual;
select hiredate from emp;

--�Ի����� 1980�� 12�� 17���� ����� ��� ������ ����ϱ�
select * from emp where hiredate='1980-12-17';
select * from emp where hiredate='80-12-17'; --���� �ٲ㼭 �ȳ���, ������/�� ����

--�Ի����� 1982�� 1�� 1�� ������ ��� ����� ���� ����ϱ�
select * from emp where hiredate>'1982-1-1';

--����Ŭ �����ð� Ȱ���� ��𿡼�?
--�Խ��ǿ� �� �ۼ��� ��¥ǥ��
--insert into board(boaridid, title, writer, regdate)
--values(1,'����','�氡','ȫ�浿',sysdate);
--ms-sql: select getdate();

--����� �޿��� 2000�޷� �̻� 4õ�޷� ������ ��� ����� ���� ����ϱ�
select * from emp where sal>=2000 and sal<=4000;
--�ڵ� ���̱�
--between A and B (=�����ϴϱ� �����ؼ� ��� �Ѵ�)
select * from emp where sal between 2000 and 4000; 

--�μ���ȣ�� 10 or 20 or 30�� ����� ���, �̸�, �޿�, �μ���ȣ ����ϱ�
select empno, ename, sal, deptno
from emp
where deptno=10 or deptno=20 or deptno=30;
--in ������: �÷��� in(������, ������, ...) > orororor
select empno, ename, sal, deptno
from emp
where deptno in (10, 20, 30); --����Ŭ������ ������ or or�� �ؼ��Ѵ�

--�μ���ȣ�� 10���� �ƴ� ��� ����� ���� ����ϱ�
select *
from emp
where deptno!=10;

--�μ���ȣ�� 10, 20���� �ƴ� ��� ����� ���� ����ϱ�
select *
from emp
where deptno!=20 and deptno!=10;
select *
from emp
where deptno not in (10, 20); --and ����

--DB���� �����Ͱ� ���� -> null �ʿ��
--ex)ȸ�����Կ��� �ʼ�/�ΰ� �Է�
/*
create table member(
  uerid varchar2(20) not null, --�ʼ��Է�
  name varchar2(20) not null, --�ʼ��Է�
  hobby varchar2(50) --�ΰ��Է�
)
���� Ȱ��/��� �ʿ��ϴ�
*/

select sal, comm from emp;
--������ ���� �ʴ� ��� ����� ���� ����ϱ�
select * from emp where comm=null; --�̷� �ȳ��´�
--null�� ���� �񱳴� is null, is not null
select * from emp where comm is null;
--������ �޴� ��� ����� ���� ����ϱ�
select * from emp where comm is not null;

--������̺��� ���, �̸�, �޿�, ����, �ѱ޿� ����ϱ�
select empno, ename, sal, comm, sal+comm as "�ѱ޿�" from emp;
--null ������ ����� ������ �ʴ´�
--null���� ��� ������ ����� null
--null�� ó���ϴ� �Լ� �ʿ䰡 ���� �߿��ϴ�
--����Ŭ: nvl(), mssql: Convert() -> null�� ġȯ�Ѵ�
--nvl(�÷���, ġȯ��)
select empno, ename, sal, comm, sal+nvl(comm, 0) as "�ѱ޿�" from emp;


--����� �޿��� 1000 �̻��̰� ������ ���� �ʴ� ����� ���, �̸�, ����, �޿�
--, ������ ����ϱ�
select empno, ename, job, sal, comm from emp where sal>=1000 and comm is null;

--DQL: select
--DDL:
--create, alter, drop, ...

create table member(
  userid VARCHAR2(20) not null, --����20��, �ѱ�10��
  hobby VARCHAR2(20), --(default null)
  hp VARCHAR2(10) null
);

--DML
--insert, update, delete
insert into member (userid) values ('hong');
--rollback;
commit; --��ũ�� �ǹݿ�, rollback �Ұ���
select * from member;
insert into member (hobby) values ('��'); --������������
insert into member(userid, hobby) values ('kglim', '�౸');
select * from member;
commit;

--nvl�� ����/���� ��� ����
select userid, nvl(hobby,'��̾���')as "���" from member;

--���ڿ� ������ ��
--�˻� (like ���� �˻�)
--ex)�����ȣ �˻�
--���ϵ�ī�� ����(%��� ��, _�ѹ���)�� �����ؼ� �����ۼ�
--����ǥ����
select ename from emp where ename like '%A%'; --A�� �� ��� ���
select ename from emp where ename like 'A%'; --A�� ���۵Ǵ�
select ename from emp where ename like '%S'; --S�� ������
select ename from emp where ename like '%LL%';
select ename from emp where ename like '%A%A%'; --A�� �ι� ���� ���
select ename from emp where ename like '_A%'; --A�� �ι�°

--����: ����Ŭ�� ����ǥ����(regexp_like)
--���� �� ���� 3�� �����
select * from emp where regexp_like (ename, '[A-C]');

--�Խ��� �˻���ɿ��� ���

--������ �����ϱ�
--order by �÷���: ����, ��¥, ���� ����
--��������, ��������
select * from emp order by sal; --default asc
select * from emp order by sal desc; --default asc

--�Ի����� ���� ���� ������ �����ؼ� ���, �̸� , �޿�, �Ի��� ����ϱ�
select empno, ename, sal, hiredate from emp order by hiredate desc;
--���ڵ����� ����
select ename from emp order by ename;

--���� ���� ����
--select  3
--from    1
--where   2
--order by  4

select empno, ename, sal, job, hiredate from emp where job='MANAGER' order by hiredate desc;

--����
select job, deptno from emp order by job asc, deptno desc; --�׷� �ȿ��� ����
select deptno, job from emp order by deptno desc, job; --�׷� �ȿ��� ����
--order by ������ �÷� ������ ���߸� ���� ����



--������ UNION
--���̺�� ���̺� ��ġ��, �ߺ��� ����
--UNION ALL �ߺ��� ����ؼ� ��ġ��

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

select * from ut union select * from uta; --�� ���̺� ������ �Ʒ��� �����̺� �����͸� ���δ�
select * from ut union all select * from uta; --���ΰ��� �ٸ��� ���ΰ���!

--�����տ��� �߿��� ��
--�����Ǵ� �÷��� Ÿ���� �����ؾ� �Ѵ�
select empno, ename from emp
union
select deptno, dname from dept;

--�̰� ����
select empno, ename from emp 
union
select dname, deptno from dept;

--�����Ǵ� �÷��� ���� ��ġ�ؾ� �Ѵ�
--���� �ȸ´� ��� null�� �̿��� �÷��� ����� ����
select empno, ename, job from emp
union
select deptno, dname, null from dept;

-------------------------------------------------------------
--���ڿ� �ռ�
--��ҹ��ں�ȯ
select initcap('the super man') from dual;
select lower('the super man') from dual;
select upper('the super man') from dual;
select ename, lower(ename) as "ename" from emp;
select * from emp where lower(ename)='king';

--���ڰ���
select length('abc') from dual;
select length('ȫ�浿') from dual;
select length('ȫ �� ��') from dual;

--���տ����� || �̰� ������ ����
select 'aaa'||'bbbb' from dual;
--�����Լ�
select concat('aaa', 'bbbb') from dual;
select concat(ename, job) from emp;
select ename||' '||job||'�Դϴ�' from emp;

--java: substring > substr()
select substr('ABCDE', 2, 3) from dual;
select substr('ABCDE', 1, 1) from dual;
select substr('ABCDE', 3, 1) from dual;
select substr('ABCDE', 3) from dual;
select substr('ABCDE', -2, 1) from dual; --�ڿ��� 2��°���� 1��
select substr('ABCDE', -2, 2) from dual;

--����
--������̺��� ename �÷� �����Ϳ� ���� ù���ڴ� �ҹ��ڷ�
--������ ���ڴ� �빮�ڷ� ����ϵ� �ϳ��� �÷����� �����(����Ī fullname)
--����: ù���ڿ� ������ ���� ���̿� ���� �ϳ� �ֱ�
--ex) SMITH > s MITH
select lower(substr(ename,1,1))||' '||substr(ename,2) as "fullname" from emp;

--LPAD, RPAD (��, �� ���°��� ä���)
select lpad('ABC', 10, '*') from dual;
select rpad('ABC', 5, '@') from dual;
--���
--����� �Է�: hong1008
--ȭ�����: ho******
select rpad(substr('hong1008', 1, 2), length('hong1008'), '*') as ID from dual;
select rpad(substr(ename, 1, 2), length(ename), '*') as ID from emp;

--����
create table member2(
  id number,
  jumin VARCHAR2(14)
);
insert into member2(id, jumin) values(100,'123456-1234567');
insert into member2(id, jumin) values(200,'234567-1234567');
commit;
select * from member2;
--��°���� 100, 123456-******* �� ���·� ��������
--�÷��� jumin
select id||', '||rpad(substr(jumin, 1, 7), length(jumin), '*') as "jumin" from MEMBER2;

--RTRIM, LTRIM (��, ���� Ư�� ���� ����)
select rtrim('MILLER', 'ER') from dual;
select ltrim('MILLER', 'M') from dual;

--ġȯ�Լ� replace
select replace('ABCDE', 'A', 'WOW') FROM DUAL;
SELECT ENAME, REPLACE(ENAME, 'A', 'KIM') FROM EMP;
-------------------------------------------------------------
--�����Լ�
--ROUND() �ݿø�
SELECT ROUND(12.345, -1) AS "R" FROM DUAL;
SELECT ROUND(12.567, 0) AS "R" FROM DUAL;
SELECT ROUND(12.345, 1) AS "R" FROM DUAL;
--TRUNC() ����
SELECT TRUNC(12.345, -1) AS "T" FROM DUAL;
SELECT TRUNC(12.567, 0) AS "T" FROM DUAL;
SELECT TRUNC(12.345, 1) AS "T" FROM DUAL;
--MOD() ������ ���ϴ� �Լ�, �����ڰ� �ƴϴ�
SELECT 12/10 FROM DUAL; --/�� ��� ������� ���´�
SELECT MOD(12, 10) FROM DUAL;
SELECT MOD(0, 0) FROM DUAL; --0���� ������ �ش�

-------------------------------------------------------------
--��¥�Լ�
SELECT * FROM SYS.NLS_SESSION_PARAMETERS;
SELECT SYSDATE FROM DUAL;

--��¥�Լ� ��� �� ���� ����
--��¥+-���� > ��¥(���ڴ� �Ϸ� ���)
--��¥-��¥ > ����(��) > �� �ٹ��ϼ� ���ϱ�

SELECT MONTHS_BETWEEN('2016-02-22', '2015-02-22') FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, '2010-01-01') FROM DUAL;

SELECT SYSDATE+100 FROM DUAL;

--����
--��� ���̺��� ������� �Ի��Ͽ��� ��������� �ټӿ��� ���ϱ�
--����: �ټӿ����� ������
--�Ѵ��� 31�̶�� �����ϰ� �ټӿ����� ���ϱ�(���� �ݿø� ó��)
SELECT EMPNO, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE))AS "�ټӿ���1",
ROUND((SYSDATE-HIREDATE)/31, 0) AS "�ټӿ���2" FROM EMP;

-------------------------------------------------------------
--��ȯ�Լ�
--TO_CHAR() ��¥ > ����, ���� > ����
--TO_DATE() ���� > ��¥
--TO_NUMBER() ���� > ����

--����Ŭ �⺻Ÿ��
--CREATE TABLE ���̺��(�÷��� Ÿ������) = CLASS MEMBER {INT AGE, ...}

--����Ÿ��
--CHAR(20) > �������� > ���� �˻��ӵ��� ������
--VARCHAR2(20) > ��������

--�����ڵ�: ��� ���� 2����Ʈ�� ǥ��
--varchar2(20): �ѱ� ���� ȥ��
--nchar(20): 20�� > 40����Ʈ
--nvarchar(20): 20�� > 40����Ʈ

CREATE TABLE TEST(
  COL1 CHAR(20),
  COL2 VARCHAR2(20),
  COL3 NCHAR(20),
  COL4 NVARCHAR2(20),
  COL5 NUMBER,
  COL6 NUMBER(5),
  COL7 NUMBER(10, 3) --��ü 10�ڸ� �� �Ҽ� 3�ڸ�
);
INSERT INTO TEST(COL3) VALUES('AAAAAAAAAAAAAAAAAA');
SELECT * FROM TEST;
INSERT INTO TEST(COL3) VALUES('������������������������������');

-------------------------------------------------------------
--TO_NUMBER()
SELECT 1+1 FROM DUAL;
SELECT 1+'1' FROM DUAL; --�ڵ� ����ȯ
SELECT '100'+'100' FROM DUAL; --TO_NUMBER('100')
-------------------------------------------------------------
--TO_CHAR()
--��¥ > ���� ��ȯ�� ǥ�������� ����ȴ�
-- YYYY MM DD DAY DY(���� ���)
SELECT SYSDATE||'��' FROM DUAL; --�ڵ� ����ȯ
SELECT TO_CHAR(SYSDATE)||'��' FROM DUAL; --�̷��� ��Ģ������ �ϴ� ���� ����
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'YYYY')||'��' AS "YYYY",
       TO_CHAR(SYSDATE, 'YEAR'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

--����
--�Ի���� 12���� ����� ���, �̸�, �Ի���, �Ի�⵵ �Ի�� ����ϱ�
SELECT EMPNO, ENAME,
       TO_CHAR(HIREDATE, 'DD') AS "�Ի���",
       TO_CHAR(HIREDATE, 'YYYY') AS "�Ի�⵵"
FROM EMP
WHERE SUBSTR(HIREDATE, 6, 2)=12;
--���� ���Ĺ��� �ȿ��� �Ϲ� ���� ������ ""�ȿ� �־ ó��
--EX) 'YYYY"��" MM"��"'

--�ֹι�ȣ ���� �� ��Ÿ��
--A�� VARCHAR2(14)
--B�� ���ڸ� NUMBER(6) ���ڸ� NUMBER(7)

--TO_CHAR(����, '����')
--100,000�� ����
SELECT '>'||TO_CHAR(12345,'99999999')||'<' FROM DUAL; --9�� ���� �ڸ��� ��������� ä���
SELECT '>'||TO_CHAR(12345,'00000000')||'<' FROM DUAL; --0�� ���� �ڸ��� 0���� ä���
SELECT '>'||TO_CHAR(12345,'$9999999')||'<' FROM DUAL; --����ǥ��
SELECT '>'||TO_CHAR(1234567,'$9,999,999')||'<' FROM DUAL; --����ǥ��
SELECT EMPNO, ENAME, TO_CHAR(SAL, '$999,999')
FROM EMP
WHERE DEPTNO=30
ORDER BY SAL DESC;
-------------------------------------------------------------
--HR�������� ����
SELECT * FROM EMPLOYEES;
--��� ���̺��� ����� �̸��� (LAST NAME, FIRST NAME) ���ļ� FULLNAME���� ���
--�Ի����� YYYY-MM-DD �������� ���
--������ ���ϰ� ������ 10% �λ���� ���� �� 1000���� �޸�ó��
--2005�� ���� �Ի��ڵ鸸 ���
SELECT LAST_NAME||' '||FIRST_NAME AS "FULLNAME",
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS "HIRE_DATE",
       SALARY,
       SALARY*12 AS "����",
       TO_CHAR(SALARY*12*1.1, '999,999') AS "�λ��"
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY')>='2005'
ORDER BY "����" DESC;
-------------------------------------------------------------
--�����ڷ�
--TO_DATE ���� > ��¥
SELECT TO_DATE('2016-12-12', 'YYYY-MM-DD') FROM DUAL;
-------------------------------------------------------------
--���� > ���� > ��¥ > ��ȯ > �Ϲ�

--�Ϲ��Լ�
CREATE TABLE F_EMP(
  ID NUMBER(6),
  JOB VARCHAR2(20)
);
INSERT INTO F_EMP(ID, JOB) VALUES (100, 'IT');
INSERT INTO F_EMP(ID, JOB) VALUES (200, 'SALES');
INSERT INTO F_EMP(ID, JOB) VALUES (300, 'MGR');
INSERT INTO F_EMP(ID) VALUES (400);
COMMIT;

--NVL2() > NULLó��
SELECT ID, JOB, NVL2(JOB, 'AAA', 'BBB') FROM F_EMP;
--JOB�� NULL�� �ƴ� ���� ó����, NULL�̸� �ް�
SELECT ID, JOB, NVL2(JOB, JOB, 'EMPTY') FROM F_EMP; --�� �Ⱦ��� �Ѵ�
SELECT ID, JOB, NVL(JOB, 'EMPTY') FROM F_EMP; --�̰Ŷ� ��� ����

--DECODE(ǥ����, ����1, ���1, ����2, ���2, ....) IF�� ���
SELECT ID, JOB, DECODE(ID,
                        100, 'IT...',
                        200, 'SALES...',
                        300, 'MGR...',
                        'ETC'
                      ) AS "JOB"
FROM F_EMP;
SELECT DECODE(JOB, 'IT', 1) FROM F_EMP;
--GROUP + DECODE �Լ� ������� ����
SELECT COUNT(DECODE(JOB, 'IT', 1)), COUNT(DECODE(JOB, 'SALES', 1))
FROM F_EMP
GROUP BY JOB;

--EMP ���̺��� �μ���ȣ�� 10�̸� �λ��, 20�̸� ������, 30�̸� ȸ���
--�������� ��Ÿ�μ��� ��� (�÷��� �μ��̸�)
SELECT DEPTNO, DECODE(DEPTNO,
                      10, '�λ��',
                      20, '������',
                      30, 'ȸ���',
                      '��Ÿ�μ�'
             ) AS "�μ��̸�"
FROM EMP
ORDER BY DEPTNO;

--����
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
--F_EMP2���� ID, JUMIN ����ϵ� JUMIN�� ���ڸ��� 1�̸� ����, 2�̸� ����, 3�̸� �߼�, �׿ܴ� ��Ÿ�� ���
--�÷��� GENDER��
SELECT ID, JUMIN, DECODE(SUBSTR(JUMIN,1,1),
        1, '����',
        2, '����',
        3, '�߼�',
        '��Ÿ'
        ) AS GENDER
FROM F_EMP2;

--����
--�μ���ȣ�� 20���� ��� �� �̸��� SMITH�� HELLO ���
--�μ���ȣ�� 20���� ��� �� �̸��� SMITH�� �ƴϸ� WORLD ���
--�μ���ȣ�� 20���� �ƴϸ� ETC ���
SELECT ENAME, DEPTNO, DECODE(DEPTNO,
        20, DECODE(ENAME,
                  'SMITH', 'HELLO',
                  'WORLD'
                  ),
        'ETC'
        ) AS "�Ǻ�"
FROM EMP;

--CASE�� > �ڹ��� SWITCH
--CASE ���� WHEN ���1 THEN ���1
--         WHEN ���2 THEN ���2
--         WHEN ���3 THEN ���3
--         ELSE ���4
--END "�÷���"
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
CASE ZIPCODE WHEN 2 THEN '����'
             WHEN 31 THEN '���'
             WHEN 32 THEN '����'
             WHEN 33 THEN '����'
             ELSE '��Ÿ����' END "REGIONNAME"
FROM T_ZIP;   

--����
--������̺��� ����޿��� 1000�޷� ���ϸ� 4��
--1001~2000 3��
--2001~3000 2��
--3001~4000 1��
--4001 �̻� Ư��
--���, �̸�, �޿�, �޿����
--�̷��Ե� �� �� �ִ�
SELECT EMPNO, ENAME, SAL, CASE WHEN SAL<=1000 THEN '4��'
                               WHEN SAL BETWEEN 1001 AND 2000 THEN '3��'
                               WHEN SAL BETWEEN 2001 AND 3000 THEN '2��'
                               WHEN SAL BETWEEN 3001 AND 4000 THEN '1��'
                               WHEN SAL > 4000 THEN 'Ư��'
                          END "�޿����"
FROM EMP;
-------------------------------------------------------------
--���� > ���� > ��¥ > ��ȯ > �Ϲ� > ����
--COUNT, SUM, AVG, MAX, MIN
--�����Լ��� ������ GROUP BY ���� ���� ���ȴ�
--��� �����Լ��� NULL�� �����Ѵ�
--SELECT���� �����Լ� �ܿ� �ٸ� �÷��� ���� �ݵ�� GROUP BY ���� �� �÷��� ����ؾ� �Ѵ�

--COUNT(�÷���): �÷��� ������ �Ǽ�
--COUNT(*): ROW �� ��ȯ
SELECT COUNT(COMM) FROM EMP;
SELECT COUNT(NVL(COMM,0)) FROM EMP;
SELECT SUM(COMM) AS "SUM" FROM EMP;

--����� ȸ�� ��å�� ���� �޶���
SELECT AVG(COMM) AS"AVG" FROM EMP; --721
SELECT 4330/14 FROM DUAL; --309

--�����Լ��� ���ϵǴ� ���� �ϳ��� ROW
SELECT MAX(SAL) FROM EMP;
SELECT COUNT(SAL), AVG(SAL), SUM(SAL), MAX(SAL), MIN(SAL) FROM EMP;
-------------------------------------------------------------
--EMPNO�� �ߺ����� ��� �׷��� �ǹ̰� ����
SELECT EMPNO, SUM(SAL)
FROM EMP
GROUP BY EMPNO;

--������ ��ձ޿� ���ϱ�
SELECT JOB, AVG(SAL), COUNT(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB;

--�μ���, ������ �޿��� ��
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

--������ ��ձ޿��� 3õ�޷� �̻��� ����� ������ ��ձ޿� ���ϱ�
--���� ���� ������ "������ ��ձ޿�" ���ϱ� �Ұ���
--�׷��� GROUP BY�� �������� HAVING���� �̿��Ѵ�
SELECT JOB, AVG(SAL) AS "AVGSAL" --4
FROM EMP --1
GROUP BY JOB --2
HAVING AVG(SAL) >=3000; --3 ������ ALIAS�� ����� �� ����

--���� ���̺� ��� SELECT
--SELECT 5
--FROM 1
--WHERE 2
--GROUP BY 3 
--HAVING 4
--ORDER BY 6

--������̺��� ������ �޿��� ���� ����ϵ�,
--������ ���� �ް� �޿��� ���� 5000�̻��� ������� ����� ����ϵ�,
--�޿��� ���� ���� ������ ���
SELECT JOB, SUM(SAL) AS "�޿���"
FROM EMP
WHERE COMM IS NOT NULL
GROUP BY JOB
HAVING SUM(SAL) >=5000
ORDER BY "�޿���";

--������̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� �� ���
SELECT DEPTNO, COUNT(SAL) AS "�ο���", SUM(SAL) AS "�޿���"
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(DEPTNO) >=4;

--������̺��� ������ �޿��� ���� 5000�� �ʰ��ϴ� ������ �޿��� ���� ���
--��, �Ǹ�����(SALESMAN)�� �����ϰ� �޿��� ������ �������� ����
SELECT JOB, SUM(SAL) AS "�޿���"
FROM EMP
WHERE JOB!='SALESMAN'
GROUP BY JOB
HAVING SUM(SAL)>5000
ORDER BY "�޿���" DESC;

-------------------------------------------------------------
--�������̺� ����� ��
--�ϳ� �̻��� ���̺� > ����
--���, �̸�, �μ���ȣ, �μ��� ���

--ANSI ����(������ WHERE�� ��Ȯ�ϴ�)
SELECT EMP.EMPNO, EMP.ENAME, EMP.DEPTNO, DEPT.DNAME 
FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--����Ŭ ����(�̰� ���� ���� ����, ������ WHERE�� ��Ȯ���� �ʴ�)
SELECT EMP.EMPNO, EMP.ENAME, EMP.DEPTNO, DEPT.DNAME
FROM EMP, DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO

--JOIN�� ���� ���̺��� �����͸� �˻��ϴ� ���
--����

--1.�����(EQUI JOIN)
--���� ���̺�� ��� ���̺� �÷��� �����͸� 1:1 ����
--(INNER) JOIN ON ������
--ANSI ����(SQL ǥ�ع���)�� ���

--2.������(NON-EQUI JOIN) > �ǹ̸� ����, ���� ������ ����ΰ� ����
--�����̺�� �����Ǵ� ���̺� �ִ� �÷��� �����Ͱ� 1:1 ���ε��� �ʴ� ���
--EX) SAL�� SALGRADE�� ã�� ��

--3.OUTER JOIN(�����+NULL) > ������� NULL�� �ؼ����� ���ؼ� �������
--�� ���� ���̺��� �������踦 �ľ��ϴ� ���� �߿�
--LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN

--4.SELF JOIN(�ڱ�����) > �ǹ̸� ����, ���� ������ ����ΰ� ����
--EX) EMP ���̺��� ������ �̸� ã��
--�ϳ��� ���̺� �ȿ��� �÷��� �ٸ� �÷��� �����ϴ� ���

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
--����Ŭ ����(NOT GOOD)
SELECT M.M1, M.M2, S.S2
FROM M, S
WHERE M.M1=S.S1;

--ANSI ����(GOOD!)
SELECT M.M1, M.M2, S.S2
FROM M INNER JOIN S
ON M.M1=S.S1; --JOIN�� ������

SELECT S.S1, S.S2, X.X2
FROM S INNER JOIN X
ON S.S1=X.X1;

--���� ���� ���̺� ����
SELECT *
FROM M JOIN S
ON M.M1=S.S1
JOIN X
ON S.S1=X.X1;

--���, �̸�, �μ���ȣ, �μ��� ����ϱ�
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;
--���̺� ����Ī�� �� �� �ִ�
----------------------------------------------
/*���͵� ���� 2016. 8. 17
--����: ������ ���� �ʴ� ������� �޿� ���� 3000�̻��� �μ�
--�μ���ȣ, �μ��� �޿��� ��, �μ��� �ο� �� ���
--�޿��� ���� "�ѱ޿�"��, �ο� ���� "�ο���"�� ǥ��
--�޿��� ���� �������� ����
SELECT DEPTNO, SUM(SAL) AS "�ѱ޿�", COUNT(*) AS "�ο���"
FROM EMP
WHERE COMM IS NULL
GROUP BY DEPTNO
HAVING SUM(SAL)>=3000
ORDER BY "�ѱ޿�" DESC;

SELECT * FROM EMP;
*/
/*
--[���������] FROM ����
-- ������̺��� �Ի���� 4,5,6,7,11,12���� �����͸�
--�������� ������� ����ϼ���.
--��, ������� 5���̶��, 5��^0^�� ������� �������ּ���.
--����, ���� ���ĺ� ������ �����ϼ���.
SELECT JOB, COUNT(*)||'��^0^��' AS "�ο���"
FROM EMP
WHERE (TO_CHAR(HIREDATE, 'MM') BETWEEN '04' AND '07')
      OR
      (TO_CHAR(HIREDATE, 'MM') BETWEEN '11' AND '12')
GROUP BY JOB
ORDER BY JOB;

--FROM ����
--  ��� ���̺��� ���� �μ��� ���� ���� �Ի��� ����� �Ի� ��¥�� YY/MM/DD ���·� ����� ��� ������ �ݿø��ؼ� ���Ͻÿ�
--  DEPTNO�� 10�� ������ 20�� �����  30 �λ�� ��Ÿ�� ��Ÿ �� ��Ÿ���ÿ�
--  �� King�� �����ϰ� ���Ͻÿ� 
SELECT DECODE(DEPTNO, 10, '������', 20, '�����', 30, '�λ��', '��Ÿ') AS "�μ�", ROUND(AVG(SAL), 0) AS "��� ����", TO_CHAR(MIN(HIREDATE), 'YY/MM/DD') AS "�Ի� ��¥"
FROM EMP
WHERE ENAME!='KING'
GROUP BY DEPTNO;

--FROM ����
-- ������ �޿��� ���� ���� ����� ������ �޿��� ���ϼ���.
-- ��, ���� ���� �޿��� ������������ ���� �ϼ���.
SELECT JOB AS "����", MAX(SAL) AS "�޿�"
FROM EMP
GROUP BY JOB
ORDER BY MAX(SAL) DESC;

--FROM �Ѽ�
--������̺��� �μ��� �޿��� ���� 2800�̻��� ����� �̸���, �޿�, �޿����հ� ����� ����ϰ�
--(����� �ݿø��Լ� ����Ͽ������������� ��Ÿ������ ���)
--(�̸��� O�� �� ����� ����ϵ��� �Ѵ�)
--�޿��� ����� ���������� ����
SELECT ENAME, SAL, SUM(SAL), ROUND(AVG(SAL), 0)
FROM EMP
WHERE ENAME LIKE '%O%'
GROUP BY DEPTNO, ENAME, SAL
HAVING SUM(SAL)>=2800
ORDER BY AVG(SAL) DESC;

--FROM ����
--��� �� ������ salesman�� ����� ���,����� , �ټӳ�� ,������� ������ ���Ͻÿ�
--��� �� �Ի� ���� 35���� ����� ������ 20% �λ��ϰ� '����ϼ̽��ϴ�' ���
--35���� �ƴ� ������� '�� ����ϼ���' ���  
SELECT EMPNO, ENAME, TRUNC((SYSDATE-HIREDATE)/365) AS "�ټӳ��", SAL, DECODE(TRUNC((SYSDATE-HIREDATE)/365), 35, (SAL*1.2|| '�� �����λ� ����ϼ̽��ϴ�'), '�� ����ϼ���')
FROM EMP
WHERE JOB='SALESMAN';
*/
----------------------------------------------
--HR����
select * from employees;
select * from DEPARTMENTS;
SELECT * FROM LOCATIONS;

--���, �̸�, �μ���ȣ, �μ��̸�
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
ORDER BY E.DEPARTMENT_ID;

--���, �̸�, �μ���ȣ, �μ���, �����ڵ�, ���ø�
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.LOCATION_ID, L.CITY
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
INNER JOIN LOCATIONS L ON D.LOCATION_ID=L.LOCATION_ID
ORDER BY E.DEPARTMENT_ID;

----------------------------------------------
--������ ����
--������
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

--���, �̸�, �޿�, �޿���� ���
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL; --��
----------------------------------------------
--OUTER JOIN
--�־���? NULL�� INNER JOIN�� ����� �ƴϱ� ������
--LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN
--����, �������� Ʃ�׿��� �ӵ����� ������ �ǹ����� ��
--���������δ� ������� ���� �����ϰ� �������踦 �ľ��ؼ�
--"�ְ� �Ǵ� ���̺� �����ִ� ������(NULL���� ������)"�� ������ �´�

SELECT *
FROM M JOIN S
ON M.M1=S.S1;

SELECT *
FROM M LEFT OUTER JOIN S
ON M.M1=S.S1; --M�� �����´�

SELECT *
FROM M RIGHT OUTER JOIN S
ON M.M1=S.S1; --S�� �����´�

SELECT *
FROM M FULL OUTER JOIN S
ON M.M1=S.S1; --LEFT/RIGHT OUTER JOIN�� UNION
----------------------------------------------
--HR����
SELECT COUNT(*) FROM EMPLOYEES; --107��

SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
ORDER BY E.DEPARTMENT_ID; --106�� ��� �ΰ�

SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IS NULL
ORDER BY E.DEPARTMENT_ID;
----------------------------------------------
--SELF JOIN
--������̺��� ���, �̸�, �����ڻ��, ������ �̸� ���
--������
SELECT E.EMPNO, E.ENAME, F.EMPNO, F.ENAME
FROM EMP E LEFT OUTER JOIN EMP F --KING ������
ON E.MGR=F.EMPNO
ORDER BY E.EMPNO;
----------------------------------------------
--ī�� �ǽ�����
-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
SELECT E.ENAME, E.EMPNO, D.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;
 
-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.
SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='DALLAS';
 
-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.
SELECT E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.ENAME LIKE '%A%';

-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������
--����ϴµ� ������ 3000�̻��� ����� ����϶�.
SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL>=3000;

-- 5. ����(����)�� 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
SELECT E.JOB, E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.JOB='SALESMAN';

-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
--(�� ) 1 : 1 ���� ��� �÷��� ����
SELECT E.EMPNO AS "�����ȣ", E.ENAME AS "����̸�", E.SAL*12 AS "����", E.SAL*12+COMM AS "�Ǳ޿�", S.GRADE AS "�޿����"
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.COMM IS NOT NULL;

-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO=10;
 
-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�,
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ�
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������
-- �����϶�.
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
--WHERE E.DEPTNO=10 OR E.DEPTNO=20 --IN�����ڸ� ���
WHERE E.DEPTNO IN(10, 20)
ORDER BY D.DEPTNO, E.SAL DESC;
 
-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� ��������
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
--SELF JOIN (�ڱ� �ڽ����̺��� �÷��� ���� �ϴ� ���)
SELECT E.EMPNO AS "�����ȣ", E.ENAME AS "����̸�", F.EMPNO AS "�����ڹ�ȣ", F.ENAME AS "�������̸�"
FROM EMP E LEFT OUTER JOIN EMP F
ON E.MGR=F.EMPNO;
----------------------------------------------
--SQL�� �� SUBQUERY!!
--������̺��� ��տ��޺��� �� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ���
--��������
SELECT AVG(SAL) FROM EMP;
SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL>2073;

--SUBQUERY ���� ���� ����, ()�ȿ�
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

--���������� ����(�÷��� ������ 1��)
--SINGLEROW SUBQUERY: ���������� ����� ���ϰ�(1���� ROW, ���� �÷�)�� ���� ���
--MULTIROW SUBQUERY: ���������� ����� ���� ��(1�� �̻��� ROW, ���� �÷�)�� ���� ���
  --�̱۰� �����ڰ� �޶���(IN, NOT IN, ALL, ANY ��)
  --ALL: SAL>1000 AND COMM >2000
  --ANY: SAL>1000 OR COMM >2000
  --WHERE SAL> ALL(SELECT SAL FROM ...) > �ᱹ ���� �������� ���´�
  --WHERE SAL> ANY(SELECT SAL FROM ...) > �ᱹ ���� ũ������ ���´�

--�������� ����
  --������ ��ȣ �ȿ�
  --�����÷����� ����
  
--�������
  --�������� > ��������
  --���������� ����� ������ ���������� ���ư��� > ���������� �ܵ����� ���డ�� �ؾ� �Ѵ�
  
--������̺��� JONES���� ���� �޿��� �޴� ����� ���, �̸�, �޿� ����ϱ�
--���Ǵ� �����ڴ� ���ϰ� ���ϴ� = < > ���� ��
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL >
(SELECT SAL
FROM EMP
WHERE ENAME='JONES');

SELECT EMPNO, ENAME, SAL
FROM EMP
--WHERE SAL > (SELECT SAL FROM EMP WHERE SAL > 2000); --�ȵ�, �̷��� IN ������ ����
WHERE SAL IN (SELECT SAL FROM EMP WHERE SAL > 2000);
--Ǯ��� SAL=2975 OR SAL=2850 OR ....
--WHERE SAL NOT IN (SELECT SAL FROM EMP WHERE SAL > 2000);
--Ǯ��� SAL!=2975 AND SAL!=2850 AND ... > ����!!! IN�� NOT IN

--���������� �ִ� ����� ����� �̸��� ���
SELECT EMPNO, ENAME
FROM EMP
WHERE EMPNO IN (SELECT MGR FROM EMP);

--���������� ���� ����� ����� �̸� ���
--NULL, AND > NULL > NVL�� �ذ�
SELECT EMPNO, ENAME
FROM EMP
WHERE EMPNO NOT IN (SELECT NVL(MGR,0) FROM EMP);

--���ӻ���� KING�� ����� ���, �̸�, ����, �����ڻ�� ���
SELECT EMPNO, ENAME, JOB, MGR
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');

--20�� �μ��� ��� �߿��� ���� ���� ������ �޴� �������
--�� ���� �޿��� �޴� ����� ���, �̸�, �޿�, �μ���ȣ ���
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--������ SALESMAN�� ����� ���� �μ����� �ٹ��ϰ�, ���� ������ �޴� �����
--���, �̸�, ����, �޿� ���
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE JOB='SALESMAN')
     AND SAL IN (SELECT SAL FROM EMP WHERE JOB='SALESMAN');
     
--�ڱ�μ��� ��� ���޺��� �� ���� ������ �޴� ����� ���, �̸�, �μ���ȣ
--�μ��� ��ձ޿� ���
--���������� �������̺� �ֱ� (in line view), FROM���� ���� �ֱ�
--������ ���
SELECT E.EMPNO, E.ENAME, E.DEPTNO, E.SAL, S.AVGSAL
FROM EMP E JOIN (SELECT DEPTNO, AVG(SAL) AS AVGSAL FROM EMP GROUP BY DEPTNO) S
ON E.DEPTNO=S.DEPTNO
WHERE E.SAL > S.AVGSAL;
----------------------------------------------
--�� ��������
--1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME='SMITH');
 
--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����,
-- �μ���ȣ�� ����϶�.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (SELECT SAL FROM EMP WHERE DEPTNO=10);
 
--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ�
-- 'BLAKE'�� ���� ����϶�.
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME='BLAKE')
      AND ENAME!='BLAKE';

--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������
-- ����ϵ�, ������ ���� ��� ������ ����϶�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY SAL DESC;
 
--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ�
-- �ִ� ����� �����ȣ�� �̸��� ����϶�.
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%');

--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� �������
-- ���� ������ �޴� ������� �̸�, �μ���ȣ, ������ ����϶�.
--(��, ALL(and) �Ǵ� ANY(or) �����ڸ� ����� ��)
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL > ALL (SELECT SAL FROM EMP WHERE DEPTNO=30);
  
--7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� �����
-- �̸�, �μ���ȣ, ������ ����϶�.
SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS');

--8. SALES �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ����϶�.
SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
 
--9. 'KING'���� �����ϴ� ��� ����� �̸��� �޿��� ����϶�
--king �� ����� ��� (mgr �����Ͱ� king ���)
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');
 
--10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ����
-- ����� ������ �μ����� �ٹ��ϴ� ��� ����� �����ȣ, �̸�,
-- �޿��� ����϶�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%S%')
      AND SAL > (SELECT AVG(SAL) FROM EMP);

--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� �����
-- �̸�, ����, �μ���ȣ�� ����϶�.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO
FROM EMP
WHERE COMM IS NOT NULL)
AND SAL IN
(SELECT SAL
FROM EMP 
WHERE COMM IS NOT NULL);

--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ����
-- ������� �̸�, ����, Ŀ�̼��� ����϶�.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE SAL NOT IN (SELECT SAL FROM EMP WHERE DEPTNO=30)
AND COMM NOT IN (SELECT NVL(COMM,0) FROM EMP WHERE DEPTNO=30);
----------------------------------------------
--DDL: CREATE, ALTER, DROP, TRUNCATE
--DML: INSERT, UPDATE, DELETE
--DCL: GRANT(����), REVOKE
--DQL(����Ŭ�� ���� ������): SELECT
--TCL: (Ʈ�����) COMMIT, ROLLBACK, SAVEPOINT

--DML�۾�
--TCP: ����Ŭ�� �����ϴ� SYSTEM ���̺�
DESC EMP; --�÷���, Ÿ��, NULL���� Ȯ��
SELECT * FROM TAB; --�������Ӱ���(����)�� �ٷ� �� �ִ� ���̺� ���
--MSSQL�� �����ͺ��̽����� ����ڸ� ����
--����Ŭ�� ����ں��� �����ͺ��̽� ����
SELECT * FROM TAB WHERE TNAME='M'; --�빮�ڷ� ����
SELECT * FROM COL; --���̺��� ������ ��� �÷� ���
SELECT * FROM COL WHERE TNAME='EMP';

SELECT * FROM USER_TABLES; --���̺� ���� �� ����
SELECT * FROM USER_TABLES WHERE TABLE_NAME='EMP';
----------------------------------------------
--DML ��������: TCL
--����: �ϳ��� ���� �۾� ����
--EX)������ ��� �������� ��� �ϳ��� �����ϸ� ó�� ���·� ���ư��� �Ѵ�
--EX)A���¿��� B���·� ��ü�� ������ COMMIT OR ROLLBACK
--���ҵ�����: �޸𸮸� �����ϰ� COMMIT�� ������ �� ���̴� �޸𸮰�
--Ʈ������� �߿��ϴ�
----------------------------------------------

--INSERT INTO ���̺��(�÷�1, �÷�2, ...) VALUSES(��1, ��2, ...);
CREATE TABLE TRANS(USERID NUMBER);
CREATE TABLE TEMP(
  ID NUMBER PRIMARY KEY, --�ߺ��Ұ�, �κҰ�
  NAME VARCHAR2(20)
);
SELECT * FROM TEMP;
INSERT INTO TEMP(ID, NAME) VALUES(100, 'ȫ�浿');
COMMIT;

--�÷�����Ʈ ���� ���� > �׷��� ��� ���� �� �־�� �ȴ�
INSERT INTO TEMP VALUES(200, '������');
--Ư���÷����� ������ �����ϱ�
INSERT INTO TEMP(ID) VALUES(300);

--PK ���� ������ ����
--INSERT INTO TEMP(NAME) VALUES('�ٺ�');
--INSERT INTO TEMP(ID, NAME) VALUES(100, '�ٺ�');

--PL-SQL: ���α׷����� ������ ��� SQL
--�׽�Ʈ�� ������ ������ �� �����ϴ�
--��� ��� ����, ;����
--������ ���������, ���� �ȵ�
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
  REGDATE DATE DEFAULT SYSDATE --�⺻�� ����
                               --INSERT ��������� ���� ������ SYSDATE
);
--�Է°� ����
INSERT INTO TEMP3(MEMBERID, NAME, REGDATE) VALUES(100, 'ȫ�浿', '2016-08-18');
--�⺻�� ����
INSERT INTO TEMP3(MEMBERID, NAME) VALUES(200, '������');
INSERT INTO TEMP3(NAME, REGDATE) VALUES('�볪��', '2016-08-18');
INSERT INTO TEMP3(MEMBERID) VALUES(300);
COMMIT;
SELECT * FROM TEMP3;
----------------------------------------------
--�ɼ�
--�뷮 INSERT �۾��ϱ�
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

--TEM4�� ��� �����͸� TEMP5�� �ֱ�
--INSERT INTO ���̺��(�÷�����Ʈ) SELECT ����
INSERT INTO TEMP5(NUM) SELECT ID FROM TEMP4;
COMMIT;

--���̺��� ���� ��� ���̺� ���� �� ������ ���Ա��� ����
--��, ���������� ������� ����
--���: ���̺� ����(���̺��� ���� ����)
CREATE TABLE COPYEMP
AS SELECT * FROM EMP;
SELECT * FROM COPYEMP;

CREATE TABLE COPYEMP2
AS SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO=20;
SELECT * FROM COPYEMP2;

--���̺��� �������� Ȯ��
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='COPYEMP';

--����
--EMP ���̺�� ���� ������ EMP2 ���̺� �����ϱ�
--������ ����, �����ʹ� ���� ����
CREATE TABLE EMP2
AS SELECT * FROM EMP WHERE 1=2; --��� ������ FALSE�� ����� ���
SELECT * FROM EMP2;
--EMP2�� �޿��� 3000 �̻��� ��� ��� INSERT
INSERT INTO EMP2 SELECT * FROM EMP WHERE SAL>=3000;
COMMIT;
----------------------------------------------
/*���� ����
--EMP ���̺��� �ֻ��� ����ڱ��� ǥ���ϱ�
--EX)ADAMS�� ����ڴ� SCOTT, SCOTT�� ����ڴ� JONES, JONES�� ����ڴ� KING
--����, �̸�, �����1, �����2, �����3�� ǥ��
SELECT E.JOB, E.ENAME, F.ENAME AS "�����1", G.ENAME AS "�����2", H.ENAME AS "�����3"
FROM EMP E LEFT OUTER JOIN EMP F
ON E.MGR=F.EMPNO LEFT OUTER JOIN EMP G
ON F.MGR=G.EMPNO LEFT OUTER JOIN EMP H
ON G.MGR=H.EMPNO;
*/
--���� 

--FROM ����
--ȸ�� ���̺�� �Խ������̺��� ������ �ؾ� �Ѵ�.
--ȸ��(member_test)���̺��� ������(5) key , ���ڿ�(20) id , ���ڿ�(20) pass , ������(11) phone ,��¥�� birthday �� �ִ�.
--�Խ���(board_test) ���̺��� ������(5) key, ���ڿ�(20) title(����) ,  ���ڿ�(50) wording (�Խñ�) �� �ִ�. 
--ȸ�����̺��� �츮�������� ��� �ִ�. ������ ����Ʈ�� ���� �ð��̰� , id �� �̸����� ���� �Ѵ�. ��й�ȣ�� 1234 �� ���� �Ѵ�. key��  Primary Key�̰� �Խ��ǰ��� 1:M �����̴� 
--�Խ������̺��� �����ִµ� ������ �츮�� �Խñۿ��� ������ ��� ���� �ִ�. (Ű���� �̼����� Ű������ �����Ѵ�.)
--��� select ���� �̼��� ȸ���� ���̵�� �ڵ�����ȣ,���� �׸��� �Խ������� , �Խñ��� ���;� �Ѵ�.
CREATE TABLE MEMBER_TEST(
  KEY NUMBER(5) PRIMARY KEY, ID VARCHAR2(20), PASS VARCHAR2(20), PHONE NUMBER(11), BIRTHDAY DATE DEFAULT SYSDATE
);
INSERT INTO MEMBER_TEST VALUES (1, '�̼���', '1234', 01026739821, '1992-09-21');
INSERT INTO MEMBER_TEST VALUES (2, '���Ѽ�', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (3, '�����', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (4, '�ڹ���', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (5, '������', '1234', 01055556666, SYSDATE);
INSERT INTO MEMBER_TEST VALUES (6, '������', '1234', 01055556666, SYSDATE);

CREATE TABLE BOARD_TEST(
  KEY NUMBER(5) PRIMARY KEY, TITLE VARCHAR2(20), WORDING VARCHAR2(50)
);
INSERT INTO BOARD_TEST VALUES (1, '�츮��','������');

SELECT M.ID, M.PHONE, M.BIRTHDAY, B.TITLE, B.WORDING
FROM MEMBER_TEST M JOIN BOARD_TEST B
ON M.KEY=B.KEY;

--FROM �Ѽ�
--'CHICAGO'���� �ٹ��ϰ� �����鼭 ������ ���� ����� ���� �μ����� ���ϴ� 
--������� �����ȣ, �̸�, �μ���ȣ, ������ ���
--(��, ������ 0�λ���� �����ϰ����)
SELECT E.EMPNO, E.ENAME, E.DEPTNO, E.COMM
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DEPTNO=(SELECT DEPTNO FROM DEPT WHERE LOC='CHICAGO')
AND COMM IS NOT NULL
AND COMM != 0;

--FROM ����???
--������̺� �����Ͽ� EMP_STUDY ���̺�� ����
--�μ��� ��տ��޺��� ������ ������ �޴�
--����� ���,�̸� ,�������̸�,�������(��, ������ �޴� ����̶�� ����+�������� 
--��� , �����ڰ� ���� ����� ���)
CREATE TABLE EMP_STUDY
AS SELECT * FROM EMP;

SELECT E.EMPNO, E.ENAME, F.ENAME, E.SAL+NVL(E.COMM, 0)
FROM EMP_STUDY E 
JOIN EMP_STUDY F ON E.MGR=F.EMPNO
JOIN (SELECT DEPTNO, AVG(SAL) AS AVGSAL FROM EMP_STUDY GROUP BY DEPTNO) G ON E.DEPTNO=G.DEPTNO
WHERE E.SAL > G.AVGSAL;
--------------------------------------------------------------------------------
--UPDATE
--update ���̺� set �÷���1=��1, �÷���2=��2, ...
--where ������
--UPDATE EMP SET SAL=(SELECT MAX(SAL) FROM EMP)

Update COPYEMP
set Job='NOT'
WHERE DEPTNO=20;

UPDATE COPYEMP
SET SAL=(SELECT SUM(SAL) FROM COPYEMP);
ROLLBACK;

UPDATE COPYEMP
SET ENAME='�ƹ���', JOB='IT', HIREDATE=SYSDATE
WHERE DEPTNO=10;
SELECT * FROM COPYEMP WHERE DEPTNO=10;
COMMIT;
--------------------------------------------------------------------------------
--DELETE
--DELETE * FROM COPYEMP; --�̰� MS ACCESS ����
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
DESC BOARD; --������ ���̺� ���� ����
SELECT * FROM USER_TABLES WHERE LOWER(TABLE_NAME)='BOARD'; --������ ���̺� ���� ����
SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)='BOARD'; --�������� ����

--����Ŭ11G���� �����Ǵ� ���: �����÷�(����)
CREATE TABLE VTABLE(
  NO1 NUMBER,
  NO2 NUMBER,
  NO3 NUMBER GENERATED ALWAYS AS (NO1+NO2) VIRTUAL --�˾Ƽ� ���Ǵ� ����/����/��� �÷�
);
--NO1, NO2 �÷����� INSERT�ϸ� �ڵ����� NO3 �÷��� INSERT

INSERT INTO VTABLE(NO1, NO2) VALUES(100, 200);
SELECT * FROM VTABLE;
COMMIT;
--�����÷��� �����Է��� �ȵȴ�
INSERT INTO VTABLE(NO1, NO2, NO3) VALUES(200, 200, 400);
--�������̺� ��������
SELECT COLUMN_NAME, DATA_TYPE, DATA_DEFAULT
FROM USER_TAB_COLUMNS WHERE TABLE_NAME='VTABLE';

--�������� ���Ǵ� �����÷�
CREATE TABLE VTABLE2(
  NO NUMBER,
  P_CODE CHAR(4),
  P_DATE CHAR(8), --20160819
  P_QTY NUMBER,
  P_BUNGI NUMBER(1) --4�б�, �̰� �����÷����� �ϰ�ʹ�
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

--���̺� ����� ���� �÷��� �ϳ� ���Ծ���...
--���� ���̺� �÷� �߰��ϱ�
ALTER TABLE TEMP6
ADD ENAME VARCHAR2(20);
DESC TEMP6;

--���� �÷��� �̸��� �߸� ���...
ALTER TABLE TEMP6
RENAME COLUMN ENAME TO USERNAME;
DESC TEMP6;

--���� �÷��� Ÿ�� �����ϱ� > MODIFY Ű����
ALTER TABLE TEMP6
MODIFY(USERNAME VARCHAR2(100));
DESC TEMP6;

--���� ���̺��� �÷� ����
ALTER TABLE TEMP6
DROP COLUMN USERNAME;

--�����ͻ���
DELETE FROM TEMP6;
--�ʱ� ���̺� ũ�Ⱑ 3M > �������߰��� �뷮 ���� (100M) > ������ ���� > �뷮�� ������
--�̷� �� �����͸� �����ϰ� �ʱ��� ���̺� ũ��� ���̴� ���� TRUNCATE

--���̺� ����
DROP TABLE TEMP6;
--------------------------------------------------------------------------------
--Ʈ������� ����Ű�� �۾� INSERT, UPDATE, DELETE ���� LOG�� ����Ѵ�
--LOG FULL�̸� �۾��� �ȵ�

--��������(CONSTRAINT) > ���Ἲ ����
--�����ͺ��̽����� ���� �߿��� ��: ���Ἲ
--Ȯ������: INSERT, UPDATE

--����Ŭ ��������
--NOT NULL: ����Ŭ������ �������� MS������ �ɼ�
--UNIQUE: ���ϰ� ����, �ߺ�X
--PRIMARY KEY: UNIQUE + NOT NULL > �ֹι�ȣ
--             ���̺� �� �÷��� ��� 1���� ����
--FOREIGN KEY: ���̺� ���� ���� ����
--CHECK: ������ ���� �Է� ���� �� ����

--�������� ��������
--���̺� ������
--���̺� ����� �߰�
--�ʿ���� ���� ���� ����
--ALTER TABLE ���̺�� DROP CONSTRAINT �����̸�
--����Ŭ���� CONSTRAINT_NAME�� �ڵ����� ���� �̸��� ���Ƿ� ����µ�, �������� �̸��� �����ϴ� ���� ����

--�������� Ȯ���ϱ�
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';

--���� �����ϱ�(Ǯ���� ǥ��)
CREATE TABLE TEMP7(
  ID NUMBER CONSTRAINT PK_TEMP7_ID PRIMARY KEY, --������ �������� �̸�
  NAME VARCHAR2(20) NOT NULL,
  ADDR VARCHAR2(40)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP7';

INSERT INTO TEMP7 VALUES(100, 'HONGGILDONG', 'SEOUL GANGNAM');
--INSERT INTO TEMP7 VALUES(100, 'GIMYUSHIN', 'SEOUL GANGNAM'); ID �ߺ�
--INSERT INTO TEMP7(ID, ADDR) VALUES(200, 'SEOUL GANGNAM'); �̸� NOT NULL
--INSERT INTO TEMP7(NAME, ADDR) VALUES('�ƹ���', 'SEOUL GANGNAM'); ID NOT NULL
INSERT INTO TEMP7(ID, NAME) VALUES(300, '������');
SELECT * FROM TEMP7;
COMMIT;

CREATE TABLE TEMP8(
  ID NUMBER CONSTRAINT PK_TEMP8_ID PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  JUMIN CHAR(6) NOT NULL CONSTRAINT UK_TEMP8_JUMIN UNIQUE, --����ũ�� �� ������ ����� �غ��� �Ѵ�
  ADDR VARCHAR2(20)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP8';

INSERT INTO TEMP8 VALUES(100,'ȫ�浿', '123456', '����� ������');
SELECT * FROM TEMP8;
--JUMIN: UNIQUE�� ����
INSERT INTO TEMP8(ID, NAME, ADDR) VALUES(200,'������', '����� ������'); --����ũ�� �� üũ ����
INSERT INTO TEMP8(ID, NAME, ADDR) VALUES(300,'�达', '����� ������'); --�׷��� �ظ��ϸ� NOT NULL�� �Բ� ����Ѵ�

--���̺� ���� �� ���� �ɱ�
CREATE TABLE TEMP9(ID NUMBER);
ALTER TABLE TEMP9
ADD CONSTRAINT PK_TEMP9_ID PRIMARY KEY(ID);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP9';

--����
--TEMP9�� ENAME VARCHAR2(20) �߰��ϱ�
ALTER TABLE TEMP9
ADD ENAME VARCHAR2(20);
--ENAME �÷��� NOT NULL �߰�
--NULL�� �̷� ���� �ȵ�...
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
INSERT INTO TEMP10 VALUES(100, '��浿', '123456', '�����', 20);
INSERT INTO TEMP10 VALUES(200, '�����', '223456', '�����', NULL); --CHECK�� NULL�� ������
COMMIT;
--------------------------------------------------------------------------------

--FOREIGN KEY(���̺� ���� ����)
CREATE TABLE C_EMP
AS SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE 1=2;
CREATE TABLE C_DEPT
AS SELECT DEPTNO, DNAME FROM DEPT WHERE 1=2;

SELECT * FROM C_EMP;
SELECT * FROM C_DEPT;
--����
--C_EMP ���̺��� DEPTNO �÷��� C_DEPT ���̺��� DEPTNO�÷��� ����
--�����ϴ� �ʿ� �Ŵ� ������ �ܷ�Ű

ALTER TABLE C_DEPT
ADD CONSTRAINT PK_C_DEPT_DEPTNO PRIMARY KEY(DEPTNO); --�̰� ����
ALTER TABLE C_EMP --�������� �ʿ��� �ܷ�Ű ����
ADD CONSTRAINT FK_C_EMP_DEPTNO FOREIGN KEY(DEPTNO) REFERENCES C_DEPT(DEPTNO); --������ �ܷ�Ű ���� ����

INSERT INTO C_DEPT VALUES(100, '�λ��');
INSERT INTO C_DEPT VALUES(200, '������');
INSERT INTO C_DEPT VALUES(300, 'ȸ���');
COMMIT;

INSERT INTO C_EMP VALUES(1001, 'ȫ�浿', 300);
INSERT INTO C_EMP VALUES(1002, '������', 300);
INSERT INTO C_EMP VALUES(1003, '������', 100);
COMMIT;

INSERT INTO C_EMP VALUES(1004, '������', NULL); --���Ի���� ��� �μ��� ���� �� �ִ�
--�ݵ�� �μ������̿��� �Ѵٸ� ���̺� ����� DEPNO�� NOT NULL�� �ɾ�� �Ѵ�

--��������� ��ġ MASTER-DETAIL�� ����
--C_EMP�� C_DEPT�� DEPTNO �÷��� �������� C_DEPT (PK�� ���� ���� ������, �θ�)
--------------------------------------------------------------------------------

--�������࿡�� �����Ͱ� �����ǰ� ������ ������ �Ұ���
DELETE FROM C_DEPT WHERE DEPTNO=100;
UPDATE C_DEPT SET DEPTNO=101 WHERE DEPTNO=100;

--���� ����(ON DELETE CASECADE)
--����Ŭ�� DELETE CASECADE�ۿ� ����, MS�� �Ѵ� ����
CREATE TABLE T1(
  COL1 NUMBER,
  CONSTRAINT PK_T1_COL1 PRIMARY KEY(COL1) --�̷��� ���������� ���߿� ���� �͵� ����
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

--CASCADE Ȯ��
DELETE FROM T1 WHERE COL1=1;
SELECT * FROM T2;
COMMIT;


--��������

--�а� ���̺�
CREATE TABLE DEPARTMENT(
  DNUM NUMBER CONSTRAINT PK_DEPARTMENT_DNUM PRIMARY KEY,
  DNAME VARCHAR2(20) NOT NULL
);

--�а� ������ �Է�
INSERT INTO DEPARTMENT VALUES(100, '�����а�');
INSERT INTO DEPARTMENT VALUES(200, '�����а�');
INSERT INTO DEPARTMENT VALUES(300, '�����а�');

--���� ���̺�
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
  --�ٷ� ������ ����ó��, �ܷ�Ű�� �ظ��ϸ� ���߿� �ϴ� ���� ����
  --DNUM NUMBER NOT NULL CONSTRAINT FK_STUDENT_DNUM REFERENCES DEPARTMENT(DNUM)
);

--���� ������ �Է�
INSERT INTO STUDENT(SNUM, SNAME, KOREAN, ENGLISH, MATH, DNUM) VALUES(10, '�̼���', 50, 80, 70, 200);
INSERT INTO STUDENT(SNUM, SNAME, KOREAN, ENGLISH, MATH, DNUM) VALUES(20, '������', 60, 50, 80, 200);
INSERT INTO STUDENT(SNUM, SNAME, KOREAN, ENGLISH, MATH, DNUM) VALUES(30, '�����', 70, 60, 70, 300);

--��� ���
SELECT S.SNUM, S.SNAME, S.TOTAL, S.AVGTOTAL, S.DNUM, D.DNAME
FROM STUDENT S JOIN DEPARTMENT D
ON S.DNUM=D.DNUM;

--------------------------------------------------------------------------------
--�򰡹���

--1> �μ����̺��� ��� �����͸� ����϶�.
SELECT * FROM EMP; --�ٳ��� DEPT
 
--2> EMP���̺��� �� ����� ����, �����ȣ, �̸�, �Ի����� ����϶�.
//�н�

--3> EMP���̺��� ������ ����ϵ�, �� �׸�(ROW)�� �ߺ����� �ʰ�
-- ����϶�.
SELECT JOB
FROM EMP
UNION
SELECT JOB
FROM EMP;
 
--4> �޿��� 2850 �̻��� ����� �̸� �� �޿��� ����϶�.
//�н�

--5> �����ȣ�� 7566�� ����� �̸� �� �μ���ȣ�� ����϶�.
 SELECT ENAME, DEPTNO
 FROM EMP
 WHERE EMPNO=7566;
 
--6> �޿��� 1500�̻� ~ 2850������ ������ ������ �ʴ� ��� ����� �̸�
-- �� �޿��� ����϶�.
//�н�

--7> 1981�� 2�� 20�� ~ 1981�� 5�� 1�Ͽ� �Ի��� ����� �̸�,���� �� 
--�Ի����� ����϶�. �Ի����� �������� �ؼ� ������������ �����϶�.
SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE BETWEEN '1981-02-20' AND '1981-05-01'
ORDER BY HIREDATE;
 
--8> 10�� �� 30�� �μ��� ���ϴ� ��� ����� �̸��� �μ� ��ȣ��
-- ����ϵ�, �̸��� ���ĺ������� �����Ͽ� ����϶�.
//�н�
 
--9> 10�� �� 30�� �μ��� ���ϴ� ��� ��� �� �޿��� 1500�� �Ѵ�
-- ����� �̸� �� �޿��� ����϶�.
--(�� �÷����� ���� employee �� Monthly Salary�� �����Ͻÿ�)
SELECT ENAME AS "EMPLOYEE", SAL AS "MONTHLY SALARY"
FROM EMP
WHERE DEPTNO IN (10, 30)
AND SAL > 1500;
 
--10> �����ڰ� ���� ��� ����� �̸� �� ������ ����϶�.
//�н�

--11> Ŀ�̼��� �޴� ��� ����� �̸�, �޿� �� Ŀ�̼��� ����ϵ�, 
-- �޿��� �������� ������������ �����Ͽ� ����϶�.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM IS NOT NULL
ORDER BY SAL; --DESC�߰�
 
--12> �̸��� �� ��° ���ڰ� A�� ��� ����� �̸��� ����϶�.
//�н�

--13> �̸��� L�� �� �� ���� �μ� 30�� �����ִ� ����� �̸��� 
--����϶�.
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%L%L%' AND DEPTNO=30;
 
--14> ������ Clerk �Ǵ� Analyst �̸鼭 �޿��� 1000,3000,5000 �� 
-- �ƴ� ��� ����� �̸�, ���� �� �޿��� ����϶�.
//�н�

--15> �����ȣ, �̸�, �޿� �׸��� 15%�λ�� �޿��� ������ ǥ���ϵ� 
--�÷����� New Salary�� �����Ͽ� ����϶�.
SELECT EMPNO, ENAME, SAL, ROUND(SAL*1.15, 0) AS "NEW SALARY" 
FROM EMP;
 
--16> 15�� ������ ������ ����Ÿ���� �޿� �λ��(�� �޿����� ���� 
-- �޿��� �� ��)�� �߰��ؼ� ����϶�.(�÷����� Increase�� �϶�). 
//�н�

--18> ��� ����� �̸�(ù ���ڴ� 
-- �빮�ڷ�, ������ ���ڴ� �ҹ��ڷ� ǥ��) �� �̸� ���̸� ǥ���ϴ�
-- ������ �ۼ��ϰ� �÷� ��Ī�� ������ �־ ����϶�.
//�н�

--19> ����� �̸��� Ŀ�̼��� ����ϵ�, Ŀ�̼��� å������ ���� 
-- ����� Ŀ�̼��� 'no commission'���� ����϶�.
SELECT ENAME, DECODE(COMM, NULL, 'NO COMMISSION', COMM)
FROM EMP;
 
--20> ��� ����� �̸�,�μ���ȣ,�μ��̸��� ǥ���ϴ� ���Ǹ� �ۼ��϶�.
//�н�

--21> 30�� �μ��� ���� ����� �̸��� �μ���ȣ �׸��� �μ��̸��� ����϶�.
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30;
 
--22> 30�� �μ��� ���� ������� ��� ������ �μ���ġ�� ����϶�.
--(��, ���� ����� �ߺ����� �ʰ� �϶�.)
SELECT E.JOB, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30
UNION
SELECT E.JOB, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30;
 
--23> Ŀ�̼��� å���Ǿ� �ִ� ��� ����� �̸�, �μ��̸� �� ��ġ�� ����϶�.
SELECT E.ENAME, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE COMM IS NOT NULL;
 
--24> �̸��� A�� ���� ��� ����� �̸��� �μ� �̸��� ����϶�.
//�н�

--25> Dallas���� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ��̸��� 
-- ����϶�.
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='DALLAS';
 
--26> ����̸� �� �����ȣ, �ش� �������̸� �� ������ ��ȣ�� ����ϵ�,
-- �� �÷����� employee,emp#,manager,mgr#���� ǥ���Ͽ� ����϶�.
//�н�

--27> ��� ����� �̸�,����,�μ��̸�,�޿� �� ����� ����϶�.
SELECT E.ENAME, E.JOB, E.DEPTNO, E.SAL, S.GRADE
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--28> Smith���� �ʰ� �Ի��� ����� �̸� �� �Ի����� ����϶�.
//�н�

--29> �ڽ��� �����ں��� ���� �Ի��� ��� ����� �̸�, �Ի���, 
-- �������� �̸�, �������� �Ի����� ����ϵ� ���� �÷����� 
-- Employee,EmpHiredate, Manager,MgrHiredate�� ǥ���Ͽ� 
-- ����϶�.
SELECT E.ENAME AS "EMPLOYEE", E.HIREDATE AS "EMPHIREDATE", F.ENAME AS "MANAGER", F.HIREDATE AS "MGRHIREDATE"
FROM EMP E JOIN EMP F
ON E.MGR=F.EMPNO
WHERE E.HIREDATE<F.HIREDATE;
 
--30> ��� ����� �޿� �ְ��,������,�Ѿ� �� ��վ��� ����ϵ� 
-- �� �÷����� Maximum,Minimum,Sum,Average�� �����Ͽ� ����϶�.
//�н�

--31> �� �������� �޿� ������.�ְ��,�Ѿ� �� ��վ��� ����϶�.
SELECT JOB, MIN(SAL) AS "�޿� ������", MAX(SAL) AS "�޿� �ְ��", SUM(SAL) AS "�Ѿ�", AVG(SAL) AS "��վ�"
FROM EMP
GROUP BY JOB;

--32> ������ ������ ��� ���� ������ ���� ����϶�.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB;
 
--33> �������� ���� ����ϵ�, ������ ��ȣ�� �ߺ����� �ʰ��϶�.
-- �׸���, �÷����� Number of Manager�� �����Ͽ� ����϶�.
SELECT COUNT(DISTINCT NVL(MGR, 0)) AS "NUMBER OF MANAGER"
FROM EMP; --COUNT(DISTINCT(MGR))

--34> �ְ� �޿��� ���� �޿��� ������ ����϶�.
//�н�

--35> ������ ��ȣ �� �ش� �����ڿ� ���� ������� ���� �޿��� ����϶�.
-- ��, �����ڰ� ���� ��� �� ���� �޿��� 1000 �̸��� �׷��� ���ܽ�Ű�� 
-- �޿��� �������� ��� ����� ������������ �����϶�.
SELECT MGR, MIN(SAL)
FROM EMP
GROUP BY MGR
HAVING MGR IS NOT NULL AND MIN(SAL)>=1000
ORDER BY MIN(SAL) DESC;
 
--36> �μ����� �μ��̸�, �μ���ġ, ��� �� �� ��� �޿��� ����϶�.
-- �׸��� ������ �÷����� �μ���,��ġ,����� ��,��ձ޿��� ǥ���϶�.
//�н�

--37> Smith�� ������ �μ��� ���� ��� ����� �̸� �� �Ի����� ����϶�.
-- ��, Smith�� �����ϰ� ����Ͻÿ�
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='SMITH')
AND ENAME!='SMITH';
 
--38> �ڽ��� �޿��� ��� �޿����� ���� ��� ����� ��� ��ȣ, �̸�, �޿��� 
--    ǥ���ϴ� ���Ǹ� �ۼ��ϰ� �޿��� �������� ����� ������������ �����϶�.
//�н�
 
--39> �̸��� T�� ���� ����� ���� �μ����� �ٹ��ϴ� ��� ����� �����ȣ
-- �� �̸��� ����϶�.
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%' );
 
--40> �μ���ġ�� Dallas�� ��� ����� �̸�,�μ���ȣ �� ������ ����϶�.
//�н� 
 
--41> KING���� �����ϴ� ��� ����� �̸��� �޿��� ����϶�.
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME='KING');
 
--42> Sales �μ��� ��� ����� ���� �μ���ȣ, �̸� �� ������ ����϶�.
//�н�

--43> �ڽ��� �޿��� ��� �޿����� ���� �̸��� T�� ���� ����� ������
-- �μ��� �ٹ��ϴ� ��� ����� ��� ��ȣ, �̸� �� �޿��� ����϶�.
SELECT EMPNO, ENAME, SAL
FROM EMP 
WHERE SAL > (SELECT AVG(SAL) FROM EMP)
AND DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%');

--44> Ŀ�̼��� �޴� ����� �޿��� ��ġ�ϴ� ����� �̸�,�μ���ȣ,�޿��� 
-- ����϶�.
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL IN (SELECT SAL FROM EMP WHERE COMM IS NOT NULL);
 
--45> Dallas���� �ٹ��ϴ� ����� ������ ��ġ�ϴ� ����� �̸�,�μ��̸�,
--     �� �޿��� ����Ͻÿ�
SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE JOB IN (SELECT E.JOB
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='DALLAS');
 
--46> Scott�� ������ �޿� �� Ŀ�̼��� �޴� ��� ����� �̸�, �Ի��� �� 
-- �޿��� ����Ͻÿ�
WHERE ENAME='SCOTT' AND COMM=(SELECT COMM FROM EMP WHERE ENAME='SCOTT')
SELECT * FROM EMP???
 
--47> ������ Clerk �� ����麸�� �� ���� �޿��� �޴� ����� �����ȣ,
-- �̸�, �޿��� ����ϵ�, ����� �޿��� ���� ������ �����϶�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL)
FROM EMP
WHERE JOB='CLERK')
ORDER BY SAL DESC;

--48> �̸��� A�� ���� ����� ���� ������ ���� ����� �̸���
-- ����, �μ���ȣ�� ����϶�.
//�н�

--49> New  York ���� �ٹ��ϴ� ����� �޿� �� Ŀ�̼��� ���� ����� 
-- ����̸��� �μ����� ����϶�.
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


--50> Dallas���� �ٹ��ϴ� ����� ���� �� �����ڰ� ���� ����� �����ȣ,����̸�,
--    ����,����,�μ���,Ŀ�̼��� ����ϵ� Ŀ�̼��� å������ ���� ����� NoCommission
--    ���� ǥ���ϰ�, Ŀ�̼��� �÷����� Comm���� ������ ����Ͻÿ�.
--    ��, �ְ���޺��� ��µǰ� �Ͻÿ�
/////////

-- view �� �������̺��ε�, ��ġ ���̺�ó�� ����� �� �ִ�
-- ��� ����Ŭ���� ��ü (create�� �����ؾ� ��)
-- å ���� ��ȭ���� ���� ������ �վ ���� �� ����
-- CREATE VIEW ���̸� AS SELECT ����
-- ���̺�ó�� ��������, ���� ������ ���̺��� �ƴϴ�
-- �޸� �� ��������� �������̺�
-- Ȥ�ڵ��� �̷��Ե� ǥ��: SQL���� ���
-- IN LINE VIWE�� FROM���� ���������� ���� �͵� ���� Ȱ��

-- �� ������?
-- 1.�������� ���Ǽ�
-- 2.����: VIEW ��ü�� ����ڸ��� ����ó��
-- EX) ���Ի������ �޿�, ȣ�� ���̺��� VIEW�� ����� ����
-- 3.������� ���̺�� ����
-- VIEW�� ���ؼ� SELECT, DML �۾� ����

--�����ڰ��� -> �ý��۱��� -> CREATE VIEW ����
CREATE VIEW V_001
AS SELECT EMPNO, ENAME FROM EMP; -- ������ ������ �̰� �ȴ�
SELECT * FROM V_001;
SELECT * FROM V_001 WHERE EMPNO=7902;
--VIEW�� �� �� �ִ� ������ ���ؼ��� �����ϴ�

-- ���� ������ �ϴ� ���̺� > ��� �����
CREATE VIEW V_002
AS SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;
SELECT * FROM V_002;

CREATE VIEW V_003
AS SELECT DEPTNO, AVG(SAL) AS "AVGSAL"
FROM EMP
GROUP BY DEPTNO; --������ ������ �ʴ� ���� �����͵� ���´� > VIEW�� ���� �����ϸ� ����
SELECT *
FROM V_003 V JOIN EMP E
ON V.DEPTNO=E.DEPTNO;

--VIEW�� ������ ����Ⱑ ����ȴ�
--MS�� ALTER, ����Ŭ�� �����(REPLACE)

-- VIEW�� ���� DML�� �����ϴ� > �信 ���ǵǾ� ������ �������̺��� �����Ͱ� �����ȴ�
SELECT * FROM C_EMP;
CREATE VIEW V_EMP
AS SELECT EMPNO, ENAME, DEPTNO
FROM C_EMP;
SELECT * FROM V_EMP;

UPDATE V_EMP
SET ENAME='QTQT';
SELECT *
FROM C_EMP; --V_EMP�� �ٶ󺸴� C_EMP ���̺��� �����Ͱ� ����Ǿ���
ROLLBACK; --��� �����ϸ� SELECT�� �ϰ�, DML�� ���ϴ� ���� ����

--WITH CHECK OPTION
--WITH READ ONLY
--����� �ɼ��� �ִ�

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

--view ��������
--1. 30�� �μ� ������� ����, �̸�, ������ ��� VIEW�� ������.
CREATE OR REPLACE VIEW DEPT30
AS SELECT JOB, ENAME, SAL
FROM EMP
WHERE DEPTNO=30;
 
--2. 30�� �μ� �������  ����, �̸�, ������ ��� VIEW�� ����µ�,
-- ������ �÷����� ����, ����̸�, �������� ALIAS�� �ְ� ������
-- 300���� ���� ����鸸 �����ϵ��� �϶�.
CREATE OR REPLACE VIEW DEPT30("����", "����̸�", "����") --�̷��Ե� ALIAS�� �� �� �ִ�
AS SELECT JOB, ENAME, SAL
FROM EMP
WHERE DEPTNO=30 AND SAL>300;

--3. �μ��� �ִ����, �ּҿ���, ��տ����� ��� VIEW�� ������.
CREATE OR REPLACE VIEW DEPTDEPT
AS SELECT DEPTNO, MAX(SAL) AS "�ִ����", MIN(SAL) AS "�ּҿ���", AVG(SAL) AS "��տ���"
FROM EMP
GROUP BY DEPTNO;
       
--4. �μ��� ��տ����� ��� VIEW�� �����, ��տ����� 2000 �̻���
-- �μ��� ����ϵ��� �϶�.
CREATE OR REPLACE VIEW DEPTDEPT
AS SELECT DEPTNO, AVG(SAL) AS "��տ���"
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>2000;
 
--5. ������ �ѿ����� ��� VIEW�� �����, ������ MANAGER��
-- ������� �����ϰ� �ѿ����� 3000�̻��� ������ ����ϵ��� �϶�.
CREATE OR REPLACE VIEW DEPTDEPT
AS SELECT JOB, SUM(SAL) AS "�ѿ���"
FROM EMP
GROUP BY JOB
HAVING JOB!='MANAGER' AND SUM(SAL)>3000;
--------------------------------------------------------------------------------
--����Ŭ ��ü �� �����ڿ��� �ʿ��� �͵�
--SEQUENCE FROM ����Ŭ ����
--SEQUENCE Ư¡
--1) �ڵ������� ���� ��ȣ�� �����մϴ�.
--2) ���� ������ ��ü(�������� ���̺��� ��� ����)
--3) �ַ� �⺻ Ű ���� �����ϱ� ���� ���˴ϴ�. (PRIMARY KEY �÷��� ������ ����)
--4) ���ø����̼� �ڵ带 ��ü�մϴ�. (JAVA ���� �� ����ϴ� �κ��� ���� �� �� �ִ�)
--5) �޸𸮿� CACHE�Ǹ�(�̸� ������ ������ �ΰ�, �ٷ� ����Ѵ�) SEQUENCE ���� �׼��� �ϴ� ȿ������ ����ŵ�ϴ�.

/*
1.2 Syntax
CREATE SEQUENCE sequence_name
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}];
sequence_name SEQUENCE�� �̸��Դϴ�.
INCREMENT BY n ���� ���� n���� SEQUENCE��ȣ ������ ������ ����.
�� ���� �����Ǹ� SEQUENCE�� 1�� ����.
START WITH n �����ϱ� ���� ù��° SEQUENCE�� ����.
�� ���� �����Ǹ� SEQUENCE�� 1�� ����.
MAXVALUE n SEQUENCE�� ������ �� �ִ� �ִ� ���� ����.
NOMAXVALUE ���������� 10^27 �ִ밪�� ����������-1�� �ּҰ��� ����.
MINVALUE n �ּ� SEQUENCE���� ����.
NOMINVALUE ���������� 1�� ����������-(10^26)�� �ּҰ��� ����.
CYCLE | NOCYCLE �ִ� �Ǵ� �ּҰ��� ������ �Ŀ� ��� ���� ������ ���� ���θ�
����. NOCYCLE�� ����Ʈ.
CACHE | NOCACHE �󸶳� ���� ���� �޸𸮿� ����Ŭ ������ �̸� �Ҵ��ϰ� ����
�ϴ°��� ����. ����Ʈ�� ����Ŭ ������ 20�� CACHE.
*/

--������
--ä��(������ �ݵ���ִ� ��ü)
--CREATE TABLE BOARD(BOARDNUM NUMBER, TITLE VARCHAR2(50));
--BOARDNUM�÷��� 1, 2, 3 �̷������� ������
--INSERT INTO BOARD(BOARDNUM, TITLE) VALUES(1, 'ó����');
CREATE TABLE KBOARD(BOARDNUM NUMBER, TITLE VARCHAR2(50));
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT COUNT(*) FROM KBOARD)+1, '��������');
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT COUNT(*) FROM KBOARD)+1, '��������2222');
COMMIT;

--������
--1���� ����
DELETE FROM KBOARD WHERE BOARDNUM=1;
--���ο�� �߰�
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT COUNT(*) FROM KBOARD)+1, '��������444');
SELECT * FROM KBOARD;

--���ο� ���(�������� ���� ���� ����)
DELETE FROM KBOARD;
COMMIT;
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT NVL(MAX(BOARDNUM), 0) FROM KBOARD)+1, '��������444');
INSERT INTO KBOARD(BOARDNUM, TITLE) VALUES((SELECT NVL(MAX(BOARDNUM), 0) FROM KBOARD)+1, '��������5555');

--[1], [2], [3], [4], [5]
--2���� ���� ��
--[1], [2], [3], [4]
--�̷��� �ٲ�� �ϰ� �ʹ�
--�̷��Ŵ� ���ø����̼ǿ��� ó�� �ض�...

--����Ŭ������ �� ���� �ϵ��� �������� ����� ����
CREATE SEQUENCE BOARD_NUM;
SELECT * FROM USER_SEQUENCES;

/*
1.4.1 NEXTVAL�� CURRVAL �ǻ翭
��) Ư¡
1) NEXTVAL�� ���� ��� ������ SEQUENCE ���� ��ȯ �Ѵ�.
2) SEQUENCE�� ������ �� ����, �ٸ� ����ڿ��� ������ ������ ���� ��ȯ�Ѵ�.
3) CURRVAL�� ���� SEQUENCE���� ��´�.
4) CURRVAL�� �����Ǳ� ���� NEXTVAL�� ���Ǿ�� �Ѵ�.
*/
SELECT BOARD_NUM.NEXTVAL FROM DUAL; --�ѹ���� �ʴ� �ڿ�
SELECT BOARD_NUM.CURRVAL FROM DUAL;

CREATE TABLE TBOARD(
  NUB NUMBER CONSTRAINT PK_TBOARD_NUM PRIMARY KEY,
  TITLE VARCHAR2(20)
);
INSERT INTO TBOARD VALUES(BOARD_NUM.NEXTVAL, '�۳���'); --�ѹ���� ����
COMMIT;

--MS�� 2012�������ʹ� ����Ŭó�� ������ ����
--���� ������ ���̺� ���������� ���
--CREATE TABLE BOARD(BOARDNUM INT IDENTITY(1,1), TITLE);
--INSERT INTO BOARD(TITILE) VALUES('����');

--MYSQL
--CREATE TABLE BOARD(BOARDNUM INT AUTO_INCREMENT, TITLE);

CREATE SEQUENCE SEQ_NUM
START WITH 10
INCREMENT BY 2;

SELECT SEQ_NUM.NEXTVAL FROM DUAL;
SELECT SEQ_NUM.CURRVAL FROM DUAL;
--------------------------------------------------------------------------------
--SEQUENCE�� ������ü
CREATE TABLE MYBOARD(ID NUMBER PRIMARY KEY, TITLE VARCHAR2(20));
CREATE TABLE YOURBOARD(NUM NUMBER PRIMARY KEY, TITLE VARCHAR2(20));
CREATE SEQUENCE COMM_SEQ;
INSERT INTO MYBOARD VALUES(COMM_SEQ.NEXTVAL,'���̺��� ó��');
SELECT * FROM MYBOARD;
INSERT INTO YOURBOARD VALUES(COMM_SEQ.NEXTVAL,'�Ϻ��� ó��');
SELECT * FROM YOURBOARD;
COMMIT;
--------------------------------------------------------------------------------
--�ǻ��÷�(PSUEDO?): ���� ���������� �������� �ʴ� �÷�
--ROWNUM: ���̺� �����ϴ� ���� �ƴ�����, �����ϴ� �� ó�� ����� �� �ִ�
--ROWID: �ּҰ�(���� ������ ����Ǿ� �ִ� ���� ���� �ּҰ�) > �ε���

SELECT * FROM EMP;
SELECT ROWNUM AS "����", EMPNO, ENAME FROM EMP; --����Ʈ ���Ŀ� ������ �������
--�־���?
--TOP-N�� ���� ����(���� �), ������ �
--MS: SELECT TOP 3 ������
--����Ŭ: ROWNUM

-- �޿��� ���� �޴� ���� 5�� ���ϱ� > ������ ���ϱ� > �Խ��� ����¡ ó���� ����
-- ���߿�
SELECT ROWNUM, E.*
FROM (SELECT * FROM EMP ORDER BY SAL DESC) E
WHERE ROWNUM <= 5;

--�޿��� ���� �޴� ���� 10�� ���ϱ�
SELECT ROWNUM, E.*
FROM (SELECT * FROM EMP ORDER BY SAL) E
WHERE ROWNUM <= 10;

--------------------------------------------------------------------------------
--�Խ��� ����¡
--������ ������ ���ϱ�(�� ���������� �� �� �ִ� ������ �Ǽ� ����)
--100�� > pagesize=10, pagecount=10

--HR���� ��ȯ
select * from employees; --107���� �����Ϳ� ���ؼ�
--41~50���� �̱� > ROWNUM�� �ι� �Ἥ 1~50 ã�� ������ 1~40������
--������ ���÷� �Ѵٰ� �մϴ�.
--BETWEEN�� �����ϴ�
SELECT S.NUM, S.EMPLOYEE_ID, S.LAST_NAME
FROM ((SELECT ROWNUM AS NUM, E.*
FROM (SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID) E
WHERE ROWNUM <=50)) S WHERE NUM>=40;

--------------------------------------------------------------------------------
--JDBC �ǽ��� ���̺�
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
 
 App���� Ʈ����� ����
 :jdbc api > dml > autocommit()
 commit, rollback ���� ����
 */
 -------------------------------------------------------------------------------