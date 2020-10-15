-- Этот файл CLP создан при помощи DB2LOOK Версии "11.5" 
-- Отметка времени: Ср 30 сен 2020 17:15:32
-- Имя базы данных: SAMPLE         
-- Версия менеджера баз данных: DB2/LINUXX8664 Version 11.5.4.0
-- Кодовая страница базы данных: 1208
-- Последовательность слияния базы данных -: IDENTITY
-- Альтернативная последовательность слияния (alt_collate): null
-- Совместимость с varchar2 (varchar2_compat): OFF


-- CONNECT TO SAMPLE;

------------------------------------------------
-- Операторы DDL для схем
------------------------------------------------

-- Запуск приведенного ниже DDL явно создаст в
-- новой базе данных схему, которая соответствует неявно созданной схеме
-- в исходной базе данных.

-- CREATE SCHEMA "VKM83249";


---------------------------------
-- Операторы DDL для последовательностей
---------------------------------


CREATE SEQUENCE "VKM83249"."SAMPSEQUENCE" AS BIGINT
	MINVALUE 1 MAXVALUE 9223372036854775807
	START WITH 1 INCREMENT BY 1
	CACHE 20 NO CYCLE NO ORDER;



------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."CL_SCHED"
------------------------------------------------
 

CREATE TABLE "VKM83249"."CL_SCHED"  (
		  "CLASS_CODE" CHAR(7 OCTETS) , 
		  "DAY" SMALLINT , 
		  "STARTING" TIME , 
		  "ENDING" TIME )   
		 		 ORGANIZE BY ROW; 






------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."DEPARTMENT"
------------------------------------------------
 

CREATE TABLE "VKM83249"."DEPARTMENT"  (
		  "DEPTNO" CHAR(3 OCTETS) NOT NULL , 
		  "DEPTNAME" VARCHAR(36 OCTETS) NOT NULL , 
		  "MGRNO" CHAR(6 OCTETS) , 
		  "ADMRDEPT" CHAR(3 OCTETS) NOT NULL , 
		  "LOCATION" CHAR(16 OCTETS) )   
		 		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."DEPARTMENT"

ALTER TABLE "VKM83249"."DEPARTMENT" 
	ADD CONSTRAINT "PK_DEPARTMENT" PRIMARY KEY
		("DEPTNO")
	ENFORCED;



-- Операторы DDL для индексов таблицы "VKM83249"."DEPARTMENT"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."XDEPT2" ON "VKM83249"."DEPARTMENT" 
		("MGRNO" ASC)
		
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

-- Операторы DDL для индексов таблицы "VKM83249"."DEPARTMENT"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."XDEPT3" ON "VKM83249"."DEPARTMENT" 
		("ADMRDEPT" ASC)
		
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;
-- Операторы DDL для алиасов на основе таблицы "VKM83249"."DEPARTMENT"

CREATE ALIAS "VKM83249"."DEPT" FOR TABLE "VKM83249"."DEPARTMENT";


------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."EMPLOYEE"
------------------------------------------------
 

CREATE TABLE "VKM83249"."EMPLOYEE"  (
		  "EMPNO" CHAR(6 OCTETS) NOT NULL , 
		  "FIRSTNME" VARCHAR(12 OCTETS) NOT NULL , 
		  "MIDINIT" CHAR(1 OCTETS) , 
		  "LASTNAME" VARCHAR(15 OCTETS) NOT NULL , 
		  "WORKDEPT" CHAR(3 OCTETS) , 
		  "PHONENO" CHAR(4 OCTETS) , 
		  "HIREDATE" DATE , 
		  "JOB" CHAR(8 OCTETS) , 
		  "EDLEVEL" SMALLINT NOT NULL , 
		  "SEX" CHAR(1 OCTETS) , 
		  "BIRTHDATE" DATE , 
		  "SALARY" DECIMAL(9,2) , 
		  "BONUS" DECIMAL(9,2) , 
		  "COMM" DECIMAL(9,2) )   
		 		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."EMPLOYEE"

