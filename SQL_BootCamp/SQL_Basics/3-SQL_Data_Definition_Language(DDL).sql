/* ==============================================================================
   SQL Data Definition Language (DDL)
-------------------------------------------------------------------------------
   This guide covers the essential DDL commands used for defining and managing
   database structures, including creating, modifying, and deleting tables.

   Table of Contents:
     1. CREATE - Creating Tables
     2. ALTER - Modifying Table Structure
     3. DROP - Removing Tables
=================================================================================
*/

----------------------------------------------------------------First Example--------------------------------------------------------------------
/* ============================================================================== 
   CREATE
=============================================================================== */

USE DATASCIENCE;


---- 1. Create a new table called persons with columns: id, person_name, birth_date, and phone

DROP TABLE IF EXISTS persons;

CREATE TABLE persons(
      id               INT IDENTITY(1,1)   PRIMARY KEY        ,
	  person_name      NVARCHAR(30)       NOT    NULL         ,
	  birth_date       DATE                                   ,
	  phone            NVARCHAR(30)       NOT    NULL
)

SELECT * FROM persons;



/* ============================================================================== 
   ALTER
=============================================================================== */

----2. Add a new column called email to the persons table


ALTER TABLE persons ADD email nvarchar(30) not null;


----3. Remove the column phone from the persons table

ALTER TABLE persons DROP COLUMN phone;



----4. TRUNCATE THE table persons

TRUNCATE TABLE persons;

----5. DROP THE tbale persons

DROP TABLE persons;



----------------------------------------------------------------Second Example--------------------------------------------------------------------

DROP TABLE IF EXISTS Students;

CREATE TABLE Students(
       RollID             INT IDENTITY(1,1)   PRIMARY KEY             ,
	   Student_Name       NVARCHAR(30)     NOT   NULL                 ,
	   birth_date         date                                        ,
	   phone_no           NVARCHAR(30)     NOT   NULL                 ,
	   email              NVARCHAR(30)     NOT   NULL
)

SELECT * FROM Students;


/* ============================================================================== 
   ALTER
=============================================================================== */

---- Add a new column called Address to the Students table

ALTER TABLE Students ADD Address  NVARCHAR(30);

---- Drop the column phone_no from the Students table

ALTER TABLE Students DROP COLUMN phone_no



------TRUNCATE THE table Students

TRUNCATE TABLE Students;


------DROP THE Table students


DROP TABLE Students;