SET PAGES 200 LONG 80000 ECHO ON;
ACC sql_id PROMPT 'Enter SQL_ID: ';

set lines 155
col execs for 999,999,999
col avg_etime for 999,999,999
col avg_lreads for 999,999,999
col begin_interval_time for a30
col node for 99999
break on plan_hash_value on startup_time skip 1
select ss.snap_id,ss.instance_number node, begin_interval_time,sql_id,plan_hash_value,
nvl(executions_delta,0) execs,
(elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
(buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta)) avg_lreads
from dba_hist_sqlstat s,dba_hist_snapshot ss
where sql_id = '&sql_id'
and ss.snap_id=s.snap_id
and ss.instance_number=s.instance_number
and executions_delta >0 order by 1,2,3;

ACC plan_hash_value PROMPT 'Enter Plan Hash Value: ';

SPO &&sql_id._&&plan_hash_value._awr.txt;

SET PAGES 2000 LIN 300 TRIMS ON ECHO ON FEED OFF HEA OFF;

SELECT * /* exclude_me */
FROM TABLE(DBMS_XPLAN.display_awr('&&sql_id.', TO_NUMBER('&&plan_hash_value.'), null, 'TYPICAL'));

SPO OFF;

SET NUM 10 PAGES 14 LONG 80 LIN 80 TRIMS OFF ECHO OFF FEED 6 HEA ON;

UNDEF sql_text_piece sql_id plan_hash_value