ALTER TABLE "VKM83249"."EMPLOYEE" 
	ADD CONSTRAINT "PK_EMPLOYEE" PRIMARY KEY
		("EMPNO")
	ENFORCED;



-- Операторы DDL для индексов таблицы "VKM83249"."EMPLOYEE"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."XEMP2" ON "VKM83249"."EMPLOYEE" 
		("WORKDEPT" ASC)
		
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;
-- Операторы DDL для алиасов на основе таблицы "VKM83249"."EMPLOYEE"

CREATE ALIAS "VKM83249"."EMP" FOR TABLE "VKM83249"."EMPLOYEE";


------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."EMP_PHOTO"
------------------------------------------------
 

CREATE TABLE "VKM83249"."EMP_PHOTO"  (
		  "EMPNO" CHAR(6 OCTETS) NOT NULL , 
		  "PHOTO_FORMAT" VARCHAR(10 OCTETS) NOT NULL , 
		  "PICTURE" BLOB(102400) LOGGED NOT COMPACT )   
		 		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."EMP_PHOTO"

ALTER TABLE "VKM83249"."EMP_PHOTO" 
	ADD CONSTRAINT "PK_EMP_PHOTO" PRIMARY KEY
		("EMPNO",
		 "PHOTO_FORMAT")
	ENFORCED;



------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."EMP_RESUME"
------------------------------------------------
 

CREATE TABLE "VKM83249"."EMP_RESUME"  (
		  "EMPNO" CHAR(6 OCTETS) NOT NULL , 
		  "RESUME_FORMAT" VARCHAR(10 OCTETS) NOT NULL , 
		  "RESUME" CLOB(5120 OCTETS) LOGGED NOT COMPACT )   
		 		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."EMP_RESUME"

ALTER TABLE "VKM83249"."EMP_RESUME" 
	ADD CONSTRAINT "PK_EMP_RESUME" PRIMARY KEY
		("EMPNO",
		 "RESUME_FORMAT")
	ENFORCED;



------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."PROJECT"
------------------------------------------------
 

CREATE TABLE "VKM83249"."PROJECT"  (
		  "PROJNO" CHAR(6 OCTETS) NOT NULL , 
		  "PROJNAME" VARCHAR(24 OCTETS) NOT NULL WITH DEFAULT '' , 
		  "DEPTNO" CHAR(3 OCTETS) NOT NULL , 
		  "RESPEMP" CHAR(6 OCTETS) NOT NULL , 
		  "PRSTAFF" DECIMAL(5,2) , 
		  "PRSTDATE" DATE , 
		  "PRENDATE" DATE , 
		  "MAJPROJ" CHAR(6 OCTETS) )   
		 		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."PROJECT"

ALTER TABLE "VKM83249"."PROJECT" 
	ADD CONSTRAINT "PK_PROJECT" PRIMARY KEY
		("PROJNO")
	ENFORCED;



-- Операторы DDL для индексов таблицы "VKM83249"."PROJECT"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."XPROJ2" ON "VKM83249"."PROJECT" 
		("RESPEMP" ASC)
		
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;
-- Операторы DDL для алиасов на основе таблицы "VKM83249"."PROJECT"

CREATE ALIAS "VKM83249"."PROJ" FOR TABLE "VKM83249"."PROJECT";


------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."PROJACT"
------------------------------------------------
 

CREATE TABLE "VKM83249"."PROJACT"  (
		  "PROJNO" CHAR(6 OCTETS) NOT NULL , 
		  "ACTNO" SMALLINT NOT NULL , 
		  "ACSTAFF" DECIMAL(5,2) , 
		  "ACSTDATE" DATE NOT NULL , 
		  "ACENDATE" DATE )   
		 		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."PROJACT"

ALTER TABLE "VKM83249"."PROJACT" 
	ADD CONSTRAINT "PK_PROJACT" PRIMARY KEY
		("PROJNO",
		 "ACTNO",
		 "ACSTDATE")
	ENFORCED;



