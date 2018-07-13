select * 
from TEMP_CASE16451 t
where nexists (select * from member where externalmemberid = t.externalmemberid)

select * from member where externalmemberid in (select externalmemberid from TEMP_CASE16451) 

select distinct m.externalmemberid, m.sourceid, t.externalmemberid, t.sourceid, m.sourceid - t.sourceid
from member m,TEMP_CASE16451 t
where m.externalmemberid = t.externalmemberid
and m.sourceid = 41603345

4,867

4,719

update member t
set sourceid = (select distinct sourceid from temp_case16451 where externalmemberid = t.externalmemberid)
where t.externalmemberid = 'R2728091'
 
update member t
set sourceid = (select distinct sourceid from temp_case16451 where externalmemberid = t.externalmemberid)
where t.externalmemberid in (select externalmemberid from temp_case16451)
and t.sourceid =  41603345

1,339

