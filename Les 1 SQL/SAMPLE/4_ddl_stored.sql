---------------------------------
-- Операторы DDL для пользовательских функций
---------------------------------


SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM'@
SET CURRENT SCHEMA = "VKM83249"@
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249"@

CREATE FUNCTION resign_employee (number CHAR(6))
  RETURNS TABLE (empno  CHAR(6),
                 salary DOUBLE,
                 dept   CHAR(3))
  MODIFIES SQL DATA
  LANGUAGE SQL
  BEGIN ATOMIC
-- -------------------------------------------------------------------------------------
-- Routine type:  SQL table function
-- Routine name:  resign_employee
--
-- Purpose:  This procedure takes in an employee number, then removes that
--           employee from the EMPLOYEE table.
--           A useful extension to this function would be to archive the
--           original record into an archive table.
--
-- --------------------------------------------------------------------------------------
    DECLARE l_salary DOUBLE;
    DECLARE l_job CHAR(3);

    SET (l_salary, l_job) = (SELECT salary, job
                               FROM OLD TABLE (DELETE FROM employee
                                                WHERE employee.empno = number));

    RETURN VALUES (number,l_salary, l_job);
  END@

---------------------------------
-- Операторы DDL для хранимых процедур
---------------------------------


SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM'@
SET CURRENT SCHEMA = "VKM83249"@
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249"@

CREATE PROCEDURE bonus_increase                            (IN p_bonusFactor
DECIMAL (3,2),                              IN p_bonusMaxSumForDept DECIMAL
(9,2),                              OUT p_deptsWithoutNewBonuses VARCHAR(255),
                             OUT p_countDeptsViewed INTEGER,          
                   OUT p_countDeptsBonusChanged INTEGER,              
               OUT p_errorMsg VARCHAR(255)) SPECIFIC BONUS_INCREASE
LANGUAGE SQL
DYNAMIC RESULT SETS 1

