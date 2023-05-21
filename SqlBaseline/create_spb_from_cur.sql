SET PAGES 200 LONG 80000 ECHO ON;
ACC sql_id PROMPT 'Enter SQL_ID: ';

SELECT plan_hash_value, SUM(executions) executions, SUM(elapsed_time) elapsed_time, /* exclude_me */
       CASE WHEN SUM(executions) > 0 THEN ROUND(SUM(elapsed_time)/SUM(executions)/1e6, 3) END avg_secs_per_exec
  FROM v$sql
 WHERE sql_id = '&&sql_id.'
 GROUP BY
       plan_hash_value
 ORDER BY
       4 DESC NULLS FIRST;

ACC plan_hash_value PROMPT 'Enter Plan Hash Value: ';
SELECT child_number, executions, elapsed_time, /* exclude_me */
       CASE WHEN executions > 0 THEN ROUND(elapsed_time/executions/1e6, 3) END avg_secs_per_exec
  FROM v$sql
 WHERE sql_id = '&&sql_id.'
   AND plan_hash_value = TO_NUMBER('&&plan_hash_value.')
 ORDER BY
       4 DESC NULLS FIRST;
       
VAR plans NUMBER;

EXEC :plans := DBMS_SPM.load_plans_from_cursor_cache('&&sql_id.', TO_NUMBER('&&plan_hash_value.'));

PRINT plans;

SET PAGES 14 LONG 80 ECHO OFF;

UNDEF sql_id plan_hash_value
