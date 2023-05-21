SET PAGES 200 LONG 80000 ECHO ON;
ACC sql_handle PROMPT 'Enter SQL Handle: ';
SPO &&sql_handle._spb.txt;
set lines 300
col creator for a20
col plan_name for a30
SELECT sql_handle, signature,creator
  FROM dba_sql_plan_baselines
 WHERE sql_handle = '&&sql_handle.'
   AND ROWNUM = 1;

SELECT plan_name, created /* exclude_me */
  FROM dba_sql_plan_baselines
 WHERE sql_handle = '&&sql_handle.'
 ORDER BY
       created;

ACC plan_name PROMPT 'Enter optional Plan Name: ';

SET NUM 20;

SELECT signature, /* exclude_me */
       plan_name,
       origin,
       parsing_schema_name,
       version,
       created,
       last_modified,
       last_executed,
       last_verified,
       optimizer_cost,
       module,
       action,
       executions,
       elapsed_time,
       cpu_time,
       buffer_gets,
       disk_reads,
       direct_writes,
       rows_processed,
       fetches
 FROM dba_sql_plan_baselines
 WHERE sql_handle = '&&sql_handle.'
   AND plan_name = NVL('&&plan_name.', plan_name)
 ORDER BY
       created;

SELECT plan_name, /* exclude_me */
       enabled,
       accepted,
       fixed,
       reproduced,
       autopurge
  FROM dba_sql_plan_baselines
 WHERE sql_handle = '&&sql_handle.'
   AND plan_name = NVL('&&plan_name.', plan_name)
 ORDER BY
       created;

ACC attribute_name PROMPT 'Enter Attribute Name (ENABLED, FIXED, AUTOPURGE, PLAN_NAME or DESCRIPTION): ';

ACC attribute_value PROMPT 'Enter Attribute Value (for flags enter YES or NO): ';

VAR plans NUMBER;

BEGIN
  :plans := DBMS_SPM.alter_sql_plan_baseline (
    sql_handle      => '&&sql_handle.',
    plan_name       => '&&plan_name.',
    attribute_name  => '&&attribute_name.',
    attribute_value => '&&attribute_value.' );
END;
/

PRINT plans;

SELECT plan_name, /* exclude_me */
       enabled,
       accepted,
       fixed,
       reproduced,
       autopurge
  FROM dba_sql_plan_baselines
 WHERE sql_handle = '&&sql_handle.'
   AND plan_name = (CASE WHEN '&&attribute_name.' = 'PLAN_NAME' THEN '&&attribute_value.' ELSE NVL('&&plan_name.', plan_name) END)
 ORDER BY
       created;

SET PAGES 14 LONG 80 ECHO OFF;

UNDEF sql_text_piece sql_handle plan_name attribute_name attribute_value
