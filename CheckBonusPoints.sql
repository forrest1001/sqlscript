select externalmemberid, count(terminaltransactionid) 
from instantrewsummarytransaction 
where suppliertransactiontype = 50112
group by externalmemberid

select * from  RYDGESBONUSPOINTS
where rydgesbonuspointsid is null

 where terminaltransactionid > 0

1,183

1,183


-- AFTER IMPORT
update RYDGESBONUSPOINTS r set 
RYDGESBONUSPOINTSID = RYDGESBONUSPOINTSID.nextval,
BONUSPOINTS = 20,
STATUS = 0,
SUPPLIERTRANSACTIONTYPE = 0,
TERMINALTRANSACTIONID = 0,
CREATIONDATE = SYSDATE,
--PRODUCTMGRID = (select m.productmgrid from member m where m.externalmemberid = r.externalmemberid),
COMMENTS = 'Added by Nghi, for Gold members', 
ENDDATE = to_date('16/07/18','dd/mm/yy') 
where RYDGESBONUSPOINTSID is null;

select externalmemberid, count(rowid) 
from RYDGESBONUSPOINTS
group by externalmemberid

select * from  RYDGESBONUSPOINTS
where terminaltransactionid > 0

group by bonuspoints

--1,255

--1,271

--4,566

--5,778
