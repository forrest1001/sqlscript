drop table temp_nghitemptable1;

-- List all stays of members
create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and transactiondate >= to_date('01/01/2017','dd/mm/yyyy')
   and transactiondate < to_date('01/01/2018','dd/mm/yyyy') 
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and transactiondate >= to_date('01/01/2017','dd/mm/yyyy')
   and transactiondate < to_date('01/01/2018','dd/mm/yyyy');
   
CREATE INDEX temp_nghitemptable1_indx ON temp_nghitemptable1
(EXTERNALMEMBERID, PRODUCTMGRID)
NOLOGGING;

with memberstay
as
(
select externalmemberid, count(terminaltransactionid) stays 
from temp_nghitemptable1
group by externalmemberid
)
select stays, count(externalmemberid) members
from memberstay
group by stays



select distinct externalmemberid from temp_nghitemptable1

-- 178,663 members

with memberstay
as
(
select t.*, m.membershiplevel
from temp_nghitemptable1 t, member m
where t.externalmemberid = m.externalmemberid
and t.productmgrid = m.productmgrid
)
select membershiplevel, sum(value) 
from memberstay
group by membershiplevel;

-- 349,241 transactions