------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."EMPPROJACT"
------------------------------------------------
 

CREATE TABLE "VKM83249"."EMPPROJACT"  (
		  "EMPNO" CHAR(6 OCTETS) NOT NULL , 
		  "PROJNO" CHAR(6 OCTETS) NOT NULL , 
		  "ACTNO" SMALLINT NOT NULL , 
		  "EMPTIME" DECIMAL(5,2) , 
		  "EMSTDATE" DATE , 
		  "EMENDATE" DATE )   
		 		 ORGANIZE BY ROW; 





-- Операторы DDL для алиасов на основе таблицы "VKM83249"."EMPPROJACT"

CREATE ALIAS "VKM83249"."EMPACT" FOR TABLE "VKM83249"."EMPPROJACT";

CREATE ALIAS "VKM83249"."EMP_ACT" FOR TABLE "VKM83249"."EMPPROJACT";


------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."ACT"
------------------------------------------------
 

CREATE TABLE "VKM83249"."ACT"  (
		  "ACTNO" SMALLINT NOT NULL , 
		  "ACTKWD" CHAR(6 OCTETS) NOT NULL , 
		  "ACTDESC" VARCHAR(20 OCTETS) NOT NULL )   
		 		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."ACT"

ALTER TABLE "VKM83249"."ACT" 
	ADD CONSTRAINT "PK_ACT" PRIMARY KEY
		("ACTNO")
	ENFORCED;



-- Операторы DDL для индексов таблицы "VKM83249"."ACT"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE UNIQUE INDEX "VKM83249"."XACT2" ON "VKM83249"."ACT" 
		("ACTNO" ASC,
		 "ACTKWD" ASC)
		
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."IN_TRAY"
------------------------------------------------
 

CREATE TABLE "VKM83249"."IN_TRAY"  (
		  "RECEIVED" TIMESTAMP , 
		  "SOURCE" CHAR(8 OCTETS) , 
		  "SUBJECT" CHAR(64 OCTETS) , 
		  "NOTE_TEXT" VARCHAR(3000 OCTETS) )   
		 		 ORGANIZE BY ROW; 






------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."ORG"
------------------------------------------------
 

CREATE TABLE "VKM83249"."ORG"  (
		  "DEPTNUMB" SMALLINT NOT NULL , 
		  "DEPTNAME" VARCHAR(14 OCTETS) , 
		  "MANAGER" SMALLINT , 
		  "DIVISION" VARCHAR(10 OCTETS) , 
		  "LOCATION" VARCHAR(13 OCTETS) )   
		 		 ORGANIZE BY ROW; 






------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."STAFF"
------------------------------------------------
 

CREATE TABLE "VKM83249"."STAFF"  (
		  "ID" SMALLINT NOT NULL , 
		  "NAME" VARCHAR(9 OCTETS) , 
		  "DEPT" SMALLINT , 
		  "JOB" CHAR(5 OCTETS) , 
		  "YEARS" SMALLINT , 
		  "SALARY" DECIMAL(7,2) , 
		  "COMM" DECIMAL(7,2) )   
		 		 ORGANIZE BY ROW; 






------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."SALES"
------------------------------------------------
 

CREATE TABLE "VKM83249"."SALES"  (
		  "SALES_DATE" DATE , 
		  "SALES_PERSON" VARCHAR(15 OCTETS) , 
		  "REGION" VARCHAR(15 OCTETS) , 
		  "SALES" INTEGER )   
		 		 ORGANIZE BY ROW; 






------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."STAFFG"
------------------------------------------------
 

CREATE TABLE "VKM83249"."STAFFG"  (
		  "ID" SMALLINT NOT NULL , 
		  "NAME" VARGRAPHIC(9 CODEUNITS16) , 
		  "DEPT" SMALLINT , 
		  "JOB" GRAPHIC(5 CODEUNITS16) , 
		  "YEARS" SMALLINT , 
		  "SALARY" DECIMAL(9,0) , 
		  "COMM" DECIMAL(9,0) )   
		 		 ORGANIZE BY ROW; 