BEGIN
-- -------------------------------------------------------------------------------------
-- Routine type:  SQL stored procedure
-- Routine name:  bonus_increase
--
-- Purpose:  This procedure takes in a multiplier value that is used to update
--           employee bonus values.  The employee bonus updates are done department
--           by department.  Updated employee bonus values are only committed if the
--           sum of the bonuses for a department does not exceed the threshold amount
--           specified by another input parameter.  A result is returned listing, by
--           department, employee numbers and currently set bonus values.
--
-- Features shown:
--           - IN and OUT parameters
--           - Variable declaration and setting
--           - Condition handler declaration and use
--           - Use of CURSOR WITH HOLD
--           - Use of SAVEPOINT and ROLLBACK to SAVEPOINT
--           - Returning of a result set to the caller
--           - Use of a WHILE loop control-statement
--           - Use of IF/ELSE statement
--           - Use of labels and GOTO statement
--           - Use of RETURN statement
--
-- Parameters:
-- IN  p_bonusFactor:      Constant multiple by which employee bonuses are updated
-- IN  p_bonusMaxSumForDept:    Maximum amount for departmental bonuses without review
-- OUT p_deptsWithoutNewBonuses:  Comma delimited list of departments that require
--                                   a manual setting and review of bonus amounts
-- OUT p_countDeptsViewed:     Number of departments processed
-- OUT p_countDeptsBonusChanged:  Number of departments for which bonuses were set
-- OUT p_errorMsg:       Error message string
-- --------------------------------------------------------------------------------------
    DECLARE v_dept, v_actdept CHAR(3);
    DECLARE v_bonus, v_deptbonus, v_newbonus DECIMAL(9,2);
    DECLARE v_empno CHAR(6);
    DECLARE v_atend SMALLINT DEFAULT 0;

    -- Cursor that lists employee numbers and bonuses ordered by department
    -- This cursor is declared as WITH HOLD so that on rollbacks it remains
    -- open.  It is declared as FOR UPDATE OF bonus, so that the employee
    -- bonus column field can be updated as the cursor iterates through the rows.

    DECLARE cSales CURSOR WITH HOLD FOR
          SELECT workdept, bonus, empno FROM employee ORDER BY workdept
      FOR UPDATE OF bonus;

    -- This cursor, declared with WITH RETURN TO CALLER, is used to return
    -- a result set to the caller when this procedure returns.  The result
    -- set contains a list of the employees and their bonus values ordered
    -- by the department numbers.

    DECLARE cEmpBonuses CURSOR WITH RETURN TO CALLER FOR
          SELECT workdept, empno, bonus FROM employee ORDER BY workdept;

    -- This continue handler is used to catch the NOT FOUND error
    -- associated with the end of the iteration over the cursor cSales.
    -- It is used to set v_atend which flags the end of the WHILE loop.

     DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_atend=1;

    -- This continue handler is used to catch any numeric overflows

    DECLARE EXIT HANDLER FOR SQLSTATE '22003'
    BEGIN
      SET p_errorMsg = 'SQLSTATE 22003 - Numeric overflow occurred setting bonus';
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET v_atend=1;

    -- Initialize local variables

    SET p_errorMsg = '';
    SET p_deptsWithoutNewBonuses = '';
    SET p_countDeptsViewed = 0;
    SET p_countDeptsBonusChanged = 0;

    -- Check input parameter is valid

    IF (p_bonusFactor < 1 OR p_bonusFactor > 2) THEN
      SET p_errorMsg = 'E01 Checking parameter p_bonusFactor, validation';
      GOTO error_found;
    END IF;

    OPEN cSales;

    FETCH cSales INTO v_dept, v_bonus, v_empno;

    nextdept:
        IF v_atend = 0 THEN

            -- This savepoint is used to rollback the bonuses assigned to employees if
            -- the sum of bonuses for a department exceeds a threshold amount

            SAVEPOINT svpt_bonus ON ROLLBACK RETAIN CURSORS;

            SET v_actdept = v_dept;
            SET v_deptbonus = 0;

            WHILE ( v_actdept = v_dept ) AND ( v_atend = 0 ) DO
                    SET v_newbonus = v_bonus * p_bonusFactor;
                    UPDATE employee SET bonus = v_newbonus WHERE empno = v_empno;
                    SET v_deptbonus = v_deptbonus + v_newbonus;
                    FETCH cSales INTO v_dept, v_bonus, v_empno;
            END WHILE;

            SET p_countDeptsViewed = p_countDeptsViewed + 1;

            IF v_deptbonus <= p_bonusMaxSumForDept THEN
                SET p_countDeptsBonusChanged = p_countDeptsBonusChanged + 1;
                COMMIT;
            ELSE
                     ROLLBACK TO SAVEPOINT svpt_bonus;
                     RELEASE SAVEPOINT svpt_bonus;
                     SET p_deptsWithoutNewBonuses =
                                     (CASE WHEN p_deptsWithoutNewBonuses = ''
                                           THEN v_actdept
                                      ELSE
                                           p_deptsWithoutNewBonuses || ', ' || v_actdept
                                      END);
            END IF;
            GOTO nextdept;
        END IF;

    OPEN cEmpBonuses;

    RETURN 0;

error_found:
    SET p_errorMsg = p_errorMsg || ' failed.';
    RETURN -1;

END@

-------------------------------
-- Операторы DDL для триггеров
-------------------------------



SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM'@
SET CURRENT SCHEMA = "VKM83249"@
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249"@
CREATE TRIGGER do_not_del_sales NO CASCADE BEFORE DELETE ON staff REFERENCING
OLD AS oldstaff FOR EACH ROW MODE DB2SQL WHEN(oldstaff.job = 'Sales') BEGIN
ATOMIC SIGNAL SQLSTATE '75000' ('Sales staff cannot be deleted... see the DO_NOT_DEL_SALES trigger.');
END@


SET SYSIBM.NLS_STRING_UNITS = 'SYSTEM'@
SET CURRENT SCHEMA = "VKM83249"@
SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","VKM83249"@
CREATE TRIGGER min_salary NO CASCADE BEFORE INSERT ON staff REFERENCING
NEW AS newstaff FOR EACH ROW MODE DB2SQL BEGIN ATOMIC SET newstaff.salary
= CASE WHEN newstaff.job = 'Mgr' AND newstaff.salary < 17000.00 THEN 17000.00
WHEN newstaff.job = 'Sales' AND newstaff.salary < 14000.00 THEN 14000.00
WHEN newstaff.job = 'Clerk' AND newstaff.salary < 10000.00 THEN 10000.00
ELSE newstaff.salary END; END@