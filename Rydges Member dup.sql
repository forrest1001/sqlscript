create table temp_rydgesmember_dup2
(
GIVENNAME varchar2(300 byte),
FAMILYNAME varchar2(300 byte),
EXTERNALMEMBERID varchar2(60 byte),
SOURCEID integer,
MEMBERSHIPLEVEL integer,
CREATIONDATE date,
POINTSBALANCE integer,
ENROLMENTCODE varchar2(60 byte),
COMPANYCODEID varchar2(60 byte),
EMAILADDRESS varchar2(300 byte)
) nologging;

select externalmemberid, count(rowid) 
from temp_rydgesmember_dup2
group by externalmemberid;

select 
GIVENNAME,
FAMILYNAME,
EXTERNALMEMBERID,
SOURCEID,
MEMBERSHIPLEVEL,
CREATIONDATE,
POINTSBALANCE,
ENROLMENTCODE,
COMPANYCODEID,
EMAILADDRESS,
(select usagecount from memberproductusage where externalmemberid = t1.externalmemberid and cardprodclassid in (851,861)) as Count851861,
(select usagecount from memberproductusage where externalmemberid = t1.externalmemberid and cardprodclassid in (895,900)) as Count895900,
(select max(lasttimeused) from memberproductusage where externalmemberid = t1.externalmemberid and cardprodclassid in (851,861,895,900)) as lastAccomDate
from temp_rydgesmember_dup2 t1


select * from memberproductusage where externalmemberid = 'R1989754'

select * from memberpoints where externalmemberid = 'R1989754' 

in (select externalmemberid from temp_rydgesmember_dup2)

select * from memberusage