------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."EMPMDC"
------------------------------------------------
 

CREATE TABLE "VKM83249"."EMPMDC"  (
		  "EMPNO" INTEGER , 
		  "DEPT" INTEGER , 
		  "DIV" INTEGER )   
		 ORGANIZE BY ROW USING ( 
		  ( "DEPT" ) , 
		  ( "DIV" ) ) 
		 ; 






------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."PRODUCT"
------------------------------------------------
 

CREATE TABLE "VKM83249"."PRODUCT"  (
		  "PID" VARCHAR(10 OCTETS) NOT NULL , 
		  "NAME" VARCHAR(128 OCTETS) , 
		  "PRICE" DECIMAL(30,2) , 
		  "PROMOPRICE" DECIMAL(30,2) , 
		  "PROMOSTART" DATE , 
		  "PROMOEND" DATE , 
		  "DESCRIPTION" XML )   
		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."PRODUCT"

ALTER TABLE "VKM83249"."PRODUCT" 
	ADD CONSTRAINT "PK_PRODUCT" PRIMARY KEY
		("PID")
	ENFORCED;



-- Операторы DDL для индексов таблицы "VKM83249"."PRODUCT"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."PROD_NAME_XMLIDX" ON "VKM83249"."PRODUCT" 
		("DESCRIPTION" ASC)
		GENERATE KEY USING XMLPATTERN '/product/description/name'
		  AS SQL VARCHAR  ( 128 OCTETS ) IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

-- Операторы DDL для индексов таблицы "VKM83249"."PRODUCT"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."PROD_DETAIL_XMLIDX" ON "VKM83249"."PRODUCT" 
		("DESCRIPTION" ASC)
		GENERATE KEY USING XMLPATTERN '/product/description/detail'
		  AS SQL VARCHAR  HASHED IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."INVENTORY"
------------------------------------------------
 

CREATE TABLE "VKM83249"."INVENTORY"  (
		  "PID" VARCHAR(10 OCTETS) NOT NULL , 
		  "QUANTITY" INTEGER , 
		  "LOCATION" VARCHAR(128 OCTETS) )   
		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."INVENTORY"

ALTER TABLE "VKM83249"."INVENTORY" 
	ADD CONSTRAINT "PK_INVENTORY" PRIMARY KEY
		("PID")
	ENFORCED;



------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."CUSTOMER"
------------------------------------------------
 

CREATE TABLE "VKM83249"."CUSTOMER"  (
		  "CID" BIGINT NOT NULL , 
		  "INFO" XML , 
		  "HISTORY" XML )   
		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."CUSTOMER"

ALTER TABLE "VKM83249"."CUSTOMER" 
	ADD CONSTRAINT "PK_CUSTOMER" PRIMARY KEY
		("CID")
	ENFORCED;



-- Операторы DDL для индексов таблицы "VKM83249"."CUSTOMER"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE UNIQUE INDEX "VKM83249"."CUST_CID_XMLIDX" ON "VKM83249"."CUSTOMER" 
		("INFO" ASC)
		GENERATE KEY USING XMLPATTERN '/customerinfo/@Cid'
		  AS SQL DOUBLE   IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

-- Операторы DDL для индексов таблицы "VKM83249"."CUSTOMER"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."CUST_NAME_XMLIDX" ON "VKM83249"."CUSTOMER" 
		("INFO" ASC)
		GENERATE KEY USING XMLPATTERN '/customerinfo/name'
		  AS SQL VARCHAR  ( 50 OCTETS ) IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

-- Операторы DDL для индексов таблицы "VKM83249"."CUSTOMER"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."CUST_PHONES_XMLIDX" ON "VKM83249"."CUSTOMER" 
		("INFO" ASC)
		GENERATE KEY USING XMLPATTERN '/customerinfo/phone'
		  AS SQL VARCHAR  ( 25 OCTETS ) IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

