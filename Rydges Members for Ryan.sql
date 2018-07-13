create table temp_fromweb as
select * from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/09/2015','dd/mm/yyyy')
and createddate < to_date('01/09/2016','dd/mm/yyyy');

-- 102,214
   
-- From KIOSK
create table temp_fromkiosk as
select * from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('01/09/2015','dd/mm/yyyy')
and creationdate < to_date('01/09/2016','dd/mm/yyyy');

-- 100,193


select * from temp_fromweb w
where exists (select * from temp_fromkiosk where w.externalmemberid = externalmemberid)

R2291294
R2291296
R2291302
R2291286

drop table temp_combinemembers;

create table temp_combinemembers as
select externalmemberid, createddate, 'WEB' as method
from temp_fromweb 
union 
select externalmemberid, creationdate, 'KIOSK' as method
from temp_fromkiosk


--- Stay
drop table temp_nghitemptable1; 

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and i.externalmemberid in (select externalmemberid from temp_combinemembers)
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and i.externalmemberid in (select externalmemberid from temp_combinemembers)
   ;

drop table temp_membersnstay;

create table temp_membersnstay as
select m.externalmemberid, m.createddate, m.method, t.transactiondate, t.value, t.cardprodclassid 
from temp_combinemembers m, temp_nghitemptable1 t 
where m.externalmemberid = t.externalmemberid
order by m.externalmemberid, t.transactiondate;

select count(distinct externalmemberid) from temp_membersnstay 

-- Members stay within 365 days
drop table temp_memberfirststay;

create table temp_memberfirststay as
select externalmemberid, createddate, min(transactiondate) firststay 
from temp_membersnstay
group by externalmemberid, createddate
having min(transactiondate) <= (createddate+365)
--99,373


select externalmemberid, createddate, min(transactiondate)
from temp_membersnstay
group by externalmemberid, createddate
having min(transactiondate) > (createddate+365)
--2,059

drop table temp_initialdata;

create table temp_initialdata as
select t1.externalmemberid, t1.createddate, t1.method, t2.firststay, t1.transactiondate, t1.value, t1.cardprodclassid
from temp_membersnstay t1, temp_memberfirststay t2
where t1.externalmemberid = t2.externalmemberid
order by t1.externalmemberid, t1.transactiondate

select externalmemberid, createddate, method, firststay, transactiondate, (transactiondate - firststay) diffdays, value, cardprodclassid
from temp_initialdata

where transactiondate <> firststay

select externalmemberid, count(transactiondate) 
from temp_initialdata
group by externalmemberid



----------------------------------------------------------------------------

create table temp_nghitemptable1 as
select p.givenname, p.familyname, m.externalmemberid, m.sourceid, membershiplevel, m.programstatus, 0 as temporarymember, 
to_char(m.startdate,'dd/mm/yyyy') joineddate,
ab.emailaddress,
cm.status as cardstatus, cm.expirydate as expirydate
from member m, cardmember cm, person p, addressbook ab
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and m.personid = p.personid
and m.externalmemberid = cm.externalmemberid
and m.productmgrid = cm.productmgrid
and cm.status < 50
and p.addressbookid = ab.addressbookid
union
select c.givenname, c.familyname, c.externalmemberid, c.sourceid, 0 as membershiplevel, c.programstatus, 1 as temporarymember,
to_char(c.joineddate,'dd/mm/yyyy') joineddate,
c.emailaddress, -1 as cardstatus, null as expirydate
from cardregistration c
where c.productmgrid in (22181,22191)
and c.externalmemberid like 'R%'
and not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid);

drop table temp_nghitemptable2;

create table temp_nghitemptable2 nologging as
select i.terminaltransactionid, i.externalmemberid, i.transactiondate 
from instantrewsummarytransaction i
where i.status < 50 
   and i.productmgrid in (22181,22191)
   and i.transactiondate >= to_date('01/08/2015','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
union 
select i.terminaltransactionid, i.externalmemberid, i.transactiondate
from loyaltypntssummarytransaction i
where i.status < 50 
   and i.productmgrid in (22181,22191)
   and i.transactiondate >= to_date('01/08/2015','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000;

-- count members
select membershiplevel, count(externalmemberid)
from temp_nghitemptable1 t1
group by membershiplevel

1	12379
2	4189
0	1373713

-- no activity in last 24 months
select membershiplevel, count(externalmemberid)
from temp_nghitemptable1 t1
where not exists (select * from temp_nghitemptable2 where externalmemberid = t1.externalmemberid)
and temporarymember = 0
group by membershiplevel 

1	3481
2	628
0	1061143

-- active in last 12 months
select membershiplevel, count(externalmemberid)
from temp_nghitemptable1 t1
where exists (select * from temp_nghitemptable2 where externalmemberid = t1.externalmemberid and transactiondate >= to_date('01/08/2016','dd/mm/yyyy') )
group by membershiplevel

1	7464
2	3274
0	193098


select membershiplevel, count(externalmemberid)
from temp_nghitemptable1 t1
where temporarymember = 0
group by membershiplevel

1	12379
2	4189
0	971924