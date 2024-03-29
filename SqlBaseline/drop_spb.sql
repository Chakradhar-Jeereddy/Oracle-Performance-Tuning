SET PAGES 200 LONG 80000 ECHO ON;
SET NUM 20;
ACC sql_handle PROMPT 'Enter SQL Handle: ';

SELECT plan_name, created /* exclude_me */
  FROM dba_sql_plan_baselines
 WHERE sql_handle = '&&sql_handle.'
 ORDER BY
       created;

ACC plan_name PROMPT 'Enter optional Plan Name: ';

SELECT plan_name, /* exclude_me */
       enabled,
       accepted,
       fixed,
       reproduced,
       autopurge,
       creator,
       created
  FROM dba_sql_plan_baselines
 WHERE sql_handle = '&&sql_handle.'
   AND plan_name = NVL('&&plan_name.', plan_name)
 ORDER BY
       created;

VAR plans NUMBER;

SET ECHO ON;

EXEC :plans := DBMS_SPM.drop_sql_plan_baseline(NVL('&&sql_handle.', 'cannot_pass_nulls'), '&&plan_name.');

PRINT plans;

SET NUM 10 PAGES 14 LONG 80 ECHO OFF;

UNDEF sql_text_piece sql_handle plan_name