-- Операторы DDL для индексов таблицы "VKM83249"."CUSTOMER"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."CUST_PHONET_XMLIDX" ON "VKM83249"."CUSTOMER" 
		("INFO" ASC)
		GENERATE KEY USING XMLPATTERN '/customerinfo/phone/@type'
		  AS SQL VARCHAR  ( 25 OCTETS ) IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."PURCHASEORDER"
------------------------------------------------
 

CREATE TABLE "VKM83249"."PURCHASEORDER"  (
		  "POID" BIGINT NOT NULL , 
		  "STATUS" VARCHAR(10 OCTETS) NOT NULL WITH DEFAULT 'Unshipped' , 
		  "CUSTID" BIGINT , 
		  "ORDERDATE" DATE , 
		  "PORDER" XML , 
		  "COMMENTS" VARCHAR(1000 OCTETS) )   
		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."PURCHASEORDER"

ALTER TABLE "VKM83249"."PURCHASEORDER" 
	ADD CONSTRAINT "PK_PURCHASEORDER" PRIMARY KEY
		("POID")
	ENFORCED;



-- Операторы DDL для индексов таблицы "VKM83249"."PURCHASEORDER"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."PO_PRODS_XMLIDX" ON "VKM83249"."PURCHASEORDER" 
		("PORDER" ASC)
		GENERATE KEY USING XMLPATTERN '/PurchaseOrder/itemlist/item/product/@pid'
		  AS SQL DOUBLE   IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

-- Операторы DDL для индексов таблицы "VKM83249"."PURCHASEORDER"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."PO_CID_XMLIDX" ON "VKM83249"."PURCHASEORDER" 
		("PORDER" ASC)
		GENERATE KEY USING XMLPATTERN '/PurchaseOrder/@Cid'
		  AS SQL DOUBLE   IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

-- Операторы DDL для индексов таблицы "VKM83249"."PURCHASEORDER"

SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM';

CREATE INDEX "VKM83249"."PO_ZIP_XMLIDX" ON "VKM83249"."PURCHASEORDER" 
		("PORDER" ASC)
		GENERATE KEY USING XMLPATTERN '/PurchaseOrder/customerAdr/addr/pcode-zip'
		  AS SQL VARCHAR  ( 16 OCTETS ) IGNORE INVALID VALUES 
		COMPRESS NO 
		INCLUDE NULL KEYS ALLOW REVERSE SCANS;

------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."CATALOG"
------------------------------------------------
 

CREATE TABLE "VKM83249"."CATALOG"  (
		  "NAME" VARCHAR(128 OCTETS) NOT NULL , 
		  "CATLOG" XML )   
		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."CATALOG"

ALTER TABLE "VKM83249"."CATALOG" 
	ADD CONSTRAINT "PK_CATALOG" PRIMARY KEY
		("NAME")
	ENFORCED;



------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."SUPPLIERS"
------------------------------------------------
 

CREATE TABLE "VKM83249"."SUPPLIERS"  (
		  "SID" VARCHAR(10 OCTETS) NOT NULL , 
		  "ADDR" XML )   
		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."SUPPLIERS"

ALTER TABLE "VKM83249"."SUPPLIERS" 
	ADD CONSTRAINT "PK_PRODUCTSUPPLIER" PRIMARY KEY
		("SID")
	ENFORCED;



------------------------------------------------
-- Операторы DDL для таблицы "VKM83249"."PRODUCTSUPPLIER"
------------------------------------------------
 

CREATE TABLE "VKM83249"."PRODUCTSUPPLIER"  (
		  "PID" VARCHAR(10 OCTETS) NOT NULL , 
		  "SID" VARCHAR(10 OCTETS) NOT NULL )   
		 ORGANIZE BY ROW; 


-- Операторы DDL для первичных ключей таблицы "VKM83249"."PRODUCTSUPPLIER"

ALTER TABLE "VKM83249"."PRODUCTSUPPLIER" 
	ADD CONSTRAINT "PK_PRODUCTSUPPLIER" PRIMARY KEY
		("PID",
		 "SID")
	ENFORCED;

