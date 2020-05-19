-- File Name : pm_gp.sql
-- Purpose : checkdb
-- \i pm_gp.sql
-- Date : 2020/04/27
-- tc@DBA
-- DB: 5.x,6.x
/*
SELECT * FROM pg_tables  where tablename='bb_lk_s2b2c_digitization_t_activ_market_coupon_platform_commodity';

select * from pg_stat_activity;

select length('bb_lk_s2b2c_digitization_t_activ_market_coupon_platform_commodi');


select a.locktype,b.relname,substring(c.current_query,1,50),c.xact_start,a.pid,a.mode,a.granted 
from pg_locks a,pg_class b,pg_stat_activity c
where a.relation = b.oid and a.pid = c.procpid;

select relfilenode,relowner,relname,relfrozenxid,age(relfrozenxid)  
from pg_class 
where relfrozenxid::text::bigint<>0 
order by age(relfrozenxid) desc limit 20; 
*/
select version();
select gp_opt_version();

select datname,age(datfrozenxid) from pg_database; 

select relfilenode,relowner,relname,relfrozenxid,age(relfrozenxid)  
from pg_class 
where relfrozenxid::text::bigint<>0 
order by age(relfrozenxid) desc limit 20;

SELECT gid, prepared,owner, database, transaction AS xmin  
FROM pg_prepared_xacts   
ORDER BY age(transaction) DESC; 

select dbid,content,role,preferred_role,mode,status,port ,hostname,datadir from gp_segment_configuration where status='d';
select * from gp_segment_configuration;
 
select * from pg_user;
select * from pg_shadow;

SELECT schemaname,count(*) FROM pg_tables group by  schemaname order by 1;
select schemaname,vacuum_count,analyze_count,count(*) from pg_stat_all_tables group by schemaname,vacuum_count,analyze_count;

SELECT schemaname,to_char(statime,'yyyy-mm-dd') statime,count(*)
FROM pg_stat_operations
WHERE subtype = 'TABLE'
group by schemaname,to_char(statime,'yyyy-mm-dd')
order by statime;

select usename,datname,client_addr, count(*) from pg_stat_activity group by usename,datname,client_addr order by count(*) desc;

select pid,to_char(now(),'HH24:mi:ss') now,datname, usename,application_name,client_addr,state,
to_char(query_start,'mm-dd HH24:mi:ss') query_start,to_char(xact_start,'mm-dd HH24:mi:ss') xact_start,substr(query,1,15) query
--waiting wt,
from pg_stat_activity
where 1=1
and state !='idle'
order by xact_start ,query_start ;

\x
select now(),d.* from pg_stat_database d where datname not in ('template0','template1','gpperfmon');

select pid, query_start,xact_start,query
from pg_stat_activity
where 1=1
and query not like '%from pg_stat_activity%'
and state ='active'
order by query_start;
\x

\! ps -ef |grep -i postgres |grep -i con|grep -v idle