----------------------------

-- Операторы DDL для производных таблиц

----------------------------
SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VDEPT      AS SELECT ALL DEPTNO,   DEPTNAME,   MGRNO,   ADMRDEPT
  FROM DEPT;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VHDEPT    AS SELECT ALL DEPTNO ,   DEPTNAME,   MGRNO ,   ADMRDEPT,
  LOCATION   FROM DEPT;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VEMP    AS SELECT ALL EMPNO ,   FIRSTNME,   MIDINIT ,   LASTNAME,
  WORKDEPT   FROM EMP;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VPROJ    AS SELECT ALL PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF,
PRSTDATE, PRENDATE, MAJPROJ FROM PROJ;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VACT AS SELECT ALL ACTNO ,   ACTKWD ,   ACTDESC FROM ACT;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VPROJACT    AS SELECT ALL PROJNO,ACTNO, ACSTAFF, ACSTDATE, ACENDATE
FROM PROJACT;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VEMPPROJACT AS SELECT ALL EMPNO, PROJNO, ACTNO, EMPTIME, EMSTDATE,
EMENDATE FROM EMPPROJACT;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VDEPMG1 (DEPTNO, DEPTNAME, MGRNO, FIRSTNME, MIDINIT,   LASTNAME,
ADMRDEPT) AS SELECT ALL DEPTNO, DEPTNAME, EMPNO, FIRSTNME, MIDINIT,   LASTNAME,
ADMRDEPT FROM DEPT LEFT OUTER  JOIN EMP ON MGRNO = EMPNO;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VEMPDPT1 (DEPTNO, DEPTNAME, EMPNO, FRSTINIT, MIDINIT,   LASTNAME,
WORKDEPT) AS SELECT ALL DEPTNO, DEPTNAME, EMPNO, SUBSTR(FIRSTNME, 1, 1),
MIDINIT,   LASTNAME, WORKDEPT FROM DEPT  RIGHT OUTER JOIN EMP ON WORKDEPT
= DEPTNO;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VASTRDE1   (DEPT1NO,DEPT1NAM,EMP1NO,EMP1FN,EMP1MI,EMP1LN,TYPE2,
  DEPT2NO,DEPT2NAM,EMP2NO,EMP2FN,EMP2MI,EMP2LN) AS SELECT ALL   D1.DEPTNO,D1.DEPTNAME,D1.MGRNO,D1.FIRSTNME,D1.MIDINIT,
  D1.LASTNAME, '1',   D2.DEPTNO,D2.DEPTNAME,D2.MGRNO,D2.FIRSTNME,D2.MIDINIT,
  D2.LASTNAME FROM VDEPMG1 D1, VDEPMG1 D2 WHERE D1.DEPTNO = D2.ADMRDEPT;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VASTRDE2   (DEPT1NO,DEPT1NAM,EMP1NO,EMP1FN,EMP1MI,EMP1LN,TYPE2,
  DEPT2NO,DEPT2NAM,EMP2NO,EMP2FN,EMP2MI,EMP2LN) AS SELECT ALL   D1.DEPTNO,D1.DEPTNAME,D1.MGRNO,D1.FIRSTNME,D1.MIDINIT,
  D1.LASTNAME,'2',   D1.DEPTNO,D1.DEPTNAME,E2.EMPNO,E2.FIRSTNME,E2.MIDINIT,
  E2.LASTNAME FROM VDEPMG1 D1, EMP E2 WHERE D1.DEPTNO = E2.WORKDEPT;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VPROJRE1   (PROJNO,PROJNAME,PROJDEP,RESPEMP,FIRSTNME,MIDINIT,
  LASTNAME,MAJPROJ) AS SELECT ALL   PROJNO,PROJNAME,DEPTNO,EMPNO,FIRSTNME,MIDINIT,
  LASTNAME,MAJPROJ FROM PROJ, EMP WHERE RESPEMP = EMPNO;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VPSTRDE1   (PROJ1NO,PROJ1NAME,RESP1NO,RESP1FN,RESP1MI,RESP1LN,
  PROJ2NO,PROJ2NAME,RESP2NO,RESP2FN,RESP2MI,RESP2LN) AS SELECT ALL   P1.PROJNO,P1.PROJNAME,P1.RESPEMP,P1.FIRSTNME,P1.MIDINIT,
  P1.LASTNAME,   P2.PROJNO,P2.PROJNAME,P2.RESPEMP,P2.FIRSTNME,P2.MIDINIT,
  P2.LASTNAME FROM VPROJRE1 P1,   VPROJRE1 P2 WHERE P1.PROJNO = P2.MAJPROJ;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VPSTRDE2   (PROJ1NO,PROJ1NAME,RESP1NO,RESP1FN,RESP1MI,RESP1LN,
  PROJ2NO,PROJ2NAME,RESP2NO,RESP2FN,RESP2MI,RESP2LN) AS SELECT ALL   P1.PROJNO,P1.PROJNAME,P1.RESPEMP,P1.FIRSTNME,P1.MIDINIT,
  P1.LASTNAME,   P1.PROJNO,P1.PROJNAME,P1.RESPEMP,P1.FIRSTNME,P1.MIDINIT,
  P1.LASTNAME FROM VPROJRE1 P1 WHERE NOT EXISTS (SELECT * FROM VPROJRE1
P2 WHERE P1.PROJNO = P2.MAJPROJ);


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VFORPLA   (PROJNO,PROJNAME,RESPEMP,PROJDEP,FRSTINIT,MIDINIT,LASTNAME)
AS SELECT ALL F1.PROJNO,PROJNAME,RESPEMP,PROJDEP, SUBSTR(FIRSTNME, 1, 1),
  MIDINIT, LASTNAME FROM VPROJRE1 F1 LEFT OUTER JOIN EMPPROJACT F2 ON F1.PROJNO
= F2.PROJNO;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VSTAFAC1(PROJNO, ACTNO, ACTDESC, EMPNO, FIRSTNME, MIDINIT, 
    LASTNAME, EMPTIME,STDATE,ENDATE, TYPE) AS SELECT ALL PA.PROJNO, PA.ACTNO,
AC.ACTDESC,' ', ' ', ' ', ' ',   PA.ACSTAFF, PA.ACSTDATE,   PA.ACENDATE,'1'
FROM PROJACT PA, ACT AC  WHERE PA.ACTNO = AC.ACTNO;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VSTAFAC2 (PROJNO, ACTNO, ACTDESC, EMPNO, FIRSTNME, MIDINIT,
LASTNAME, EMPTIME,STDATE, ENDATE, TYPE) AS SELECT ALL EP.PROJNO, EP.ACTNO,
AC.ACTDESC, EP.EMPNO,EM.FIRSTNME, EM.MIDINIT, EM.LASTNAME, EP.EMPTIME,
EP.EMSTDATE,   EP.EMENDATE,'2' FROM EMPPROJACT EP, ACT AC, EMP EM WHERE
EP.ACTNO = AC.ACTNO AND EP.EMPNO = EM.EMPNO;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VPHONE   (LASTNAME,   FIRSTNAME,   MIDDLEINITIAL,   PHONENUMBER,
  EMPLOYEENUMBER,   DEPTNUMBER,   DEPTNAME) AS SELECT ALL LASTNAME,   FIRSTNME,
  MIDINIT ,   VALUE(PHONENO,' '),   EMPNO,   DEPTNO,   DEPTNAME FROM EMP,
DEPT WHERE WORKDEPT = DEPTNO;


SET CURRENT SCHEMA = "VKM83249";
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249";
CREATE VIEW VEMPLP   (EMPLOYEENUMBER,   PHONENUMBER) AS SELECT ALL EMPNO
,   PHONENO FROM EMP;


--COMMIT WORK;
--CONNECT RESET;